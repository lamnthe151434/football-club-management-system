/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.supplier;

import dal.partner.SupplierDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.partner.Supplier;

/**
 *
 * @author ADMIN
 */
public class EditSupplierController extends HttpServlet {

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
        int supplierID = Integer.parseInt(request.getParameter("id"));
        SupplierDBContext sdb = new SupplierDBContext();
        Supplier supplier = sdb.getSupplier(supplierID);

        
        if(supplier.getAddress() == null) supplier.setAddress("");
        if(supplier.getPhone()== null) supplier.setPhone("");
        if(supplier.getEmail() == null) supplier.setEmail("");
        
        String result = "";
        result += supplier.getSupplierID() + "|";
        result += supplier.getSupplierID() + "|";
        result += supplier.getAddress() + "|";
        result += supplier.getPhone() + "|";
        result += supplier.getSupplierName() + "|";
        result += supplier.getEmail();

        PrintWriter writer = response.getWriter();
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
        String rawSupplierID = request.getParameter("supplierID");
        String rawSupplierName = request.getParameter("supplierName");
        String rawAddress = request.getParameter("address");
        String rawPhone = request.getParameter("phone");
        String rawEmail = request.getParameter("email");

        if(rawAddress == null) rawAddress = "";
        if(rawPhone == null) rawPhone = "";
        if(rawEmail == null) rawEmail = "";
        
        int supplierID = Integer.parseInt(rawSupplierID);
        String supplierName = rawSupplierName;
        String address = rawAddress;
        String phone = rawPhone;
        String email = rawEmail;

        Supplier supplier = new Supplier(supplierID, supplierName, address, phone, email);
        SupplierDBContext sdb = new SupplierDBContext();
        sdb.updateSupplier(supplier);

        response.sendRedirect("list");
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
