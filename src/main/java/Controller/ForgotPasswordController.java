package Controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Calendar;
import java.util.Date;

import Entity.User;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import Util.MailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/forgot")
public class ForgotPasswordController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final UserService userService = new UserServiceImpl();
    private final SecureRandom random = new SecureRandom();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
        
    	String email = req.getParameter("email");
        if (email == null || email.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập email đã đăng ký.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        // tìm người dùng theo email
        User u = userService.findByEmailOrNull(email.trim().toLowerCase());
        if (u == null) {
            req.setAttribute("error", "Email không hợp lệ hoặc chưa được đăng ký!");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        // sinh mã reset
        String code = String.format("%06d", random.nextInt(1_000_000));
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MINUTE, 1); // hạn 1 phút
        Date expiry = cal.getTime();

        try {
            // lưu mã và hạn vào user
            userService.setResetCode(u, code, expiry);

            // gửi mail
            String subject = "Mã đặt lại mật khẩu UTE Shop";
            String html = "<p>Xin chào " + (u.getFullname() != null ? u.getFullname() : u.getUsername()) + ",</p>"
                    + "<p>Mã đặt lại mật khẩu của bạn là: <b>" + code + "</b></p>"
                    + "<p>Mã có hiệu lực trong 1 phút.</p>";

            MailUtil.sendMail(email.trim(), subject, html);

            req.setAttribute("message", "Mã xác nhận đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
        }

        req.setAttribute("prefillEmail", email.trim());
        req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
    }
}
