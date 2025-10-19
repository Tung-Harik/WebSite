package Controller.Admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import Entity.Product;
import Service.ProductService;
import Service.Impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/admin/products")
public class ProductController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        //User u = (User) session.getAttribute("account");
        
//        if (u.getRoleID() == null || u.getRoleID() != 1) {
//            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
//            return;
//        }
        
        List<Product> products = productService.findAll();
        req.setAttribute("products", products);

        // Forward JSP
        req.getRequestDispatcher("/views/admin/products.jsp").forward(req, resp);
        
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String action = req.getParameter("action");

        try {
            if ("create".equalsIgnoreCase(action)) {
                handleCreate(req, session);
            } else if ("update".equalsIgnoreCase(action)) {
                handleUpdate(req, session);
            } else if ("delete".equalsIgnoreCase(action)) {
                handleDelete(req, session);
            } else {
                session.setAttribute("flashError", "Hành động không hợp lệ");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("flashError", "Lỗi: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
	}
	
	private void handleCreate(HttpServletRequest req, HttpSession session) {
        String name = req.getParameter("name");
        String priceStr = req.getParameter("prices");

        if (isBlank(name) || isBlank(priceStr)) {
            session.setAttribute("flashError", "Tên và giá không được để trống");
            return;
        }

        Product p = new Product();
        p.setName(name.trim());
        p.setPrices(new BigDecimal(priceStr));

        productService.create(p);
        session.setAttribute("flash", "Đã thêm sản phẩm mới");
    }

    private void handleUpdate(HttpServletRequest req, HttpSession session) {
        Integer id = parseIntOrNull(req.getParameter("id"));
        String name = req.getParameter("name");
        String priceStr = req.getParameter("prices");

        if (id == null) { session.setAttribute("flashError", "Thiếu ID sản phẩm"); return; }
        if (isBlank(name) || isBlank(priceStr)) {
            session.setAttribute("flashError", "Tên và giá không được để trống");
            return;
        }

        Product p = productService.findById(id);

        if (p == null) {
            session.setAttribute("flashError", "Không tìm thấy sản phẩm #" + id);
            return;
        }

        p.setName(name.trim());
        p.setPrices(new BigDecimal(priceStr));
        
        productService.update(p);
        session.setAttribute("flash", "Đã cập nhật sản phẩm #" + id);
    }

    private void handleDelete(HttpServletRequest req, HttpSession session) {
        Integer id = parseIntOrNull(req.getParameter("id"));
        if (id == null) { session.setAttribute("flashError", "Thiếu ID để xoá"); return; }

        boolean ok = productService.deleteById(id);
        session.setAttribute("flash", ok ? "Đã xoá sản phẩm #" + id : "Xoá thất bại");
    }

    private static Integer parseIntOrNull(String s) {
        try { return Integer.valueOf(s); } catch (Exception e) { return null; }
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
