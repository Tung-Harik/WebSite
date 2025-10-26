package Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import Entity.User;

public interface UserService {
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
    User login(String username, String password);
    
    //Forgot Password
    User findByEmailOrNull(String email);
    void setResetCode(User u, String code, Date expiry);
    void clearResetCode(User u);
}
