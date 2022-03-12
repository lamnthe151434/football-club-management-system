/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.partner;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.partner.Supplier;

/**
 *
 * @author ADMIN
 */
public class SupplierDBContext extends DBContext {

    public ArrayList<Supplier> getSuppliers() {
        ArrayList<Supplier> customers = new ArrayList<>();
        try {
            String sql = "SELECT [Supplier_ID]\n"
                    + "      ,[Supplier_Name]\n"
                    + "      ,[Address]\n"
                    + "      ,[Phone]\n"
                    + "      ,[Email]\n"
                    + "  FROM [dbo].[Supplier]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int supplierID = rs.getInt("Supplier_ID");
                String customerName = rs.getString("Supplier_Name");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                Supplier c = new Supplier(supplierID, customerName, address, phone, email);
                customers.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customers;
    }

    public ArrayList<Supplier> getSuppliers(int pageIndex, int pageSize) {
        ArrayList<Supplier> customers = new ArrayList<>();
        try {
            String sql = "SELECT [Supplier_ID]\n"
                    + "      ,[Supplier_Name]\n"
                    + "      ,[Address]\n"
                    + "      ,[Phone]\n"
                    + "      ,[Email] FROM\n"
                    + " (SELECT *, ROW_NUMBER() OVER (ORDER BY [Supplier_ID] ASC) as row_index FROM [Supplier]) tb\n"
                    + "  WHERE row_index >=(?-1)*?+1 AND row_index <= ?*?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageIndex);
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int supplierID = rs.getInt("Supplier_ID");
                String customerName = rs.getString("Supplier_Name");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                
                if(address == null) address = "";
                if(phone == null) phone = "";
                if(email == null) email = "";
                Supplier c = new Supplier(supplierID, customerName, address, phone, email);
                customers.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(customers.size());
        return customers;
    }

    public Supplier getSupplier(int supplierID) {
        try {
            String sql = "SELECT [Supplier_Name]\n"
                    + "      ,[Address]\n"
                    + "      ,[Phone]\n"
                    + "      ,[Email]\n"
                    + "  FROM [dbo].[Supplier] WHERE [Supplier_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, supplierID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String customerName = rs.getString("Supplier_Name");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                Supplier customer = new Supplier(supplierID, customerName, address, phone, email);
                return customer;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertSupplier(Supplier customer) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[Supplier]\n"
                    + "           ([Supplier_Name]\n"
                    + "           ,[Address]\n"
                    + "           ,[Phone]\n"
                    + "           ,[Email])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?)";
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, customer.getSupplierName());
            stm.setString(2, customer.getAddress());
            stm.setString(3, customer.getPhone());
            stm.setString(4, customer.getEmail());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                connection.setAutoCommit(true);
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    public void deleteSupplier(int supplierID) {
        try {
            String sql = "DELETE FROM [dbo].[Supplier]\n"
                    + "WHERE [Supplier_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, supplierID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateSupplier(Supplier customer) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Supplier]\n"
                    + "   SET [Supplier_Name] = ?\n"
                    + "      ,[Address] = ?\n"
                    + "      ,[Phone] = ?\n"
                    + "      ,[Email] = ?\n"
                    + " WHERE [Supplier_ID] = ?";
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, customer.getSupplierName());
            stm.setString(2, customer.getAddress());
            stm.setString(3, customer.getPhone());
            stm.setString(4, customer.getEmail());
            stm.setInt(5, customer.getSupplierID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                connection.setAutoCommit(true);
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    public int getTotalRecord() {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Supplier]";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
}
