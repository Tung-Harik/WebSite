package Dao;

import java.util.Optional;

import Entity.Cart;
import Entity.CartItems;

public interface CartDao {
	Optional<Cart> findActiveByUserId(int userId);
	
    Cart save(Cart cart); // persist/merge
    
    Optional<CartItems> findItemById(int itemId);
    
    void deleteItem(CartItems item);
    
    Optional<Cart> findById(int cartId);
    
    boolean deleteItemByIdAndUserId(int itemId, int userId);
}
