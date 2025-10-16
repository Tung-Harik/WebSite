package Controller.User;

import java.io.IOException;
import java.util.List;

import Entity.Invoice;
import Entity.User;
import Service.InvoiceService;
import Service.Impl.InvoiceServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/user/orders")
public class Orders extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final InvoiceService invoiceService = new InvoiceServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User u = (User) session.getAttribute("account");

        // Lấy toàn bộ đơn hàng của user (DAO của bạn: findByNguoiDungID)
        List<Invoice> orders = invoiceService.findByNguoiDungID(u.getId());

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/user/orders.jsp").forward(req, resp);
	}
}
