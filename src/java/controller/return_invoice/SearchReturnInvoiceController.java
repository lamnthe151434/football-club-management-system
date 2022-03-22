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
        ReturnInvoiceDBContext iidb = new ReturnInvoiceDBContext();
        int id = Integer.parseInt(request.getParameter("id"));

        ReturnInvoice returnInvoice = iidb.getReturnInvoice(id);
        String description = returnInvoice.getDescription();
        if (description == null) {
            description = "";
        }
        int statusNumber = returnInvoice.getStatus();

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
        PrintWriter writer = response.getWriter();

        int discountType = 1;
        String discountUnit = "";
        if (returnInvoice.isDiscountType()) {
            discountType = 1;
            discountUnit = "VND";
        } else {
            discountType = 0;
            discountUnit = "%";
        }

        String result = "";
        result += returnInvoice.getReturnInvoiceID() + "|";
        result += status + "|";
        result += returnInvoice.getDate() + "|";
        result += returnInvoice.getSupplier().getSupplierName() + "|";
        result += returnInvoice.getSupplier().getSupplierID() + "|";
        result += returnInvoice.getTotal() + "|";
        result += returnInvoice.getDiscount() + " " + discountUnit + "|";
        result += returnInvoice.getMustPay() + "|";
        result += returnInvoice.getPaid() + "|";
        result += returnInvoice.getReturnMoney() + "|";
        result += description + "|";
        result += discountType + "|";

        ArrayList<ReturnInvoiceDetail> invoices = returnInvoice.getInvoices();
        for (int i = 0; i < invoices.size(); i++) {
            ReturnInvoiceDetail in = invoices.get(i);
            Product product = in.getProduct();
            result += "<tr>";
            result += "<td>" + (i + 1) + "</td>";
            if (product.getStatus() == 0) {
                result += "<td>" + formatProductId(product.getProductID()) + "(Đã xóa)</td>";
            } else {
                result += "<td>" + formatProductId(product.getProductID()) + "</td>";
            }
            result += "<td>" + product.getProductName() + "</td>";
            result += "<td>" + product.getUnit() + "</td>";
            result += "<td>" + in.getUnitPrice() + "</td>";
            result += "<td>" + in.getQuantity() + "</td>";
            result += "<td>" + in.getTotal() + "</td>";
            result += "</tr>";
        }

        writer.println(result);

    }

    public String formatProductId(int id) {
        String idStr = String.valueOf(id);
        int len = idStr.length();
        switch (len) {
            case 1:
                return "P0000" + id;
            case 2:
                return "P000" + id;
            case 3:
                return "P00" + id;
            case 4:
                return "P0" + id;
            default:
                return "P0000" + id;
        }

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
            int returnInvoiceID = Integer.parseInt(searchKey);

            ReturnInvoiceDBContext idb = new ReturnInvoiceDBContext();

            ReturnInvoice returnInvoice = idb.getReturnInvoice(returnInvoiceID);
            invoices.add(returnInvoice);
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
