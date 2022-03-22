/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.customer;

import dal.partner.CustomerDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.partner.Customer;

/**
 *
 * @author ADMIN
 */
public class SearchCustomerController extends HttpServlet {

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

        String searchKeyword = request.getParameter("keyword");
        String type = request.getParameter("type");

        CustomerDBContext sdb = new CustomerDBContext();
        ArrayList<Customer> customers = sdb.getCustomers();
        boolean status = false;
        PrintWriter writer = response.getWriter();
        String result = "";
        result += "<table>";
        for (int i = customers.size() - 1; i >= 0; i--) {
            Customer customer = customers.get(i);
            if (customer.getCustomerName().contains(searchKeyword)) {
                String hyperSign = "";
                if (customer.getPhone().length() > 0) {
                    hyperSign = "-";
                }
                status = true;
                result += "<tr>";
                result += "<td>";
                result += "<span onclick=\"setValue('" + customer.getCustomerID() + "','" + customer.getCustomerName() + "','" + type + "')\"  >"
                        + customer.getCustomerName() + " " + hyperSign + " " + customer.getPhone() + "</span> <br/>";
                result += "</td>";
                result += "</tr>";
            }
        }
        if (status == false) {
            result += "<tr><td>Không tìm thấy nhà cung cấp!</td></tr>";
        }
        result += "</table>";
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
