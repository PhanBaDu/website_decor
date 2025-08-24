package data.dao;

import data.models.User;

public interface UserDao {
    public User find(String emailPhone, String password);
    public User insertUser(String name, String email, String phone, String password);
    public boolean existsByEmail(String email);
    public boolean existsByPhone(String phone);
}
