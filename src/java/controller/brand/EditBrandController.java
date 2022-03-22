/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.brand;

import dal.product.BrandDBContext;
import dal.product.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Brand;
import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class EditBrandController extends HttpServlet {

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
        int brandID = Integer.parseInt(request.getParameter("id"));
        BrandDBContext db = new BrandDBContext();
        Brand brand = db.getBrand(brandID);

        String result = "";
        result += brand.getBrandID() + "|";
        result += brand.getBrandName();

        PrintWriter writer = response.getWriter();

        writer.println(result);

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
          response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        int brandID = Integer.parseInt(request.getParameter("brandID"));
        String brandName = request.getParameter("brandName");
        System.out.println(brandID);
        BrandDBContext bdb = new BrandDBContext();
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<Product> products = pdb.getProductsByBrand(brandID);

        Brand newBrand = new Brand(brandID, brandName);

        for (Product product : products) {
            product.setBrand(newBrand);
            pdb.updateProduct(product);
        }

        bdb.updateBrand(newBrand);
        response.sendRedirect("../product/list");
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
