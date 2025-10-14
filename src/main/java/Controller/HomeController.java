package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Entity.Product;
import Service.ProductService;
import Service.Impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Product> products = productService.findAll();

		Map<Integer, String> imgById = new HashMap<>();
		for (Product p : products) {
		    String imageName = switch (p.getId()) {
		        case 1 -> "son3ce.png";
		        case 2 -> "sua_rua_mat_1.png";
		        case 3 -> "anessa.png";
		        default -> "placeholder.png";
		    };
		    imgById.put(p.getId(), imageName);
		}
		req.setAttribute("imgById", imgById);
        
        req.setAttribute("products", products);
        
		req.getRequestDispatcher("/home.jsp").forward(req, resp);
	}
}
