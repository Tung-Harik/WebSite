package Controller;

import Util.JPAUtil;
import jakarta.persistence.EntityManager;

public class TestConnection {
    public static void main(String[] args) {
        try {
            EntityManager em = JPAUtil.getEm();
            System.out.println("Database connection OK!");
            em.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
