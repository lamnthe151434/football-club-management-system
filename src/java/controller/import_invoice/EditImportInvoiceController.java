/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools @ Templates
 * and open the template in the editor.
 */
package controller.import_invoice;

import dal.partner.SupplierDBContext;
import dal.product.ProductDBContext;
import dal.transaction.ImportInvoiceDBContext;
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
import model.transaction.ImportInvoice;
import model.transaction.ImportInvoiceDetail;

/**
 *
 * @author ADMIN
 */
public class EditImportInvoiceController extends HttpServlet {

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

        int discountType = 1;
        if (importInvoice.isDiscountType()) {
            discountType = 1;
        } else {
            discountType = 0;
        }

        String result = "";
        PrintWriter writer = response.getWriter();
        result += importInvoice.getImportInvoiceID() + "|";
        result += importInvoice.getImportInvoiceID() + "|";
        result += status + "|";
        result += importInvoice.getDate() + "|";
        result += importInvoice.getSupplier().getSupplierName() + "|";
        result += importInvoice.getSupplier().getSupplierID() + "|";
        result += importInvoice.getTotal() + "|";
        result += importInvoice.getTotal() + "|";
        result += importInvoice.getDiscount() + "|";
        result += importInvoice.getMustPay() + "|";
        result += importInvoice.getMustPay() + "|";
        result += importInvoice.getPaid() + "|";
        result += importInvoice.getReturnMoney() + "|";
        result += description + "|";
        if (importInvoice.getStatus() == 1) {
            result += "<input id=\"edit-status\" type=\"hidden\" name =\"status\" />\n";
            result += "<button type=\"button\" onclick=\"checkInput('edit','edit-form', 'edit-status', '1')\">LƯU</button>\n";
            result += "<button type=\"button\" onclick=\"checkInput('edit','edit-form', 'edit-status', '2')\">HOÀN THÀNH</button>\n";
            result += "<button type=\"button\" onclick=\"checkInput('edit','edit-form', 'edit-status', '0')\">HỦY PHIẾU</button>";
        }
        if (importInvoice.getStatus() == 2) {
            result += "<input id=\"edit-status\" type=\"hidden\" name =\"status\" />\n";
            result += "<button type=\"button\" onclick=\"checkInput('edit','edit-form', 'edit-status', '2')\">LƯU</button>\n";
            result += "<button type=\"button\" onclick=\"checkInput('edit','edit-form', 'edit-status', '0')\">HỦY PHIẾU</button>";
        }
        result += "|";

        result += importInvoice.getDiscount() + "|";
        result += discountType + "|";

        ArrayList<ImportInvoiceDetail> invoices = importInvoice.getInvoices();
        for (int i = 0; i < invoices.size(); i++) {
            ImportInvoiceDetail in = invoices.get(i);
            Product product = in.getProduct();
            result += "<tr id =\"edit-" + (i + 1) + "\">";
            result += "<td><button type =\"button\" onclick=\"deleteFrom('edit'," + (i + 1)
                    + ")\"><i class =\"fa fa-trash\" ></i></button></td>";
            result += "<td>" + (i + 1) + "</td>";
            if (product.getStatus() == 0) {
                result += "<td>" + formatProductId(product.getProductID()) + "(Đã xóa)</td>";
            } else {
                result += "<td>" + formatProductId(product.getProductID()) + "</td>";
            }
            result += "<td>" + product.getProductName() + "<input type=\"hidden\" name =\"id\" value =\""
                    + product.getProductID() + "\"" + "</td>";
            result += "<td>" + product.getUnit() + "</td>";
            result += "<td>" + in.getUnitPrice() + "</td>";
            if (product.getStatus() == 0) {
                result += "<td>" + product.getQuantity();
                result += "<input type=\"hidden\" value=\"" +product.getQuantity()  + "\" name =\"quantity\" />";
                result += "</td>";
            } else {
                result += "<td>";
                result += "<button type=\"button\" onclick=\"increaseQuantity('edit'," + (i + 1)
                        + ")\"><i class=\"fa fa-arrow-up\"></i></button>";
                result += "<input maxlength =\"12\" onkeyup =\"setAmount('edit',this.value," + (i + 1)
                        + ")\"type=\"text\" name =\"quantity\" value=\"" + in.getQuantity() + "\" />";
                result += "<button type=\"button\" onclick=\"decreaseQuantity('edit'," + (i + 1)
                        + ")\"><i class=\"fa fa-arrow-down\"></i></button>";
                result += "</td>";
            }
            result += "<td>" + in.getTotal() + "</td>";
            result += "</tr>" + "@";
        }

        String[] separeated = result.split("|");
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
                return "P" + id;
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
        request.setCharacterEncoding("utf-8");
        SupplierDBContext sdb = new SupplierDBContext();
        ProductDBContext pdb = new ProductDBContext();
        int importInvoiceID = Integer.parseInt(request.getParameter("invoiceID"));
        String rawDate = request.getParameter("date");
        String rawSupplierID = request.getParameter("supplierID");
        String rawDiscount = request.getParameter("discount");
        String rawMustPay = request.getParameter("mustPay");
        String rawPaid = request.getParameter("paid");
        String rawTotalAmount = request.getParameter("totalAmount");
        String rawDiscountType = request.getParameter("discountType");
        String rawDescription = request.getParameter("desciption");
        String rawStatus = request.getParameter("status");

        float mustPay = Float.parseFloat(rawMustPay);
        float totalAmount = Float.parseFloat(rawTotalAmount);
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

        ImportInvoiceDBContext iidb = new ImportInvoiceDBContext();
        ImportInvoice importInvoice = iidb.getImportInvoice(importInvoiceID);

        int newStatus = Integer.parseInt(rawStatus);
        int oldStatus = importInvoice.getStatus();

//        System.out.println(newStatus + ", " + oldStatus);
        // phiếu tạm -> đã nhập hàng
        if (newStatus == (oldStatus + 1)) {

        }
        // phiếu tạm -> hủy phiếu
        if (newStatus == (oldStatus - 1)) {

        }
        // đã nhập hàng -> hủy phiếu
        if ((newStatus == (oldStatus - 2)) || (newStatus == 2 && oldStatus == 2)) {
            ArrayList<ImportInvoiceDetail> invoices = iidb.getImportInvoiceDetails(importInvoiceID);
            for (int i = 0; i < invoices.size(); i++) {
                ImportInvoiceDetail iid = invoices.get(i);
                int oldQuantity = iid.getQuantity();
                Product p = iid.getProduct();
                pdb.decreaseQuantity(p, oldQuantity);
            }
        }

        iidb.deleteImportInvoiceDetail(importInvoiceID);

        ArrayList<ImportInvoiceDetail> importInvoiceDetails = new ArrayList<>();

        for (int i = 0; i < productIDs.length; i++) {
            int productID = Integer.parseInt(String.valueOf(productIDs[i]));
            int quantity = Integer.parseInt(String.valueOf(quantities[i]));
            Product p = pdb.getProduct(productID);
            if ((newStatus == (oldStatus + 1)) || (oldStatus == 2 && newStatus == 2)) {
                pdb.increaseQuantity(p, quantity);
            }
            ImportInvoiceDetail ii = new ImportInvoiceDetail(importInvoiceID, p, p.getCost(), quantity);
            importInvoiceDetails.add(ii);
        }

        ImportInvoice invoice = new ImportInvoice(importInvoiceID, date, supplier,
                discount, discountType, paid, totalAmount,
                importInvoiceDetails, newStatus, description);
        iidb.updateImportInvoice(invoice);

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
