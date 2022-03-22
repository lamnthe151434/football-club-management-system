/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.supplier;

import dal.partner.SupplierDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.partner.Supplier;

/**
 *
 * @author ADMIN
 */
public class CheckExistSupplier extends HttpServlet {

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
        SupplierDBContext cdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = cdb.getSuppliers();

        String supplierName = request.getParameter("supplierName");
        String currentSupplierName = request.getParameter("currentSupplierName");
        String phone = request.getParameter("phone");
        String currentPhone = request.getParameter("currentPhone");
        System.out.println(supplierName + ", " + currentSupplierName);
        boolean status = true;
        for (int i = 0; i < suppliers.size(); i++) {
            Supplier c = suppliers.get(i);
            if (c.getSupplierName().equals(supplierName) && c.getPhone().equals(phone) ) {
                if (c.getSupplierName().equals(currentSupplierName) && c.getPhone().equals(currentPhone)) {
                    continue;
                } else {
                    status = false;
                    break;
                }
            }
        }
        PrintWriter writer = response.getWriter();

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
