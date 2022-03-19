package model.product;

import model.product.Category;
import model.product.Brand;

public class Product {

    private int productID;
    private String productName;
    private Category category;
    private Brand brand;
    private String unit;
    private float cost;
    private float price;
    private int quantity;
    private int status;
    private String description;

    public Product() {
    }

    public Product(int productID, String productName, Category category, Brand brand, String unit, float cost, float price, int quantity, int status, String description) {
        this.productID = productID;
        this.productName = productName;
        this.category = category;
        this.brand = brand;
        this.unit = unit;
        this.cost = cost;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.description = description;
    }

    public Product(String productName, Category category, Brand brand, String unit, float cost, float price, int quantity, int status, String description) {
        this.productName = productName;
        this.category = category;
        this.brand = brand;
        this.unit = unit;
        this.cost = cost;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.description = description;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public float getCost() {
        return cost;
    }

    public void setCost(float cost) {
        this.cost = cost;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
