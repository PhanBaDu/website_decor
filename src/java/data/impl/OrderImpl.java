package data.impl;

import data.dao.OrderDao;
import data.models.Order;
import data.models.OrderItem;
import data.driver.MySqlDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderImpl implements OrderDao {
    
    @Override
    public List<Order> getAll() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY created_at DESC";
        
        try (Connection conn = MySqlDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderNumber(rs.getString("order_number"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setShippingPhone(rs.getString("shipping_phone"));
                order.setShippingName(rs.getString("shipping_name"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                
                // Lấy order items
                order.setOrderItems(getOrderItems(order.getId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    @Override
    public boolean create(Order order) {
        String sql = "INSERT INTO orders (user_id, order_number, total_amount, shipping_address, " +
                    "shipping_phone, shipping_name, order_status, payment_method, created_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = MySqlDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getOrderNumber());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getShippingPhone());
            ps.setString(6, order.getShippingName());
            ps.setString(7, order.getOrderStatus());
            ps.setString(8, order.getPaymentMethod());
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                // Lấy ID của order vừa tạo
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    order.setId(orderId);
                    
                    // Tạo order items
                    if (order.getOrderItems() != null) {
                        createOrderItems(orderId, order.getOrderItems());
                    }
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        
        try (Connection conn = MySqlDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setSubtotal(rs.getDouble("subtotal"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    
    private boolean createOrderItems(int orderId, List<OrderItem> items) {
        String sql = "INSERT INTO order_items (order_id, product_id, product_name, product_image, " +
                    "quantity, price, subtotal, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = MySqlDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setString(3, item.getProductName());
                ps.setString(4, item.getProductImage());
                ps.setInt(5, item.getQuantity());
                ps.setDouble(6, item.getPrice());
                ps.setDouble(7, item.getSubtotal());
                ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
                ps.addBatch();
            }
            
            int[] results = ps.executeBatch();
            for (int result : results) {
                if (result <= 0) return false;
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper method để tạo order number
    public String generateOrderNumber() {
        return "ORD" + System.currentTimeMillis();
    }
}
