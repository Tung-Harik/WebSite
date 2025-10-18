package Controller.Api;

import java.io.IOException;
import java.util.Map;

import Entity.User;
import Security.JwtUtil;
import Service.UserService;
import Service.Impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/v1/api/auth/login")
public class AuthLogin extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final UserService userService = new UserServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json; charset=UTF-8");
	    req.setCharacterEncoding("UTF-8");

	    String body = req.getReader().lines().collect(java.util.stream.Collectors.joining());
	    String username = extract(body, "username");
	    String password = extract(body, "password");
	    if (username == null || password == null) {
	      resp.setStatus(400); resp.getWriter().write("{\"error\":\"Missing credentials\"}"); return;
	    }

	    User u = userService.login(username, password);
	    if (u == null) { resp.setStatus(401); resp.getWriter().write("{\"error\":\"Invalid\"}"); return; }

	    String access  = JwtUtil.genAccess(u.getId(), u.getUsername(), Map.of("role", u.getRoleID()));
	    String refresh = JwtUtil.genRefresh(u.getId());
	    
	    resp.getWriter().write("{\"accessToken\":\""+access+"\",\"refreshToken\":\""+refresh+"\"}");
	}
	
	private static String extract(String json, String key) {
	    var m = java.util.regex.Pattern.compile("\""+key+"\"\\s*:\\s*\"([^\"]+)\"").matcher(json);
	    return m.find()? m.group(1) : null;
	  }
}
