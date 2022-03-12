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
public class ImportInvoice {

    private int importInvoiceID;
    private Date date;
    private Supplier supplier;
    private ArrayList<ImportInvoiceDetail> invoices;
    private int status;
    private String description;

    public float getTotal() {
        float sum = 0;
        for (ImportInvoiceDetail invoice : invoices) {
            sum += invoice.getTotal();
        }
        return sum;
    }

    public ImportInvoice() {
    }

    public ImportInvoice(Date date, Supplier supplier, ArrayList<ImportInvoiceDetail> invoices, int status, String description) {
        this.date = date;
        this.supplier = supplier;
        this.invoices = invoices;
        this.status = status;
        this.description = description;
    }

    public ImportInvoice(int importInvoiceID, Date date, Supplier supplier, ArrayList<ImportInvoiceDetail> invoices, int status, String description) {
        this.importInvoiceID = importInvoiceID;
        this.date = date;
        this.supplier = supplier;
        this.invoices = invoices;
        this.status = status;
        this.description = description;
    }

    public int getImportInvoiceID() {
        return importInvoiceID;
    }

    public void setImportInvoiceID(int importInvoiceID) {
        this.importInvoiceID = importInvoiceID;
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

    public ArrayList<ImportInvoiceDetail> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<ImportInvoiceDetail> invoices) {
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
