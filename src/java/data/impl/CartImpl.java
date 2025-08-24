package data.impl;

import data.models.Cart;
import data.dao.CartDao;
import data.driver.MySqlDriver;
import java.sql.*;

public class CartImpl implements CartDao{
    private Connection con;
    
    public CartImpl() {
        this.con = MySqlDriver.getConnection();
    }
    
    @Override
    public boolean addNewProductToCart(Cart cart) {
        // First check if product exists in cart
        String checkSql = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
        String insertSql = "INSERT INTO cart (user_id, product_id, quantity, price, created_at, updated_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        String updateSql = "UPDATE cart SET quantity = quantity + ?, price = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ? AND product_id = ?";

        try {
            // Check if product already exists in cart
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, cart.getUserId());
                checkPs.setInt(2, cart.getProductId());

                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    // Product exists, update quantity
                    try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                        updatePs.setInt(1, cart.getQuantity());
                        updatePs.setDouble(2, cart.getPrice());
                        updatePs.setInt(3, cart.getUserId());
                        updatePs.setInt(4, cart.getProductId());

                        return updatePs.executeUpdate() > 0;
                    }
                } else {
                    // Product doesn't exist, insert new
                    try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                        insertPs.setInt(1, cart.getUserId());
                        insertPs.setInt(2, cart.getProductId());
                        insertPs.setInt(3, cart.getQuantity());
                        insertPs.setDouble(4, cart.getPrice());

                        return insertPs.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
