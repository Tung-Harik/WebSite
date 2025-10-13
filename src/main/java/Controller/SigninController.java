package Controller;

import java.io.IOException;

import Entity.User;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import Util.Passwords;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/register")
public class SigninController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final UserService service = new UserServiceImpl();

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/signin.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String password = trim(req.getParameter("password"));
        String fullname = trim(req.getParameter("fullname"));
        String diaChi   = trim(req.getParameter("diachi"));
        String sdt      = trim(req.getParameter("sdt"));
        String email    = trim(req.getParameter("email"));

        // 1) Validate cơ bản
        String error = validate(username, password, diaChi, sdt);
        if (error != null) {
            req.setAttribute("error", error);
            // giữ lại giá trị đã nhập (trừ password)
            req.setAttribute("form_username", username);
            req.setAttribute("form_fullname", fullname);
            req.setAttribute("form_diachi", diaChi);
            req.setAttribute("form_sdt", sdt);
            req.setAttribute("form_email", email);
            req.getRequestDispatcher("/signin.jsp").forward(req, resp);
            return;
        }

        // 2) Kiểm tra trùng username
        if (service.existsByUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại.");
            keepForm(req, username, fullname, diaChi, sdt, email);
            req.getRequestDispatcher("/signin.jsp").forward(req, resp);
            return;
        }

        // 3) Băm mật khẩu và lưu
        String hashed = Passwords.hash(password);
        User u = User.builder()
                .username(username)
                .password(hashed)
                .fullname(fullname)
                .diaChi(diaChi)
                .sdt(sdt)
                .roleID(3)
                .email(email)
                .build();
        try {
            service.create(u);
            req.setAttribute("success", "Tạo tài khoản thành công! Bạn có thể đăng nhập ngay.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi lưu dữ liệu. Vui lòng thử lại.");
            keepForm(req, username, fullname, diaChi, sdt, email);
            req.getRequestDispatcher("/signin.jsp").forward(req, resp);
        }
	}
	
	private static String trim(String s) { return s == null ? null : s.trim(); }

    private static String validate(String username, String password, String diaChi, String sdt) {
        if (isBlank(username))  return "Tên đăng nhập không hợp lệ.";
        if (isBlank(password)) return "Mật khẩu không hợp lệ.";
        if (isBlank(diaChi)) return "Địa chỉ không hợp lệ.";
        if (isBlank(sdt)) return "SĐT không hợp lệ.";
        if (!sdt.matches("^[0-9+\\-\\s]{8,15}$"))        return "SĐT chỉ gồm số, +, -, khoảng trắng (8–15 ký tự).";
        return null;
    }

    private static boolean isBlank(String s) { return s == null || s.isEmpty(); }

    private static void keepForm(HttpServletRequest req, String un, String fn, String dc, String phone, String email) {
        req.setAttribute("form_username", un);
        req.setAttribute("form_fullname", fn);
        req.setAttribute("form_diachi", dc);
        req.setAttribute("form_sdt", phone);
        req.setAttribute("form_email", email);
    }
}
