package data.impl;

import data.models.Cart;
import data.models.Product;
import data.dao.CartDao;
import data.driver.MySqlDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartImpl implements CartDao{
    private Connection con;
    
    public CartImpl() {
        this.con = MySqlDriver.getConnection();
    }
    
    @Override
    public boolean addNewProductToCart(Cart cart) {
        String checkSql = "SELECT quantity FROM orders WHERE user_id = ? AND product_id = ?";
        String insertSql = "INSERT INTO cart (user_id, product_id, quantity, price, created_at, updated_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        String updateSql = "UPDATE cart SET quantity = quantity + ?, price = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ? AND product_id = ?";

        try {
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, cart.getUserId());
                checkPs.setInt(2, cart.getProductId());

                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                        updatePs.setInt(1, cart.getQuantity());
                        updatePs.setDouble(2, cart.getPrice());
                        updatePs.setInt(3, cart.getUserId());
                        updatePs.setInt(4, cart.getProductId());

                        return updatePs.executeUpdate() > 0;
                    }
                } else {
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

    @Override
    public List<Cart> getCartsByUserId(int userId) {
        List<Cart> carts = new ArrayList<>();

        String sql = "SELECT c.id, c.user_id, c.product_id, c.quantity AS cart_quantity, c.price, c.created_at, c.updated_at, " +
            "p.id AS product_id, p.name, p.image, p.price AS product_price, " +
            "p.quantity AS product_quantity, p.status, p.id_category " +
            "FROM orders c " +
            "JOIN products p ON c.product_id = p.id " +
            "WHERE c.user_id = ?";


        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("cart_quantity")); // Số lượng trong giỏ hàng
                cart.setPrice(rs.getDouble("price"));
                cart.setCreatedAt(rs.getTimestamp("created_at"));
                cart.setUpdatedAt(rs.getTimestamp("updated_at"));

                Product product = new Product();
                product.setId(rs.getInt("product_id")); // ID của sản phẩm
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("product_price")); // Giá của sản phẩm
                product.setQuantity(rs.getInt("product_quantity")); // Số lượng có sẵn trong kho
                product.setStatus(rs.getBoolean("status"));
                product.setIdCategory(rs.getInt("id_category"));

                cart.setProduct(product);
                carts.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return carts;
    }
    
    @Override
    public boolean removeFromCart(int cartId) {
        String sql = "DELETE FROM orders WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean increaseQuantity(int cartId, int maxQuantity) {
        String checkSql = "SELECT quantity FROM orders WHERE id = ?";
        String updateSql = "UPDATE cart SET quantity = quantity + 1, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        
        try {
            // Kiểm tra số lượng hiện tại trong giỏ hàng
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, cartId);
                ResultSet rs = checkPs.executeQuery();
                
                if (rs.next()) {
                    int cartQuantity = rs.getInt("quantity"); // Số lượng trong giỏ hàng
                    
                    // Chỉ tăng nếu số lượng trong giỏ < số lượng có sẵn trong kho
                    if (cartQuantity < maxQuantity) {
                        try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                            updatePs.setInt(1, cartId);
                            
                            return updatePs.executeUpdate() > 0;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean decreaseQuantity(int cartId) {
        String checkSql = "SELECT quantity FROM orders WHERE id = ?";
        String updateSql = "UPDATE cart SET quantity = quantity - 1, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND quantity > 1";
        
        try {
            // Kiểm tra số lượng hiện tại
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, cartId);
                ResultSet rs = checkPs.executeQuery();
                
                if (rs.next()) {
                    int currentQuantity = rs.getInt("quantity");
                    
                    if (currentQuantity > 1) {
                        // Giảm số lượng nếu > 1
                        try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                            updatePs.setInt(1, cartId);
                            
                            return updatePs.executeUpdate() > 0;
                        }
                    } else if (currentQuantity == 1) {
                        // Không làm gì nếu số lượng = 1 (không xóa)
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
