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
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.partner.Supplier;

/**
 *
 * @author ADMIN
 */
public class InsertSupplierController extends HttpServlet {

//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        HttpSession session = request.getSession();
//
//        String submitType = request.getParameter("submitType");
//        session.setAttribute("submitType", submitType);
//
//        String rawSupplierName = request.getParameter("supplierName");
//        String rawAddress = request.getParameter("address");
//        String rawPhone = request.getParameter("phone");
//        String rawDob = request.getParameter("dob");
//        String rawGender = request.getParameter("gender");
//        String rawDescription = request.getParameter("description");
//        System.out.println("dob: (" +rawDob + ")");
//
//        if (rawAddress == null) {
//            rawAddress = "";
//        }
//        if (rawPhone == null) {
//            rawPhone = "";
//        }
//        if (rawDob.length() < 4) {
//            rawDob = "0001-01-01";
//        }
//
//        if (rawGender == null) {
//            rawGender = "1";
//        }
//
//        String supplierName = rawSupplierName;
//        String address = rawAddress;
//        String phone = rawPhone;
//        System.out.println("dob: (" +rawDob + ")");
//        Date dob = Date.valueOf(rawDob);
//        String description = rawDescription;
//        int genderInt = Integer.parseInt(rawGender);
//        boolean gender = true;
//
//        if (genderInt == 1) {
//            gender = true;
//        } else {
//            gender = false;
//        }
//
//        Supplier supplier = new Supplier(supplierName, gender, dob,
//                phone, address, description);
//        SupplierDBContext cdb = new SupplierDBContext();
//        cdb.insertSupplier(supplier);
//
//        response.sendRedirect("list");
//    }
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
        request.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();

        String rawSupplierName = request.getParameter("supplierName");
        String rawAddress = request.getParameter("address");
        String rawPhone = request.getParameter("phone");
        String rawDob = request.getParameter("dob");
        String rawGender = request.getParameter("gender");
        String rawDescription = request.getParameter("description");
        System.out.println("dob: (" + rawDob + ")");
        String boxType = request.getParameter("boxType");

        if (rawAddress == null) {
            rawAddress = "";
        }
        if (rawPhone == null) {
            rawPhone = "";
        }
        if (rawDob.length() < 4) {
            rawDob = "0001-01-01";
        }

        if (rawGender == null) {
            rawGender = "1";
        }
        
        if(rawDescription == null) {
            rawDescription = "";
        }

        String supplierName = rawSupplierName;
        String address = rawAddress;
        String phone = rawPhone;
        System.out.println("dob: (" + rawDob + ")");
        Date dob = Date.valueOf(rawDob);
        String description = rawDescription;
        int genderInt = Integer.parseInt(rawGender);
        boolean gender = true;

        if (genderInt == 1) {
            gender = true;
        } else {
            gender = false;
        }

        Supplier supplier = new Supplier(supplierName, gender, dob,
                phone, address, description);
        SupplierDBContext cdb = new SupplierDBContext();
        cdb.insertSupplier(supplier);
        String result = "";
        result += "<table>";
        ArrayList<Supplier> suppliers = cdb.getSuppliers();
        for (int i = suppliers.size() - 1; i >= 0; i--) {
            Supplier ss = suppliers.get(i);
            result += "<tr>";
            result += "<td>";
            result += "<span onclick=\"setValue('" + ss.getSupplierID() + "', '"
                    + ss.getSupplierName() + "', '" + boxType + "')\">";
            result += ss.getSupplierName();

            if (ss.getPhone().length() == 10) {
                result += " - " + ss.getPhone();
            }
            result += "</span>";

            result += "</td>";
            result += "</tr>";
        }
        result += "</table>";
        System.out.println(result);
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
  response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();

        String submitType = request.getParameter("submitType");
        session.setAttribute("submitType", submitType);

        String rawSupplierName = request.getParameter("supplierName");
        String rawAddress = request.getParameter("address");
        String rawPhone = request.getParameter("phone");
        String rawDob = request.getParameter("dob");
        String rawGender = request.getParameter("gender");
        String rawDescription = request.getParameter("description");
        System.out.println("dob: (" + rawDob + ")");

        if (rawAddress == null) {
            rawAddress = "";
        }
        if (rawPhone == null) {
            rawPhone = "";
        }
        if (rawDob.length() < 4) {
            rawDob = "0001-01-01";
        }

        if (rawGender == null) {
            rawGender = "1";
        }

        String supplierName = rawSupplierName;
        String address = rawAddress;
        String phone = rawPhone;
        System.out.println("dob: (" + rawDob + ")");
        Date dob = Date.valueOf(rawDob);
        String description = rawDescription;
        int genderInt = Integer.parseInt(rawGender);
        boolean gender = true;

        if (genderInt == 1) {
            gender = true;
        } else {
            gender = false;
        }

        Supplier supplier = new Supplier(supplierName, gender, dob,
                phone, address, description);
        SupplierDBContext cdb = new SupplierDBContext();
        cdb.insertSupplier(supplier);

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
