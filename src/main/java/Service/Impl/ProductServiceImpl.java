package Service.Impl;

import java.util.List;
import java.util.Optional;

import Dao.ProductDao;
import Dao.Impl.ProductDaoImpl;
import Entity.Product;
import Service.ProductService;

public class ProductServiceImpl implements ProductService {

    private final ProductDao productDao = new ProductDaoImpl();

    @Override
    public Product create(Product product) {
        return productDao.create(product);
    }

    @Override
    public Optional<Product> findById(Integer id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findAll(int page, int size) {
        return productDao.findAll(page, size);
    }

    @Override
    public long count() {
        return productDao.count();
    }

    @Override
    public Product update(Product product) {
        return productDao.update(product);
    }

    @Override
    public boolean deleteById(Integer id) {
        return productDao.deleteById(id);
    }

    @Override
    public List<Product> findByNameContaining(String keyword) {
        return productDao.findByNameContaining(keyword);
    }
}
