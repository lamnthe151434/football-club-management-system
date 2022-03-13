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
import model.product.Category;
import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class ProductDBContext extends DBContext {

    public ArrayList<Product> getProductsByCategory(int categoryID) {
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "";
            sql = "SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Product] WHERE [Category_ID] = ?\n";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("Product_ID");
                int barcode = rs.getInt("Barcode");
                String productName = rs.getString("Product_Name");
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                String unit = rs.getString("Unit");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);

                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getProductsByBrand(int brandID) {
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM [dbo].[Product] WHERE [Brand_ID] = ?\n";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, brandID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = Integer.parseInt(rs.getString("Product_ID"));
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                String productName = rs.getString("Product_Name");
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getProductsByCategory(String searchKey, int categoryID, int pageIndex, int pageSize) {
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description] FROM \n"
                    + "(SELECT *, ROW_NUMBER() OVER (ORDER BY [Product_ID] ASC) as row_index FROM [Product] "
                    + " WHERE [Category_ID] = ? AND (product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%')) tb\n"
                    + "WHERE row_index >=(?-1)*?+1 AND row_index <= ?*?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryID);
            stm.setInt(2, pageIndex);
            stm.setInt(3, pageSize);
            stm.setInt(4, pageIndex);
            stm.setInt(5, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = Integer.parseInt(rs.getString("Product_ID"));
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                String productName = rs.getString("Product_Name");
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getProductsByBrand(String searchKey, int brandID, int pageIndex, int pageSize) {
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status] \n"
                    + "      ,[Description] FROM \n"
                    + "(SELECT *, ROW_NUMBER() OVER (ORDER BY [Product_ID] ASC) as row_index FROM [Product]"
                    + "WHERE  [Brand_ID] = ? AND (product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%')) tb\n"
                    + "WHERE row_index >=(?-1)*?+1 AND row_index <= ?*? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, brandID);
            stm.setInt(2, pageIndex);
            stm.setInt(3, pageSize);
            stm.setInt(4, pageIndex);
            stm.setInt(5, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = Integer.parseInt(rs.getString("Product_ID"));
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                String productName = rs.getString("Product_Name");
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getProducts(String searchKey, int pageIndex, int pageSize) {
        ArrayList<Product> products = new ArrayList<>();
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description] FROM \n"
                    + "(SELECT *, ROW_NUMBER() OVER (ORDER BY [Product_ID] ASC) as row_index FROM [Product]"
                    + "WHERE product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%') tb\n"
                    + "WHERE row_index >=(?-1)*?+1 AND row_index <= ?*?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageIndex);
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = Integer.parseInt(rs.getString("Product_ID"));
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                String productName = rs.getString("Product_Name");
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getProducts(String searchKey, ArrayList<Integer> criterias, int pageIndex, int pageSize) {
        ArrayList<Product> products = new ArrayList<>();
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        try {
            String sql = "SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "  FROM \n"
                    + "  (SELECT *, ROW_NUMBER() OVER (ORDER BY [Product_ID] ASC) as row_index FROM [Product]\n"
                    + "                    WHERE [Category_ID] = ? AND [Brand_ID] = ? AND (product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%')) tb\n"
                    + "                    WHERE row_index >=(?-1)*?+1 AND row_index <= ?*?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, criterias.get(0));
            stm.setInt(2, criterias.get(1));
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);
            stm.setInt(5, pageIndex);
            stm.setInt(6, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = Integer.parseInt(rs.getString("Product_ID"));
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                String productName = rs.getString("Product_Name");
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getProducts(String productName) {
        ArrayList<Product> products = new ArrayList<>();
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        try {
            String sql = "SELECT SELECT [Product_ID]\n"
                    + "      ,[Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + " FROM [dbo].[Product] WHERE [Product_Name] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, productName);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int productID = Integer.parseInt(rs.getString("Product_ID"));
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public Product getProduct(int productID) {
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        try {
            String sql = "SELECT [Barcode]\n"
                    + "      ,[Product_Name]\n"
                    + "      ,[Brand_ID]\n"
                    + "      ,[Category_ID]\n"
                    + "      ,[Cost]\n"
                    + "      ,[Price]\n"
                    + "      ,[Unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Status]\n"
                    + "      ,[Description]\n"
                    + "FROM [dbo].[Product] WHERE [Product_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, String.valueOf(productID));
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int barcode = rs.getInt("Barcode");
                String unit = rs.getString("Unit");
                String productName = rs.getString("Product_Name");
                int categoryID = Integer.parseInt(rs.getString("Category_ID"));
                int brandID = Integer.parseInt(rs.getString("Brand_ID"));
                Category category = cdb.getCategory(categoryID);
                Brand brand = bdb.getBrand(brandID);
                float cost = rs.getFloat("Cost");
                float price = rs.getFloat("Price");
                int quantity = Integer.parseInt(rs.getString("Quantity"));
                int status = rs.getInt("Status");
                String description = rs.getString("Description");
                Product p = new Product(productID, barcode, productName,
                        category, brand, unit, cost, price, quantity,
                        status, description);
                return p;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertProduct(Product product) {
        String sql = "INSERT INTO [dbo].[Product]\n"
                + "           ([Barcode]\n"
                + "           ,[Product_Name]\n"
                + "           ,[Brand_ID]\n"
                + "           ,[Category_ID]\n"
                + "           ,[Cost]\n"
                + "           ,[Price]\n"
                + "           ,[Unit]\n"
                + "           ,[Quantity]\n"
                + "           ,[Status]\n"
                + "           ,[Description])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, product.getBarcode());
            stm.setString(2, product.getProductName());
            stm.setInt(3, product.getBrand().getBrandID());
            stm.setInt(4, product.getCategory().getCategoryID());
            stm.setFloat(5, product.getCost());
            stm.setFloat(6, product.getPrice());
            stm.setString(7, product.getUnit());
            stm.setInt(8, product.getQuantity());
            stm.setInt(9, product.getStatus());
            stm.setString(10, product.getDescription());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public void decreaseQuantity(Product product, int quantity) {
        try {
            String sql = "UPDATE [dbo].[Product]\n"
                    + "   SET [Quantity] = [Quantity] - ?\n"
                    + " WHERE [Product_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, quantity);
            stm.setInt(2, product.getProductID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void increaseQuantity(Product product, int quantity) {
        try {
            String sql = "UPDATE [dbo].[Product]\n"
                    + "   SET [Quantity] = [Quantity] + ?\n"
                    + " WHERE [Product_ID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, quantity);
            stm.setInt(2, product.getProductID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [Product_Name] = ?\n"
                + "      ,[Brand_ID] = ?\n"
                + "      ,[Category_ID] = ?\n"
                + "      ,[Cost] =?\n"
                + "      ,[Price] = ?\n"
                + "      ,[Quantity] = ?\n"
                + "      ,[Status] = ?\n"
                + "      ,[Description] = ?\n"
                + " WHERE [Product_ID] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, product.getProductName());
            stm.setInt(2, product.getBrand().getBrandID());
            stm.setInt(3, product.getCategory().getCategoryID());
            stm.setFloat(4, product.getCost());
            stm.setFloat(5, product.getPrice());
            stm.setInt(6, product.getQuantity());
            stm.setInt(7, product.getStatus());
            stm.setString(8, product.getDescription());
            stm.setInt(9, product.getProductID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
        }
    }

    public void deleteProduct(int productID) {
        String sql = "DELETE FROM [dbo].[Product]\n"
                + "      WHERE [Product_ID] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, productID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getTotalRecord(String searchKey) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Product] "
                + "WHERE product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%'";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setString(1, searchKey);
//            stm.setString(2, searchKey);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int getTotalRecord(String searchKey, ArrayList<Integer> criterias) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Product] WHERE [Category_ID] = ? AND [Brand_ID] = ?\n"
                + "AND (product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%') ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, criterias.get(0));
            stm.setInt(2, criterias.get(1));
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int getTotalRecordByCategory(String searchKey, int categoryID) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Product] WHERE [Category_ID] = ?\n"
                + "AND (product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%')";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int getTotalRecordByBrand(String searchKey, int brandID) {
        String sql = "SELECT COUNT(*) AS [Total] FROM [Product] WHERE [Brand_ID] = ? \n"
                + "AND (product_name like '%" + searchKey + "%' or Cast(product_id as NVARCHAR(50)) like '%" + searchKey + "%')";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, brandID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

}
