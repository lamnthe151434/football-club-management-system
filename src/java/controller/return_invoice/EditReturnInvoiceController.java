/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools @ Templates
 * and open the template in the editor.
 */
package controller.return_invoice;

import dal.partner.SupplierDBContext;
import dal.product.ProductDBContext;
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
public class EditReturnInvoiceController extends HttpServlet {

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

        ReturnInvoice returnInvoices = rdb.getReturnInvoice(id);
        String description = returnInvoices.getDescription();
        if (description == null) {
            description = "";
        }

        int statusNumber = returnInvoices.getStatus();

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
        result += returnInvoices.getReturnInvoiceID() + "|";
        result += returnInvoices.getReturnInvoiceID() + "|";
        result += returnInvoices.getStatus() + "|";
        result += returnInvoices.getDate() + "|";
        result += returnInvoices.getSupplier().getSupplierID() + "|";
        result += returnInvoices.getSupplier().getSupplierName() + "|";
        result += returnInvoices.getTotal() + "|";
        result += status + "|";
        result += description + "|";
        ArrayList<ReturnInvoiceDetail> invoices = returnInvoices.getInvoices();
        for (int i = 0; i < invoices.size(); i++) {
            ReturnInvoiceDetail in = invoices.get(i);
            Product product = in.getProduct();
            result += "<tr id =\"edit-" + (i + 1) + "\">";
            result += "<td><button type =\"button\" onclick=\"deleteFrom('edit','edit-" + (i + 1)
                    + "')\"><i class =\"fa fa-trash\" ></i></button></td>";
            result += "<td>" + (i + 1) + "</td>";
            result += "<td>" + product.getProductID() + "<input type=\"hidden\" name = \"id\" value = \""
                    + product.getProductID() + "\"" + "</td>";
            result += "<td>" + product.getProductName() + "</td>";
            result += "<td>" + product.getUnit() + "</td>";
            result += "<td>" + in.getUnitPrice() + "</td>";
            result += "<td><input onkeyup = \"setAmount('edit',this.value,'edit-"
                    + (i + 1) + "')\" type=\"text\" name = \"quantity\"  value = \"" + in.getQuantity() + "\" /></td>";
            result += "<td>" + in.getTotal() + "</td>";
            result += "</tr>";
        }
        result += "|";
        if (returnInvoices.getStatus() == 1) {
            result += "<input type=\"submit\" onclick=\"checkInput('edit-form', 'edit-status', '1')\" value =\"Lưu\" />\n";
            result += "<input type=\"submit\" onclick=\"checkInput('edit-form', 'edit-status', '2')\" value =\"Hoàn thành\" />\n";
            result += "<input type=\"submit\" onclick=\"checkInput('edit-form', 'edit-status', '0')\" value =\"Hủy phiếu\" />";
        }
        if (returnInvoices.getStatus() == 2) {
            result += "<input type=\"submit\" onclick=\"checkInput('edit-form', 'edit-status', '2')\" value =\"Lưu\" />\n";
            result += "<input type=\"submit\" onclick=\"checkInput('edit-form', 'edit-status', '0')\" value =\"Hủy phiếu\" />";
        }

        String[] separeated = result.split("|");
        System.out.println("leng " + separeated.length);
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
          SupplierDBContext sdb = new SupplierDBContext();
        ProductDBContext pdb = new ProductDBContext();

        int returnInvoiceID = Integer.parseInt(request.getParameter("invoiceID"));
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

        ReturnInvoiceDBContext iidb = new ReturnInvoiceDBContext();
        ReturnInvoice returnInvoice = iidb.getReturnInvoice(returnInvoiceID);

        int newStatus = Integer.parseInt(rawStatus);
        int oldStatus = returnInvoice.getStatus();

        System.out.println(newStatus + ", " + oldStatus);

        // phiếu tạm -> đã nhập hàng
        if (newStatus == (oldStatus + 1)) {

        }
        // phiếu tạm -> hủy phiếu
        if (newStatus == (oldStatus - 1)) {

        }
        // đã nhập hàng -> hủy phiếu
        if (newStatus == (oldStatus - 2)) {
            ArrayList<ReturnInvoiceDetail> invoices = iidb.getReturnInvoiceDetails(returnInvoiceID);
            for (int i = 0; i < invoices.size(); i++) {
                ReturnInvoiceDetail iid = invoices.get(i);
                int oldQuantity = iid.getQuantity();
                Product p = iid.getProduct();
                pdb.decreaseQuantity(p, oldQuantity);
            }
        }

        iidb.deleteReturnInvoiceDetail(returnInvoiceID);

        ArrayList<ReturnInvoiceDetail> returnInvoiceDetails = new ArrayList<>();

        for (int i = 0; i < productIDs.length; i++) {
            int productID = Integer.parseInt(String.valueOf(productIDs[i]));
            int quantity = Integer.parseInt(String.valueOf(quantities[i]));
            Product p = pdb.getProduct(productID);
            if (newStatus == (oldStatus + 1)) {
                pdb.increaseQuantity(p, quantity);
            }
            ReturnInvoiceDetail ii = new ReturnInvoiceDetail(returnInvoiceID, p, p.getCost(), quantity);
            returnInvoiceDetails.add(ii);
        }

        ReturnInvoice invoice = new ReturnInvoice(returnInvoiceID, date, supplier,
                discount, discountType, paid, returnInvoiceDetails, oldStatus, description);
        iidb.updateReturnInvoice(invoice);

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
