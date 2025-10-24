package Controller.Admin;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import Entity.User;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import Util.Passwords;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/admin/users")
public class UserController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        List<User> users = userService.findAll(); // đổi qua DAO nếu bạn không có service
        req.setAttribute("users", users);
        
        req.getRequestDispatcher("/views/admin/users.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        req.setCharacterEncoding("UTF-8");
        String action = Optional.ofNullable(req.getParameter("action")).orElse("");

        try {
            switch (action) {
                case "create":
                    handleCreate(req, session);
                    break;
                case "update":
                    handleUpdate(req, session);
                    break;
                case "delete":
                    handleDelete(req, session);
                    break;
                default:
                    session.setAttribute("flashError", "Hành động không hợp lệ");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("flashError", "Lỗi: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/users");
	}
	
	private void handleCreate(HttpServletRequest req, HttpSession session) {
		String username = trim(req.getParameter("username"));
		String password = trim(req.getParameter("password"));
		String fullname = trim(req.getParameter("fullname"));
		String email = trim(req.getParameter("email"));
		String sdt = trim(req.getParameter("sdt"));
		String diaChi = trim(req.getParameter("diaChi"));
		Integer roleID = parseIntOr(req.getParameter("roleID"), 3); // mặc định 3 = user

		if (isBlank(username) || isBlank(password)) {
			session.setAttribute("flashError", "Username và Password là bắt buộc");
			return;
		}
		
		Optional<User> existed = userService.findByUsername(username);
		if (existed.isPresent()) {
		    session.setAttribute("flashError", "Username đã tồn tại");
		    return;
		}
		
		String hashed = Passwords.hash(password);
		
		User u = User.builder().username(username).password(hashed) // TODO: Hash password nếu cần (BCrypt)
				.fullname(fullname).email(email).sdt(sdt).diaChi(diaChi).roleID(roleID).build();
		userService.create(u);
		
		session.setAttribute("flash", "Đã tạo người dùng mới");
	}

	private void handleUpdate(HttpServletRequest req, HttpSession session) {
		Integer id = parseIntOrNull(req.getParameter("id"));
		if (id == null) {
			session.setAttribute("flashError", "Thiếu ID");
			return;
		}

		User u = userService.findById(id);
		if (u == null) {
			session.setAttribute("flashError", "Không tìm thấy người dùng #" + id);
			return;
		}

		String username = trim(req.getParameter("username"));
		String password = trim(req.getParameter("password")); // có thể để trống = không đổi
		String fullname = trim(req.getParameter("fullname"));
		String email = trim(req.getParameter("email"));
		String sdt = trim(req.getParameter("sdt"));
		String diaChi = trim(req.getParameter("diaChi"));
		Integer roleID = parseIntOr(req.getParameter("roleID"), u.getRoleID() != null ? u.getRoleID() : 3);

		if (!isBlank(username) && !username.equals(u.getUsername())) {
		    User existed = userService.findByUsername(username).orElse(null);
		    if (existed != null && !existed.getId().equals(u.getId())) {
		        session.setAttribute("flashError", "Username đã tồn tại");
		        return;
		    }
		    u.setUsername(username);
		}

		if (!isBlank(password)) {
			u.setPassword(password); // TODO: hash
		}
		u.setFullname(fullname);
		u.setEmail(email);
		u.setSdt(sdt);
		u.setDiaChi(diaChi);
		u.setRoleID(roleID);

		userService.update(u);
		session.setAttribute("flash", "Đã cập nhật người dùng #" + id);
	}

	private void handleDelete(HttpServletRequest req, HttpSession session) {
		Integer id = parseIntOrNull(req.getParameter("id"));
		if (id == null) {
			session.setAttribute("flashError", "Thiếu ID");
			return;
		}

		boolean ok = userService.deleteById(id);
		session.setAttribute("flash", ok ? ("Đã xoá người dùng #" + id) : "Xoá thất bại");
	}

    private static String trim(String s) { return s == null ? null : s.trim(); }
    private static boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
    private static Integer parseIntOrNull(String s) { try { return Integer.valueOf(s); } catch (Exception e) { return null; } }
    private static Integer parseIntOr(String s, Integer def) { try { return Integer.valueOf(s); } catch (Exception e) { return def; } }
}
