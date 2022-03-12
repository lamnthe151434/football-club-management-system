/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.product;

import controller.BaseAuthenticationController;
import dal.product.BrandDBContext;
import dal.product.CategoryDBContext;
import dal.product.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Brand;
import model.product.Category;
import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class EditProductController extends BaseAuthenticationController {

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int productID = Integer.parseInt(request.getParameter("id"));
        ProductDBContext db = new ProductDBContext();
        Product product = db.getProduct(productID);
        String result = "";
        result += product.getProductID() + "|";
        result += product.getProductID() + "|";
        result += product.getCategory().getCategoryName() + "|";
        result += product.getCategory().getCategoryID() + "|";
        result += product.getCost() + "|";
        result += product.getProductName() + "|";
        result += product.getBrand().getBrandName() + "|";
        result += product.getBrand().getBrandID() + "|";
        result += product.getPrice();
//        result += product.getQuantity();

        PrintWriter writer = response.getWriter();

        writer.println(result);
        writer.flush();
        writer.close();
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDBContext db = new ProductDBContext();
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();

        String rawProductID = request.getParameter("productID");
        String rawProductName = request.getParameter("productName");
        String rawCategoryID = request.getParameter("categoryID");
        String rawBrandID = request.getParameter("brandID");
        String rawImportPrice = request.getParameter("cost");
        String rawSellPrice = request.getParameter("price");
//        String rawQuanity = request.getParameter("quantity");

        int productID = Integer.parseInt(rawProductID);
        String productName = rawProductName;
        int categoryID = Integer.parseInt(rawCategoryID);
        int brandID = Integer.parseInt(rawBrandID);
        float cost = Float.parseFloat(rawImportPrice);
        float price = Float.parseFloat(rawSellPrice);
//        int quantity = Integer.parseInt(rawQuanity);

        Category category = cdb.getCategory(categoryID);
        Brand brand = bdb.getBrand(brandID);
//        Product product = new Product(productID, productName, category, brand,
//                cost, price, 0, 1);
//        db.updateProduct(product);
        response.sendRedirect("list");
    }

}
