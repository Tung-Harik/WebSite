package Service.Impl;

import java.math.BigDecimal;
import java.util.Date;

import Dao.CartDao;
import Dao.Impl.CartDaoImpl;
import Entity.Cart;
import Entity.CartItems;
import Entity.Invoice;
import Entity.Product;
import Entity.User;
import Service.CartService;
import Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;

public class CartServiceImpl implements CartService{

	private final CartDao cartDao = new CartDaoImpl();
	
	@Override
	public Cart getOrCreateActiveCart(int userId) {
		return cartDao.findActiveByUserId(userId).orElseGet(() -> {
            // tạo cart mới
            EntityManager em = JPAUtil.getEm();
            try {
                em.getTransaction().begin();
                User userRef = em.getReference(User.class, userId);

                Cart cart = new Cart();
                cart.setUser(userRef);
                cart.setCheckedOut(false);

                em.persist(cart);
                em.getTransaction().commit();
                return cart;
            } catch (Exception ex) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw ex;
            } finally {
                em.close();
            }
        });
	}

	@Override
	public void addItem(int userId, int productId, int quantity) {
		if (quantity < 1) quantity = 1;

        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();

            // cart active cho user
            Cart cart = cartDao.findActiveByUserId(userId).orElse(null);
            if (cart == null) {
                User u = em.getReference(User.class, userId);
                cart = new Cart();
                cart.setUser(u);
                cart.setCheckedOut(false);
                em.persist(cart);
                em.flush();
            } else {
                // chuyển sang managed
                cart = em.merge(cart);
            }

            Product p = em.getReference(Product.class, productId);

            // BUSINESS: nếu cùng sản phẩm đã có trong giỏ => tăng số lượng
            Cart finalCart = cart;
            CartItems existed = cart.getItems().stream()
            		.filter(i -> i.getProduct().getId() == productId)
                    .findFirst().orElse(null);

            if (existed != null) {
                existed.setQuantity(existed.getQuantity() + quantity);
            } else {
                CartItems item = new CartItems();
                item.setCart(finalCart);
                item.setProduct(p);
                item.setQuantity(quantity);
                // chốt giá tại thời điểm thêm:
                BigDecimal currentPrice = p.getPrices(); // giả định Product có getPrice()
                item.setPrice(currentPrice);
                finalCart.getItems().add(item);
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
	public void updateItemQuantity(int userId, int itemId, int quantity) {
		if (quantity < 1) quantity = 1;

        EntityManager em = JPAUtil.getEm();
        try {
            em.getTransaction().begin();
            CartItems item = em.find(CartItems.class, itemId);
            if (item == null) {
                em.getTransaction().rollback();
                return;
            }
            // Bảo vệ: chỉ cho sửa item thuộc cart active của đúng user
            Cart cart = item.getCart();
            if (cart.getUser().getId() != userId || Boolean.TRUE.equals(cart.getCheckedOut())) {
                em.getTransaction().rollback();
                return;
            }
            item.setQuantity(quantity);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
	}

	@Override
	public boolean removeItem(int userId, int itemId) {
		return cartDao.deleteItemByIdAndUserId(itemId, userId);
	}

	@Override
	public void checkout(int userId) {
		EntityManager em = JPAUtil.getEm();
	    EntityTransaction tx = em.getTransaction();
	    
	    try {
	      tx.begin();

	      // Lấy cart đang mở kèm items + product trong CÙNG EM
	      Cart cart = em.createQuery("""
	          SELECT c FROM Cart c
	          LEFT JOIN FETCH c.items it
	          LEFT JOIN FETCH it.product p
	          WHERE c.user.id = :uid
	            AND (c.checkedOut = false OR c.checkedOut IS NULL)
	        """, Cart.class)
	        .setParameter("uid", userId)
	        .getSingleResult();

	      if (cart.getItems() == null || cart.getItems().isEmpty()) {
	        tx.rollback();
	        return; // giỏ trống
	      }

	      Date now = new Date();

	      // Mỗi CartItem -> 1 dòng Invoice (đúng schema hiện tại của bạn)
	      for (CartItems it : cart.getItems()) {
	        Invoice inv = new Invoice();
	        inv.setNgayLap(now);
	        inv.setNguoiDungID(userId);
	        inv.setProduct(it.getProduct());
	        inv.setSoLuong(it.getQuantity());
	        inv.setDonGia(it.getPrice());
	        
	        // Nếu DB không tự tính tongTien, có thể set:
	        // inv.setTongTien(it.getPrice().multiply(BigDecimal.valueOf(it.getQuantity())));

	        em.persist(inv); // dùng cùng EM cho nhanh (thay vì gọi invoiceDao.create)
	      }

	      cart.setCheckedOut(true);
	      em.createQuery("DELETE FROM CartItems ci WHERE ci.cart.id = :cid")
	        .setParameter("cid", cart.getId())
	        .executeUpdate();

	      tx.commit();
	    } catch (NoResultException e) {
	      if (tx.isActive()) tx.rollback(); // không có cart mở
	    } catch (Exception e) {
	      if (tx.isActive()) tx.rollback();
	      throw e;
	    } finally { em.close(); }
	}

	@Override
	public Cart loadActiveCartForView(int userId) {
		return getOrCreateActiveCart(userId);
	}

}
