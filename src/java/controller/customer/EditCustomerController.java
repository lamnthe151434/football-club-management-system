/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.customer;

import dal.partner.CustomerDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.partner.Customer;

/**
 *
 * @author ADMIN
 */
public class EditCustomerController extends HttpServlet {

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
        int customerID = Integer.parseInt(request.getParameter("id"));
        CustomerDBContext cdb = new CustomerDBContext();
        Customer customer = cdb.getCustomer(customerID);

        if (customer.getAddress() == null) {
            customer.setAddress("");
        }
        if (customer.getPhone() == null) {
            customer.setPhone("");
        }

        String result = "";
        result += customer.getCustomerID() + "|";
        result += customer.getCustomerID() + "|";
        result += customer.getCustomerName() + "|";
        result += customer.getDob()+ "|";
        result += customer.isGender()+ "|";
        result += customer.getPhone() + "|";
        result += customer.getAddress() + "|";
        result += customer.getDescription();
       
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
          response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String rawCustomerID = request.getParameter("customerID");
        String rawCustomerName = request.getParameter("customerName");
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
        if (rawDob == null || rawDob.equals("")) {
            rawDob = "0001-01-01";
        }

        int customerID = Integer.parseInt(rawCustomerID);
        String customerName = rawCustomerName;
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

        Customer customer = new Customer(customerID, customerName, gender, dob,
                phone, address, description);
        CustomerDBContext cdb = new CustomerDBContext();
        cdb.updateCustomer(customer);

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
