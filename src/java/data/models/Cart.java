package data.models;
import java.sql.Timestamp;

public class Cart {
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private double price;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    public Cart() {
        
    }
    
    public Cart(int id, int userId, int productId, int quantity, double price, 
                Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    public Cart(int userId, int productId, int quantity, double price) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public double getSubtotal() {
        return this.quantity * this.price;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Cart cart = (Cart) obj;
        return id == cart.id;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}
