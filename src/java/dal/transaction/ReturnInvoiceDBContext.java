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
import model.transaction.ReturnInvoice;
import model.transaction.ReturnInvoiceDetail;

/**
 *
 * @author ADMIN
 */
public class ReturnInvoiceDBContext extends DBContext {

    public ArrayList<ReturnInvoice> getReturnInvoices(String[] from, String[] to, int[] status,
            int pageIndex, int pageSize, String orderBy) {
        ArrayList<ReturnInvoice> returnInvoices = new ArrayList<>();
        SupplierDBContext sdb = new SupplierDBContext();
        try {
            String sql = "SELECT [Return_Invoice_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Supplier_ID]\n"
                    + "      ,[Discount]\n"
                    + "      ,[Discount_Type]\n"
                    + "      ,[Pay]\n"
                    + "      ,[Total_Amount]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM "
                    + " (SELECT *, ROW_NUMBER() OVER (" + orderBy + ") as row_index FROM [Return_Invoice]"
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
            System.out.println(sql);
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageIndex);
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int returnInvoiceID = rs.getInt("Return_Invoice_ID");
                Date date = rs.getDate("Date");
                Supplier supplier = sdb.getSupplier(rs.getInt("Supplier_ID"));
                float discount = rs.getFloat("Discount");
                float paid = rs.getFloat("Pay");
                boolean discountType = rs.getBoolean("Discount_Type");
                String description = rs.getString("Description");
                int sta = rs.getInt("Status");
                float totalAmount = rs.getFloat("Total_Amount");
                ArrayList<ReturnInvoiceDetail> returnInvoiceDetails
                        = getReturnInvoiceDetails(rs.getInt("Return_Invoice_ID"));
                ReturnInvoice invoice = new ReturnInvoice(returnInvoiceID, date,
                        supplier, discount, discountType, paid, totalAmount,
                        returnInvoiceDetails, sta, description);
                returnInvoices.add(invoice);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return returnInvoices;
    }

