package Service;

import java.util.List;

import Entity.Product;

public interface ProductService {
    // CREATE
    Product create(Product product);

    // READ
    Product findById(Integer id);
    List<Product> findAll();
    List<Product> findAll(int page, int size); // phân trang
    long count();

    // UPDATE
    Product update(Product product);

    // DELETE
    boolean deleteById(Integer id);

    // EXTRA
    List<Product> findByNameContaining(String keyword); // tìm theo tên gần đúng
}
