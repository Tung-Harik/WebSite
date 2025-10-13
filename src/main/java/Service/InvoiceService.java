package Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import Entity.Invoice;

public interface InvoiceService {
    // CREATE
    Invoice create(Invoice invoice);

    // READ
    Optional<Invoice> findById(Integer id);
    List<Invoice> findAll();
    List<Invoice> findAll(int page, int size);
    long count();

    // UPDATE
    Invoice update(Invoice invoice);

    // DELETE
    boolean deleteById(Integer id);

    // EXTRA
    List<Invoice> findByNguoiDungID(int userId); // tìm hóa đơn theo người dùng
    List<Invoice> findByDateRange(Date startDate, Date endDate); // tìm trong khoảng ngày
}
