package Service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;

import Dao.UserDao;
import Dao.Impl.UserDaoImpl;
import Entity.User;
import Service.UserService;

public class UserServiceImpl implements UserService{

	UserDao dao = new UserDaoImpl();
	
	@Override
	public User create(User user) {
		if (dao.existsByUsername(user.getUsername().trim())) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại");
        }
		
		return dao.create(user);
	}

	@Override
	public User findById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public Optional<User> findByUsername(String username) {
		return dao.findByUsername(username);
	}

	@Override
	public List<User> findAll() {
		return dao.findAll();
	}

	@Override
	public List<User> findAll(int page, int size) {
		return dao.findAll(page, size);
	}

	@Override
	public long count() {
		return dao.count();
	}

	@Override
	public User update(User user) {
		if (user == null || user.getId() == null)
            throw new IllegalArgumentException("User/id must not be null");

        // Nếu username thay đổi, kiểm tra trùng
        User current = dao.findById(user.getId());
        if (current == null) {
            throw new RuntimeException("User không tồn tại");
        }
        
        String newUsername = user.getUsername();
        
        if (newUsername != null && !newUsername.isBlank()
                && !newUsername.equals(current.getUsername())
                && dao.existsByUsername(newUsername.trim())) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại");
        }

        return dao.update(user);
	}

	@Override
	public boolean deleteById(Integer id) {
		if (id == null) return false;
        return dao.deleteById(id);
	}

	@Override
	public boolean existsByUsername(String username) {
		if (username == null) return false;
        return dao.existsByUsername(username.trim());
	}

	
	//Method đăng nhập vào hệ thống
	@Override
	public User login(String username, String password) {
		if (username == null || password == null) return null;

	    return findByUsername(username.trim())
	        .filter(u -> BCrypt.checkpw(password, u.getPassword()))
	        .orElse(null);
	}

	@Override
	public User findByEmailOrNull(String email) {
		return dao.findByEmail(email);
	}

	@Override
	public void setResetCode(User u, String code, Date expiry) {
		u.setResetCode(code);
	    u.setResetExpiry(expiry);
	    dao.update(u);
	}

	@Override
	public void clearResetCode(User u) {
		u.setResetCode(null);
	    u.setResetExpiry(null);
	    dao.update(u);
	}

}
