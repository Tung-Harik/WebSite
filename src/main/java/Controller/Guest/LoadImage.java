package Controller.Guest;

import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/img")
public class LoadImage extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String BASE_DIR = "/assets/img/products";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String f = req.getParameter("f");
	    if (f == null || f.isBlank()) {
	      resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
	      return;
	    }

	    // Giải mã UTF-8 và chặn path-traversal
	    f = URLDecoder.decode(f, StandardCharsets.UTF_8);
	    if (f.contains("..") || f.contains("/") || f.contains("\\")) {
	      resp.sendError(HttpServletResponse.SC_FORBIDDEN);
	      return;
	    }

	    // Lấy đường dẫn thực trong webapp
	    String real = getServletContext().getRealPath(BASE_DIR + "/" + f);
	    File file = new File(real);
	    if (!file.exists() || !file.isFile()) {
	      // fallback ảnh dự phòng
	      real = getServletContext().getRealPath(BASE_DIR + "/noimage.jpg");
	      file = new File(real);
	      if (!file.exists()) {
	        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return;
	      }
	    }

	    // Content-Type theo đuôi file
	    String mime = getServletContext().getMimeType(file.getName());
	    if (mime == null) mime = "application/octet-stream";
	    resp.setContentType(mime);
	    resp.setHeader("Cache-Control", "public, max-age=86400");

	    try (InputStream in = new FileInputStream(file);
	         OutputStream out = resp.getOutputStream()) {
	      in.transferTo(out);
	    }
	}
}
