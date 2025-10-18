package Controller;

import java.io.IOException;

import Entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);

        // Nếu chưa đăng nhập thì về login
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy user từ session
        User user = (User) session.getAttribute("account");

        // Kiểm tra roleID
        if (user.getRoleID() == 1) {
            resp.sendRedirect(req.getContextPath() + "/admin/trangchu");
        } 
        else if (user.getRoleID() == 3) {
            resp.sendRedirect(req.getContextPath() + "/user/trangchu");
        } 
        else {
            
        }
	}
}
