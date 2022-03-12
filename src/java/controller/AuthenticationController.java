/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dal.AccountDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author ADMIN
 */
public class AuthenticationController extends HttpServlet {

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
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
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
        Boolean loginStatus = false;
        // Get username + password from user input
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Get account from database
        AccountDBContext db = new AccountDBContext();
        Account account = db.getAccount(username, password);
//        System.out.println(username + ", " + password);
        if(account == null) {
            System.out.println("dm");
        }
        // Check 
        request.setAttribute("loginStatus", loginStatus);
        if (account != null) {
            loginStatus = true;
            HttpSession session = request.getSession();
            Cookie c_username = new Cookie("username", username);
            Cookie c_password = new Cookie("password", password);
            c_username.setMaxAge(3600);
            c_password.setMaxAge(3600);
            response.addCookie(c_username);
            response.addCookie(c_password);
            session.setAttribute("account", account);
            response.sendRedirect("product/list");
        } else {
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
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

    @Override
    public void destroy() {
        super.destroy(); //To change body of generated methods, choose Tools | Templates.
    }
    
}
