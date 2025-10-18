package Security;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {"/v1/api/*"})
public class JwtAuthFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		String path = req.getRequestURI().substring(req.getContextPath().length());
		
		// Cho phép các endpoint PUBLIC đi qua không cần token
	    if (path.startsWith("/v1/api/auth/login")
	        || path.startsWith("/v1/api/auth/refresh")) {
	      chain.doFilter(req, resp);
	      return;
	    }

	    // Cho phép OPTIONS (CORS preflight) không cần token
	    if ("OPTIONS".equalsIgnoreCase(req.getMethod())) {
	      resp.setStatus(HttpServletResponse.SC_OK);
	      return;
	    }
	    
		String auth = req.getHeader("Authorization");
		
		if (auth == null || !auth.startsWith("Bearer ")) {
			resp.setStatus(401);
			resp.setContentType("application/json;charset=UTF-8");
			resp.getWriter().write("{\"error\":\"Missing Bearer token\"}");
			return;
		}

		try {
			String token = auth.substring(7);
			var jws = JwtUtil.parse(token); // verify signature + exp
			int userId = Integer.parseInt(jws.getBody().getSubject());
			req.setAttribute("jwtUserId", userId);
			chain.doFilter(req, resp);
		} catch (io.jsonwebtoken.JwtException e) {
			resp.setStatus(401);
			resp.setContentType("application/json;charset=UTF-8");
			resp.getWriter().write("{\"error\":\"Invalid or expired token\"}");
		}
	}
	
}
