package Dao;

import java.util.List;

import Entity.Product;

public interface ProductDao {
    Product create(Product product);
    Product findById(Integer id);
    List<Product> findAll();
    List<Product> findAll(int page, int size);
    long count();
    Product update(Product product);
    boolean deleteById(Integer id);
    List<Product> findByNameContaining(String keyword);
}
