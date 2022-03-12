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
public class SearchSupplierController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchSupplierController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchSupplierController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        response.setContentType("text/html;charset=UTF-8");
        
        
        String searchKeyword = request.getParameter("keyword");
        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        boolean status = false;
        PrintWriter writer = response.getWriter();
        String result = "";
        result += "<table>";
        for (int i = suppliers.size() - 1; i >= 0; i--) {
            Supplier supplier = suppliers.get(i);
            if (supplier.getSupplierName().contains(searchKeyword)) {
                status = true;
                result += "<tr>";
                result += "<td>";
                result += "<span onclick=\"setValue('" + supplier.getSupplierID() + "','" + supplier.getSupplierName() + "', 'supplier')\" class =\"product-insert\" >"
                        + supplier.getSupplierName() + "</span> <br/>";
                result += "</td>";
                result += "<td>";
                result += "<button onclick=\"edit(" + supplier.getSupplierID() + ", 'supplier')\" >Edit</button>";
                result += "</td>";
                result += "<td>";
                result += "<button onclick=\"deleteEntity(" + supplier.getSupplierID() + ", 'supplier')\">Delete</button>";
                result += "</td>";
                result += "</tr>";
            }
        }
        if (status == false) {
            result += "<tr><td>Không có bản ghi nào tìm thấy!</td></tr>";
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
