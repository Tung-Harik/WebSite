package Controller.Shipper;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import Entity.Invoice;
import Service.Impl.InvoiceServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/shipper/orders"})
public class Orders extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final InvoiceServiceImpl invoiceService = new InvoiceServiceImpl();
    
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doPost (req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

        String fromS = trimToNull(req.getParameter("from"));       // yyyy-MM-dd
        String toS   = trimToNull(req.getParameter("to"));         // yyyy-MM-dd

        ZoneId zone = ZoneId.of("Asia/Ho_Chi_Minh");
        Date fromDate = null, toDateExclusive = null;

        try {
            if (fromS != null) {
                LocalDate from = LocalDate.parse(fromS);
                fromDate = Date.from(from.atStartOfDay(zone).toInstant());
            }
            if (toS != null) {
                LocalDate to = LocalDate.parse(toS).plusDays(1);
                toDateExclusive = Date.from(to.atStartOfDay(zone).toInstant());
            }
        } catch (Exception ignored) {}

        // ============= LOGIC CHÍNH =============
        List<Invoice> invoices = new ArrayList<>();

        if (fromDate != null || toDateExclusive != null) {
            invoices = invoiceService.findByDateRange(fromDate, toDateExclusive);
        }
        else {
            invoices = new ArrayList<>();
        }

        // Gắn attributes
        req.setAttribute("invoices", invoices);
        req.setAttribute("from", fromS);
        req.setAttribute("to", toS);

        req.getRequestDispatcher("/views/shipper/orders.jsp").forward(req, resp);
	}
	
	 private String trimToNull(String s) {
	        if (s == null) return null;
	        s = s.trim();
	        return s.isEmpty() ? null : s;
	    }
}
