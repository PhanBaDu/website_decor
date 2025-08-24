package data.dao;

import data.models.Cart;
import java.util.List;

public interface CartDao {
    boolean addNewProductToCart(Cart cart);
    
    List<Cart> getCartsByUserId(int userId);
    
    boolean removeFromCart(int cartId);
    
    boolean increaseQuantity(int cartId, int maxQuantity);
    
    boolean decreaseQuantity(int cartId);
}
