package Filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/user/*"})
public class AuthFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req  = (HttpServletRequest) request;
	    HttpServletResponse resp = (HttpServletResponse) response;

	    HttpSession session = req.getSession(false);
	    Object account = (session == null) ? null : session.getAttribute("account");

	    if (account == null) {
	      // chưa đăng nhập -> về trang login
	      resp.sendRedirect(req.getContextPath() + "/login");
	      return;
	    }

	    chain.doFilter(request, response);
	}

}
