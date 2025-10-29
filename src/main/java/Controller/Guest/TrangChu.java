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
		
		String q = trimToNull(req.getParameter("q"));

        int page = parseIntOrDefault(req.getParameter("page"), 1);
        int size = parseIntOrDefault(req.getParameter("size"), 8);
        if (size <= 0) size = 8;

        long totalItems;
        int totalPages;
        List<Product> products;

        if (q != null) {
            // Nhánh tìm kiếm
            totalItems = productService.countByNameContaining(q);
            totalPages = (int) Math.ceil(totalItems / (double) size);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;
            if (page < 1) page = 1;

            products = productService.findByNameContaining(q, page, size);
        } else {
            // Nhánh danh sách tất cả
            totalItems = productService.count();
            totalPages = (int) Math.ceil(totalItems / (double) size);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;
            if (page < 1) page = 1;

            products = productService.findAll(page, size);
        }

        // Map ảnh theo id (giữ y nguyên như bạn có)
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

        req.setAttribute("products", products);
        req.setAttribute("imgById", imgById);
        req.setAttribute("page", page);
        req.setAttribute("size", size);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("q", q);                           // giữ lại từ khoá để hiển thị
        req.setAttribute("listPath", req.getServletPath()); // "/trangchu"


        req.getRequestDispatcher("/trangchu.jsp").forward(req, resp);
	}
	
	private int parseIntOrDefault(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
	
	private String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
}
