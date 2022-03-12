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
public class SearchProductController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

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
        response.setContentType("text/html;charset=UTF-8");
        String rawProductID = request.getParameter("id");

        if (rawProductID == "") {
            return;
        }
        int productID = Integer.parseInt(rawProductID);
        ProductDBContext pdb = new ProductDBContext();
        Product product = pdb.getProduct(productID);

        PrintWriter writer = response.getWriter();

        String result = "";

        if (product != null) {
            result += product.getProductID() + "|";
            result += product.getBarcode()+ "|";
            result += product.getProductName() + "|";
            result += product.getCategory().getCategoryName() + "|";
            result += product.getBrand().getBrandName() + "|";
            result += product.getUnit()+ "|";
            result += product.getCost() + "|";
            result += product.getPrice() + "|";
            result += product.getDescription() + "|";
            result += product.getStatus();
        }
        writer.println(result);

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
//        BrandDBContext bdb = new BrandDBContext();
//        CategoryDBContext cdb = new CategoryDBContext();
//
//        String rawBrandID = request.getParameter("brandID");
//        String rawCategoryID = request.getParameter("categoryID");
//        String brandName = "";
//        String categoryName = "";
//
//        if (rawCategoryID == null) {
//            rawCategoryID = "-1";
//        }
//        if (rawBrandID == null) {
//            rawBrandID = "-1";
//        }
//
//        int categoryID = Integer.parseInt(rawCategoryID);
//        int brandID = Integer.parseInt(rawBrandID);
//
//        Brand b = bdb.getBrand(brandID);
//        Category c = cdb.getCategory(categoryID);
//
//        if (categoryID == -1) {
//            categoryName = "Tất cả";
//        } else {
//            categoryName = c.getCategoryName();
//        }
//        if (brandID == -1) {
//            brandName = "Tất cả";
//        } else {
//            brandName = b.getBrandName();
//        }
//        Category category = new Category(categoryID, categoryName);
//        Brand brand = new Brand(brandID, brandName);
//
//        ProductDBContext pdb = new ProductDBContext();
//        ArrayList<Integer> criterias = new ArrayList<>();
//        criterias.add(categoryID);
//        criterias.add(brandID);
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
//
//        request.getRequestDispatcher("../view/product/list.jsp").forward(request, response);
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
