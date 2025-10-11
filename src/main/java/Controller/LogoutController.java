package Controller;

import java.io.IOException;

import Util.Constraint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = "/logout")
public class LogoutController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//Xóa Session hiện tại
		HttpSession session = req.getSession(false); // false = không tạo mới nếu chưa có
        if (session != null) {
            session.invalidate();
        }
        
        //Xóa Cookie
        clearRememberMe(resp);
        
        resp.sendRedirect(req.getContextPath() + "/login");
	}
	
	private void clearRememberMe(HttpServletResponse resp) {
        Cookie cu = new Cookie(Constraint.COOKIE_USERNAME, "");
        Cookie cp = new Cookie(Constraint.COOKIE_PASSWORD, "");

        cu.setMaxAge(0);
        cp.setMaxAge(0);
        cu.setPath("/");
        cp.setPath("/");

        resp.addCookie(cu);
        resp.addCookie(cp);
    }
}
