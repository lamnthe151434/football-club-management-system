/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.transaction;

import dal.DBContext;
import dal.partner.SupplierDBContext;
import dal.product.ProductDBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.partner.Supplier;
import model.product.Product;
import model.transaction.ImportInvoice;
import model.transaction.ImportInvoiceDetail;

/**
 *
 * @author ADMIN
 */
public class ImportInvoiceDBContext extends DBContext {

    public ArrayList<ImportInvoice> getImportInvoices(int pageIndex, int pageSize) {
        ArrayList<ImportInvoice> importInvoices = new ArrayList<>();
        SupplierDBContext sdb = new SupplierDBContext();
        try {
            String sql = "SELECT [Import_Invoice_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Supplier_ID]\n"
                    + "      ,[Description]\n"
                    + "      ,[Status] FROM "
                    + " (SELECT *, ROW_NUMBER() OVER (ORDER BY [Import_Invoice_ID] ASC) as row_index FROM [Import_Invoice]) tb\n"
                    + "  WHERE row_index >=(?-1)*?+1 AND row_index <= ?*?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageIndex);
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int importInvoiceID = rs.getInt("Import_Invoice_ID");
                Date date = rs.getDate("Date");
                Supplier supplier = sdb.getSupplier(rs.getInt("Supplier_ID"));
                String description = rs.getString("Description");
                int status = rs.getInt("Status");
                ArrayList<ImportInvoiceDetail> importInvoiceDetails
                        = getImportInvoiceDetails(rs.getInt("Import_Invoice_ID"));
                ImportInvoice invoice = new ImportInvoice(importInvoiceID, date,
                        supplier, importInvoiceDetails, status, description);
                importInvoices.add(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return importInvoices;
    }

    public ImportInvoice getImportInvoice(int importInvoiceID) {
        SupplierDBContext sdb = new SupplierDBContext();
        try {
            String sql = "SELECT [Date]\n"
                    + "      ,[Supplier_ID]\n"
                    + "      ,[Description]\n"
                    + "      ,[Status] [Import_Invoice]\n"
                    + "  WHERE ]Import_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, importInvoiceID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("Date");
                Supplier supplier = sdb.getSupplier(rs.getInt("Supplier_ID"));
                String description = rs.getString("Description");
                int status = rs.getInt("Status");
                ArrayList<ImportInvoiceDetail> importInvoiceDetails
                        = getImportInvoiceDetails(importInvoiceID);
                ImportInvoice invoice = new ImportInvoice(importInvoiceID, date,
                        supplier, importInvoiceDetails, status, description);
                return invoice;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<ImportInvoiceDetail> getImportInvoiceDetails(int importInvoiceID) {
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<ImportInvoiceDetail> importInvoiceDetails = new ArrayList<>();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Unit_Price]\n"
                    + "      ,[Quantity]\n"
                    + "  FROM [dbo].[Import_Invoice_Detail]"
                    + "  WHERE [Import_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, importInvoiceID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product product = pdb.getProduct(rs.getInt("Product_ID"));
                float unitPrice = rs.getFloat("Unit_Price");
                int quantity = rs.getInt("quantity");
                ImportInvoiceDetail invoice = new ImportInvoiceDetail(importInvoiceID,
                        product, unitPrice, quantity);
                importInvoiceDetails.add(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return importInvoiceDetails;
    }

    public void insertImportInvoice(ImportInvoice invoice) {
        try {
            String sql = "INSERT INTO [dbo].[Import_Invoice]\n"
                    + "           ([Date]\n"
                    + "           ,[Supplier_ID]\n"
                    + "           ,[Description]\n"
                    + "           ,[Status])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?)";
            PreparedStatement stmOne = connection.prepareStatement(sql);
            stmOne.setDate(1, (Date) invoice.getDate());
            stmOne.setInt(2, invoice.getSupplier().getSupplierID());
            stmOne.setString(3, invoice.getDescription());
            stmOne.setInt(4, invoice.getStatus());
            stmOne.executeUpdate();
            ArrayList<ImportInvoiceDetail> list = invoice.getInvoices();

            for (ImportInvoiceDetail importInvoiceDetail : list) {
                insertImportInvoiceDetail(importInvoiceDetail);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

        }

    }

    public void insertImportInvoiceDetail(ImportInvoiceDetail invoice) {

        try {
            String sql = "INSERT INTO [dbo].[Import_Invoice_Detail]\n"
                    + "           ([Import_Invoice_ID]\n"
                    + "           ,[Product_ID]\n"
                    + "           ,[Unit_Price]\n"
                    + "           ,[Quantity])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?)";
            PreparedStatement stmTwo = connection.prepareStatement(sql);
            stmTwo.setInt(1, invoice.getImportInvoiceID());
            stmTwo.setInt(2, invoice.getProduct().getProductID());
            stmTwo.setFloat(3, invoice.getUnitPrice());
            stmTwo.setInt(4, invoice.getQuantity());
            stmTwo.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public int getTotalRecord() {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Import_Invoice]";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");

            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public Date today() {
        try {
            String sql = "SELECT GETDATE() AS [Date]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDate("Date");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
