/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.transaction;

import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class OrderDetail {

    private int orderID;
    private Product product;
    private float unitPrice;
    private int quantity;

    public float getTotal() {
        return product.getPrice() * quantity;
    }

    public OrderDetail() {
    }

    public OrderDetail(int orderID, Product product, float unitPrice, int quantity) {
        this.orderID = orderID;
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public OrderDetail(Product product, float unitPrice, int quantity) {
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

  
   
}
