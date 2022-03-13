/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.import_invoice;

import dal.transaction.ImportInvoiceDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Product;
import model.transaction.ImportInvoice;
import model.transaction.ImportInvoiceDetail;

/**
 *
 * @author ADMIN
 */
public class SearchImportInvoiceController extends HttpServlet {

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
            out.println("<title>Servlet SearchImportInvoiceController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchImportInvoiceController at " + request.getContextPath() + "</h1>");
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
        ImportInvoiceDBContext iidb = new ImportInvoiceDBContext();
        int id = Integer.parseInt(request.getParameter("id"));

        ImportInvoice importInvoice = iidb.getImportInvoice(id);
        String description = importInvoice.getDescription();
        if (description == null) {
            description = "";
        }
        int statusNumber = importInvoice.getStatus();

        String status = "";
        if (statusNumber == 0) {
            status = "Đã hủy";
        }
        if (statusNumber == 1) {
            status = "Phiếu tạm";
        }
        if (statusNumber == 2) {
            status = "Đã nhập hàng";
        }
        String result = "";
        PrintWriter writer = response.getWriter();
        result += importInvoice.getImportInvoiceID() + "|";
        result += importInvoice.getDate() + "|";
        result += importInvoice.getSupplier().getSupplierName() + "|";
        result += importInvoice.getTotal() + "|";
        result += status + "|";
        result += description + "|";
        ArrayList<ImportInvoiceDetail> invoices = importInvoice.getInvoices();
        for (int i = 0; i < invoices.size(); i++) {
            ImportInvoiceDetail in = invoices.get(i);
            Product product = in.getProduct();
            result += "<tr>";
            result += "<td>" + (i + 1) + "</td>";
            result += "<td>" + product.getProductID() + "</td>";
            result += "<td>" + product.getProductName() + "</td>";
            result += "<td>" + product.getUnit() + "</td>";
            result += "<td>" + in.getUnitPrice() + "</td>";
            result += "<td>" + in.getQuantity() + "</td>";
            result += "<td>" + in.getTotal() + "</td>";
            result += "</tr>";
        }
        result += "|";

        String[] separeated = result.split("|");
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
        String rawSearchKey = request.getParameter("searchKey");

        if (rawSearchKey == null) {
            rawSearchKey = "";
        }

        String rawFrom = request.getParameter("from");
        String rawTo = request.getParameter("to");

        Date from = Date.valueOf(rawFrom);
        Date to = Date.valueOf(rawTo);

        String rawStatus = request.getParameter("status");

        if (rawStatus != null) {
            String[] statusStr = rawStatus.split("|");
            int[] status = new int[statusStr.length];
            for (int i = 0; i < statusStr.length; i++) {
                status[i] = Integer.parseInt(statusStr[i]);
            }
        }

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
