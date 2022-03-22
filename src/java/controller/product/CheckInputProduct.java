/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.product;

import dal.product.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class CheckInputProduct extends HttpServlet {

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
        String productName = request.getParameter("productName");
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        int brandID = Integer.parseInt(request.getParameter("brandID"));

        String currentProductName = request.getParameter("currentProductName");
        String rawCurCategoryID = request.getParameter("currentCategoryID");
        String rawCurBrandID = request.getParameter("currentBrandID");

        boolean flag = true;
        int currentCategoryID = 0, currentBrandID = 0;
        if (rawCurCategoryID != null && rawCurBrandID != null) {
            currentCategoryID = Integer.parseInt(rawCurCategoryID);
            currentBrandID = Integer.parseInt(rawCurBrandID);
            flag = false;
        }

        ProductDBContext pdb = new ProductDBContext();
        ArrayList<Product> products = pdb.getProducts();

        PrintWriter writer = response.getWriter();

        boolean status = true;
        for (int i = 0; i < products.size(); i++) {
            Product p = products.get(i);
            if (p.getProductName().equals(productName)
                    && p.getCategory().getCategoryID() == categoryID
                    && p.getBrand().getBrandID() == brandID) {
                if (p.getProductName().equals(currentProductName)
                        && p.getCategory().getCategoryID() == currentCategoryID
                        && p.getBrand().getBrandID() == currentBrandID) {
                    continue;
                } else {
                    status = false;
                    break;
                }
            }
        }

        writer.print(status);
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
