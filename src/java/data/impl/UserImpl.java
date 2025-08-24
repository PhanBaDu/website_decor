package data.impl;

import java.sql.Connection;
import data.dao.UserDao;
import data.driver.MySqlDriver;
import data.models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserImpl implements UserDao{
    private Connection con;
    
    public UserImpl() {
        this.con = MySqlDriver.getConnection();
    }
    
    @Override
    public User find(String emailPhone, String password) {
        String sql;
        boolean isEmail = emailPhone.contains("@");

        if (isEmail) {
            sql = "SELECT id, name, email, phone, password, role FROM users WHERE email = ? AND password = ?";
        } else {
            sql = "SELECT id, name, email, phone, password, role FROM users WHERE phone = ? AND password = ?";
        }

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, emailPhone);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    
    @Override
    public User insertUser(String name, String email, String phone, String password) {
        if (existsByEmail(email)) {
            throw new IllegalArgumentException("Email đã được sử dụng.");
        }
        
        if (existsByPhone(phone)) {
            throw new IllegalArgumentException("Số điện thoại đã được sử dụng.");
        }
        
        String sql = "INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, 1)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.setString(5, "USER");
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                return null; 
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    return new User(id, name, email, phone, password, "USER");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public boolean existsByEmail(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // nếu có kết quả → tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean existsByPhone(String phone) {
        String sql = "SELECT id FROM users WHERE phone = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
