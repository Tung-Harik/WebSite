package Controller;

import Dao.InvoiceDao;
import Entity.Invoice;
import Entity.Product;

import java.math.BigDecimal;

public class TestInvoice {
    public static void main(String[] args) {
        InvoiceDao dao = new InvoiceDao();

        // Giả sử sản phẩm đã tồn tại trong DB
        Product product = new Product();
        product.setId(1); // ID sản phẩm có sẵn trong DB

        // Tạo hóa đơn mới
        Invoice invoice = new Invoice();
        invoice.setNguoiDungID(1); // ví dụ user có id = 1
        invoice.setProduct(product);
        invoice.setSoLuong(3);
        invoice.setDonGia(new BigDecimal("500.00"));
        invoice.setGhiChu("Mua 3 cái laptop Dell");

        dao.create(invoice);

        System.out.println("Hóa đơn đã được thêm vào!");
    }
}
