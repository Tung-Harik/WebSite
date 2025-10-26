package Dao;

import java.util.List;
import java.util.Optional;

import Entity.User;

public interface UserDao {
	// CREATE
    User create(User user);

    // READ
    User findById(Integer id);
    Optional<User> findByUsername(String username);
    List<User> findByNameLike(String name);
    
    List<User> findAll();
    
    List<User> findAll(int page, int size); // phân trang
    long count();

    // UPDATE
    User update(User user);

    // DELETE
    boolean deleteById(Integer id);

    // EXTRA
    boolean existsByUsername(String username);
    
    User findByEmail(String email);
}
