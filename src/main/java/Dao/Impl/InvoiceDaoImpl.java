package Dao.Impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import Dao.InvoiceDao;
import Entity.Invoice;
import Util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class InvoiceDaoImpl implements InvoiceDao {

    @Override
    public Invoice create(Invoice invoice) {
        EntityManager em = JPAUtil.getEm();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(invoice);
            tx.commit();
            return invoice;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Invoice> findById(Integer id) {
        EntityManager em = JPAUtil.getEm();
        try {
            return Optional.ofNullable(em.find(Invoice.class, id));
        } finally {
            em.close();
        }
    }

    @Override
    public List<Invoice> findAll() {
        EntityManager em = JPAUtil.getEm();
        try {
            return em.createQuery("SELECT i FROM Invoice i", Invoice.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Invoice> findAll(int page, int size) {
        EntityManager em = JPAUtil.getEm();
        try {
            TypedQuery<Invoice> query = em.createQuery("SELECT i FROM Invoice i", Invoice.class);
            query.setFirstResult((page - 1) * size);
            query.setMaxResults(size);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long count() {
        EntityManager em = JPAUtil.getEm();
        try {
            return em.createQuery("SELECT COUNT(i) FROM Invoice i", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public Invoice update(Invoice invoice) {
        EntityManager em = JPAUtil.getEm();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Invoice updated = em.merge(invoice);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean deleteById(Integer id) {
        EntityManager em = JPAUtil.getEm();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Invoice invoice = em.find(Invoice.class, id);
            if (invoice != null) {
                em.remove(invoice);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Invoice> findByNguoiDungID(int userId) {
        EntityManager em = JPAUtil.getEm();
        try {
            TypedQuery<Invoice> query = em.createQuery(
                "SELECT i FROM Invoice i WHERE i.nguoiDungID = :uid", Invoice.class);
            query.setParameter("uid", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Invoice> findByDateRange(Date start, Date end) {
        EntityManager em = JPAUtil.getEm();
        try {
            TypedQuery<Invoice> query = em.createQuery(
                "SELECT i FROM Invoice i WHERE i.ngayLap BETWEEN :s AND :e", Invoice.class);
            query.setParameter("s", start);
            query.setParameter("e", end);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
