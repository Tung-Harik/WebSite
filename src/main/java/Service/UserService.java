package Service;

import java.util.List;
import java.util.Optional;

import Entity.User;

public interface UserService {
	// CREATE
    User create(User user);

    // READ
    Optional<User> findById(Integer id);
    Optional<User> findByUsername(String username);
    List<User> findAll();
    
    List<User> findAll(int page, int size); // phân trang
    long count();

    // UPDATE
    User update(User user);

    // DELETE
    boolean deleteById(Integer id);

    // EXTRA
    boolean existsByUsername(String username);
    User login(String username, String password);
}
