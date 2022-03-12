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

    private int orderDetailID;
    private Product product;
    private float unitPrice;
    private int quantity;

    public float getTotal() {
        return product.getPrice() * quantity;
    }

    public OrderDetail() {
    }

    public OrderDetail(Product product, float unitPrice,  int quantity) {
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public OrderDetail(int orderDetailID, Product product, float unitPrice, int quantity) {
        this.orderDetailID = orderDetailID;
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

   

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
