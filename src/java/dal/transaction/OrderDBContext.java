/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.transaction;

import dal.DBContext;
import dal.partner.CustomerDBContext;
import dal.product.ProductDBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.partner.Customer;
import model.product.Product;
import model.transaction.Order;
import model.transaction.OrderDetail;

/**
 *
 * @author ADMIN
 */
public class OrderDBContext extends DBContext {

    public ArrayList<Order> getOrders(String[] from, String[] to, int[] status,
            int pageIndex, int pageSize) {
        ArrayList<Order> orders = new ArrayList<>();
        CustomerDBContext sdb = new CustomerDBContext();
        try {
            String sql = "SELECT [Order_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Customer_ID]\n"
                    + "      ,[Discount]\n"
                    + "      ,[Discount_Type]\n"
                    + "      ,[Pay]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM "
                    + " (SELECT *, ROW_NUMBER() OVER (ORDER BY [Order_ID] ASC) as row_index FROM [Order]"
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
                int orderID = rs.getInt("Order_ID");
                Timestamp date = rs.getTimestamp("Date");
                Customer supplier = sdb.getCustomer(rs.getInt("Customer_ID"));
                float discount = rs.getFloat("Discount");
                float paid = rs.getFloat("Pay");
                boolean discountType = rs.getBoolean("Discount_Type");
                String description = rs.getString("Description");
                int sta = rs.getInt("Status");
                ArrayList<OrderDetail> orderDetails
                        = getOrderDetails(rs.getInt("Order_ID"));
                Order invoice = new Order(orderID, date,
                        supplier, discount, discountType, paid, orderDetails,
                        sta, description);
                orders.add(invoice);
            }
            System.out.println(sql);
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orders;
    }

    public Order getOrder(int orderID) {
        CustomerDBContext sdb = new CustomerDBContext();
        try {
            String sql = "SELECT [Order_ID]\n"
                    + "      ,[Date]\n"
                    + "      ,[Customer_ID]\n"
                    + "      ,[Discount]\n"
                    + "      ,[Discount_Type]\n"
                    + "      ,[Pay]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Order]\n"
                    + "  WHERE [Order_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, orderID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Timestamp date = rs.getTimestamp("Date");
                Customer supplier = sdb.getCustomer(rs.getInt("Customer_ID"));
                float discount = rs.getFloat("Discount");
                float paid = rs.getFloat("Pay");
                boolean discountType = rs.getBoolean("Discount_Type");
                String description = rs.getString("Description");
                int sta = rs.getInt("Status");
                ArrayList<OrderDetail> orderDetails
                        = getOrderDetails(rs.getInt("Order_ID"));
                Order invoice = new Order(orderID, date,
                        supplier, discount, discountType, paid, orderDetails,
                        sta, description);
                return invoice;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<OrderDetail> getOrderDetails(int orderID) {
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<OrderDetail> orderDetails = new ArrayList<>();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Unit_Price]\n"
                    + "      ,[Quantity]\n"
                    + "  FROM [dbo].[Order_Detail]"
                    + "  WHERE [Order_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, orderID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product product = pdb.getProduct(rs.getInt("Product_ID"));
                float unitPrice = rs.getFloat("Unit_Price");
                int quantity = rs.getInt("quantity");
                OrderDetail invoice = new OrderDetail(orderID,
                        product, unitPrice, quantity);
                orderDetails.add(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderDetails;
    }

    public void insertOrder(Order invoice) {
        try {
            String sql = "INSERT INTO [dbo].[Order]\n"
                    + "           ([Date]\n"
                    + "           ,[Customer_ID]\n"
                    + "           ,[Discount]\n"
                    + "           ,[Discount_Type]\n"
                    + "           ,[Pay]\n"
                    + "           ,[Status]\n"
                    + "           ,[Description])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmOne = connection.prepareStatement(sql);
            stmOne.setTimestamp(1, (Timestamp) invoice.getDate());
            stmOne.setInt(2, invoice.getCustomer().getCustomerID());
            stmOne.setFloat(3, invoice.getDiscount());
            stmOne.setBoolean(4, invoice.isDiscountType());
            stmOne.setFloat(5, invoice.getPaid());
            stmOne.setInt(6, invoice.getStatus());
            stmOne.setString(7, invoice.getDescription());
            stmOne.executeUpdate();
            ArrayList<OrderDetail> list = invoice.getInvoices();
            for (OrderDetail orderDetail : list) {
                insertOrderDetail(orderDetail);
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

        }

    }

    public void insertOrderDetail(OrderDetail invoice) {

        try {
            String sql = "INSERT INTO [dbo].[Order_Detail]\n"
                    + "           ([Order_ID]\n"
                    + "           ,[Product_ID]\n"
                    + "           ,[Unit_Price]\n"
                    + "           ,[Quantity])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?)";
            PreparedStatement stmTwo = connection.prepareStatement(sql);
            stmTwo.setInt(1, invoice.getOrderID());
            stmTwo.setInt(2, invoice.getProduct().getProductID());
            stmTwo.setFloat(3, invoice.getUnitPrice());
            stmTwo.setInt(4, invoice.getQuantity());
            stmTwo.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updateOrder(Order in) {
        try {
            String sql = "UPDATE [dbo].[Order]\n"
                    + "   SET [Date] = ?\n"
                    + "      ,[Customer_ID] = ?\n"
                    + "      ,[Discount] = ?\n"
                    + "      ,[Discount_Type] = ?\n"
                    + "      ,[Pay] = ?\n"
                    + "      ,[Status] = ?\n"
                    + "      ,[Description] = ?\n"
                    + " WHERE [Order_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setTimestamp(1, (Timestamp) in.getDate());
            stm.setInt(2, in.getCustomer().getCustomerID());
            stm.setFloat(3, in.getDiscount());
            stm.setBoolean(4, in.isDiscountType());
            stm.setFloat(5, in.getPaid());
            stm.setInt(6, in.getStatus());
            stm.setString(7, in.getDescription());
            stm.executeUpdate();

            ArrayList<OrderDetail> invoices = in.getInvoices();
            for (OrderDetail invoice : invoices) {
                insertOrderDetail(invoice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateOrderDetail(OrderDetail ind) {
        try {
            String sql = "UPDATE [dbo].[Order_Detail]\n"
                    + "   SET [Product_ID] = ?\n"
                    + "      ,[Unit_Price] = ?\n"
                    + "      ,[Quantity] = ?\n"
                    + " WHERE [Order_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, ind.getProduct().getProductID());
            stm.setFloat(2, ind.getUnitPrice());
            stm.setInt(3, ind.getQuantity());
            stm.setInt(4, ind.getOrderID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteOrderDetail(int orderID) {
        try {
            String sql = "DELETE FROM [dbo].[Order_Detail]\n"
                    + "      WHERE [Order_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, orderID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getTotalRecord(String[] from, String[] to, int[] status) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Order]"
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
            Logger.getLogger(OrderDBContext.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int getTotalRecord() {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Order]";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class
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
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
