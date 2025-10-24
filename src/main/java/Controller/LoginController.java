package Controller;

import java.io.IOException;

import Entity.User;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import Util.Constraint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	UserService service = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String rememberedUser = null;
        String rememberedPass = null;

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (Constraint.COOKIE_USERNAME.equals(c.getName())) {
                    rememberedUser = c.getValue();
                } else if (Constraint.COOKIE_PASSWORD.equals(c.getName())) {
                    rememberedPass = c.getValue();
                }
            }
        }

        req.setAttribute("rememberedUser", rememberedUser);
        req.setAttribute("rememberedPass", rememberedPass);
        req.setAttribute("rememberChecked", rememberedUser != null && rememberedPass != null);
		
		req.getRequestDispatcher("/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        boolean isRememberMe = "on".equals(req.getParameter("remember"));

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không được rỗng");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        User user = service.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);

            if (isRememberMe) {
                saveRememberMe(req, resp, username, password);  // lưu cả 2
            } else {
                clearRememberMe(resp);                          // bỏ tick thì xoá
            }

            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
	}
	
	/** Lưu cookie Remember  */
    private void saveRememberMe(HttpServletRequest req, HttpServletResponse resp,
                                String username, String password) {
        int maxAge = 7 * 24 * 60 * 60; // 7 ngày

        Cookie cu = new Cookie(Constraint.COOKIE_USERNAME, username);
        Cookie cp = new Cookie(Constraint.COOKIE_PASSWORD, password);

        cu.setMaxAge(maxAge);
        cp.setMaxAge(maxAge);

        // để mọi URL trong app đều đọc được
        cu.setPath("/");
        cp.setPath("/");

        // an toàn hơn một chút
        cu.setHttpOnly(true);
        cp.setHttpOnly(true);
        boolean secure = req.isSecure(); // true nếu đang chạy https
        cu.setSecure(secure);
        cp.setSecure(secure);

        resp.addCookie(cu);
        resp.addCookie(cp);
    }

    /** Xoá cookie Remember */
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
