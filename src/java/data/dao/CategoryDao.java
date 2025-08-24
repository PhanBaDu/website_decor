package data.dao;

import java.util.List;
import data.models.Category;

public interface CategoryDao {
    public List<Category> findAll();
}
