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

    public ArrayList<ImportInvoice> getImportInvoices(String[] from, String[] to, int[] status,
            int pageIndex, int pageSize) {
        ArrayList<ImportInvoice> importInvoices = new ArrayList<>();
        SupplierDBContext sdb = new SupplierDBContext();
        try {
            String sql = "SELECT [Import_Invoice_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Supplier_ID]\n"
                    + "      ,[Discount]\n"
                    + "      ,[Discount_Type]\n"
                    + "      ,[Pay]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM "
                    + " (SELECT *, ROW_NUMBER() OVER (ORDER BY [Import_Invoice_ID] ASC) as row_index FROM [Import_Invoice]"
                    + "  WHERE (YEAR([Date]) BETWEEN " + from[0] + "  AND " + to[0] + " )\n"
                    + "  AND (MONTH([Date]) BETWEEN " + from[1] + " AND " + to[1] + " )\n"
                    + "  AND (DAY([Date]) BETWEEN " + from[2] + " AND  " + to[2] + " )";
            if (status.length != 0) {
                sql += " AND (";
                for (int i = 0; i < status.length; i++) {
                    int s = status[i];
                    sql += "[Status] = " + s;
                    if (i != status.length - 1) {
                        sql += " OR ";
                    }
                }
                sql += ")\n";
            }
            sql += ") tb";
            sql += "  WHERE row_index >=(?-1)*?+1 AND row_index <= ?*?";
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
                float discount = rs.getFloat("Discount");
                float paid = rs.getFloat("Pay");
                boolean discountType = rs.getBoolean("Discount_Type");
                String description = rs.getString("Description");
                int sta = rs.getInt("Status");
                ArrayList<ImportInvoiceDetail> importInvoiceDetails
                        = getImportInvoiceDetails(rs.getInt("Import_Invoice_ID"));
                ImportInvoice invoice = new ImportInvoice(importInvoiceID, date,
                        supplier, discount, discountType, paid, importInvoiceDetails,
                        sta, description);
                importInvoices.add(invoice);
            }
            System.out.println(sql);
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return importInvoices;
    }

    public ImportInvoice getImportInvoice(int importInvoiceID) {
        SupplierDBContext sdb = new SupplierDBContext();
        try {
            String sql = "SELECT [Import_Invoice_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Supplier_ID]\n"
                    + "      ,[Discount]\n"
                    + "      ,[Discount_Type]\n"
                    + "      ,[Pay]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Import_Invoice]\n"
                    + "  WHERE [Import_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, importInvoiceID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("Date");
                Supplier supplier = sdb.getSupplier(rs.getInt("Supplier_ID"));
                float discount = rs.getFloat("Discount");
                float paid = rs.getFloat("Pay");
                boolean discountType = rs.getBoolean("Discount_Type");
                String description = rs.getString("Description");
                int sta = rs.getInt("Status");
                ArrayList<ImportInvoiceDetail> importInvoiceDetails
                        = getImportInvoiceDetails(rs.getInt("Import_Invoice_ID"));
                ImportInvoice invoice = new ImportInvoice(importInvoiceID, date,
                        supplier, discount, discountType, paid, importInvoiceDetails,
                        sta, description);
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
                    + "           ,[Discount]\n"
                    + "           ,[Discount_Type]\n"
                    + "           ,[Pay]\n"
                    + "           ,[Status]\n"
                    + "           ,[Description])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmOne = connection.prepareStatement(sql);
            stmOne.setDate(1, invoice.getDate());
            stmOne.setInt(2, invoice.getSupplier().getSupplierID());
            stmOne.setFloat(3, invoice.getDiscount());
            stmOne.setBoolean(4, invoice.isDiscountType());
            stmOne.setFloat(5, invoice.getPaid());
            stmOne.setInt(6, invoice.getStatus());
            stmOne.setString(7, invoice.getDescription());
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

    public void updateImportInvoice(ImportInvoice in) {
        try {
            String sql = "UPDATE [dbo].[Import_Invoice]\n"
                    + "   SET [Date] = ?\n"
                    + "      ,[Supplier_ID] = ?\n"
                    + "      ,[Discount] = ?\n"
                    + "      ,[Discount_Type] = ?\n"
                    + "      ,[Pay] = ?\n"
                    + "      ,[Status] = ?\n"
                    + "      ,[Description] = ?\n"
                    + " WHERE [Import_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, in.getDate());
            stm.setInt(2, in.getSupplier().getSupplierID());
            stm.setFloat(3, in.getDiscount());
            stm.setBoolean(4, in.isDiscountType());
            stm.setFloat(5, in.getPaid());
            stm.setInt(6, in.getStatus());
            stm.setString(7, in.getDescription());
            stm.executeUpdate();

            ArrayList<ImportInvoiceDetail> invoices = in.getInvoices();
            for (ImportInvoiceDetail invoice : invoices) {
                insertImportInvoiceDetail(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateImportInvoiceDetail(ImportInvoiceDetail ind) {
        try {
            String sql = "UPDATE [dbo].[Import_Invoice_Detail]\n"
                    + "   SET [Product_ID] = ?\n"
                    + "      ,[Unit_Price] = ?\n"
                    + "      ,[Quantity] = ?\n"
                    + " WHERE [Import_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, ind.getProduct().getProductID());
            stm.setFloat(2, ind.getUnitPrice());
            stm.setInt(3, ind.getQuantity());
            stm.setInt(4, ind.getImportInvoiceID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteImportInvoiceDetail(int importInvoiceID) {
        try {
            String sql = "DELETE FROM [dbo].[Import_Invoice_Detail]\n"
                    + "      WHERE [Import_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, importInvoiceID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getTotalRecord(String[] from, String[] to, int[] status) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Import_Invoice]"
                + "WHERE (YEAR([Date]) BETWEEN " + from[0] + "  AND " + to[0] + " )\n"
                + "  AND (MONTH([Date]) BETWEEN " + from[1] + " AND " + to[1] + " )\n"
                + "  AND (DAY([Date]) BETWEEN " + from[2] + " AND  " + to[2] + ")";
        if (status.length != 0) {
            sql += " AND (";
            for (int i = 0; i < status.length; i++) {
                int s = status[i];
                sql += "[Status] = " + s;
                if (i != status.length - 1) {
                    sql += " OR ";
                }
            }
            sql += ")\n";
        }
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
