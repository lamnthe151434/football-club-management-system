package model.transaction;

import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class ImportInvoiceDetail {

    private int importInvoiceID;
    private Product product;
    private float unitPrice;
    private int quantity;

    public ImportInvoiceDetail() {
    }

    public ImportInvoiceDetail(Product product, float unitPrice, int quantity) {
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public ImportInvoiceDetail(int importInvoiceID, Product product, float unitPrice, int quantity) {
        this.importInvoiceID = importInvoiceID;
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public float getTotal() {
        return unitPrice * quantity;
    }

    public int getImportInvoiceID() {
        return importInvoiceID;
    }

    public void setImportInvoiceID(int importInvoiceID) {
        this.importInvoiceID = importInvoiceID;
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
