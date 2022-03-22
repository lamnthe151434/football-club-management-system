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
import javax.servlet.http.HttpSession;
import model.partner.Customer;

/**
 *
 * @author ADMIN
 */
public class ListCustomerController extends HttpServlet {

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
        CustomerDBContext sdb = new CustomerDBContext();

        HttpSession session = request.getSession();
        String submitType = String.valueOf(session.getAttribute("submitType"));
        String searchKey = request.getParameter("searchKey");
        if (searchKey == null) {
            searchKey = "";
        }
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
            orderBy += "[Customer_ID] ASC";
        }

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
        ArrayList<Customer> customers = sdb.getCustomers(pageIndex, pageSize, searchKey, orderBy);

        int totalRecord = sdb.getTotalRecord();
//        System.out.println(totalRecord);
        int totalPage = totalRecord / pageSize;
        if (totalRecord % pageSize != 0) {
            totalPage += 1;
        }

        String track = "";

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

        track += " of " + totalRecord;

        ArrayList<Integer> pageSizeOptions = new ArrayList<>();
        pageSizeOptions.add(10);
        pageSizeOptions.add(20);
        pageSizeOptions.add(30);
        pageSizeOptions.add(40);
        pageSizeOptions.add(50);

        request.setAttribute("pageSizeOptions", pageSizeOptions);
        request.setAttribute("selectedPageSize", pageSize);
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("customers", customers);
        request.setAttribute("track", track);
        request.setAttribute("submitType", submitType);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortType", sortType);
        request.setAttribute("searchKey", searchKey);

        request.getRequestDispatcher("../view/customer/list.jsp").forward(request, response);
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
