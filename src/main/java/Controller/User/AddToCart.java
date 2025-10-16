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

@WebServlet(urlPatterns = "/user/cart/add")
public class AddToCart extends HttpServlet{

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

        String productIdStr = req.getParameter("productId");
        String qtyStr = req.getParameter("quantity");

        try {
            int pid = Integer.parseInt(productIdStr);
            int qty = (qtyStr == null || qtyStr.isBlank()) ? 1 : Integer.parseInt(qtyStr);
            if (qty < 1) qty = 1;

            cartService.addItem(u.getId(), pid, qty);
            req.getSession().setAttribute("flashSuccess", "Đã thêm vào giỏ hàng.");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("flashError", "Dữ liệu không hợp lệ.");
        }
        
        
        resp.sendRedirect(req.getContextPath() + "/home");
	}
}
