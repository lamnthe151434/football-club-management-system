/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.product;

import dal.product.BrandDBContext;
import dal.product.CategoryDBContext;
import dal.product.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.product.Brand;
import model.product.Category;
import model.product.Product;

/**
 *
 * @author ADMIN
 */
public class SearchProductController extends HttpServlet {

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
        String rawProductID = request.getParameter("id");

        if (rawProductID == "") {
            return;
        }
        int productID = Integer.parseInt(rawProductID);
        ProductDBContext pdb = new ProductDBContext();
        Product product = pdb.getProduct(productID);

        PrintWriter writer = response.getWriter();

        String result = "";

        if (product != null) {
            result += product.getProductID() + "|";
            result += product.getProductName() + "|";
            result += product.getCategory().getCategoryName() + "|";
            result += product.getBrand().getBrandName() + "|";
            result += product.getUnit() + "|";
            result += product.getCost() + "|";
            result += product.getPrice() + "|";
            result += product.getDescription() + "|";
            result += product.getStatus();
        }
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
        String type = request.getParameter("type");
        ProductDBContext pdb = new ProductDBContext();
        ArrayList<Product> products = pdb.getProducts(searchKey);
        PrintWriter writer = response.getWriter();
        String result = "";

        String onclick = "";

        if (type != null) {
            onclick = "addTo('" + type + "',";
        } else {
            onclick = "addTo(";
        }

        if (products.size() > 0) {
            for (int i = 0; i < products.size(); i++) {
                Product product = products.get(i);
                result += "<div class=\"product-result\" onclick=\"" + onclick + ""
                        + product.getProductID() + ")\"  >";
                result += "<span>Mã hàng: " + product.getProductID() + " </span>";
                result += "<span>ĐVT: " + product.getUnit() + " </span>";
                result += "<span>Tồn kho: " + product.getQuantity() + " </span></br>";
                result += "<span>Tên hàng: " + product.getProductName() + " </span>";
                result += "<span>Giá bán: " + product.getPrice() + " </span>";
                result += "</div>";
            }
        } else {
            result += "<div class=\"no-result\">";
            result += "<span>Không tìm thấy sản phẩm</span>";
            result += "</div>";
        }

        writer.println(result);
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
