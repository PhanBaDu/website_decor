package data.dao;

import java.util.List;
import data.models.Product;

public interface ProductDao {
    public List<Product> findAll();
    
    public Product findById(int id);
    
    public boolean create(Product product);
}
