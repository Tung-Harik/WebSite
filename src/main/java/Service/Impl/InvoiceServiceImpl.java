package Service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import Dao.InvoiceDao;
import Dao.Impl.InvoiceDaoImpl;
import Entity.Invoice;
import Service.InvoiceService;

public class InvoiceServiceImpl implements InvoiceService {

    private final InvoiceDao invoiceDao = new InvoiceDaoImpl();

    @Override
    public Invoice create(Invoice invoice) {
        return invoiceDao.create(invoice);
    }

    @Override
    public Optional<Invoice> findById(Integer id) {
        return invoiceDao.findById(id);
    }

    @Override
    public List<Invoice> findAll() {
        return invoiceDao.findAll();
    }

    @Override
    public List<Invoice> findAll(int page, int size) {
        return invoiceDao.findAll(page, size);
    }

    @Override
    public long count() {
        return invoiceDao.count();
    }

    @Override
    public Invoice update(Invoice invoice) {
        return invoiceDao.update(invoice);
    }

    @Override
    public boolean deleteById(Integer id) {
        return invoiceDao.deleteById(id);
    }

    @Override
    public List<Invoice> findByNguoiDungID(int userId) {
        return invoiceDao.findByNguoiDungID(userId);
    }

    @Override
    public List<Invoice> findByDateRange(Date startDate, Date endDate) {
        return invoiceDao.findByDateRange(startDate, endDate);
    }

	@Override
	public Invoice getByIdAndUserOrNull(int invoiceId, int userId) {
		return invoiceDao.getByIdAndUserOrNull(invoiceId, userId);
	}

	@Override
	public void updateGhiChu(int id, String newStatus) {
		invoiceDao.updateGhiChu(id, newStatus);
	}
}
