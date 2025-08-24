package data.impl;

import data.dao.CategoryDao;
import java.util.List;
import java.sql.Connection;
import data.driver.MySqlDriver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import data.models.Category;
import java.util.ArrayList;

public class CategoryImpl implements CategoryDao {
    private Connection con;
    
    public CategoryImpl() {
        this.con = MySqlDriver.getConnection();
    }
    
    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT id, name FROM categories";

        try (PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                list.add(new Category(id, name));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    @Override
    public boolean create(Category category) {
        String sql = "INSERT INTO categories (name) VALUES (?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean existsByName(String name) {
        String sql = "SELECT COUNT(*) FROM categories WHERE LOWER(name) = LOWER(?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
