package Dao.Impl;

import java.util.List;
import java.util.Optional;

import Dao.UserDao;
import Entity.User;
import Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class UserDaoImpl implements UserDao{

	@Override
	public User create(User user) {
		EntityManager em = JPAUtil.getEm();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            em.persist(user);
            tx.commit();
            return user; 
        } catch (RuntimeException e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
	}

	@Override
	public User findById(Integer id) {
		EntityManager em = JPAUtil.getEm();
		
		try {
	        return em.find(User.class, id);
	    } finally {
	        em.close();
	    }
	}

	@Override
	public Optional<User> findByUsername(String username) {
		EntityManager em = JPAUtil.getEm();
		
        try {
            TypedQuery<User> q = em.createQuery(
                "SELECT u FROM User u WHERE u.username = :username", User.class);
            q.setParameter("username", username);
            return Optional.of(q.getSingleResult());
        } catch (NoResultException ex) {
            return Optional.empty();
        } finally {
            em.close();
        }
	}

	@Override
	public List<User> findAll() {
		EntityManager em = JPAUtil.getEm();
		
        try {
            return em.createQuery("SELECT u FROM User u ORDER BY u.id DESC", User.class)
                     .getResultList();
        } finally {
            em.close();
        }
	}

	@Override
	public List<User> findAll(int page, int size) {
		int first = Math.max(0, (page - 1) * size);
        EntityManager em = JPAUtil.getEm();
        
        try {
            return em.createQuery("SELECT u FROM User u ORDER BY u.id DESC", User.class)
                     .setFirstResult(first)
                     .setMaxResults(size)
                     .getResultList();
        } finally {
            em.close();
        }
	}

	@Override
	public long count() {
		EntityManager em = JPAUtil.getEm();
		
        try {
            return em.createQuery("SELECT COUNT(u) FROM User u", Long.class)
                     .getSingleResult();
        } finally {
            em.close();
        }
	}

	@Override
	public User update(User user) {
		EntityManager em = JPAUtil.getEm();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            User merged = em.merge(user); // trả về bản managed
            tx.commit();
            return merged;
        } catch (RuntimeException e) {
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
            User ref = em.find(User.class, id);
            if (ref != null) {
                em.remove(ref);
                tx.commit();
                return true;
            } else {
                tx.rollback();
                return false;
            }
        } catch (RuntimeException e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
	}

	@Override
	public boolean existsByUsername(String username) {
		EntityManager em = JPAUtil.getEm();
		
        try {
            Long cnt = em.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.username = :u", Long.class)
                    .setParameter("u", username)
                    .getSingleResult();
            return cnt != null && cnt > 0;
        } finally {
            em.close();
        }
	}

	@Override
	public User findByEmail(String email) {
		EntityManager em = JPAUtil.getEm();
	    try {
	        TypedQuery<User> query = em.createQuery(
	            "SELECT u FROM User u WHERE u.email = :email", User.class);
	        query.setParameter("email", email);
	        List<User> result = query.getResultList();
	        return result.isEmpty() ? null : result.get(0);
	    } finally {
	        em.close();
	    }
	}

}
