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
        String checkSql = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
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

        String sql = "SELECT c.*, p.id AS product_id, p.name, p.image, p.price AS product_price, " +
            "p.quantity AS product_quantity, p.status, p.id_category " +
            "FROM cart c " +
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
                cart.setQuantity(rs.getInt("quantity"));
                cart.setPrice(rs.getDouble("price"));
                cart.setCreatedAt(rs.getTimestamp("created_at"));
                cart.setUpdatedAt(rs.getTimestamp("updated_at"));

                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
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
}
