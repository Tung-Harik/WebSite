package Controller.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import Entity.Cart;
import Entity.CartItems;
import Entity.User;
import Service.CartService;
import Service.Impl.CartServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/user/cart")
public class CartView extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User u = (User) session.getAttribute("account");

        Cart cart = cartService.getOrCreateActiveCart(u.getId()); // đảm bảo có cart
        
        // nạp lại để có items + product dùng cho JSP
        cart = cartService.loadActiveCartForView(u.getId());

     // Chỉ build imgById cho các sản phẩm có trong giỏ
        Map<Integer, String> imgById = new HashMap<>();
        for (CartItems it : cart.getItems()) {
            int pid = it.getProduct().getId();

            String fileName = switch (pid) {
	            case 1 -> "Áo thể chất.png";
	            case 2 -> "Áo đồng phục UTE.png";
	            case 3 -> "Áo khoa CLC.png";
	            case 4 -> "Áo TN UTE.png";
	            case 5 -> "balo UTE.jpg";
	            case 6 -> "móc khóa UTE.jpg";
	            case 7 -> "Nón UTE.jpg";
	            case 8 -> "Ô UTE.jpg";
	            case 9 -> "sổ tay UTE.jpg";
	            default -> "Áo TN UTE.png";
            };
            
            imgById.put(pid, fileName);
        }
        
        req.setAttribute("cart", cart);
        req.setAttribute("imgById", imgById);
        req.getRequestDispatcher("/views/user/cart.jsp").forward(req, resp);
	}
	
}
