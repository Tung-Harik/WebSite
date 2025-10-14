package Controller.User;

import java.io.IOException;
import java.util.Optional;

import Entity.User;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import Util.Passwords;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = {"/user/profile"})
public class Profile extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
		User current = (User)session.getAttribute("account");
		
		Optional<User> fresh = userService.findById(current.getId());
        fresh.ifPresent(u -> req.setAttribute("editUser", u));
        
		req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession(false);
        User sessionUser = (User)session.getAttribute("account");
        
        try {
        	User dbUser = userService.findById(sessionUser.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy tài khoản."));
        	
        	String username = trim(req.getParameter("username"));
            String fullname = trim(req.getParameter("fullname"));
            String diaChi   = trim(req.getParameter("diaChi"));
            String sdt      = trim(req.getParameter("sdt"));
            String email    = trim(req.getParameter("email"));
            String newPass  = trim(req.getParameter("password")); 
            
            //Kiểm tra thông tin người dùng nhập vào
            if (isBlank(username)) {
                throw new IllegalArgumentException("Username là bắt buộc.");
            }
            if (username.length() > 50) {
                throw new IllegalArgumentException("Username tối đa 50 ký tự.");
            }
            if (!username.equalsIgnoreCase(dbUser.getUsername())
                    && userService.existsByUsername(username)) {
                throw new IllegalArgumentException("Tên đăng nhập đã tồn tại.");
            }
            if (isBlank(diaChi)) {
                throw new IllegalArgumentException("Địa chỉ là bắt buộc.");
            }
            if (isBlank(sdt)) {
                throw new IllegalArgumentException("SĐT là bắt buộc.");
            }
            if (newPass != null && newPass.length() > 50) {
                throw new IllegalArgumentException("Password tối đa 50 ký tự.");
            }
            
            //Gán giá trị mới 
            dbUser.setUsername(username);
            dbUser.setFullname(fullname);
            dbUser.setDiaChi(diaChi);
            dbUser.setSdt(sdt);
            dbUser.setEmail(email);
            
            //Nếu người dùng đổi mật khẩu
            if (!isBlank(newPass)) {
                
                dbUser.setPassword(Passwords.hash(newPass));
            }
            
            User saved = userService.update(dbUser);

            // Đồng bộ lại session 
            if (session != null) {
                session.setAttribute("account", saved);
            }
            
            req.setAttribute("editUser", saved);
        }catch(Exception e) {
        	
        }
        
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
	}
	
	private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private static String trim(String s) {
        return s == null ? null : s.trim();
    }
}
