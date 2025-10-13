package Dao;

import Entity.Invoice;
import Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class InvoiceDao {

    public void create(Invoice invoice) {
        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            em.persist(invoice);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Invoice findById(int id) {
        EntityManager em = JPAUtil.getEm();
        try {
            return em.find(Invoice.class, id);
        } finally {
            em.close();
        }
    }

    public List<Invoice> findAll() {
        EntityManager em = JPAUtil.getEm();
        try {
            TypedQuery<Invoice> q = em.createQuery("SELECT i FROM Invoice i", Invoice.class);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Invoice invoice) {
        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            em.merge(invoice);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            Invoice invoice = em.find(Invoice.class, id);
            if (invoice != null) em.remove(invoice);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
