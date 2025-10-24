package Controller.Product;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import Service.ProductService;
import Entity.Product;
import Service.Impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/user/product/detail")
public class ProductDetails extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Product p = productService.findById(id);
            if (p == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            // Map ID → ảnh
            Map<Integer, String> imgById = new HashMap<>();
            imgById.put(1, "Áo thể chất.png");
            imgById.put(2, "Áo đồng phục UTE.png");
            imgById.put(3, "Áo khoa CLC.png");
            imgById.put(4, "Áo TN UTE.png");
            imgById.put(5, "balo UTE.jpg");
            imgById.put(6, "móc khóa UTE.jpg");
            imgById.put(7, "Nón UTE.jpg");
            imgById.put(8, "Ô UTE.jpg");
            imgById.put(9, "sổ tay UTE.jpg");

            String imageName = imgById.getOrDefault(id, "Áo TN UTE.png");

            req.setAttribute("product", p);
            req.setAttribute("imageName", imageName);
            req.getRequestDispatcher("/views/products/product-details.jsp")
               .forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
	}
}
