/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.transaction;

import java.util.ArrayList;
import java.util.Date;
import model.partner.Customer;

/**
 *
 * @author ADMIN
 */
public class Order {

    private int orderID;
    private Date date;
    private Customer customer;
    private ArrayList<OrderDetail> invoices;
    private int status;
    private String description;

    public float getTotal() {
        float sum = 0;
        for (OrderDetail order : invoices) {
            sum += order.getTotal();
        }
        return sum;
    }

    public Order() {
        invoices = new ArrayList<>();
    }

    public Order(int orderID, Date date, Customer customer, ArrayList<OrderDetail> invoices, int status, String description) {
        this.orderID = orderID;
        this.date = date;
        this.customer = customer;
        this.invoices = invoices;
        this.status = status;
        this.description = description;
    }

    public Order(Date date, Customer customer, ArrayList<OrderDetail> invoices, int status, String description) {
        this.date = date;
        this.customer = customer;
        this.invoices = invoices;
        this.status = status;
        this.description = description;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public ArrayList<OrderDetail> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<OrderDetail> invoices) {
        this.invoices = invoices;
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
