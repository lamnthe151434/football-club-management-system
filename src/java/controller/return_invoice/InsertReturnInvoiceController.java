/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.import_invoice;

import dal.partner.SupplierDBContext;
import dal.product.ProductDBContext;
import dal.transaction.ReturnInvoiceDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class InsertReturnInvoiceController extends HttpServlet {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

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
            out.println("<title>Servlet InsertReturnInvoiceController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertReturnInvoiceController at " + request.getContextPath() + "</h1>");
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
        SupplierDBContext sdb = new SupplierDBContext();
        ReturnInvoiceDBContext rdb = new ReturnInvoiceDBContext();
        ProductDBContext pdb = new ProductDBContext();

        String rawDate = request.getParameter("date");
        String rawSupplierID = request.getParameter("supplierID");
        String rawDiscount = request.getParameter("discount");
        String rawPaid = request.getParameter("paid");
        String rawDiscountType = request.getParameter("discountType");
        String rawDescription = request.getParameter("desciption");
        String rawStatus = request.getParameter("status");

        float discount = Float.parseFloat(rawDiscount);
        float paid = Float.parseFloat(rawPaid);

        boolean discountType = true;
        if (rawDiscountType.equals("1")) {
            discountType = true;
        } else {
            discountType = false;
        }

        String productIDs[] = request.getParameterValues("id");
        String quantities[] = request.getParameterValues("quantity");

        int supplierID = Integer.parseInt(rawSupplierID);
        Supplier supplier = sdb.getSupplier(supplierID);

        String separatedDate[] = rawDate.split("/");
        rawDate = "";
        for (int i = separatedDate.length - 1; i >= 0; i--) {
            rawDate += separatedDate[i];
            if (i != 0) {
                rawDate += "-";
            }
        }
        Date date = Date.valueOf(rawDate);
        String description = rawDescription;
        int status = Integer.parseInt(rawStatus);

//        ArrayList<Product> products = new ArrayList<>();
        ReturnInvoiceDBContext irdb = new ReturnInvoiceDBContext();

        ArrayList<ReturnInvoiceDetail> returnInvoiceDetails = new ArrayList<>();

        int returnInvoiceID = irdb.getTotalRecord() + 1;

        for (int i = 0; i < productIDs.length; i++) {
            int productID = Integer.parseInt(String.valueOf(productIDs[i]));
            int quantity = Integer.parseInt(String.valueOf(quantities[i]));
            Product p = pdb.getProduct(productID);
            p.setQuantity(p.getQuantity() - quantity);
            if (status == 2) {
                pdb.updateProduct(p);
            }
            ReturnInvoiceDetail ii = new ReturnInvoiceDetail(returnInvoiceID, p, p.getCost(), quantity);
            returnInvoiceDetails.add(ii);
            System.out.println(returnInvoiceID);
        }

        ReturnInvoice invoice = new ReturnInvoice(returnInvoiceID, date, supplier,
                discount, discountType, paid, returnInvoiceDetails, status, description);
        irdb.insertReturnInvoice(invoice);

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
