package com.cart;
import java.io.Serializable;

public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int productId;
    private String productName;
    private int quantity;
    private double price;
    private String imageBase64;
    private int cartItemID;
    
    public CartItem() {
    }

    public CartItem(int productId, String productName, int quantity, double price, String imageBase64) {
        if (quantity <= 0) throw new IllegalArgumentException("Quantity must be positive.");
        if (price < 0) throw new IllegalArgumentException("Price must be non-negative.");
        if (productName == null || productName.isEmpty()) throw new IllegalArgumentException("Product name cannot be null or empty.");

        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.imageBase64 = imageBase64 != null ? imageBase64 : "";
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
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

    public String getImageBase64() {
        return imageBase64;
    }

    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
    }
    public int getcartItemID() {
        return cartItemID;
    }

    public void setcartItemID(int cartItemID) {
        this.cartItemID = cartItemID;
    }
}
