package data.dao;

import data.models.Cart;
import java.util.List;

public interface CartDao {
    boolean addNewProductToCart(Cart cart);
    
    List<Cart> getCartsByUserId(int userId);
}
