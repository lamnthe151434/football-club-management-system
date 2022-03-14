/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.return_invoice;

import dal.partner.SupplierDBContext;
import dal.transaction.ReturnInvoiceDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.partner.Supplier;
import model.product.Product;
import model.transaction.ReturnInvoice;
import model.transaction.ReturnInvoiceDetail;

/**
 *
 * @author ADMIN
 */
public class SearchReturnInvoiceController extends HttpServlet {

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
            out.println("<title>Servlet SearchReturnInvoiceController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchReturnInvoiceController at " + request.getContextPath() + "</h1>");
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
        ReturnInvoiceDBContext rdb = new ReturnInvoiceDBContext();
        int id = Integer.parseInt(request.getParameter("id"));

        ReturnInvoice importInvoice = rdb.getReturnInvoice(id);
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
            status = "Đã trả hàng nhập";
        }
        String result = "";
        PrintWriter writer = response.getWriter();
        result += importInvoice.getReturnInvoiceID() + "|";
        result += importInvoice.getDate() + "|";
        result += importInvoice.getSupplier().getSupplierName() + "|";
        result += importInvoice.getTotal() + "|";
        result += status + "|";
        result += description + "|";
        ArrayList<ReturnInvoiceDetail> invoices = importInvoice.getInvoices();
        for (int i = 0; i < invoices.size(); i++) {
            ReturnInvoiceDetail in = invoices.get(i);
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
        String searchKey = request.getParameter("searchKey");
        ArrayList<ReturnInvoice> invoices = new ArrayList<>();

        if (searchKey != null || !searchKey.equals("")) {
            int importInvoiceID = Integer.parseInt(searchKey);

            ReturnInvoiceDBContext idb = new ReturnInvoiceDBContext();

            ReturnInvoice importInvoice = idb.getReturnInvoice(importInvoiceID);
            invoices.add(importInvoice);
        }
        SupplierDBContext sdb = new SupplierDBContext();
        ArrayList<Supplier> suppliers = sdb.getSuppliers();

        request.setAttribute("returnInvoices", invoices);
        request.setAttribute("searchKey", searchKey);
        request.setAttribute("suppliers", suppliers);

        request.getRequestDispatcher("../../view/transaction/return/list.jsp").forward(request, response);

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
