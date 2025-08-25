package data.impl;

import data.dao.ProductDao;
import java.util.List;
import java.sql.Connection;
import data.driver.MySqlDriver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import data.models.Product;
import java.util.ArrayList;

public class ProductImpl implements ProductDao{
    private Connection con;
    
    public ProductImpl() {
        this.con = MySqlDriver.getConnection();
    }
    
    @Override
    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, image, price, quantity, status, id_category FROM products";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                boolean status = rs.getBoolean("status");
                int idCategory = rs.getInt("id_category");

                list.add(new Product(id, name, image, price, quantity, status, idCategory));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public Product findById(int productId) {
        String sql = "SELECT id, name, image, price, quantity, status, id_category FROM products WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    boolean status = rs.getBoolean("status");
                    int idCategory = rs.getInt("id_category");

                    return new Product(id, name, image, price, quantity, status, idCategory);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public boolean create(Product product) {
        String sql = "INSERT INTO products (name, image, price, quantity, status, id_category) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getImage());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setBoolean(5, product.isStatus());
            ps.setInt(6, product.getIdCategory());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean update(Product product) {
        String sql = "UPDATE products SET name = ?, image = ?, price = ?, quantity = ?, status = ?, id_category = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getImage());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setBoolean(5, product.isStatus());
            ps.setInt(6, product.getIdCategory());
            ps.setInt(7, product.getId());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
