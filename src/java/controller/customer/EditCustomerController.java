/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.customer;

import dal.partner.CustomerDBContext;
import java.io.IOException;
import java.io.PrintWriter;
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
        int customerID = Integer.parseInt(request.getParameter("id"));
        CustomerDBContext cdb = new CustomerDBContext();
        Customer customer = cdb.getCustomer(customerID);

        
        if(customer.getAddress() == null) customer.setAddress("");
        if(customer.getPhone()== null) customer.setPhone("");
        if(customer.getEmail() == null) customer.setEmail("");
        
        String result = "";
        result += customer.getCustomerID() + "|";
        result += customer.getCustomerID() + "|";
        result += customer.getAddress() + "|";
        result += customer.getPhone() + "|";
        result += customer.getCustomerName() + "|";
        result += customer.getEmail();

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
        String rawCustomerID = request.getParameter("customerID");
        String rawCustomerName = request.getParameter("customerName");
        String rawAddress = request.getParameter("address");
        String rawPhone = request.getParameter("phone");
        String rawEmail = request.getParameter("email");

        if(rawAddress == null) rawAddress = "";
        if(rawPhone == null) rawPhone = "";
        if(rawEmail == null) rawEmail = "";
        
        int customerID = Integer.parseInt(rawCustomerID);
        String customerName = rawCustomerName;
        String address = rawAddress;
        String phone = rawPhone;
        String email = rawEmail;

        Customer customer = new Customer(customerID, customerName, address, phone, email);
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
