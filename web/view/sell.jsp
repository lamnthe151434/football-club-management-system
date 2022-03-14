<%-- 
    Document   : sell
    Created on : Mar 15, 2022, 12:15:17 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel ="stylesheet" href="css/mystyle.css" />
        <script src="js/code.js" type="text/javascript"></script>
    </head>
    <style>

        body{
            overflow: auto;
            background: #EEEEEE;
        }
        .container .top,
        .container .left,
        .container .right {
            padding: 20px;
            margin-bottom: 20px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0px 0px 2px 2px #ccc;
        }

        .container .top {
            margin-top: 20px;
        }

        .container .left {
            float: left;
            width: 62%;
            height: 450px;
            overflow: auto;
        }
        .container .right {
            float: right;
            width: 30%;
            height: 450px;
            overflow: auto;
        }

        .container .left table {
            /*margin-top: 15px;*/
            font-size: 17px;
            text-align: left;
            width: 100%;
            table-layout: fixed;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-collapse: collapse;
            /*box-sizing: border-box;*/
        }

        .container .left table thead{
            position: sticky;
            top:0;
            /*background-color: #009879;*/
            /*color: #ffffff;*/
        }

        .container .left table td {
            padding: 10px;
            word-wrap: break-word;    
        }

        .container .left table tr {
            border-bottom: 1px solid #dddddd;
        }

        .container .left table tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .container .left table tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }



    </style>
    <body>
        <div class="header" >
            <h2 class="title" >Bán hàng</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="slider.jsp" />
        </div>
        <div class="container" >
            <div class="top" >
                <div class="horizontal-search" >
                    <input id="search-bar" type="text" placeholder="Theo mã hoặc tên hàng" value="${requestScope.searchKey}" name="id">
                    <button onclick="setSearchKey('search-key', 'search-bar')"><i class="fa fa-search"></i></button>         
                </div>
            </div>
            <div class="left" id="left" >
                <table>
                    <thead>
                        <tr>
                            <td style="width: 20px;" ></td>
                            <td>STT</td>
                            <td>Mã hàng</td>
                            <td>Tên hàng</td>
                            <td>ĐVT</td>
                            <td>Đơn giá</td>
                            <td>Số lương</td>
                            <td>Thành tiền</td>
                        </tr>
                    </thead>
                    <tbody id="insert-product-list" class="import-invoice-insert" >

                    </tbody>
                </table>
            </div>
            <div class="right" ></div>
        </div>
    </body>
</html>
