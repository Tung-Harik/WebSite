package Controller.User;

import java.io.IOException;

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

@WebServlet(urlPatterns = "/user/orders/detail")
public class OrderDetails extends HttpServlet{

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

        String idStr = req.getParameter("id");
        try {
            int orderId = Integer.parseInt(idStr);
            Invoice inv = invoiceService.getByIdAndUserOrNull(orderId, u.getId());
            if (inv == null) {
                session.setAttribute("flashError", "Đơn hàng không tồn tại hoặc không thuộc về bạn.");
                resp.sendRedirect(req.getContextPath() + "/user/orders");
                return;
            }
            req.setAttribute("order", inv);
            req.getRequestDispatcher("/views/user/order-details.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/user/orders");
        }
	}
}
