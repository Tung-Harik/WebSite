package Controller;

import Dao.ProductDao;
import Entity.Product;
import java.math.BigDecimal;

public class TestProduct {
    public static void main(String[] args) {
        ProductDao dao = new ProductDao();

        // Thêm sản phẩm mới
        Product p = new Product();
        p.setId(2);
        p.setName("Laptop Acer");
        p.setPrices(BigDecimal.valueOf(2000.00));
        dao.create(p);

        // Lấy ra
        Product found = dao.findById(1);
        if (found != null) {
            System.out.println("Found: " + found.getName() + " - " + found.getPrices());
        } else {
            System.out.println("Not found!");
        }

        // Cập nhật
        if (found != null) {
            found.setPrices(BigDecimal.valueOf(1400.00));
            dao.update(found);
            System.out.println("Updated successfully!");
        }

        // Xóa (nếu muốn)
        // dao.delete(1);
    }
}
