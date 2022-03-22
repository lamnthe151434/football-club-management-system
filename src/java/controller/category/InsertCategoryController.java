/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.category;

import controller.BaseAuthenticationController;
import dal.product.CategoryDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Category;

/**
 *
 * @author ADMIN
 */
public class InsertCategoryController extends BaseAuthenticationController {

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
        CategoryDBContext db = new CategoryDBContext();
        String rawCategoryName = request.getParameter("categoryName");
        String boxType = request.getParameter("boxType");

        String categoryName = rawCategoryName;
        db.insertCategory(categoryName);

        ArrayList<Category> categories = db.getCategories();
        String result = "";

        PrintWriter writer = response.getWriter();
        result += "<table>";
        result += "<tr>";
        result += "<td><span onclick=\"setValue('-1', 'Tất cả', 'category')\" \n"
                + " class =\"category-value\">Tất cả</span></td>";
        result += "</tr>";
        for (int i = categories.size() - 1; i >= 0; i--) {
            Category category = categories.get(i);
            result += "<tr>";
            result += "<td>";
            result += "<span onclick=\"setValue('" + category.getCategoryID() + "','" + category.getCategoryName() + "', '" + boxType + "')\"  >"
                    + category.getCategoryName() + "</span>";
            result += "</td>";
            result += "<td>";
            result += "<button type=\"button\" onclick=\"edit('" + category.getCategoryID() + "', '" + boxType + "')\" ><i class=\"fa fa-pencil\" ></i></button>";
            result += "</td>";
            result += "<td>";
            result += "<button type=\"button\" onclick=\"deleteEntity('" + category.getCategoryID() + "', '" + boxType + "')\"><i class=\"fa fa-trash\" ></i></button>";
            result += "</td>";
            result += "</tr>";
        }
        result += "<table>";

        writer.println(result);
    }

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

}
