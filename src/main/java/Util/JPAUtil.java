package Util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
	private static final EntityManagerFactory emf = buildEmf();

    private static EntityManagerFactory buildEmf() {
        try {
            return Persistence.createEntityManagerFactory("UserPU");
        } catch (Exception e) {
            // log nếu cần
            throw new RuntimeException("Cannot initialize EntityManagerFactory", e);
        }
    }

    public static EntityManager getEm() {
        return emf.createEntityManager();
    }

    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
