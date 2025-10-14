package Filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {"/user/*"})
public class NoCacheFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse resp = (HttpServletResponse) response;

	    // Chặn cache response
	    resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
	    resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); // để tương thích cũ
	    resp.setHeader("Pragma", "no-cache");
	    resp.setDateHeader("Expires", 0);

	    chain.doFilter(request, response);
	}

}
