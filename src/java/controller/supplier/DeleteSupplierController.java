/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.supplier;

import dal.partner.SupplierDBContext;
import dal.transaction.ImportInvoiceDBContext;
import dal.transaction.ReturnInvoiceDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.transaction.ImportInvoice;
import model.transaction.ReturnInvoice;

/**
 *
 * @author ADMIN
 */
public class DeleteSupplierController extends HttpServlet {

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
        int supplierID = Integer.parseInt(request.getParameter("id"));
        SupplierDBContext sdb = new SupplierDBContext();

        ImportInvoiceDBContext iidb = new ImportInvoiceDBContext();
        ReturnInvoiceDBContext rdb = new ReturnInvoiceDBContext();
        int defaultSupplierID = 1;
        ArrayList<ImportInvoice> importInvoices = iidb.getImportInvoices();
        ArrayList<ReturnInvoice> returnInvoices = rdb.getReturnInvoices();
        for (ImportInvoice in : importInvoices) {
            iidb.updateDefaultSupplier(defaultSupplierID, in.getImportInvoiceID());
        }
        
        for (ReturnInvoice re : returnInvoices) {
            rdb.updateDefaultSupplier(defaultSupplierID, re.getReturnInvoiceID());
        }
        
        sdb.deleteSupplier(supplierID);
        response.sendRedirect("list");
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
