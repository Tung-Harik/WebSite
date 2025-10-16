package Controller.User;

import java.io.IOException;

import Entity.User;
import Service.CartService;
import Service.Impl.CartServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/user/checkout")
public class Checkout extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        User u = (User) session.getAttribute("account");

        // BUSINESS: chốt đơn
        cartService.checkout(u.getId());

        // Tuỳ ý: chuyển tới trang cảm ơn/hoá đơn
        req.getSession().setAttribute("flash", "Đã thanh toán giỏ hàng.");
        resp.sendRedirect(req.getContextPath() + "/user/orders"); 
	}
}
