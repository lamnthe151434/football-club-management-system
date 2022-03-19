/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.supplier;

import dal.partner.SupplierDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
        SupplierDBContext cdb = new SupplierDBContext();
        Supplier supplier = cdb.getSupplier(supplierID);

        if (supplier.getAddress() == null) {
            supplier.setAddress("");
        }
        if (supplier.getPhone() == null) {
            supplier.setPhone("");
        }

        String result = "";
        result += supplier.getSupplierID() + "|";
        result += supplier.getSupplierID() + "|";
        result += supplier.getSupplierName() + "|";
        result += supplier.getDob()+ "|";
        result += supplier.isGender()+ "|";
        result += supplier.getPhone() + "|";
        result += supplier.getAddress() + "|";
        result += supplier.getDescription() ;

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
        String rawDob = request.getParameter("dob");
        String rawGender = request.getParameter("gender");
        String rawDescription = request.getParameter("description");

        if (rawAddress == null) {
            rawAddress = "";
        }
        if (rawPhone == null) {
            rawPhone = "";
        }
        if (rawDob == null) {
            rawDob = "0001-01-01";
        }

        int supplierID = Integer.parseInt(rawSupplierID);
        String supplierName = rawSupplierName;
        String address = rawAddress;
        String phone = rawPhone;
        Date dob = Date.valueOf(rawDob);
        String description = rawDescription;
        int genderInt = Integer.parseInt(rawGender);
        boolean gender = true;
        if (genderInt == 1) {
            gender = true;
        } else {
            gender = false;
        }

        Supplier supplier = new Supplier(supplierID, supplierName, gender, dob,
                phone, address, description);
        SupplierDBContext cdb = new SupplierDBContext();
        cdb.updateSupplier(supplier);

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
