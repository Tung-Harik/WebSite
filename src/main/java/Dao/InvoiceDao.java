package Dao;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import Entity.Invoice;

public interface InvoiceDao {
    Invoice create(Invoice invoice);
    Optional<Invoice> findById(Integer id);
    List<Invoice> findAll();
    List<Invoice> findAll(int page, int size);
    long count();
    Invoice update(Invoice invoice);
    boolean deleteById(Integer id);
    List<Invoice> findByNguoiDungID(int userId);
    List<Invoice> findByDateRange(Date startDate, Date endDate);
    
    Invoice getByIdAndUserOrNull(int invoiceId, int userId);
    void updateGhiChu (int id, String newStatus);
}
