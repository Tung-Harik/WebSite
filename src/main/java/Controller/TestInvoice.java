package Controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import Entity.Invoice;
import Entity.Product;
import Service.InvoiceService;
import Service.ProductService;
import Service.Impl.InvoiceServiceImpl;
import Service.Impl.ProductServiceImpl;

public class TestInvoice {
    public static void main(String[] args) {
        InvoiceService invoiceService = new InvoiceServiceImpl();
        ProductService productService = new ProductServiceImpl();

        // Tạo sản phẩm mẫu
        Product product = new Product();
        product.setId(101);
        product.setName("Iphone 16 Pro");
        product.setPrices(BigDecimal.valueOf(3500.00)); // dùng BigDecimal.valueOf()
        Product createdProduct = productService.create(product);

        // Tạo hóa đơn
        Invoice invoice = new Invoice();
        invoice.setNguoiDungID(1);
        invoice.setProduct(createdProduct);
        invoice.setSoLuong(2);
        invoice.setDonGia(createdProduct.getPrices()); // không cần BigDecimal.valueOf() nữa
        invoice.setTongTien(invoice.getDonGia().multiply(BigDecimal.valueOf(invoice.getSoLuong()))); // ✅ đúng cách
        invoice.setNgayLap(new Date());
        invoice.setGhiChu("Khách hàng thân thiết");

        Invoice created = invoiceService.create(invoice);
        System.out.println("Created invoice id: " + created.getId());

        // 3️⃣ Tìm hóa đơn theo ID
        invoiceService.findById(created.getId()).ifPresent(inv ->
            System.out.println("Found invoice: Tổng tiền = " + inv.getTongTien())
        );

        // 4️⃣ Cập nhật ghi chú
        created.setGhiChu("Đã giao hàng");
        Invoice updated = invoiceService.update(created);
        System.out.println("Updated note: " + updated.getGhiChu());

        // 5️⃣ Lấy tất cả hóa đơn
        List<Invoice> all = invoiceService.findAll();
        System.out.println("All invoices:");
        all.forEach(i ->
            System.out.println("   - ID " + i.getId() + " | " + i.getNgayLap() + " | " + i.getTongTien())
        );

        // 6️⃣ (Tuỳ chọn) Xóa hóa đơn
        // invoiceService.deleteById(created.getId());
        // System.out.println("Deleted invoice id " + created.getId());
    }
}
