package Controller.Shipper;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import Entity.Invoice;
import Service.InvoiceService;
import Service.Impl.InvoiceServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/shipper/home"})
public class Home extends HttpServlet{

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
        
        LocalDate today = LocalDate.now();
        Date startOfDay = Date.from(today.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endOfDay = Date.from(today.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

        // Gọi DAO để lấy các hóa đơn trong ngày hôm nay
        List<Invoice> todayOrders = invoiceService.findByDateRange(startOfDay, endOfDay);
        
     // Chỉ giữ các đơn KHÔNG phải "Hoàn thành"
        List<Invoice> needToDeliver = todayOrders.stream()
                .filter(inv -> inv.getGhiChu() == null || !"Hoàn thành".equals(inv.getGhiChu()))
                .collect(java.util.stream.Collectors.toList());

        req.setAttribute("orders", needToDeliver);
		
		req.getRequestDispatcher("/views/shipper/home.jsp").forward(req, resp);
	}
}
