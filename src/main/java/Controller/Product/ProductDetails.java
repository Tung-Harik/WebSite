package Controller.Product;

import java.io.IOException;

import Service.ProductService;
import Entity.Product;
import Service.Impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/user/product/detail", "/guest/product/detail", "/product/detail"})
public class ProductDetails extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
        Object account = (session != null) ? session.getAttribute("account") : null;

        // Nếu chưa đăng nhập mà đi vào /user/..., thì chuyển hướng sang /guest/product/detail
        String servletPath = req.getServletPath();
        if (account == null && servletPath.startsWith("/user/")) {
            String id = req.getParameter("id");
            resp.sendRedirect(req.getContextPath() + "/guest/product/detail?id=" + id);
            return;
        }

        // --- 2️⃣ Lấy id sản phẩm ---
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/trangchu");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Product product = productService.findById(id);
            if (product == null) {
                req.setAttribute("error", "Không tìm thấy sản phẩm.");
                req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
                return;
            }

            // --- 3️⃣ Map ảnh cho sản phẩm ---
            String imageName = switch (id) {
                case 1 -> "Áo thể chất.png";
                case 2 -> "Áo đồng phục UTE.png";
                case 3 -> "Áo khoa CLC.png";
                case 4 -> "Áo TN UTE.png";
                case 5 -> "balo UTE.jpg";
                case 6 -> "móc khóa UTE.jpg";
                case 7 -> "Nón UTE.jpg";
                case 8 -> "Ô UTE.jpg";
                case 9 -> "sổ tay UTE.jpg";
                default -> "noimage.jpg";
            };

            req.setAttribute("imgFile", imageName);
            req.setAttribute("product", product);

            // --- 4️⃣ Chuyển sang view phù hợp ---
            String view = "/views/products/product-details.jsp";


            req.getRequestDispatcher(view).forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/trangchu");
        }
	}
}
