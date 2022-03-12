/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.product;

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
public class ChangePriceController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
//        String rawCategoryID = request.getParameter("categoryID");
//        String rawBrandID = request.getParameter("brandID");
//        String rawCategoryName = request.getParameter("categoryName");
//        String rawBrandName = request.getParameter("brandName");
//        if (rawCategoryID == null && rawBrandID == null) {
//            rawCategoryID = "-1";
//            rawBrandID = "-1";
//        }
//        if (rawCategoryName == null && rawBrandName == null) {
//            rawCategoryName = "All categories";
//            rawBrandName = "All brands";
//        }
//
//        System.out.println(rawBrandName + ", " + rawCategoryName);
//
//        int categoryID = Integer.parseInt(rawCategoryID);
//        int brandID = Integer.parseInt(rawBrandID);
//
//        String categoryName = rawCategoryName;
//        String brandName = rawBrandName;
//
//        Category category = new Category(categoryID, categoryName);
//        Brand brand = new Brand(brandID, brandName);
//
//        ProductDBContext pdb = new ProductDBContext();
//        ArrayList<Integer> criterias = new ArrayList<>();
//        criterias.add(categoryID);
//        criterias.add(brandID);
//
//        CategoryDBContext cdb = new CategoryDBContext();
//        BrandDBContext bdb = new BrandDBContext();
//
//        ArrayList<Category> categories = cdb.getCategories();
//        ArrayList<Brand> brands = bdb.getBrands();
//
//        String rawPageIndex = request.getParameter("pageIndex");
//        if (rawPageIndex == null) {
//            rawPageIndex = "1";
//        }
//        String rawPageSize = request.getParameter("pageSize");
//        if (rawPageSize == null) {
//            rawPageSize = "10";
//        }
//
//        int pageIndex = Integer.parseInt(rawPageIndex);
//        int pageSize = Integer.parseInt(rawPageSize);
//
//        int totalRecord = 0;
//
//        if (brandID == -1 && categoryID == -1) {
//            totalRecord = pdb.getTotalRecord();
//        } else {
//            if (brandID == -1) {
//                totalRecord = pdb.getTotalRecordByCategory(categoryID);
//            }
//            if (categoryID == -1) {
//                totalRecord = pdb.getTotalRecordByBrand(brandID);
//            }
//            if (categoryID != -1 && brandID != -1) {
//                totalRecord = pdb.getTotalRecord(criterias);
//            }
//        }
//        int totalPage = totalRecord / pageSize;
//        if (totalRecord % pageSize != 0) {
//            totalPage += 1;
//        }
//
//        String track = "";
//
//        int begin = ((pageIndex - 1) * pageSize) + 1;
//        int end = 0;
//
//        track += String.valueOf(begin);
//
//        if (pageIndex == totalPage) {
//            if (pageIndex * pageSize == totalRecord) {
//                end = totalRecord;
//            } else {
//                end = pageIndex * pageSize - (pageSize - (totalRecord % pageSize));
//            }
//        } else {
//            end = pageIndex * pageSize;
//        }
//
//        if (end != begin) {
//            track += "-";
//            track += String.valueOf(end);
//        }
//
//        track += " of " + totalRecord;
//
//        ArrayList<Product> products = new ArrayList<>();
//
//        if (brandID == -1 && categoryID == -1) {
//            products = pdb.getProducts(pageIndex, pageSize);
//        } else {
//            if (brandID == -1) {
//                products = pdb.getProductsByCategory(categoryID, pageIndex, pageSize);
//            }
//            if (categoryID == -1) {
//                products = pdb.getProductsByBrand(brandID, pageIndex, pageSize);
//            }
//            if (categoryID != -1 && brandID != -1) {
//                products = pdb.getProducts(criterias, pageIndex, pageSize);
//            }
//        }
//
//        ArrayList<Integer> pageSizeOptions = new ArrayList<>();
//        pageSizeOptions.add(10);
//        pageSizeOptions.add(20);
//        pageSizeOptions.add(30);
//        pageSizeOptions.add(40);
//        pageSizeOptions.add(50);
//
//        request.setAttribute("products", products);
//        request.setAttribute("categories", categories);
//        request.setAttribute("brands", brands);
//        request.setAttribute("pageSizeOptions", pageSizeOptions);
//        request.setAttribute("selectedPageSize", pageSize);
//        request.setAttribute("pageIndex", pageIndex);
//        request.setAttribute("totalPage", totalPage);
//        request.setAttribute("track", track);
//
//        request.setAttribute("category", category);
//        request.setAttribute("brand", brand);

        request.getRequestDispatcher("../../view/product/change/price.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDBContext pdb = new ProductDBContext();
        String priceType = request.getParameter("priceType");
        String baseType = request.getParameter("baseType");
        String expressionSign = request.getParameter("expressionSign");
        String expressionUnit = request.getParameter("expressionUnit");
        String rawSetPrice = request.getParameter("setPrice");

        float setPrice = Float.parseFloat(rawSetPrice);
        int productID = Integer.parseInt(request.getParameter("productID"));
        Product product = pdb.getProduct(productID);
        System.out.println(setPrice);

        float basePrice = 0;
        float newPrice = 0;

        if ("cost".equals(baseType)) {
            basePrice = product.getCost();

        }
        if ("price".equals(baseType)) {
            basePrice = product.getPrice();
        }

        if ("+".equals(expressionSign)) {
            if ("VND".equals(expressionUnit)) {
                newPrice = basePrice + setPrice;
            } else {
                newPrice = basePrice + (basePrice * (setPrice / 100));
            }
        } else {
            if ("VND".equals(expressionUnit)) {
                newPrice = basePrice - setPrice;
            } else {
                newPrice = basePrice - (basePrice * (setPrice / 100));
            }
        }

        if ("cost".equals(priceType)) {
            product.setCost(newPrice);
        }

        if ("price".equals(priceType)) {
            product.setPrice(newPrice);
        }

        pdb.updateProduct(product);

        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
