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
import model.product.Category;

/**
 *
 * @author ADMIN
 */
public class CategoryDBContext extends DBContext {

    public ArrayList<Category> getCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        try {
            String sql = "SELECT [Category_ID],[Category_Name] FROM [dbo].[Category]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                String categoryName = rs.getString("Category_Name");
                Category c = new Category(categoryID, categoryName);
                categories.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }

    public Category getCategory(int categoryID) {
        try {
            String sql = "SELECT [Category_Name] FROM [dbo].[Category] WHERE [Category_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String categoryName = rs.getString("Category_Name");
                Category c = new Category(categoryID, categoryName);
                return c;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertCategory(String categoryName) {
        String sql = "INSERT INTO [dbo].[Category]\n"
                + "           ([Category_Name])\n"
                + "     VALUES\n"
                + "           (?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, categoryName);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
//        finally {
//            if (stm != null) {
//                try {
//                    stm.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        }
    }

    public void updateBrand(Category category) {
        String sql = "UPDATE [dbo].[Category] SET [Category_Name] = ?"
                + "      WHERE [Category_ID] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, category.getCategoryName());
            stm.setInt(2, category.getCategoryID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteCategory(int categoryID) {
        String sql = "DELETE FROM [dbo].[Category]\n"
                + "      WHERE [Category_ID] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
}
