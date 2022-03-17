/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.transaction;

import java.util.ArrayList;
import java.sql.Date;
import model.partner.Supplier;

/**
 *
 * @author ADMIN
 */
public class ReturnInvoice {

    private int returnInvoiceID;
    private Date date;
    private Supplier supplier;
    private float discount;
    private boolean discountType;
    private float paid;
    private ArrayList<ReturnInvoiceDetail> invoices;
    private int status;
    private String description;

    public float getMustPay() {
        float sum = 0;
        for (ReturnInvoiceDetail invoice : invoices) {
            sum += invoice.getTotal();
        }
        if (discountType) {
            sum -= discount;
        } else {
            sum -= (sum * (discount / 100));
        }
        return sum;
    }

    public float getReturnMoney() {
        return paid - getMustPay();
    }

    public float getTotal() {
        float sum = 0;
        for (ReturnInvoiceDetail invoice : invoices) {
            sum += invoice.getTotal();
        }
        return sum;
    }

    public ReturnInvoice() {
        invoices = new ArrayList<>();
    }

    public ReturnInvoice(int returnInvoiceID, Date date, Supplier supplier, float discount, boolean discountType, float paid, ArrayList<ReturnInvoiceDetail> invoices, int status, String description) {
        this.returnInvoiceID = returnInvoiceID;
        this.date = date;
        this.supplier = supplier;
        this.discount = discount;
        this.discountType = discountType;
        this.paid = paid;
        this.invoices = invoices;
        this.status = status;
        this.description = description;
    }

    public ReturnInvoice(Date date, Supplier supplier, float discount, boolean discountType, float paid, ArrayList<ReturnInvoiceDetail> invoices, int status, String description) {
        this.date = date;
        this.supplier = supplier;
        this.discount = discount;
        this.discountType = discountType;
        this.paid = paid;
        this.invoices = invoices;
        this.status = status;
        this.description = description;
    }

    public int getReturnInvoiceID() {
        return returnInvoiceID;
    }

    public void setReturnInvoiceID(int returnInvoiceID) {
        this.returnInvoiceID = returnInvoiceID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public boolean isDiscountType() {
        return discountType;
    }

    public void setDiscountType(boolean discountType) {
        this.discountType = discountType;
    }

    public float getPaid() {
        return paid;
    }

    public void setPaid(float paid) {
        this.paid = paid;
    }

    public ArrayList<ReturnInvoiceDetail> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<ReturnInvoiceDetail> invoices) {
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
