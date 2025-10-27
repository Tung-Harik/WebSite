package Controller.Guest;

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

@WebServlet(urlPatterns = "/trangchu")
public class TrangChu extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 // 1) Tham số phân trang
        int page = parseIntOrDefault(req.getParameter("page"), 1);
        int size = parseIntOrDefault(req.getParameter("size"), 8);
        if (size <= 0) size = 8;

        // 2) Tổng bản ghi & tổng trang
        long totalItems = productService.count();
        int totalPages = (int) Math.ceil(totalItems / (double) size);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;
        if (page < 1) page = 1;

        // 3) Lấy dữ liệu theo trang
        List<Product> products = productService.findAll(page, size);

        // 4) Map ảnh theo id (dựa đúng tên file bạn có trong webapp/assets/img/products)
        Map<Integer, String> imgById = new HashMap<>();
        for (Product p : products) {
            String imageName = switch (p.getId()) {
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
            imgById.put(p.getId(), imageName);
        }

        // 5) Gắn attribute & đường phân trang
        req.setAttribute("products", products);
        req.setAttribute("imgById", imgById);
        req.setAttribute("page", page);
        req.setAttribute("size", size);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("listPath", req.getServletPath()); // = "/trangchu"

        req.getRequestDispatcher("/trangchu.jsp").forward(req, resp);
	}
	
	private int parseIntOrDefault(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
