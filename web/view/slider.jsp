<%-- 
    Document   : slider
    Created on : Mar 5, 2022, 10:08:46 AM
    Author     : ADMIN
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="ltr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href ="../css/mystyle.css" />
    </head>
    <body>
        <div class="slider-menu">
            <ul>
                <section class ="setting" >
                </section>
                <section>
                    <!--<li class="links-group-title">Tổng quan</li>-->
                    <li onclick="changePage('http://localhost:8080/IEPM/dashboard')" class="slider-item"><i class="fa fa-dashboard"></i>Tổng quan</li>
                </section>
                <section>
                    <li class="links-group-title">Hàng hóa</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/product/list')" class="slider-item"><i class="fa fa fa-cube"></i>Danh mục</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/product/change/price')" class="slider-item"><i class="fa fa-money"></i>Thay đổi giá</li>
                    <!--<li onclick="" class="slider-item"><i class="fa fa fa-cubes"></i>Kiểm kho</li>-->
                </section>
                <section>
                    <li class="links-group-title">Giao dịch</li>
                    <li class="slider-item"><i class="fa fa-shopping-cart"></i>Hóa đơn</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/invoice/import/list')" class="slider-item"><i class="fa fa-dashboard"></i>Nhập hàng</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/invoice/return/list')" class="slider-item"><i class="fa fa-dashboard"></i>Trả hàng nhập</li>
                </section>
                <section>
                    <li class="links-group-title">Đối tác</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/customer/list')" class="slider-item"><i class="fa fa-user"></i>Khách hàng</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/supplier/list')" class="slider-item"><i class="fa fa-group"></i>Nhà cung cấp</li>
                </section>
<!--                <section>
                    <li class="links-group-title">Báo cáo</li>
                    <li onclick="" class="slider-item"><i class="fa fa-pie-chart"></i>Hàng hóa</li>
                    <li onclick="" class="slider-item"><i class="fa fa-dashboard"></i>Bán hàng</li>
                    <li onclick="" class="slider-item"><i class="fa fa-dashboard"></i>Khách hàng</li>
                    <li onclick="" class="slider-item"><i class="fa fa-group"></i>Nhà cung cấp</li>
                    <li onclick="" class="slider-item"><i class="fa fa-dashboard"></i>Tài chính</li>
                </section>-->
                <section>
                    <li class="links-group-title">Bán hàng</li>
                    <li onclick="changePage('http://localhost:8080/IEPM/sell')" class="slider-item"><i class="fa fa-pie-chart"></i>Bán hàng</li>
                </section>
            </ul>
        </div>
    </body>
    <script>
        function changePage(url) {
            var currentUrl = window.location.href;
            if (currentUrl !== url) {
                window.location.href = url;
            }
        }
    </script>
</html>
