/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.category;

import controller.BaseAuthenticationController;
import dal.product.CategoryDBContext;
import dal.product.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Category;
import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class EditCategoryController extends BaseAuthenticationController {

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
        request.setCharacterEncoding("utf-8");
        int categoryID = Integer.parseInt(request.getParameter("id"));
        CategoryDBContext db = new CategoryDBContext();
        Category category = db.getCategory(categoryID);

        String result = "";
        result += category.getCategoryID() + "|";
        result += category.getCategoryName();

        PrintWriter writer = response.getWriter();

        writer.println(result);

    }

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        String categoryName = request.getParameter("categoryName");
        CategoryDBContext cdb = new CategoryDBContext();
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<Product> products = pdb.getProductsByBrand(categoryID);

        Category newCategory = new Category(categoryID, categoryName);

        for (Product product : products) {
            product.setCategory(newCategory);
            pdb.updateProduct(product);
        }
        cdb.updateBrand(newCategory);
        response.sendRedirect("../product/list");
    }

}
