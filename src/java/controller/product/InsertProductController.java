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
public class InsertProductController extends BaseAuthenticationController {

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ArrayList<Category> categories = cdb.getCategories();
        ArrayList<Brand> brands = bdb.getBrands();

        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("../view/product/catalog/insert.jsp").forward(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDBContext db = new ProductDBContext();
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();

        String rawBarcode = request.getParameter("barcode");
        String rawProductName = request.getParameter("productName");
        String rawUnit = request.getParameter("unit");
        String rawCategoryID = request.getParameter("category");
        String rawBrandID = request.getParameter("brand");
        String rawQuantity = request.getParameter("price");
        String rawCost = request.getParameter("cost");
        String rawPrice = request.getParameter("price");
        String rawDescription = request.getParameter("description");
        String rawStatus = request.getParameter("status");
        if (rawStatus == null) {
            rawStatus = "0";
        }

        int barcode = Integer.parseInt(rawBarcode);
        String productName = rawProductName;
        int categoryID = Integer.parseInt(rawCategoryID);
        int brandID = Integer.parseInt(rawBrandID);
        String unit = rawUnit;
        int quantity = Integer.parseInt(rawQuantity);
        float cost = Float.parseFloat(rawCost);
        float price = Float.parseFloat(rawPrice);
        int status = Integer.parseInt(rawStatus);
        String description = rawDescription;

        Category category = cdb.getCategory(categoryID);
        Brand brand = bdb.getBrand(brandID);
        Product product = new Product(barcode, productName, category,
                brand, unit, cost, price, quantity, status, description);
        db.insertProduct(product);
        response.sendRedirect("list");
    }

}
