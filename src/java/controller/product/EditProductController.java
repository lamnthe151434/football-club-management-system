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

        if (product.getDescription() == null) {
            product.setDescription("");
        }

        result += product.getProductID() + "|";
        result += product.getProductID() + "|";
        result += product.getProductName() + "|";
        result += product.getCategory().getCategoryID() + "|";
        result += product.getCategory().getCategoryName() + "|";
        result += product.getBrand().getBrandID() + "|";
        result += product.getBrand().getBrandName() + "|";
        result += product.getCost() + "|";
        result += product.getPrice() + "|";
        result += product.getUnit() + "|";
        result += product.getQuantity() + "|";
        result += product.getDescription();

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

        int productId = Integer.parseInt(request.getParameter("productID"));
        String productName = request.getParameter("productName");
        String unit = request.getParameter("unit");
        String rawCategoryID = request.getParameter("category");
        String rawBrandID = request.getParameter("brand");
        String rawQuantity = request.getParameter("quantity");
        String rawCost = request.getParameter("cost").replace("Â VND", "");
        rawCost = rawCost.replace(".", "");
        String rawPrice = request.getParameter("price").replace("Â VND", "");
        rawPrice = rawPrice.replace(".", "");
        String rawDescription = request.getParameter("description");

        int categoryID = Integer.parseInt(rawCategoryID);
        int brandID = Integer.parseInt(rawBrandID);
        int quantity = Integer.parseInt(rawQuantity);
        float cost = Float.parseFloat(rawCost);
        float price = Float.parseFloat(rawPrice);
        String description = rawDescription;

        Category category = cdb.getCategory(categoryID);
        Brand brand = bdb.getBrand(brandID);
        Product product = new Product(productId, productName, category,
                brand, unit, cost, price, quantity, 1, description);
        db.updateProduct(product);

//        db.updateProduct(product);
        response.sendRedirect("list");
    }

}
