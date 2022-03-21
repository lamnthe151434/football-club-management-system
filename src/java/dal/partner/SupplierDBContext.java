/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.partner;

import dal.DBContext;
import java.sql.Date;
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
        ArrayList<Supplier> suppliers = new ArrayList<>();
        try {
            String sql = "SELECT [Supplier_ID]\n"
                    + "      ,[Supplier_Name]\n"
                    + "      ,[Address]\n"
                    + "      ,[Phone]\n"
                    + "      ,[DOB]\n"
                    + "      ,[Gender]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Supplier]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int supplierID = rs.getInt("Supplier_ID");
                String supplierName = rs.getString("Supplier_Name");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                Date dob = rs.getDate("DOB");
                boolean gender = rs.getBoolean("Gender");
                String description = rs.getString("Description");
                Supplier c = new Supplier(supplierID, supplierName, gender, dob,
                        phone, address, description);
                suppliers.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return suppliers;
    }

    public ArrayList<Supplier> getSuppliers(int pageIndex, int pageSize) {
        ArrayList<Supplier> suppliers = new ArrayList<>();
        try {
            String sql = "SELECT [Supplier_ID]\n"
                    + "      ,[Supplier_Name]\n"
                    + "      ,[Address]\n"
                    + "      ,[Phone]\n"
                    + "      ,[DOB]\n"
                    + "      ,[Gender]\n"
                    + "      ,[Description] FROM\n"
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
                String supplierName = rs.getString("Supplier_Name");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                Date dob = rs.getDate("DOB");
                boolean gender = rs.getBoolean("Gender");
                String description = rs.getString("Description");
                Supplier c = new Supplier(supplierID, supplierName, gender, dob,
                        phone, address, description);
                suppliers.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(suppliers.size());
        return suppliers;
    }

    public Supplier getSupplier(int supplierID) {
        try {
            String sql = "SELECT [Supplier_ID]\n"
                    + "      ,[Supplier_Name]\n"
                    + "      ,[Address]\n"
                    + "      ,[Phone]\n"
                    + "      ,[DOB]\n"
                    + "      ,[Gender]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Supplier] WHERE [Supplier_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, supplierID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String supplierName = rs.getString("Supplier_Name");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                Date dob = rs.getDate("DOB");
                boolean gender = rs.getBoolean("Gender");
                String description = rs.getString("Description");
                Supplier supplier = new Supplier(supplierID, supplierName, gender,
                        dob, phone, address, description);
                return supplier;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertSupplier(Supplier supplier) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[Supplier]\n"
                    + "           ([Supplier_Name]\n"
                    + "           ,[Address]\n"
                    + "           ,[Phone]\n"
                    + "           ,[DOB]\n"
                    + "           ,[Gender]\n"
                    + "           ,[Description])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?)";
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, supplier.getSupplierName());
            stm.setString(2, supplier.getAddress());
            stm.setString(3, supplier.getPhone());
            stm.setDate(4, supplier.getDob());
            stm.setBoolean(5, supplier.isGender());
            stm.setString(6, supplier.getDescription());
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

    public void updateSupplier(Supplier supplier) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Supplier]\n"
                    + "   SET [Supplier_Name] = ?\n"
                    + "      ,[Address] = ?\n"
                    + "      ,[Phone] = ?\n"
                    + "      ,[DOB] = ?\n"
                    + "      ,[Gender] = ?\n"
                    + "      ,[Description] = ?\n"
                    + " WHERE [Supplier_ID] = ?";
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, supplier.getSupplierName());
            stm.setString(2, supplier.getAddress());
            stm.setString(3, supplier.getPhone());
            stm.setDate(4, supplier.getDob());
            stm.setBoolean(5, supplier.isGender());
            stm.setString(6, supplier.getDescription());
            stm.setInt(7, supplier.getSupplierID());
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
