/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.product;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.product.Brand;

/**
 *
 * @author ADMIN
 */
public class BrandDBContext extends DBContext {

    public ArrayList<Brand> getBrands() {
        ArrayList<Brand> brands = new ArrayList<>();
        try {
            String sql = "SELECT [Brand_ID], [Brand_Name] FROM [Brand]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                String brandName = rs.getString("Brand_Name");
                Brand b = new Brand(brandID, brandName);
                brands.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return brands;
    }

    public Brand getBrand(int brandID) {
        try {
            String sql = "SELECT [Brand_Name] FROM [Brand] WHERE [Brand_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, brandID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String brandName = rs.getString("Brand_Name");
                Brand b = new Brand(brandID, brandName);
                return b;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertBrand(String brandName) {
        String sql = "INSERT INTO [Brand]([Brand_Name]) VALUES (?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, brandName);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
//        finally {
//            if (stm != null) {
//                try {
//                    stm.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        }
    }

    public void updateBrand(Brand brand) {
        String sql = "UPDATE [dbo].[Brand] SET [Brand_Name] = ?"
                + "      WHERE [Brand_ID] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, brand.getBrandName());
            stm.setInt(2, brand.getBrandID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteBrand(int brandID) {
        String sql = "DELETE FROM [dbo].[Brand]\n"
                + "      WHERE [Brand_ID] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, brandID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
        }
    }
}
