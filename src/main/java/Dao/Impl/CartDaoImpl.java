package Dao.Impl;

import java.util.Optional;

import Dao.CartDao;
import Entity.Cart;
import Entity.CartItems;
import Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class CartDaoImpl implements CartDao{

	@Override
	public Optional<Cart> findActiveByUserId(int userId) {
		EntityManager em = JPAUtil.getEm();
        try {
            String jpql = "SELECT c FROM Cart c " +
                          "LEFT JOIN FETCH c.items i " +   // nạp items để dùng ở JSP
                          "LEFT JOIN FETCH i.product p " + // nạp product để hiển thị
                          "WHERE c.user.id = :uid AND c.checkedOut = false";
            TypedQuery<Cart> q = em.createQuery(jpql, Cart.class);
            q.setParameter("uid", userId);
            Cart result = q.getSingleResult();
            return Optional.of(result);
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
	}

	@Override
	public Cart save(Cart cart) {
		EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            Cart merged = em.merge(cart);
            em.getTransaction().commit();
            return merged;
        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
	}

	@Override
	public Optional<CartItems> findItemById(int itemId) {
		EntityManager em = JPAUtil.getEm();
        try {
            CartItems item = em.find(CartItems.class, itemId);
            if (item != null) {
                // chạm product để đảm bảo nạp trước khi đóng EM nếu bạn cần
                item.getProduct().getId();
            }
            return Optional.ofNullable(item);
        } finally {
            em.close();
        }
	}

	@Override
	public void deleteItem(CartItems item) {
		EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            CartItems managed = em.find(CartItems.class, item.getId());
            if (managed != null) {
                em.remove(managed);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
	}

	@Override
	public Optional<Cart> findById(int cartId) {
		EntityManager em = JPAUtil.getEm();
        try {
            Cart c = em.find(Cart.class, cartId);
            return Optional.ofNullable(c);
        } finally {
            em.close();
        }
	}

	@Override
	public boolean deleteItemByIdAndUserId(int itemId, int userId) {
		var em = JPAUtil.getEm();
	    try {
	        em.getTransaction().begin();
	        int affected = em.createQuery("""
	            DELETE FROM CartItems ci
	            WHERE ci.id = :iid
	              AND ci.cart.user.id = :uid
	              AND (ci.cart.checkedOut = false OR ci.cart.checkedOut IS NULL)
	        """)
	        .setParameter("iid", itemId)
	        .setParameter("uid", userId)
	        .executeUpdate();
	        em.getTransaction().commit();
	        return affected > 0;
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) em.getTransaction().rollback();
	        throw e;
	    } finally {
	        em.close();
	    }
	}
	
}
