package data.dao;

import data.models.Cart;

public interface CartDao {
    boolean addNewProductToCart(Cart cart);
    
//    void addToCart(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException;
}
