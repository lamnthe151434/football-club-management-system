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
public class ReturnInvoiceDetail {

    private int returnInvoiceDetailID;
    private Product product;
    private float unitPrice;
    private int quantity;

    public float getTotal() {
        return product.getPrice() * quantity;
    }

    public ReturnInvoiceDetail() {
    }

    public ReturnInvoiceDetail(Product product, float unitPrice, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public ReturnInvoiceDetail(int returnInvoiceDetailID, Product product, float unitPrice, int quantity) {
        this.returnInvoiceDetailID = returnInvoiceDetailID;
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

    public int getReturnInvoiceDetailID() {
        return returnInvoiceDetailID;
    }

    public void setReturnInvoiceDetailID(int returnInvoiceDetailID) {
        this.returnInvoiceDetailID = returnInvoiceDetailID;
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
