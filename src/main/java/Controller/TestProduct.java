package Controller;

import java.math.BigDecimal;

import Entity.Product;
import Service.ProductService;
import Service.Impl.ProductServiceImpl;

public class TestProduct {
    public static void main(String[] args) {
        ProductService service = new ProductServiceImpl();

        // Tạo mới
        Product p = new Product();
        p.setName("Laptop Dell XPS");
        p.setPrices(BigDecimal.valueOf(2300.00)); // dùng BigDecimal.valueOf()

        Product created = service.create(p);
        System.out.println("Created product: " + created.getId() + " - " + created.getName());

        // Tìm theo ID
        service.findById(created.getId()).ifPresent(prod ->
            System.out.println("Found: " + prod.getName() + " - $" + prod.getPrices())
        );

        // Cập nhật
        created.setPrices(BigDecimal.valueOf(2100.00)); // sửa tương tự
        Product updated = service.update(created);
        System.out.println("Updated price: " + updated.getPrices());

        // Danh sách tất cả sản phẩm
        System.out.println("All Products:");
        service.findAll().forEach(prod ->
            System.out.println("   - " + prod.getId() + ": " + prod.getName() + " ($" + prod.getPrices() + ")")
        );

        // Xóa (nếu muốn)
        // service.deleteById(created.getId());
        // System.out.println("Deleted product id " + created.getId());
    }
}
