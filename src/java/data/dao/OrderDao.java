package data.dao;

import data.models.Order;
import java.util.List;

public interface OrderDao {
    List<Order> getAll();
    boolean create(Order order);
}
