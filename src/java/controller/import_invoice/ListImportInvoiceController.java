/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.import_invoice;

import dal.partner.SupplierDBContext;
import dal.transaction.ImportInvoiceDBContext;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.partner.Supplier;
import model.transaction.ImportInvoice;

/**
 *
 * @author ADMIN
 */
public class ListImportInvoiceController extends HttpServlet {

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
        ImportInvoiceDBContext idb = new ImportInvoiceDBContext();
        SupplierDBContext sdb = new SupplierDBContext();

        String searchKey = request.getParameter("searchKey");
        ArrayList<ImportInvoice> importInvoices = null;

        String sortBy = request.getParameter("sortBy");
        String sortType = request.getParameter("sortType");

        String orderBy = "ORDER BY ";

        if (sortBy != null && sortType != null && sortBy != "" && sortType != "") {
            orderBy += sortBy + " ";
            if (!sortType.equals("0")) {
                if (sortType.equals("1")) {
                    orderBy += "ASC";
                }

                if (sortType.equals("2")) {
                    orderBy += "DESC";
                }
            }
        }

        if (orderBy.trim().equals("ORDER BY")) {
            orderBy += "[Import_Invoice_ID] ASC";
        }

        String rawFrom = request.getParameter("from");
        String rawTo = request.getParameter("to");

        String from = rawFrom;
        String to = rawTo;

        if (rawFrom == null || rawFrom.equals("")) {
            from = "1990-01-01";
        }
        if (rawTo == null || rawTo.equals("")) {
            to = "2030-12-31";
        }

        String statuses = request.getParameter("status");
        if (statuses == null) {
            statuses = "12";
        }

//        System.out.println(from + "->" + to);
//        System.out.println(statuses);
        int[] status = new int[statuses.length()];

        for (int i = 0; i < statuses.length(); i++) {
            char ch = statuses.charAt(i);
            status[i] = Integer.parseInt(String.valueOf(ch));
        }

        String[] separatedFrom = from.split("-");
        String[] separatedTo = to.split("-");

        String rawPageIndex = request.getParameter("pageIndex");
        if (rawPageIndex == null) {
            rawPageIndex = "1";
        }
        String rawPageSize = request.getParameter("pageSize");
        if (rawPageSize == null) {
            rawPageSize = "10";
        }

        int pageIndex = Integer.parseInt(rawPageIndex);
        int pageSize = Integer.parseInt(rawPageSize);

        int totalRecord = idb.getTotalRecord(separatedFrom, separatedTo, status);

        int totalPage = totalRecord / pageSize;
        if (totalRecord % pageSize != 0) {
            totalPage += 1;
        }

        String track = "Hiển thị ";
        int begin = ((pageIndex - 1) * pageSize) + 1;
        int end = 0;

        track += String.valueOf(begin);

        if (pageIndex == totalPage) {
            if (pageIndex * pageSize == totalRecord) {
                end = totalRecord;
            } else {
                end = pageIndex * pageSize - (pageSize - (totalRecord % pageSize));
            }
        } else {
            end = pageIndex * pageSize;
        }

        if (end != begin) {
            track += "-";
            track += String.valueOf(end);
        }

        track += " / Tổng số " + totalRecord + " phiếu";

        String key = "";
        if (searchKey == null) {
            key = "";
            searchKey = "";
        } else {
            key = searchKey.replaceAll("\\s+", "");
        }

        if (!key.equals("")) {
            importInvoices = new ArrayList<>();
            int importInvoiceID = Integer.parseInt(key);
            ImportInvoice importInvoice = idb.getImportInvoice(importInvoiceID);
            if (importInvoice != null) {
                importInvoices.add(importInvoice);
            }
        } else {
            importInvoices = idb.getImportInvoices(separatedFrom, separatedTo,
                    status, pageIndex, pageSize, orderBy);
        }
        ArrayList<Supplier> suppliers = sdb.getSuppliers();
        ArrayList<Integer> pageSizeOptions = new ArrayList<>();
        pageSizeOptions.add(10);
        pageSizeOptions.add(20);
        pageSizeOptions.add(30);
        pageSizeOptions.add(40);
        pageSizeOptions.add(50);

        Date todayDate = idb.today();
        String today = String.valueOf(todayDate);

        request.setAttribute("pageSizeOptions", pageSizeOptions);
        request.setAttribute("selectedPageSize", pageSize);
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("statuses", statuses);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortType", sortType);

        request.setAttribute("today", today);
        request.setAttribute("track", track);
        if (rawFrom != null && !rawFrom.equals("")) {
            request.setAttribute("from", from);
        }
        if (rawTo != null && !rawTo.equals("")) {
            request.setAttribute("to", to);
        }
        request.setAttribute("importInvoices", importInvoices);
        request.setAttribute("searchKey", searchKey);
        request.setAttribute("suppliers", suppliers);

        request.getRequestDispatcher("../../view/transaction/import/list.jsp").forward(request, response);
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
