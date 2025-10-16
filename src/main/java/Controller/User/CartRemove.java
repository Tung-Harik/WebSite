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

@WebServlet(urlPatterns = "/user/cart/remove")
public class CartRemove extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        User u = (User) session.getAttribute("account");

        String itemIdStr = req.getParameter("itemId");
        
        try {
            int itemId = Integer.parseInt(itemIdStr);
            cartService.removeItem(u.getId(), itemId);
            req.getSession().setAttribute("flashSuccess", "Đã xoá sản phẩm khỏi giỏ.");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("flashError", "Dữ liệu không hợp lệ.");
        }

        resp.sendRedirect(req.getContextPath() + "/user/cart");
	}
}
