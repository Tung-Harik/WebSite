package Controller.Api;

import java.io.IOException;

import Service.CartService;
import Service.Impl.CartServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/v1/api/checkout")
public class Checkout extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json;charset=UTF-8");
	    Integer userId = (Integer) req.getAttribute("jwtUserId");
	    if (userId == null) { resp.setStatus(401); resp.getWriter().write("{\"error\":\"No user\"}"); return; }

	    //int created = cartService.checkout(userId);
	    //resp.getWriter().write("{\"created\":"+created+"}");
	}
}
