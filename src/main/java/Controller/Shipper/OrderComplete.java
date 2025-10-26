package Controller.Shipper;

import java.io.IOException;

import Service.InvoiceService;
import Service.Impl.InvoiceServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/shipper/order/complete")
public class OrderComplete extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final InvoiceService invoiceService = new InvoiceServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
        invoiceService.updateGhiChu(id, "Hoàn thành");

        resp.sendRedirect(req.getContextPath() + "/shipper/home");
	}
}
