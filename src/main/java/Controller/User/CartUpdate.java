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

@WebServlet(urlPatterns = "/user/cart/update")
public class CartUpdate extends HttpServlet{

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

        String itemIdStr = req.getParameter("itemId");
        String qtyStr = req.getParameter("quantity");

        try {
            int itemId = Integer.parseInt(itemIdStr);
            int qty = Integer.parseInt(qtyStr);
            if (qty < 1) qty = 1;

            cartService.updateItemQuantity(u.getId(), itemId, qty);
            req.getSession().setAttribute("flash", "Đã cập nhật số lượng.");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("flash", "Dữ liệu không hợp lệ.");
        }

        resp.sendRedirect(req.getContextPath() + "/user/cart");
	}
}
