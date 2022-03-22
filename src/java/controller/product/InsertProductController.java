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
import javax.servlet.http.HttpSession;
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        ProductDBContext db = new ProductDBContext();
        CategoryDBContext cdb = new CategoryDBContext();
        BrandDBContext bdb = new BrandDBContext();
        HttpSession session = request.getSession();

        String submitType = request.getParameter("submitType");
        session.setAttribute("submitType", submitType);

        String productName = request.getParameter("productName");
        String unit = request.getParameter("unit");
        String rawCategoryID = request.getParameter("category");
        String rawBrandID = request.getParameter("brand");
        System.out.println(rawBrandID);
        String rawQuantity = request.getParameter("quantity");
        String rawCost = request.getParameter("cost").replace("VND", "").trim();
        rawCost = rawCost.replace(".", "");
        rawCost = rawCost.substring(0, rawCost.length() - 1);
        System.out.println("(" + rawCost + ")");
        String rawPrice = request.getParameter("price").replace("VND", "").trim();
        rawPrice = rawPrice.replace(".", "");
        rawPrice = rawPrice.substring(0, rawPrice.length() - 1);
        String rawDescription = request.getParameter("description");

        int brandID = Integer.parseInt(rawBrandID);
        int categoryID = Integer.parseInt(rawCategoryID);
        int quantity = Integer.parseInt(rawQuantity);
        float cost = Float.parseFloat(rawCost);
        float price = Float.parseFloat(rawPrice);
        String description = rawDescription;

        Category category = cdb.getCategory(categoryID);
        Brand brand = bdb.getBrand(brandID);
        Product product = new Product(productName, category,
                brand, unit, cost, price, quantity, 1, description);
        db.insertProduct(product);

        response.sendRedirect("list");
    }

}
