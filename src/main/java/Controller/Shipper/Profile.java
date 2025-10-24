package Controller.Shipper;

import java.io.IOException;
import java.util.regex.Pattern;

import Entity.User;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/shipper/profile")
public class Profile extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		
        if (session == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        
        User acc = (User) session.getAttribute("account");
        
        if (acc == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        
        if (acc.getRoleID() == null || acc.getRoleID() != 5) {
            resp.sendRedirect(req.getContextPath() + "/access-denied");
            return;
        }
        
        req.getRequestDispatcher("/views/shipper/profile.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
	    User account = (User) session.getAttribute("account");
	    String base = req.getContextPath() + "/shipper/profile";

	    String action = trim(req.getParameter("action"));

	    try {
	        if (account == null) {
	            session.setAttribute("error", "Vui lòng đăng nhập lại.");
	            resp.sendRedirect(req.getContextPath() + "/login");
	            return;
	        }

	        // Tải user mới nhất từ DB để update
	        User user = userService.findById(account.getId());
	        if (user == null) {
	            session.setAttribute("error", "Không tìm thấy tài khoản.");
	            resp.sendRedirect(base);
	            return;
	        }

	        if ("update".equals(action)) {
	            String fullname = trim(req.getParameter("fullname"));
	            String email    = trim(req.getParameter("email"));
	            String sdt      = trim(req.getParameter("sdt"));
	            String diaChi   = trim(req.getParameter("diaChi"));

	            // Validate đơn giản
	            if (isBlank(fullname)) throw new IllegalArgumentException("Họ tên không được để trống.");
	            if (!isValidEmail(email)) throw new IllegalArgumentException("Email không hợp lệ.");
	            if (!isValidPhone(sdt)) throw new IllegalArgumentException("Số điện thoại không hợp lệ.");

	            // Check trùng email bằng UserService (ngoại trừ chính mình)
	            User emailOwner = userService.findByEmailOrNull(email);
	            if (emailOwner != null && !emailOwner.getId().equals(user.getId())) {
	                throw new IllegalArgumentException("Email đã được sử dụng bởi tài khoản khác.");
	            }

	            // Cập nhật thông tin
	            user.setFullname(fullname);
	            user.setEmail(email);
	            user.setSdt(sdt);
	            user.setDiaChi(diaChi);

	            user = userService.update(user); // lưu DB

	            // Đồng bộ lại session
	            session.setAttribute("account", user);
	            session.setAttribute("success", "Cập nhật hồ sơ thành công.");
	            resp.sendRedirect(base);
	            return;
	        }

	        if ("password".equals(action)) {
	            String current = trim(req.getParameter("currentPassword"));
	            String npass   = trim(req.getParameter("newPassword"));
	            String cpass   = trim(req.getParameter("confirmPassword"));

	            if (isBlank(current) || isBlank(npass) || isBlank(cpass)) {
	                throw new IllegalArgumentException("Vui lòng điền đầy đủ các trường mật khẩu.");
	            }
	            if (!npass.equals(cpass)) {
	                throw new IllegalArgumentException("Mật khẩu xác nhận không khớp.");
	            }
	            if (npass.length() < 8) {
	                throw new IllegalArgumentException("Mật khẩu mới phải từ 8 ký tự trở lên.");
	            }

	            // Xác thực mật khẩu hiện tại
	            if (user.getPassword() == null || !org.mindrot.jbcrypt.BCrypt.checkpw(current, user.getPassword())) {
	                throw new IllegalArgumentException("Mật khẩu hiện tại không đúng.");
	            }

	            // Hash & update
	            String hashed = org.mindrot.jbcrypt.BCrypt.hashpw(npass, org.mindrot.jbcrypt.BCrypt.gensalt(12));
	            user.setPassword(hashed);
	            userService.update(user);

	            session.setAttribute("success", "Đổi mật khẩu thành công.");
	            resp.sendRedirect(base);
	            return;
	        }

	        // Action không hợp lệ
	        session.setAttribute("error", "Hành động không hợp lệ.");
	        resp.sendRedirect(base);

	    } catch (Exception ex) {
	        ex.printStackTrace();
	        session.setAttribute("error", ex.getMessage());
	        resp.sendRedirect(base);
	    }
	}
	
	private String trim(String s) { return s == null ? null : s.trim(); }
    private boolean isBlank(String s) { return s == null || s.isEmpty(); }

    private boolean isValidEmail(String email) {
        if (isBlank(email)) return false;
        String re = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return Pattern.matches(re, email);
    }

    private boolean isValidPhone(String phone) {
        if (isBlank(phone)) return false;

        String re = "^(\\+84|0)\\d{9,10}$";
        return Pattern.matches(re, phone);
    }
}









