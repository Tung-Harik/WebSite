package Security;

import java.security.Key;
import java.util.Date;
import java.util.Map;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

public class JwtUtil {
	private static final Key KEY = Keys.hmacShaKeyFor(JwtConfig.SECRET.getBytes());
	
	public static String genAccess(int userId, String username, Map<String, Object> extra) {
		long now = System.currentTimeMillis();
		return Jwts.builder().setIssuer(JwtConfig.ISSUER).setSubject(String.valueOf(userId)).setIssuedAt(new Date(now))
				.setExpiration(new Date(now + JwtConfig.ACCESS_TTL_MS))
				.addClaims(extra == null ? Map.of("uname", username) : extra).signWith(KEY, SignatureAlgorithm.HS256)
				.compact();
	}

	public static String genRefresh(int userId) {
		long now = System.currentTimeMillis();
		return Jwts.builder().setIssuer(JwtConfig.ISSUER).setSubject(String.valueOf(userId)).setIssuedAt(new Date(now))
				.setExpiration(new Date(now + JwtConfig.REFRESH_TTL_MS)).claim("type", "refresh")
				.signWith(KEY, SignatureAlgorithm.HS256).compact();
	}

	public static Jws<Claims> parse(String token) {
		return Jwts.parserBuilder().setSigningKey(KEY).build().parseClaimsJws(token);
	}

	public static int getUserId(String token) {
		return Integer.parseInt(parse(token).getBody().getSubject());
	}

	public static boolean isRefresh(String token) {
		Object t = parse(token).getBody().get("type");
		return "refresh".equals(t);
	}
}
