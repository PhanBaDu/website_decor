package data.dao;

import data.impl.CategoryImpl;
import data.impl.ProductImpl;
import data.impl.UserImpl;

public interface Database {
    
    public static UserDao getUserDao() {
        return new UserImpl();
    }
    
    public static CategoryDao getCategoriesDao() {
        return new CategoryImpl();
    }
    
    public static ProductDao getProductsDao() {
        return new ProductImpl();
    }
}