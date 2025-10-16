package Service;

import Entity.Cart;

public interface CartService {
	Cart getOrCreateActiveCart(int userId);
	
    void addItem(int userId, int productId, int quantity);         // tuỳ chọn
    
    void updateItemQuantity(int userId, int itemId, int quantity);
    
    boolean removeItem(int userId, int itemId);
    
    void checkout(int userId);
    
    Cart loadActiveCartForView(int userId); // đã nạp items & product để forward JSP
}
