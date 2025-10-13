package Dao;

import Entity.Product;
import Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class ProductDao {

    public void create(Product p) {
        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Product findById(int id) {
        EntityManager em = JPAUtil.getEm();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    public List<Product> findAll() {
        EntityManager em = JPAUtil.getEm();
        try {
            TypedQuery<Product> q = em.createQuery("SELECT p FROM Product p", Product.class);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Product p) {
        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            em.merge(p);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            Product p = em.find(Product.class, id);
            if (p != null) em.remove(p);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}