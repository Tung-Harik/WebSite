package Service.Impl;

import java.util.List;

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
    public Product findById(Integer id) {
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
	public List<Product> findByNameContaining(String keyword, int page, int size) {
		List<Product> all = productDao.findByNameContaining(keyword == null ? "" : keyword.trim());
        if (all.isEmpty()) return all;

        int total = all.size();
        int totalPages = (int) Math.ceil(total / (double) size);
        if (totalPages == 0) totalPages = 1;
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        int from = (page - 1) * size;
        int to = Math.min(from + size, total);
        return all.subList(from, to);
	}

	@Override
	public long countByNameContaining(String keyword) {
		return productDao.findByNameContaining(keyword == null ? "" : keyword.trim()).size();
	}
}
