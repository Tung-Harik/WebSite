package Controller.Api;

import java.io.IOException;

import Service.CartService;
import Service.Impl.CartServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/v1/api/cart/add")
public class AddToCart extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json;charset=UTF-8");
	    Integer userId = (Integer) req.getAttribute("jwtUserId"); // đã set ở JwtAuthFilter
	    if (userId == null) { resp.setStatus(401); resp.getWriter().write("{\"error\":\"No user\"}"); return; }

	    String body = req.getReader().lines().collect(java.util.stream.Collectors.joining());
	    int productId = Integer.parseInt(extractNum(body, "productId"));
	    int qty       = Integer.parseInt(extractNum(body, "quantity"));

	    cartService.addItem(userId, productId, qty);
	    resp.getWriter().write("{\"ok\":true}");
	}
	
	private static String extractNum(String json, String key){
	    var m=java.util.regex.Pattern.compile("\""+key+"\"\\s*:\\s*\"?(\\d+)\"?").matcher(json);
	    return m.find()?m.group(1):null;
	  }
}
