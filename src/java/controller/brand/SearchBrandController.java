/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.brand;

import dal.product.BrandDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Brand;

/**
 *
 * @author ADMIN
 */
public class SearchBrandController extends HttpServlet {

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
        BrandDBContext db = new BrandDBContext();
        String searchKeyword = request.getParameter("keyword");
        String boxType = request.getParameter("boxType");

        ArrayList<Brand> brands = db.getBrands();
        PrintWriter writer = response.getWriter();

        String result = "";
        result += "<table>";
        if (boxType.equals("brand")) {
            result += "<tr>\n"
                    + " <td><span onclick=\"setValue('-1', 'All brands', '" + boxType + "')\" \n"
                    + " class =\"brand-value\">All brands</span></td>\n"
                    + " </tr>";
        }
        for (int i = brands.size() - 1; i >= 0; i--) {
            Brand brand = brands.get(i);
            if (brand.getBrandName().contains(searchKeyword)) {
                result += "<tr>";
                result += "<td>";
                result += "<span onclick=\"setValue('" + brand.getBrandID() + "','" + brand.getBrandName() + "', '" + boxType + "')\" class =\"brand-value\" >"
                        + brand.getBrandName() + "</span> <br/>";
                result += "</td>";
                result += "<td>";
                result += "<button onclick=\"edit(" + brand.getBrandID() + ", 'brand')\" >Edit</button>";
                result += "</td>";
                result += "<td>";
                result += "<button onclick=\"deleteEntity(" + brand.getBrandID() + ", 'brand')\">Delete</button>";
                result += "</td>";
                result += "</tr>";
            }
        }
        result += "</table>";
        writer.println(result);

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
