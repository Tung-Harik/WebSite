package Security;

public class JwtConfig {
	public static final String ISSUER = "UTE SHOP";
	public static final String SECRET = "change_this_to_a_real_256bit_secret________________________________";
	public static final long ACCESS_TTL_MS = 15 * 60 * 1000; // 15 phút
	public static final long REFRESH_TTL_MS = 7L * 24 * 60 * 60 * 1000; // 7 ngày

	private JwtConfig() {
	}
}