    public ReturnInvoice getReturnInvoice(int returnInvoiceID) {
        SupplierDBContext sdb = new SupplierDBContext();
        try {
            String sql = "SELECT [Return_Invoice_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Supplier_ID]\n"
                    + "      ,[Discount]\n"
                    + "      ,[Discount_Type]\n"
                    + "      ,[Pay]\n"
                    + "      ,[Total_Amount]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Return_Invoice]\n"
                    + "  WHERE [Return_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, returnInvoiceID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Date date = rs.getDate("Date");
                Supplier supplier = sdb.getSupplier(rs.getInt("Supplier_ID"));
                float discount = rs.getFloat("Discount");
                float paid = rs.getFloat("Pay");
                boolean discountType = rs.getBoolean("Discount_Type");
                String description = rs.getString("Description");
                int sta = rs.getInt("Status");
                float totalAmount = rs.getFloat("Total_Amount");
                ArrayList<ReturnInvoiceDetail> returnInvoiceDetails
                        = getReturnInvoiceDetails(rs.getInt("Return_Invoice_ID"));
                ReturnInvoice invoice = new ReturnInvoice(returnInvoiceID, date,
                        supplier, discount, discountType, paid, totalAmount,
                        returnInvoiceDetails, sta, description);
                return invoice;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<ReturnInvoiceDetail> getReturnInvoiceDetails(int returnInvoiceID) {
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<ReturnInvoiceDetail> returnInvoiceDetails = new ArrayList<>();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Unit_Price]\n"
                    + "      ,[Quantity]\n"
                    + "  FROM [dbo].[Return_Invoice_Detail]"
                    + "  WHERE [Return_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, returnInvoiceID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product product = pdb.getProduct(rs.getInt("Product_ID"));
                float unitPrice = rs.getFloat("Unit_Price");
                int quantity = rs.getInt("quantity");
                ReturnInvoiceDetail invoice = new ReturnInvoiceDetail(returnInvoiceID,
                        product, unitPrice, quantity);
                returnInvoiceDetails.add(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return returnInvoiceDetails;
    }

    public void insertReturnInvoice(ReturnInvoice invoice) {
        try {
            String sql = "INSERT INTO [dbo].[Return_Invoice]\n"
                    + "           ([Date]\n"
                    + "           ,[Supplier_ID]\n"
                    + "           ,[Discount]\n"
                    + "           ,[Discount_Type]\n"
                    + "           ,[Pay]\n"
                    + "           ,[Total_Amount]\n"
                    + "           ,[Status]\n"
                    + "           ,[Description])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmOne = connection.prepareStatement(sql);
            stmOne.setDate(1, invoice.getDate());
            stmOne.setInt(2, invoice.getSupplier().getSupplierID());
            stmOne.setFloat(3, invoice.getDiscount());
            stmOne.setBoolean(4, invoice.isDiscountType());
            stmOne.setFloat(5, invoice.getPaid());
            stmOne.setFloat(6, invoice.getTotalAmount());
            stmOne.setInt(7, invoice.getStatus());
            stmOne.setString(8, invoice.getDescription());
            stmOne.executeUpdate();
            ArrayList<ReturnInvoiceDetail> list = invoice.getInvoices();
            for (ReturnInvoiceDetail returnInvoiceDetail : list) {
                insertReturnInvoiceDetail(returnInvoiceDetail);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

        }

    }

    public void insertReturnInvoiceDetail(ReturnInvoiceDetail invoice) {

        try {
            String sql = "INSERT INTO [dbo].[Return_Invoice_Detail]\n"
                    + "           ([Return_Invoice_ID]\n"
                    + "           ,[Product_ID]\n"
                    + "           ,[Unit_Price]\n"
                    + "           ,[Quantity])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?)";
            PreparedStatement stmTwo = connection.prepareStatement(sql);
            stmTwo.setInt(1, invoice.getReturnInvoiceID());
            stmTwo.setInt(2, invoice.getProduct().getProductID());
            stmTwo.setFloat(3, invoice.getUnitPrice());
            stmTwo.setInt(4, invoice.getQuantity());
            stmTwo.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updateReturnInvoice(ReturnInvoice in) {
        try {
            String sql = "UPDATE [dbo].[Return_Invoice]\n"
                    + "   SET [Date] = ?\n"
                    + "      ,[Supplier_ID] = ?\n"
                    + "      ,[Discount] = ?\n"
                    + "      ,[Discount_Type] = ?\n"
                    + "      ,[Pay] = ?\n"
                    + "      ,[Total_Amount] = ?\n"
                    + "      ,[Status] = ?\n"
                    + "      ,[Description] = ?\n"
                    + " WHERE [Return_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, in.getDate());
            stm.setInt(2, in.getSupplier().getSupplierID());
            stm.setFloat(3, in.getDiscount());
            stm.setBoolean(4, in.isDiscountType());
            stm.setFloat(5, in.getPaid());
            stm.setFloat(6, in.getTotalAmount());
            stm.setInt(7, in.getStatus());
            stm.setString(8, in.getDescription());
            stm.setInt(9, in.getReturnInvoiceID());
            stm.executeUpdate();

            ArrayList<ReturnInvoiceDetail> invoices = in.getInvoices();
            for (ReturnInvoiceDetail invoice : invoices) {
                insertReturnInvoiceDetail(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateReturnInvoiceDetail(ReturnInvoiceDetail ind) {
        try {
            String sql = "UPDATE [dbo].[Return_Invoice_Detail]\n"
                    + "   SET [Product_ID] = ?\n"
                    + "      ,[Unit_Price] = ?\n"
                    + "      ,[Quantity] = ?\n"
                    + " WHERE [Return_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, ind.getProduct().getProductID());
            stm.setFloat(2, ind.getUnitPrice());
            stm.setInt(3, ind.getQuantity());
            stm.setInt(4, ind.getReturnInvoiceID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteReturnInvoiceDetail(int returnInvoiceID) {
        try {
            String sql = "DELETE FROM [dbo].[Return_Invoice_Detail]\n"
                    + "      WHERE [Return_Invoice_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, returnInvoiceID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getTotalRecord(String[] from, String[] to, int[] status) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Return_Invoice]"
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
            Logger.getLogger(ReturnInvoiceDBContext.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int getTotalRecord() {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Return_Invoice]";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReturnInvoiceDBContext.class
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
            Logger.getLogger(ReturnInvoiceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
