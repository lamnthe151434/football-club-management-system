<%@page import="model.product.Brand"%>
<%@page import="model.product.Category"%>
<%@page import="model.product.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="ltr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">      
        <title>Product</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel ="stylesheet" href="../css/mystyle.css" />
        <script src="../js/code.js" type="text/javascript"></script>
    </head>
    <style>

        .modal .modal-header .title {
            font-weight: bold;
            font-size: 20px;
            color: #837DEC;
            padding: 10px 10px 10px 0;
        }


        .container .main-content .middle table {
            /*margin-top: 15px;*/
            font-size: 17px;
            text-align: left;
            width: 1220px;
            table-layout: fixed;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-collapse: collapse;
            /*box-sizing: border-box;*/
        }

        .container .main-content .middle {
            margin-left: 15px;
            width: 1220px;
            height: 450px;
            overflow: auto;
        }
        .container .main-content .middle table {
            /*margin-top: 15px;*/
            font-size: 17px;
            text-align: left;
            width: 1250px;
            table-layout: fixed;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-collapse: collapse;
            /*box-sizing: border-box;*/
        }

        .container .main-content .middle thead{
            position: sticky;
            top:0;
            background-color: #009879;
            color: #ffffff;
        }

        .container .main-content .middle table thead td, 
        .container .main-content .middle table tbody td {
            width: 100px;
            padding: 10px;
            word-wrap: break-word;    
        }

        .container .main-content .middle table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .container .main-content .middle table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .container .main-content .middle table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }



        .container .top .group-search .category, 
        .container .top .group-search .brand{
            /*display: inline-block;*/
            margin-right:10px; 
        }


        .modal .product-insert-modal, 
        .modal .product-edit-modal,
        .modal .category-insert-modal,
        .modal .category-edit-modal,
        .modal .brand-insert-modal,
        .modal .brand-edit-modal,
        .modal .product-unit-insert-modal,
        .modal .product-unit-edit-modal,
        .modal .unit-insert-modal,
        .modal .unit-edit-modal  
        {
            position: absolute;
            padding: 15px 35px 15px 35px;
            background: #fff;           
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 10;
            border-radius: 20px;
            box-shadow: 0px 0px 2px 2px #ccc;
        }

        .modal .product-insert-modal,
        .modal .product-edit-modal
        {
            top: 7vh;
            left: 80vh;
            width: 35vw;
            height: 70vh;

        }
        .modal {
            position: fixed;
            left: 0;
            top: 0;
            display: block;
            background: rgba(0, 0, 0, 0.5);
            height: 100%;
            width: 100%;
            transform: scale(0);
            transition-duration: 0s;
            z-index: 2;
        }


        .modal .category-insert-modal,
        .modal .brand-edit-modal,
        .modal .category-edit-modal,
        .modal .brand-insert-modal

        {
            top: 23vh;
            left: 99vh;
            width: 17vw;
            height: 25vh;

        }

        .modal .brand-insert-modal .modal-content,
        .modal .category-insert-modal .modal-content,
        .modal .brand-edit-modal .modal-content,
        .modal .category-edit-modal .modal-content {

            margin-top: 10px;
        }

        .modal .product-insert-modal .modal-content ,
        .modal .product-edit-modal .modal-content  {
            margin-top: 10px;
            position: relative;
        }


        .modal .product-insert-modal .modal-content input,
        .modal .product-edit-modal .modal-content input
        {
            width: 98%;
            padding: 10px;
            /*height: 30px;*/
            margin-top: 5px;
            background: #fff;
            border:none;
            outline: none;
            border-bottom: 1px solid #C7C7C7;           
            background: #fff;
        }

        .modal .product-edit-modal .modal-content table td:nth-child(1),
        .modal .product-insert-modal .modal-content table td:nth-child(1) {
            padding:10px 10px 10px 0px;
            width: 120px;
            /*border: 1px solid #000;*/
        }

        .modal .product-insert-modal .modal-content table tr:nth-child(10) td, 
        .modal .product-edit-modal .modal-content table tr:nth-child(10) td {
            /*border: 1px solid #000;*/
            /*box-sizing: border-box;*/
            text-align: center;
            width: 420px;
        }

        .modal .product-edit-modal .modal-content table tr:nth-child(10) td button,
        .modal .product-insert-modal .modal-content table tr:nth-child(10) td button{
            margin-top: 10px;
            padding:5px 10px 5px 10px;
            width: 150px;
            color: #fff;

            margin-right: 30px;
            text-align: center;
            border-radius: 5px;
        }

        .modal .product-edit-modal .modal-content table tr:nth-child(10) td button:hover,
        .modal .product-insert-modal .modal-content table tr:nth-child(10) td button:hover {
            box-shadow: 0px 0px 2px 2px #ccc;
        }

        .modal .product-insert-modal .modal-content table tr:nth-child(10) td button:nth-of-type(3),
        .modal .product-edit-modal .modal-content table tr:nth-child(10) td button:nth-of-type(3) {
            margin-right: 0px;
            background: rgb(0, 0, 200);
        }
        .modal .product-insert-modal .modal-content table tr:nth-child(10) td button:nth-of-type(2),
        .modal .product-edit-modal .modal-content table tr:nth-child(10) td button:nth-of-type(2) {
            background: rgb(0, 200, 0);
        }
        .modal .product-insert-modal .modal-content table tr:nth-child(10) td button:nth-of-type(1),
        .modal .product-edit-modal .modal-content table tr:nth-child(10) td button:nth-of-type(1) {
            background: rgb(200, 0, 0);
            margin-left: 5px;
        }

        .table-title {
            font-size: 17px;
            font-weight: 600;
        }

        .modal .product-edit-modal .modal-content table td:nth-child(2),
        .modal .product-insert-modal .modal-content table td:nth-child(2) {
            padding: 10px 0px 0x 0px;
            width: 390px;
            box-sizing: border-box;
            /*border: 1px solid #000;*/

        }
        .modal .product-edit-modal .modal-content input:focus,
        .modal .product-insert-modal .modal-content input:focus {
            border-bottom: 1px solid blue;
            box-shadow: 0px  2px #ccc;
        }

        .modal .product-edit-modal .modal-content table td span,
        .modal .product-insert-modal .modal-content table td span {
            padding: 10px;
            width: 98%;
            display: inline-block;
            border-bottom: 1px solid #C7C7C7; 
            cursor: pointer;
        }

        #brand-edit-name,
        #category-edit-name,
        #brand-insert-name,
        #category-insert-name {
            width: 350px;
        }
        .modal .product-edit-modal .modal-content table td span:hover,
        .modal .product-insert-modal .modal-content table td span:hover{
            border-bottom: 1px solid blue; 
        }


        .modal .category-insert-modal .modal-content input,
        .modal .brand-insert-modal .modal-content input,
        .modal .brand-edit-modal .modal-content input ,
        .modal .category-edit-modal .modal-content input,
        .modal .unit-insert-modal .modal-content input,
        .modal .unit-edit-modal .modal-content input {
            width: 255px;
            height: 35px;
            margin-top: 5px;
        }


        .modal .product-insert-modal .modal-content #category-insert-container ,
        .modal .product-insert-modal .modal-content #brand-insert-container  ,
        .modal .product-edit-modal .modal-content #category-edit-container ,
        .modal .product-edit-modal .modal-content #brand-edit-container  { 
            position: absolute;
            top: 130px;
            left: 130px;
            width: 370px;
            background: #fff;
            display: none;
            box-shadow: 0px 0px 2px 2px #ccc;
            border: 1px solid blue;
            border-radius: 5px;

        }


        .modal .product-edit-modal .modal-content #brand-edit-container ,
        .modal .product-insert-modal .modal-content #brand-insert-container 

        {
            top: 170px;
            z-index: 2;

        }

        .modal .product-edit-modal .modal-content #category-edit-container 
        .modal .product-insert-modal .modal-content #category-insert-container 

        {
            z-index: 3;
        }


        .modal .product-insert-modal .modal-content #category-insert-container  input,
        .modal .product-insert-modal .modal-content #brand-insert-container  input,
        .modal .product-edit-modal .modal-content #category-edit-container input,
        .modal .product-edit-modal .modal-content #brand-edit-container  input{
            width: 345px;
            height: 45px;
            box-sizing: border-box;
            border: none;
            outline: none;
            margin: 10px;
            margin-top: 0;
            padding: 10px;
            padding-left: 0px;
            padding-bottom: 5px;
            border-bottom: 3px solid #FFCD1F;
        }



        .modal .product-insert-modal .modal-content #category-insert-container  #category-insert-list,
        .modal .product-insert-modal .modal-content #brand-insert-container  #brand-insert-list,
        .modal .product-edit-modal .modal-content #category-edit-container #category-edit-list,
        .modal .product-edit-modal .modal-content #brand-edit-container  #brand-edit-list {
            overflow: auto;
            height: 165px;
            width: 100%x;
        }

        .modal .product-insert-modal .modal-content #category-insert-container  #category-insert-list table td,
        .modal .product-insert-modal .modal-content #brand-insert-container  #brand-insert-list table td,
        .modal .product-edit-modal .modal-content #category-edit-container  #category-edit-list table td,
        .modal .product-edit-modal .modal-content #brand-edit-container  #brand-edit-list table td

        {
            padding: 0px;
            margin: 0px;
            height: 20px;
            width: 100%;
        }




        .modal .product-insert-modal .modal-content #category-insert-container  #category-insert-list span,
        .modal .product-insert-modal .modal-content #brand-insert-container   #brand-insert-list span,
        .modal .product-edit-modal .modal-content #category-edit-container #category-edit-list span,
        .modal .product-edit-modal .modal-content #brand-edit-container #brand-edit-list span
        {
            cursor: pointer;
            display: inline-block;
            width: 335px;
            height: 20px;
            margin: 0px;
            border: none;
        }

        .modal .product-insert-modal .modal-content #category-insert-container  #category-insert-list span:hover,
        .modal .product-insert-modal .modal-content #brand-insert-container    #brand-insert-list  span:hover,
        .modal .product-edit-modal .modal-content #category-edit-container #category-edit-list span:hover,
        .modal .product-edit-modal .modal-content #brand-edit-container  #brand-edit-list  span:hover

        {
            background: #FFCD1F;
            color: #000;
        }

        .container .main-content .top .group-search:nth-of-type(2)  {
            /*border: 1px solid #000;*/
            position: relative;
            margin-bottom: 60px;
        }

        .container .main-content .top .group-search .brand {
            position: absolute;
            width: 280px;
            top: 0;
            left: 350px;
        }

        .container .main-content .top .group-search .category {
            position: absolute;
            width: 275px;
            top: 0;
            left: 10;
        }



        .container .main-content .top .group-search .brand .brand-container #brand-name,
        .container .main-content .top .group-search .category .category-container #category-name{
            display: inline-block;
            width: 170px;
            height: 30px;
            padding: 5px;
            border: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
            border-radius: 5px;
        }



        .container .main-content .top .group-search .brand .brand-container #brand-search-box,
        .container .main-content .top .group-search .category .category-container #category-search-box {
            position: absolute;
            top: 38px;
            left: 0px;
            height: 220px;
            width: 255px;
            background: #fff;
            /*border: 1px solid #000;*/
            box-shadow: 0px 0px 2px 2px #ccc;
            box-sizing: border-box;   
            display: none;
            z-index: 2;

        }

        .container .main-content .top .group-search .brand .brand-container #brand-search-box {
            width: 260px;
        }
        .container .main-content .top .group-search .brand .brand-container #brand-search-box input,
        .container .main-content .top .group-search .category .category-container #category-search-box input {
            width: 235px;
            height: 45px;
            box-sizing: border-box;
            border: none;
            outline: none;
            margin: 10px;
            margin-top: 0;
            padding: 10px;
            padding-left: 0px;
            padding-bottom: 5px;
            border-bottom: 3px solid #FFCD1F;
        }


        .container .top {
            margin-bottom: 30px;
        }

        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-list,
        .container .main-content .top .group-search .category .category-container #category-search-box #category-list {
            overflow: auto;
            height: 165px;
            width: 255px;

        }
        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-list{
            width: 260px;
        }

        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-list span,
        .container .main-content .top .group-search .category .category-container #category-search-box #category-list span {
            cursor: pointer;
            display: inline-block;
            width: 245px;
            height: 20px;
            padding: 5px;
            margin: 0px;
        }

        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-list span:hover,
        .container .main-content .top .group-search .category .category-container #category-search-box #category-list span:hover {
            background: #FFCD1F;
            color: #000;
        }

        .container .main-content .top .group-search .brand .brand-container  .btn-add,
        .container .main-content .top .group-search .category .category-container .btn-add {
            position: absolute;
            top: 7px;
            cursor: pointer;
            width: 10px;
            background: none;
            border: none;
            font-weight: bold;
        }
        .container .main-content .top .group-search .brand .btn-add:hover,
        .container .main-content .top .group-search .category .btn-add:hover {
            background: #ccc;
        }
        .modal .product-insert-modal .modal-content .radio-button input , 
        .modal .product-edit-modal .modal-content  .radio-button input  {
            width: 30px;
            height: 15px;
        }


        .modal .product-insert-modal .modal-content  textarea, 
        .modal .product-edit-modal .modal-content  textarea {
            overflow: scroll;
            resize: none;
            margin-top: 5px;
            margin-bottom: 35px;
            border: 1px solid #000;
        }


        .container .bottom span {
            position: absolute;
            left: 35vw;
        }

        .modal .product-insert-modal .modal-content #category-insert-container  #category-insert-list .no-result,
        .modal .product-insert-modal .modal-content #brand-insert-container  #brand-insert-list .no-result,
        .modal .product-edit-modal .modal-content #category-edit-container #category-edit-list .no-result,
        .modal .product-edit-modal .modal-content #brand-edit-container  #brand-edit-list .no-result
        {
            display: block;
            padding: 50px 5px 20px 10px;
            text-align: center;
            color: #ccc;
            font-size: 25px;
        }


        .modal .product-insert-modal .modal-content #category-insert-container  #category-insert-list .no-result:hover,
        .modal .product-insert-modal .modal-content #brand-insert-container  #brand-insert-list .no-result:hover,
        .modal .product-edit-modal .modal-content #category-edit-container #category-edit-list .no-result:hover,
        .modal .product-edit-modal .modal-content #brand-edit-container  #brand-edit-list .no-result:hover {
            background: #fff;
            color: #ccc;
        }

        .sort-by {
            cursor: pointer;
        }

        .warning {
            position: absolute;
            right: 15px;
            bottom: 15px;
            z-index: 99;
        }

        .warning div {
            width: 250px;
            background: #C75B56;
            padding: 15px;
            /*padding-top: 10px;*/
            /*padding-bottom: 10px;*/
            color: #fff;
            border-radius: 7px;
            margin-top: 5px;
            /*animation-name: fadeIn;*/
            animation-duration: 0.3s;
            cursor: pointer;
        }
        @keyframes fadeIn{
            from{
                opacity: 0;
            } 
            to {
                opacity: 1;
            }
        }
        @keyframes fadeOut{
            from{
                opacity: 1;
            } 
            to {
                opacity: 0;
            }
        }
        .warning div:hover {
            box-shadow: 0px 0px 2px 2px grey;
            background: red;
        }

        .modal .insert-confirm-modal,
        .modal .delete-confirm-modal{
            position: absolute;
            padding: 15px 35px 15px 35px;
            border-radius: 5px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.2s;
            z-index: 99;
            top: 0vh;
            left: 75vh;
            width: 25vw;
            height: 12vh;
            font-size: 17px;
            box-shadow: 0px 2px 2px #000;
            padding: 10px 20px 10px 20px;
            /*border: 0.5px solid blue;*/
        }
        .modal .insert-confirm-modal .btn-group,
        .modal .delete-confirm-modal .btn-group

        {
            width: 100%;
            margin-top: 10px;
            text-align: right;
        }

        .modal .insert-confirm-modal .btn-group button ,
        .modal .delete-confirm-modal .btn-group button 
        {
            padding: 5px;
            margin-left: 10px;
            width: 70px;
            border: 5px;
            color: #fff;
        }
        .modal .insert-confirm-modal .btn-group button:hover ,
        .modal .delete-confirm-modal .btn-group button:hover 
        {
            box-shadow: 0px 0px 2px 2px #ccc;
        }
        .modal .insert-confirm-modal .btn-group button:nth-of-type(1) ,
        .modal .delete-confirm-modal .btn-group button:nth-of-type(1) 
        {
            background: rgb(200, 0, 0);
        }
        .modal .insert-confirm-modal .btn-group button:nth-of-type(2),
        .modal .delete-confirm-modal .btn-group button:nth-of-type(2) {

            background: rgb(0, 200, 0);
            /*margin-right: 10px;*/
        }




    </style>
    <body>

        <div id ="header" class ="header" >
            <h2 class ="title" >Danh mục</h2>
        </div>
        <div class ="navigator" > 
            <jsp:include page = "../../view/slider.jsp" />
        </div>
        <div class="search-section" >
            <form id="search-form" action="list" method="POST" >
                <input type="hidden" id="search-key" name ="searchKey" value="${requestScope.searchKey}" />
                <input type="hidden" id="category-search"  value="${category.categoryID}" name="categoryID" />
                <input type="hidden" value="${category.categoryName}" name="categoryName" />
                <input type="hidden" id="brand-search" value="${brand.brandID}" name="brandID" />
                <input type="hidden" value="${brand.brandName}" name="brandName" />
                <input type="hidden" id="page-index" value="${requestScope.pageIndex}"  name="pageIndex" />
                <input type="hidden" id="page-size" value="${requestScope.selectedPageSize}"  name="pageSize"  />
                <input type="hidden" id="sort-by" name="sortBy" value="${requestScope.sortBy}" />
                <input type="hidden" id="sort-type" name="sortType"  value="${requestScope.sortType}"/>
            </form>
        </div>
        <div id ="container" class ="container">
            <div class ="main-content" >
                <div class ="top" >
                    <div class ="group-search" >
                        <div class ="horizontal-search" >
                            <input id="search-bar" value="${requestScope.searchKey}" type="text" placeholder="Tìm kiếm theo tên hoặc mã hàng" name="search">
                            <button type="button" onclick="setSearchKey('search-key', 'search-bar')"><i class="fa fa-search"></i></button>         
                        </div>
                        <div class ="btn-add" >
                            <button onclick="openModal('product-insert-modal')">Thêm mới hàng hóa</button>
                        </div>
                    </div>
                    <div class ="group-search" >
                        <form id ="search-product" action="list" method="GET" >
                            <div class ="category" >
                                <div class ="category-container">
                                    <span>Nhóm hàng: </span>
                                    <span id="category-name" onclick="openBox('category-search-box')" >${requestScope.category.categoryName}</span>
                                    <input id ="category-id" name ="categoryID" type ="hidden"  
                                           value ="${requestScope.category.categoryID}" />
                                    <div id = "category-search-box">
                                        <input type ="text" onkeyup="search(this.value, 'category')"  placeholder="Tìm kiếm nhóm hàng"/>
                                        <div id="category-list" >
                                            <table>
                                                <tr>
                                                    <td><span onclick="setValue('-1', 'Tất cả', 'category')" 
                                                              class ="category-value">Tất cả</span></td>
                                                </tr>
                                                <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category')" class ="category-value">${c.categoryName}</span></td>
                                                        <td><button class="action" type="button" onclick="edit(${c.categoryID}, 'category')" ><i class="fa fa-pencil" ></i></button></td>
                                                        <td><button class="action" type ="button" onclick="deleteEntity(${c.categoryID}, 'category')"><i class ="fa fa-trash" ></i> </button></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                    <button type="button" onclick="openModal('category-insert-modal')"  class ="btn-add"><i class="fa fa-plus" ></i></button>
                                </div>
                            </div >
                            <div class ="brand" >
                                <div class ="brand-container"  >
                                    <span>Thương hiệu: </span>
                                    <span id="brand-name" onclick="openBox('brand-search-box')" >${requestScope.brand.brandName}</span>
                                    <input id ="brand-id" name ="brandID" type ="hidden"
                                           value ="${requestScope.brand.brandID}" />
                                    <div id ="brand-search-box" >
                                        <input type ="text" onkeyup="search(this.value, 'brand')" placeholder="Tìm kiếm thương hiệu" />
                                        <div id = "brand-list" >
                                            <table >
                                                <tr>
                                                    <td><span onclick="setValue('-1', 'Tất cả', 'brand')" 
                                                              class ="brand-value">Tất cả</span></td>
                                                </tr>
                                                <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                                    <tr>
                                                        <td class="first-td" ><span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand')" class ="brand-value">${b.brandName}</span></td>
                                                        <td><button class="action" type="button"  onclick="edit(${b.brandID}, 'brand')" ><i class="fa fa-pencil" ></i></button></td>
                                                        <td><button class="action" type="button"  onclick="deleteEntity(${b.brandID}, 'brand')"><i class ="fa fa-trash" ></i></button></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                    <button type="button" onclick="openModal('brand-insert-modal')"  class ="btn-add"><i class="fa fa-plus" ></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class ="middle" >
                    <c:if test="${requestScope.products.size() > 0}" >
                        <table>
                            <thead>
                                <tr>
                                    <td class="sort-by" onclick="sortBy('Product_ID', 0)">
                                        <span>Mã hàng</span>
                                        <c:if  test="${requestScope.sortBy == 'Product_ID' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Product_Name', 1)">
                                        <span> Tên hàng hóa</span>
                                        <c:if  test="${requestScope.sortBy == 'Product_Name' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Category_ID', 2)"> 
                                        <span>Nhóm hàng</span>
                                        <c:if  test="${requestScope.sortBy == 'Category_ID' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Brand_ID', 3)">
                                        <span>Thương hiệu</span> 
                                        <c:if  test="${requestScope.sortBy == 'Brand_ID' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Unit', 4)">
                                        <span>Đơn vị</span>  
                                        <c:if  test="${requestScope.sortBy == 'Unit' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Cost', 5)">
                                        <span>Giá vốn</span>
                                        <c:if  test="${requestScope.sortBy == 'Cost' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 

                                    </td>
                                    <td class="sort-by" onclick="sortBy('Price', 6)">
                                        <span>Giá bán</span>
                                        <c:if  test="${requestScope.sortBy == 'Price' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Quantity', 7)">
                                        <span>Số lượng</span>
                                        <c:if  test="${requestScope.sortBy == 'Quantity' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 

                                    </td>
                                    <td class="sort-by">
                                        <span>Hành động</span>
                                    </td>
                                </tr>
                            </thead>
                            <tbody id="product-list">
                                <c:set var="products" value="${requestScope.products}"  ></c:set>
                                <c:forEach var="p" begin="0" end="${products.size()}" items="${products}" >
                                    <tr>
                                        <td>${p.productID}</td>
                                        <td>${p.productName}</td>
                                        <td>${p.category.categoryName}</td>
                                        <td>${p.brand.brandName}</td>
                                        <td>${p.unit}</td>
                                        <td>${p.cost}</td>
                                        <td>${p.price}</td>
                                        <td>${p.quantity}</td>
                                        <td>
                                            <button class="action" type="button" onclick="edit(${p.productID}, 'product')"><i class="fa fa-pencil" ></i></button>
                                            <button class="action" type="button" onclick="deleteEntity(${p.productID}, 'product')"><i class ="fa fa-trash" ></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${requestScope.products.size() ==0}" >
                        <p>Không tìm thấy hàng hóa</p>
                    </c:if>
                </div>
                <c:if test="${requestScope.products.size() >= 10 || requestScope.pageIndex >= 2}" >
                    <div class ="bottom" >
                        <div class ="pageSize" >
                            Số bản ghi <select name ="pageSize" id ="pageSize" onchange="setPageSize('pageSize')">
                                <c:set var="pageSizeOptions" value="${requestScope.pageSizeOptions}" ></c:set>  
                                <c:set var="selectedPageSize" value="${requestScope.selectedPageSize}" ></c:set>
                                <c:forEach var="pageSize" begin="0" end="${pageSizeOptions.size()}" items="${pageSizeOptions}" >
                                    <option value ="${pageSize}" 
                                            <c:if test="${selectedPageSize == pageSize}" > 
                                                selected="selected"
                                            </c:if>> ${pageSize}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <span>${requestScope.track}</span>
                        <div class ="pagger" id ="pagger" > 


                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        <div class ="modal" >
            <div class ="product-insert-modal" id ="product-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm hàng hóa</h2>
                    <button class ="btn-close" onclick="closeModal('product-insert-modal')" >x</button>
                </div>
                <form id="product-insert-form" action="insert" method="POST" >
                    <div class ="modal-content" >
                        <table>
                            <tr>
                                <td class="table-title" >Mã hàng</td>
                                <td colspan="2" ><span>Mã hàng tự động</span></td>
                            </tr>
                            <tr>
                                <td class="table-title">Tên hàng</td>
                                <td colspan="2"><input type ="text" name ="productName" class ="product-insert"  /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Nhóm hàng</td>
                                <td>
                                    <input id ="category-insert-id" class ="product-insert" type ="hidden" name="category" >
                                    <span id ="category-insert-name"  onclick="openBox('category-insert-container')" >---Chọn nhóm hàng---</span>
                                </td>
                                <td>
                                    <button type="button" onclick="openModal('category-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Thương hiệu</td>
                                <td>
                                    <input id ="brand-insert-id" class ="product-insert" type ="hidden" name="brand" >
                                    <span  onclick="openBox('brand-insert-container')"  id ="brand-insert-name" >---Chọn thương hiệu---</span>
                                </td>
                                <td>
                                    <button type="button" onclick="openModal('brand-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></button>

                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Giá vốn</td>
                                <td colspan="2"> 
                                    <input onfocus="enableEnterNumber('insert-cost')"  
                                           onkeyup="validateInputNumber(this.value, 'insert-cost')" 
                                           onblur="convertToVND('insert-cost')"
                                           id="insert-cost" type ="number" name ="cost" class ="product-insert" value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Giá bán</td>
                                <td colspan="2">  <input onfocus="enableEnterNumber('insert-price')"  
                                                         onkeyup="validateInputNumber(this.value, 'insert-price')" 
                                                         onblur="convertToVND('insert-price')" id="insert-price" type ="number" name ="price" class ="product-insert" value="0" /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Đơn vị</td>
                                <td colspan="2"><input type ="text" name ="unit" class ="product-insert" /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Tồn kho</td>
                                <td colspan="2"> <input onkeyup="validateInputNumber(this.value, 'insert-quantity')" id="insert-quantity" value="0" type ="number" name ="quantity" class ="product-insert"  /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Mô tả</td>
                                <td colspan="2">   <input type ="text" name ="description" class ="product-insert"  /></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <button type="button" onclick="setSubmitType('0', true, 'product-insert')"  >Đóng</button>
                                    <button type="button" onclick="setSubmitType('0', false, 'product-insert')" >Lưu</button>
                                    <button type="button" onclick="setSubmitType('1', false, 'product-insert')" >Lưu và thêm mới</button>
                                    <input type="hidden" name="submitType" id="submit-type" value="${requestScope.submitType}" />
                                </td>

                            </tr>
                        </table>
                        <div class ="btn-group" 
                             <input type="submit" value ="Save" class ="product-input" />
                        </div>
                        <div id ="category-insert-container" >
                            <input class ="product-insert" type ="text" onkeyup="search(this.value, 'category-insert')" placeholder="Tìm kiếm nhóm hàng" />
                            <div id = "category-insert-list" >
                                <table>
                                    <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                        <tr>
                                            <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-insert')" class ="category-value">${c.categoryName}</span></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>

                        <div id ="brand-insert-container" >
                            <input  class ="product-insert"
                                    type ="text" onkeyup="search(this.value, 'brand-insert')" placeholder="Tìm kiếm thương hiệu"/>
                            <div id = "brand-insert-list" >
                                <table>
                                    <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                        <tr>
                                            <td class="first-td" ><span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand-insert')" class ="brand-value">${b.brandName}</span></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
        <div class ="modal" >
            <div class ="product-edit-modal" id ="product-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Chỉnh sửa thông tin hàng hóa</h2>
                    <button class ="btn-close" onclick="closeModal('product-edit-modal')" >x</button>
                </div>
                <form id="product-edit-form" action="edit" method="POST" >
                    <div class ="modal-content" >
                        <table>
                            <tr>
                                <td class="table-title" >Mã hàng</td>
                                <td colspan="2" >
                                    <span class ="product-edit"></span>
                                    <input type ="hidden" name ="productID" class ="product-edit"  />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Tên hàng</td>
                                <td colspan="2">
                                    <input type ="text" name ="productName" class ="product-edit"  />
                                    <input type ="hidden" class ="check-exist"  />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Nhóm hàng</td>
                                <td>
                                    <input id ="category-edit-id" class ="product-edit" type ="hidden" name="category" >
                                    <input type ="hidden" class ="check-exist"  />
                                    <span id ="category-edit-name"  class ="product-edit" onclick="openBox('category-edit-container')" >---Chọn nhóm hàng---</span>
                                </td>
                                <td>
                                    <button type="button" onclick="openModal('category-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Thương hiệu</td>
                                <td>
                                    <input id ="brand-edit-id" class ="product-edit" type ="hidden" name ="brand"  >
                                    <input type ="hidden" class ="check-exist"  />
                                    <span  onclick="openBox('brand-edit-container')"  class ="product-edit" id ="brand-edit-name" >---Chọn thương hiệu---</span>
                                </td>
                                <td>
                                    <button type="button" onclick="openModal('brand-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></button>

                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Giá vốn</td>
                                <td colspan="2"> 
                                    <input onfocus="enableEnterNumber('edit-cost')"  
                                           onkeyup="validateInputNumber(this.value, 'edit-cost')" 
                                           onblur="convertToVND('edit-cost')"
                                           id="edit-cost" type ="number" name ="cost" class ="product-edit"  />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Giá bán</td>
                                <td colspan="2">  <input onfocus="enableEnterNumber('edit-price')"  
                                                         onkeyup="validateInputNumber(this.value, 'edit-price')" 
                                                         onblur="convertToVND('edit-price')" id="edit-price" type ="number" name ="price"  class ="product-edit" /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Đơn vị</td>
                                <td colspan="2"><input type ="text" name ="unit" class ="product-edit" /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Tồn kho</td>
                                <td colspan="2"> <input onkeyup="validateInputNumber(this.value, 'edit-quantity')"  id="edit-quantity" type ="text" name ="quantity" class ="product-edit"  /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Mô tả</td>
                                <td colspan="2">   <input type ="text" name ="description" class ="product-edit"  /></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <button type="button" onclick="closeModal('product-edit-modal')"  >Đóng</button>
                                    <button type="button" onclick="
                                            checkInputProduct('product-edit');
                                            var status = document.getElementById('status').value;
                                            if (status === 'true') {
                                                submitForm('product-edit-form');
                                            }
                                            " >Lưu</button>
                                </td>
                            </tr>
                        </table>

                        <div id ="category-edit-container" >
                            <input class ="product-edit" type ="text" onkeyup="search(this.value, 'category-edit')" placeholder="Tìm kiếm nhóm hàng" />
                            <div id = "category-edit-list" >
                                <table>
                                    <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                        <tr>
                                            <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-edit')" class ="category-value">${c.categoryName}</span></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>

                        <div id ="brand-edit-container" >
                            <input  class ="product-edit"
                                    type ="text" onkeyup="search(this.value, 'brand-edit')" placeholder="Tìm kiếm thương hiệu"/>
                            <div id = "brand-edit-list" >
                                <table>
                                    <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                        <tr>
                                            <td class="first-td" ><span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand-edit')" class ="brand-value">${b.brandName}</span></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>

        <div class ="modal"  > 
            <div class ="category-insert-modal" id ="category-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm nhóm hàng</h2>
                    <button class ="btn-close" onclick="closeModal('category-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" >  
                    <form action="" >
                        <!--<span>Category Name</span>-->
                        <input type ="text" placeholder="Tên nhóm hàng" name ="categoryName" id ="category-insert-input" class ="category-insert" /> 
                    </form>
                </div>
                <div onclick="checkInputBraCate('category-insert')" class ="btn-save"> <span>Lưu</span></div>
            </div>
        </div>
        <div class ="modal" > 
            <div  class ="brand-insert-modal" id ="brand-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm thương hiệu</h2>
                    <button class ="btn-close" onclick="closeModal('brand-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <input type ="text" placeholder="Tên thương hiệu" name ="brandName" id ="brand-insert-input"  class ="brand-insert" /> 
                </div>
                <div onclick="checkInputBraCate('brand-insert')" class ="btn-save"> <span>Lưu</span></div>
            </div>
        </div>
        <div class ="modal"  > 
            <div class ="category-edit-modal" id ="category-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Sửa nhóm hàng</h2>
                    <button class ="btn-close" onclick="closeModal('category-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >  
                    <form id="category-edit-form" action="../category/edit" method="POST" >
                        <!--<span>Category Name</span>-->
                        <input type ="hidden" name ="categoryID"  class ="category-edit" /> 
                        <input type ="hidden" id ="current-category" /> 
                        <input type ="text" placeholder="Tên nhóm hàng" name ="categoryName" id ="category-edit-input" class ="category-edit" /> 
                        <!--<button>Lưu</button>-->
                        <button class="btn-save" type="button" onclick="checkInputBraCate('category-edit')" >Lưu</button>
                    </form>

                </div>
            </div>
        </div>
        <div class ="modal" > 
            <div  class ="brand-edit-modal" id ="brand-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Sửa thương hiệu</h2>
                    <button class ="btn-close" onclick="closeModal('brand-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <form id="brand-edit-form" action="../brand/edit" method="POST" >
                        <!--<span>Brand Name</span>-->
                        <input type ="hidden"  name ="brandID" class ="brand-edit" /> 
                        <input type ="hidden" id ="current-brand" /> 
                        <input type ="text" placeholder="Tên thương hiệu" name ="brandName"  class ="brand-edit" id ="brand-edit-input" /> 
                        <button class="btn-save" type="button" onclick="checkInputBraCate('brand-edit')" >Lưu</button>
                    </form>

                </div>
            </div>
        </div>
        <div class ="modal" style="background: rgba(0, 0, 0, 0)">
            <div class ="delete-confirm-modal" id ="delete-confirm-modal" >
                <div class ="modal-content" >
                    <p id="message-title"></p>
                    <div class="btn-group" >
                        <button type="button" onclick="closeModal('delete-confirm-modal')" >Đóng</button>
                        <button id="button-delete" type="button"  >Tiếp tục</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="warning" id="warning" onclick="fadeOutMessage()" >

        </div>
        <div>
            <input type="hidden" id="status" />
        </div>
        <script>
            <c:if test="${(requestScope.products.size() >= 10 
                          || requestScope.pageIndex >= 2) 
                          && requestScope.totalPage > 1}" >
            pagger('pagger',${requestScope.pageIndex},
                  ${requestScope.selectedPageSize},
                  ${requestScope.totalPage}, 2);
            </c:if>

            <c:if test="${requestScope.submitType.equals('1')}">
            openModal('product-insert-modal');
            </c:if>

            var productList = document.getElementById('product-list');
            var trs = productList.children;
            for (var i = 0, max = trs.length; i < max; i++) {
                tds = trs[i].children;
                tds[0].innerHTML = formatProductId(tds[0].innerHTML);
            }



            function sortBy(by, position) {
                var groupTitle = document.getElementsByClassName("sort-by");
                var title = groupTitle[position].children;
                var sortByTitle = document.getElementById("sort-by");
                var sortType = document.getElementById("sort-type");
                if (title.length > 1) {
                    var icon = title[1];
//                alert(icon.className);
                    if (icon.className === "fa fa-arrow-up") {
                        sortType.value = "2";
                    }
                    if (icon.className === "fa fa-arrow-down") {
                        sortType.value = "1";
                    }
                    sortByTitle.value = by;
                } else {
                    sortByTitle.value = by;
                    sortType.value = "1";
                }
                submitForm("search-form");
            }

            function generateWarning(message) {
                var warningBox = document.getElementById("warning");
                var number = warningBox.length;

                var messageBox = "<div onclick=\"fadeOutSpecificMessage('message" + number + "')\" id=\"message" + number + "\" >" + message + "</div>"

                warningBox.innerHTML += messageBox;

                var box = document.getElementById("message" + number);
                box.style.animationName = "fadeIn";
            }

            function fadeOutSpecificMessage(id) {
                var mesage = document.getElementById(id);
                mesage.style.animationName = "fadeOut";
            }

            function fadeOutMessage() {
                var warningBox = document.getElementById("warning");
                var messageBox = warningBox.children;
                for (var i = messageBox.length - 1, max = 0; i >= max; i--) {
                    warningBox.removeChild(messageBox[i]);
                }

            }


            function checkInputBraCate(id) {
                var type = id.split("-")[0];
                var action = id.split("-")[1];
                var url = "";
                var title = "";
                if (type === 'category') {
                    var category = document.getElementById(type + "-" + action + "-input");
                    var currentCategory = document.getElementById('current-category');
                    url += "../category/check/input?categoryName=" + category.value;
                    url += "&currentCategoryName=" + currentCategory.value;
                    title = "Nhóm hàng";
//                    alert(url);
                }

                if (type === 'brand') {
                    var brand = document.getElementById(type + "-" + action + "-input");
                    var currentBrand = document.getElementById('current-brand');
                    url += "../brand/check/input?brandName=" + brand.value;
                    url += "&currentBrandName=" + currentBrand.value;
                    title = "Thương hiệu";
                }

                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    if (result === "false") {
                        generateWarning(title + " đã tồn tại");
                    } else {
                        if (id === 'category-edit' || id === 'brand-edit') {
                            submitForm(id + "-form");
                        } else {
                            insert(id);
                        }
                    }
//                    alert(result);
                });
            }

            function setSubmitType(newType, close, inputType) {
                var submitType = document.getElementById('submit-type');
                var currentType = submitType.value;
                if (currentType === "1" && newType === "0") {
                    var url = "../set/session?submitType=0";
                    fetch(url);
                }

                if (newType === "0" && close) {
                    closeModal(inputType + '-modal');
                } else {
                    checkInputProduct(inputType);
                    var status = document.getElementById('status').value;
                    if (status === "true") {
                        submitType.value = newType;
                        submitForm(inputType + '-form');
                    }
                }
            }



            function checkInputProduct(id) {
                var input = document.getElementsByClassName(id);
//                alert(input[0]);
                var url = "";
                if (id == "product-insert") {
                    if (input[0].value == "") {
                        generateWarning("Chưa nhập tên hàng");
                        return;
                    }
                    if (input[1].value == "") {
                        generateWarning("Chưa chọn nhóm hàng");
                        return;
                    }
                    if (input[2].value == "") {
                        generateWarning("Chưa chọn thương hiệu");
                        return;
                    }
                    url += "check/input?productName=" + input[0].value;
                    url += "&categoryID=" + input[1].value;
                    url += "&brandID=" + input[2].value;
                } else {
                    var checkExist = document.getElementsByClassName('check-exist');
                    var currentProductName = checkExist[0].value;
                    var currentCategory = checkExist[1].value;
                    var currentBrand = checkExist[2].value;

                    if (input[2].value == "") {
                        generateWarning("Chưa nhập tên hàng hóa");
                        return;
                    }
                    if (input[3].value == "") {
                        generateWarning("Chưa chọn nhóm hàng");
                        return;
                    }
                    if (input[5].value == "") {
                        generateWarning("Chưa chọn thương hiệu");
                        return;
                    }
                    url += "check/input?productName=" + input[2].value;
                    url += "&categoryID=" + input[3].value;
                    url += "&brandID=" + input[5].value;
                    url += "&currentProductName=" + currentProductName;
                    url += "&currentCategoryID=" + currentCategory;
                    url += "&currentBrandID=" + currentBrand;

                }

                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var status = document.getElementById('status');
                    if (result === "false") {
                        generateWarning("Sản phẩm đã tồn tại");
                        status.value = false;
                    } else {
                        status.value = true;
                    }
                });
            }



            function openModal(id) {
                var box = document.getElementById(id);
                var modal = document.getElementsByClassName('modal');
                if (id === 'product-insert-modal') {
                    modal[0].style.transform = "scale(1)";
                } else if (id === 'product-edit-modal') {
                    modal[1].style.transform = "scale(1)";
                } else if (id === 'category-insert-modal') {
                    modal[2].style.transform = "scale(1)";
                } else if (id === 'brand-insert-modal') {
                    modal[3].style.transform = "scale(1)";
                } else if (id === 'category-edit-modal') {
                    modal[4].style.transform = "scale(1)";
                } else if (id === 'brand-edit-modal') {
                    modal[5].style.transform = "scale(1)";
                } else if (id === 'delete-confirm-modal') {
                    modal[6].style.transform = "scale(1)";
                }
                box.style.transform = "scale(1)";


                if (id.split("-")[0] === 'product') {
                    insertType = id.split("-")[0];
                }
            }

            function closeModal(id) {
                var box = document.getElementById(id);
                var modal = document.getElementsByClassName('modal');
                if (id === 'product-insert-modal') {
                    modal[0].style.transform = "scale(0)";
                } else if (id === 'product-edit-modal') {
                    modal[1].style.transform = "scale(0)";
                } else if (id === 'category-insert-modal') {
                    modal[2].style.transform = "scale(0)";
                } else if (id === 'brand-insert-modal') {
                    modal[3].style.transform = "scale(0)";
                } else if (id === 'category-edit-modal') {
                    modal[4].style.transform = "scale(0)";
                } else if (id === 'brand-edit-modal') {
                    modal[5].style.transform = "scale(0)";
                } else if (id === 'delete-confirm-modal') {
                    modal[6].style.transform = "scale(0)";
                }

                box.style.transform = "scale(0)";

                var input = id.split('-modal')[0];
                if (id !== 'product-edit-modal') {
                    clearInputData(input);
                }

                if (id.split("-")[0] === 'product') {
                    insertType = "";
                }


            }

            function clearInputData(id) {
                //            alert(id);
                var input = document.getElementsByClassName(id);
                for (var i = 0; i < input.length; i++) {
                    input[i].value = "";
                }
            }

            function search(value, type) {
                var entity = type.split('-')[0];
                var url = "../" + entity + "/search?keyword=" + value;
                url += "&boxType=";
                if (type === entity) {
                    url += entity;
                } else {
                    url += type;
                }
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var box = document.getElementById(type + '-list');
                    box.innerHTML = result;
                });
            }

            function enableEnterNumber(id) {
                var inp = document.getElementById(id);
                inp.type = "number";
            }

            function convertToVND(id) {
                var inp = document.getElementById(id);
                inp.type = "text";
                var x = parseInt(inp.value);
                x = x.toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                inp.value = x;
            }

            function validateInputNumber(inValue, id) {
                var inp = document.getElementById(id);
                if (inValue === "" || inValue == null) {
                    inp.value = "0";
                }

                if (inValue.length > 1 && inValue.charAt(0) == '0') {
                    inp.value = inValue.replace('0', '');
                }

            }

            function searchProduct() {
                var category = document.getElementById('category-id');
                var brand = document.getElementById('brand-id');
                var categorySearch = document.getElementById('category-search');
                var brandSearch = document.getElementById('brand-search');
                categorySearch.value = category.value;
                brandSearch.value = brand.value;
                var form = document.getElementById('search-form');
                form.submit();
            }

            var insertType = "";

            // insert category or brand
            function insert(type) {
                var boxType = "";
                var inputType = type + "-input";
                var inputBar = document.getElementById(inputType);
                var input = inputBar.value;

                var modal = document.getElementsByClassName("modal");
                type = type.split('-')[0];
                if (modal[0].style.transform == "scale(1)") {
                    boxType = type + "-insert";
                } else if (modal[1].style.transform == "scale(1)") {
                    boxType = type + "-edit";
                } else {
                    boxType = type;
                }


                if (input === "") {
                    return;
                }
                var url = "../" + type + "/insert?" + type + "Name=" + input;
                url += "&boxType=" + boxType;

                fetch(url)
                        .then(function (response) {
                            return response.text();
                        })
                        .then(function (result) {
                            document.getElementById(type + '-list').innerHTML = result;
                            geCatBraValue(type);
                        });


                var id = type + "-insert-modal";
                closeModal(id);
            }

            function geCatBraValue(type) {
                var url1 = "../" + type + "/get?boxType=" + type + "-edit";
                fetch(url1)
                        .then(function (response) {
                            return response.text();
                        })
                        .then(function (result) {
                            document.getElementById(type + '-edit-list').innerHTML = result;
                        });
                var url2 = "../" + type + "/get?boxType=" + type + "-insert";
                fetch(url2)
                        .then(function (response) {
                            return response.text();
                        })
                        .then(function (result) {
                            document.getElementById(type + '-insert-list').innerHTML = result;
                        });
            }


            // edit product
            function edit(id, type) {
                //            alert(id);
                var url;
                if (type === 'product') {
                    url = "edit?id=" + id;
                }
                if (type === 'category') {
                    url = "../category/edit?id=" + id;
                }
                if (type === 'brand') {
                    url = "../brand/edit?id=" + id;
                }
                var edit = document.getElementsByClassName(type + "-edit");
                var checkExist = document.getElementsByClassName('check-exist');
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var arr = result.split('|');
                    if (type === 'product') {
                        edit[0].innerHTML = formatProductId(arr[0]);
                        edit[1].value = arr[1];
                        edit[2].value = arr[2];
                        edit[3].value = arr[3];
                        edit[4].innerHTML = arr[4];
                        edit[5].value = arr[5];
                        edit[6].innerHTML = arr[6];
                        edit[7].value = arr[7];
                        edit[8].value = arr[8];
                        edit[9].value = arr[9];
                        edit[10].value = arr[10];
                        edit[11].value = arr[11];

                        checkExist[0].value = arr[2];
                        checkExist[1].value = arr[3];
                        checkExist[2].value = arr[5];
                    } else {
                        edit[0].value = arr[0];
                        for (var i = 1, max = arr.length; i < max; i++) {
                            edit[i].value = arr[i];
                        }

                        if (type === 'brand') {
                            var currentBrand = document.getElementById('current-brand');
                            currentBrand.value = arr[1];
                        }
                        if (type === 'category') {
                            var currentCategory = document.getElementById('current-category');
                            currentCategory.value = arr[1];
                        }
                    }

                });
                openModal(type + '-edit-modal');
            }

            function formatProductId(id) {

                var len = (id + "").length;
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

            function deleteEntity(id, type) {
                var messageTitle = document.getElementById('message-title');
                var buttonDelete = document.getElementById('button-delete');
                var url;
                if (type === 'product') {
                    messageTitle.innerHTML = "Tất cả thông tin liên quan đến mặt hàng sẽ bị xóa, bạn có muốn tiếp tục?";
                    url = "delete?id=" + id;
                }
                if (type === 'category') {
                    messageTitle.innerHTML = "Tất cả thông tin liên quan đến nhóm hàng sẽ bị xóa, bạn có muốn tiếp tục?";
                    url = "../category/delete?id=" + id;
                }
                if (type === 'brand') {
                    messageTitle.innerHTML = "Tất cả thông tin liên quan đến thương hiệu sẽ bị xóa, bạn có muốn tiếp tục?";
                    url = "../brand/delete?id=" + id;
                }
                buttonDelete.onclick = function () {
                    window.location.href = url;
                };
                openModal("delete-confirm-modal");
            }

//            function commitedDelete(url) {
//                window.location.href = url;
//            }
            function setSearchKey(searchKey, searchBar) {
//                alert(value);
                var key = document.getElementById(searchKey);
                var search = document.getElementById(searchBar);
                key.value = search.value;
                submitForm("search-form");
            }



            function openBox(id) {
//                alert(id);
                var box = document.getElementById(id);
                if (box.style.display === 'block') {
                    box.style.display = "none";
                } else {
                    box.style.display = "block";
//                    alert(box.style.display);
                }
            }
            function closeBox(id) {
                var box = document.getElementById(id);
                box.style.display = 'none';
            }

            function setValue(idValue, nameValue, id) {
                var inputId = document.getElementById(id + '-id');
                var inputName = document.getElementById(id + '-name');
                inputId.value = idValue;
                inputName.innerHTML = nameValue;

                if (id === 'brand' || id === 'category') {
                    searchProduct();
                }
                closeBox(id + "-container");
            }


        </script>
    </body>
</html>
