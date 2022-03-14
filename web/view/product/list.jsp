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
            border-radius: 10px;
            background: #FDFDFE;
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 10;
        }

        /*        .modal{
                    z-index: 99;
                }*/

        .modal .product-insert-modal,
        .modal .product-edit-modal
        {
            top: 10.5vh;
            left: 38.5vh;
            width: 70vw;
            height: 65vh;

        }

        .modal .product-unit-insert-modal,
        .modal .product-edit-insert-modal {
            top: 20vh;
            left: 65vh;
            width: 40vw;
            height: 50vh;
        }

        .modal .category-insert-modal,
        .modal .brand-edit-modal,
        .modal .category-edit-modal,
        .modal .brand-insert-modal,
        .modal .unit-insert-modal,
        .modal .unit-edit-modal 
        {
            top: 23vh;
            left: 90vh;
            width: 17vw;
            height: 25vh;

        }

        .modal .brand-insert-modal .modal-content,
        .modal .category-insert-modal .modal-content,
        .modal .brand-edit-modal .modal-content,
        .modal .category-edit-modal .modal-content,
        .modal .unit-insert-modal .modal-content ,
        .modal .unit-edit-modal .modal-content {
            margin-top: 15px;
        }

        .modal .product-insert-modal .modal-content ,
        .modal .product-edit-modal .modal-content  {
            margin-top: 25px;
            /*border: 1px solid #000;*/
        }
        .modal .product-insert-modal .modal-content .row,
        .modal .product-edit-modal .modal-content .row {
            display: block;
            margin-bottom: 25px;
            /*border: 1px solid #000;*/
        }

        .modal .product-insert-modal .modal-content .row .column,
        .modal .product-edit-modal .modal-content .row .column {
            display: inline-block;
            margin-right: 100px;
        }

        .modal .product-insert-modal .modal-content .row .column:nth-of-type(3),
        .modal .product-insert-modal .modal-content .row .column:nth-of-type(6),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(3),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(6) {
            margin-right: 0px;
        }
        .modal .product-insert-modal .modal-content .row .column:nth-of-type(2),
        .modal .product-insert-modal .modal-content .row .column:nth-of-type(5),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(2),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(5)
        {
            margin-right: 90px;

        }

        .modal .product-insert-modal .modal-content .row .column input,
        .modal .product-edit-modal .modal-content .row .column input
        {
            width: 250px;
            height: 35px;
            margin-top: 5px;
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

        .modal .product-insert-modal .modal-content .row .column .btn-add,
        .modal .product-edit-modal .modal-content .row .column .btn-add
        {
            cursor: pointer;
            color: blue;
            font-weight: bold;
            padding: 5px;
        }

        .modal .product-insert-modal .modal-content .row .column .btn-add:hover,
        .modal .product-edit-modal .modal-content .row .column .btn-add:hover
        {
            color: #fff;
            background: #ccc;
            border-radius: 5px;
        }


        .modal .product-insert-modal .modal-content .row .column .category-container,
        .modal .product-insert-modal .modal-content .row .column .brand-container,
        .modal .product-edit-modal .modal-content .row .column .category-container,
        .modal .product-edit-modal .modal-content .row .column .brand-container {
            position: relative;
            display: inline-block;
            /*border: 1px solid #000;*/
            box-sizing: border-box;
            border-collapse: collapse;
            margin-top: 5px;

        }
        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-name,
        .modal .product-insert-modal .modal-content .row .column .brand-container #brand-insert-name,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-name,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-name
        {
            display: inline-block;
            width: 250px;
            height: 38px;
            padding: 8px;
            border: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
        }



        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-search-box,
        .modal .product-insert-modal .modal-content .row .column .brand-container #brand-insert-search-box,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-search-box,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-search-box
        {
            position: absolute;
            top: 0px;
            left: 0px;
            height: 220px;
            width: 250px;
            background: #fff;
            /*border: 1px solid #000;*/
            box-shadow: 0px 0px 2px 2px #ccc;
            box-sizing: border-box;   
            display: none;
        }


        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-search-box input,
        .modal .product-insert-modal .modal-content .row .column .brand-container #brand-insert-search-box input,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-search-box input,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-search-box input{
            width: 230px;
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



        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-search-box #category-insert-box,
        .modal .product-insert-modal .modal-content .row .column .brand-container #brand-insert-search-box #brand-insert-box,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-search-box #category-edit-box,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-search-box #brand-edit-box {
            overflow: auto;
            height: 165px;
            width: 250px;
        }



        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-search-box,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-search-box
        {
            z-index: 3;
        }


        .modal .product-insert-modal .modal-content .row .column .brand-container #brand-insert-search-box,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-search-box {
            z-index: 2;
        }

        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-search-box #category-insert-box span,
        .modal .product-insert-modal .modal-content .row .column .brand-container #brand-insert-search-box  #brand-insert-box span,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-search-box #category-edit-box span,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-search-box #brand-edit-box span
        {
            cursor: pointer;
            display: inline-block;
            width: 245px;
            height: 20px;
            padding: 5px;
            margin: 0px;
        }

        .modal .product-insert-modal .modal-content .row .column .category-container #category-insert-search-box #category-insert-box span:hover,
        .modal .product-insert-modal .modal-content .row .column .brand-container  #brand-insert-search-box  #brand-insert-box  span:hover,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-search-box #category-edit-box span:hover,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-search-box #brand-edit-box  span:hover

        {
            background: #FFCD1F;
            color: #000;
        }

        span.product-edit {
            display: inline-block;
            width: 254px;
            height: 37px;
            padding: 5px;
            margin-top: 5px;
            border: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;

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

        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-box,
        .container .main-content .top .group-search .category .category-container #category-search-box #category-box {
            overflow: auto;
            height: 165px;
            width: 255px;

        }
        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-box{
            width: 260px;
        }

        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-box span,
        .container .main-content .top .group-search .category .category-container #category-search-box #category-box span {
            cursor: pointer;
            display: inline-block;
            width: 245px;
            height: 20px;
            padding: 5px;
            margin: 0px;
        }

        .container .main-content .top .group-search .brand .brand-container #brand-search-box #brand-box span:hover,
        .container .main-content .top .group-search .category .category-container #category-search-box #category-box span:hover {
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
        .modal .product-insert-modal .modal-content .row  .column .radio-button input , 
        .modal .product-edit-modal .modal-content .row .column .radio-button input  {
            width: 30px;
            height: 15px;
        }


        .modal .product-insert-modal .modal-content .row  .column  textarea, 
        .modal .product-edit-modal .modal-content .row  .column  textarea {
            overflow: scroll;
            resize: none;
            margin-top: 5px;
            margin-bottom: 35px;
            border: 1px solid #000;
        }

        .modal .product-insert-modal .modal-content .row:nth-of-type(4) button {
            width: 1000px;
            height: 30px;
            display: block;
            text-align: center;
        }

        .container .bottom span {
            position: absolute;
            left: 35vw;
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
                                        <div id="category-box" >
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
                                        <div id = "brand-box" >
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
                                    <td>Mã hàng</td>
                                    <td>Mã vạch</td>
                                    <td>Tên hàng hóa</td>
                                    <td>Nhóm hàng</td>
                                    <td>Thương hiệu</td>
                                    <td>Đơn vị</td>
                                    <td>Giá vốn</td>
                                    <td>Giá bán</td>
                                    <td>Số lượng</td>
                                    <td>Hành động</td>
                                </tr>
                            </thead>
                            <tbody id="product-list">
                                <c:set var="products" value="${requestScope.products}"  ></c:set>
                                <c:forEach var="p" begin="0" end="${products.size()}" items="${products}" >
                                    <tr>
                                        <!--<td><input type ="checkbox" /></td>-->
                                        <td>${p.productID}</td>
                                        <td>${p.barcode}</td>
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
                <form action="insert" method="POST" >
                    <div class ="modal-content" >
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Mã hàng</span> <br/>
                                <input type ="text" name ="productID" class ="product-insert"  />
                            </div>
                            <div class ="column"  > 
                                <span>Nhóm hàng</span> <br/>
                                <div class ="category-container" >
                                    <span id ="category-insert-name"  onclick="openBox('category-insert-search-box')" >---Chọn nhóm hàng---</span>
                                    <input id ="category-insert-id" class ="product-insert" type ="hidden" name ="category" >
                                    <div id="category-insert-search-box">
                                        <input class ="product-insert" type ="text" onkeyup="search(this.value, 'category-insert')" placeholder="Tìm kiếm nhóm hàng" />
                                        <div id = "category-insert-box" >
                                            <table>
                                                <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-insert')" class ="category-value">${c.categoryName}</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <span onclick="openModal('category-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></span>
                            </div>
                            <div class ="column" > 
                                <span>Số lượng</span> <br/>
                                <input type ="text" name ="quantity" class ="product-insert"  />
                            </div>

                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Mã vạch</span> <br/>
                                <input type ="text" name ="barcode" class ="product-insert"  />
                            </div>
                            <div class ="column" > 
                                <span>Thương hiệu</span> <br/>
                                <div class ="brand-container" >
                                    <span  onclick="openBox('brand-insert-search-box')"  id ="brand-insert-name" >---Chọn thương hiệu---</span>
                                    <input id ="brand-insert-id" class ="product-insert" type ="hidden" name ="brand"  >
                                    <div id="brand-insert-search-box">
                                        <input  class ="product-insert"
                                                type ="text" onkeyup="search(this.value, 'brand-insert')" placeholder="Tìm kiếm thương hiệu"/>
                                        <div id = "brand-insert-box" >
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
                                <span onclick="openModal('brand-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></span>
                            </div> 
                            <div class ="column" > 
                                <span>Giá vốn</span> <br/>
                                <input type ="text" name ="cost" class ="product-insert"  />
                            </div>
                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Tên hàng hóa</span> <br/>
                                <input type ="text" name ="productName" class ="product-insert"  />
                            </div>
                            <div class ="column"> 
                                <span>Đơn vị</span> <br/>
                                <input type ="text" name ="unit" class ="product-insert" />
                            </div>
                            <div class ="column"> 
                                <span>Giá bán</span> <br/>
                                <input type ="text" name ="price" class ="product-insert" />
                            </div>

                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Mô tả</span> <br/>
                                <input type ="text" name ="description" class ="product-insert"  />
                            </div>

                            <input type="checkbox" value="1" name="status" />
                            <label>Bán trực tiếp</label>
                        </div>
                        <div class ="btn-group" >
                            <input type="submit" value ="Save" class ="product-input" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class ="modal" >
            <div class ="product-edit-modal" id ="product-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Sửa hàng hóa</h2>
                    <button class ="btn-close" onclick="closeModal('product-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form action ="edit" method ="POST" >
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Mã hàng hóa</span> <br/>
                                <span class ="product-edit"></span>
                                <input type ="hidden" name ="productID" class ="product-edit" />
                            </div>
                            <div class ="column"  > 
                                <span>Nhóm hàng</span> <br/>
                                <div class ="category-container" >
                                    <span id ="category-edit-name" onclick="openBox('category-edit-search-box')" >---Chọn nhóm hàng---</span>
                                    <input id ="category-edit-id" class ="product-edit" type ="hidden" name ="category" >
                                    <div id="category-edit-search-box">
                                        <input type ="text" onkeyup="search(this.value, 'category-edit')" placeholder="Tìm kiếm nhóm hàng" />
                                        <div id = "category-edit-box" >
                                            <table>
                                                <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-edit')" class ="category-value">${c.categoryName}</span></td>
                                                        <td><button class="action" type="button" onclick="edit(${c.categoryID}, 'category')" ><i class="fa fa-pencil" ></i></button></td>
                                                        <td><button class="action" type ="button" onclick="deleteEntity(${c.categoryID}, 'category')"><i class ="fa fa-trash" ></i> </button></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <span onclick="openModal('category-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></span>
                            </div>
                            <div class ="column" > 
                                <span>Giá nhập</span> <br/>
                                <input type ="text" name ="cost" class ="product-edit"/>
                            </div>
                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Tên hàng hóa</span> <br/>
                                <input type ="text" name ="productName" class ="product-edit"  />
                            </div>
                            <div class ="column" > 
                                <span>Thương hiệu</span> <br/>
                                <div class ="brand-container" >
                                    <span id ="brand-edit-name" onclick="openBox('brand-edit-search-box')" >---Chọn thương hiệu---</span>
                                    <input id ="brand-edit-id" type ="hidden" name ="brandID" class ="product-edit" >
                                    <div id="brand-edit-search-box" >
                                        <input type ="text" onkeyup="search(this.value, 'brand-edit')" placeholder="Tìm kiếm thương hiệu" />
                                        <div id = "brand-edit-box" >
                                            <table>
                                                <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                                    <tr>
                                                        <td class="first-td" ><span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand-edit')" class ="brand-value">${b.brandName}</span></td>
                                                        <td><button class="action" type="button"  onclick="edit(${b.brandID}, 'brand')" ><i class="fa fa-pencil" ></i></button></td>
                                                        <td><button class="action" type="button"  onclick="deleteEntity(${b.brandID}, 'brand')"><i class ="fa fa-trash" ></i></button></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <span onclick="openModal('brand-insert-modal')" class ="btn-add" ><i class="fa fa-plus" ></i></span>
                            </div>
                            <div class ="column"> 
                                <span>Giá bán</span> <br/>
                                <input type ="text" name ="price" class ="product-edit"  />
                            </div>
                        </div>
                        <div class ="btn-group" >
                            <input type="submit" value ="Save" />
                        </div>
                    </form>
                </div>
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
                <div onclick="insert('category-insert')" class ="btn-save"> <span>Save</span></div>
            </div>
        </div>
        <div class ="modal" > 
            <div class ="brand-insert-modal" id ="brand-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm thương hiệu</h2>
                    <button class ="btn-close" onclick="closeModal('brand-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <form action="" >
                        <!--<span>Brand Name</span>-->
                        <input type ="text" placeholder="Tên thương hiệu" name ="brandName" id ="brand-insert-input"  class ="brand-insert" /> 
                    </form>
                </div>
                <div onclick="insert('brand-insert')" class ="btn-save"> <span>Save</span></div>
            </div>
        </div>
        <div class ="modal"  > 
            <div class ="category-edit-modal" id ="category-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Sửa nhóm hàng</h2>
                    <button class ="btn-close" onclick="closeModal('category-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >  
                    <form action="../category/edit" method="POST" >
                        <!--<span>Category Name</span>-->
                        <input type ="hidden" name ="categoryID"  class ="category-edit" /> 
                        <input type ="text" placeholder="Tên nhóm hàng" name ="categoryName" class ="category-edit" /> 
                        <button>Save</button>
                    </form>
                </div>
            </div>
        </div>
        <div class ="modal" > 
            <div class ="brand-edit-modal" id ="brand-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Sửa thương hiệu</h2>
                    <button class ="btn-close" onclick="closeModal('brand-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <form action="../brand/edit" method="POST" >
                        <!--<span>Brand Name</span>-->
                        <input type ="hidden"  name ="brandID" class ="brand-edit" /> 
                        <input type ="text" placeholder="Tên thương hiệu" name ="brandName"  class ="brand-edit" /> 
                        <button>Save</button>
                    </form>
                </div>
            </div>
        </div>
        <script>
            <c:if test="${requestScope.products.size() >= 10 || requestScope.pageIndex >= 2}" >
            pagger('pagger',${requestScope.pageIndex},
                ${requestScope.selectedPageSize},
                ${requestScope.totalPage}, 2);
            </c:if>

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
                if (type === (entity + "-insert")) {
                    url += entity + "-insert";
                } else {
                    url += entity;
                }
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var box = document.getElementById(type + '-box');
                    if (result === "") {
                        box.innerHTML = "There are no records to display!"
                        return;
                    }
                    box.innerHTML = result;
                });
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
                alert(insertType);
                var inputType = type + "-input";
                var inputBar = document.getElementById(inputType);
                var input = inputBar.value;
                //            inputBar.value = "";
                type = type.split('-')[0];
                if (input === "") {
                    return;
                }
                var url = "../" + type + "/insert?" + type + "Name=" + input;
                url += "&boxType=";
                if (insertType === ("product")) {
                    url += type + "-insert";
                } else {
                    url += type;
                }
                alert(url);
                fetch(url)
                        .then(function (response) {
                            return response.text();
                        })
                        .then(function (result) {

                            document.getElementById(type + '-box').innerHTML = result;
                            document.getElementById(type + '-insert-box').innerHTML = result;
                            document.getElementById(type + '-edit-box').innerHTML = result;
                            document.getElementById(type + '-box').innerHTML = result;
                        });


                var id = type + "-insert-modal";
                closeModal(id);
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
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var arr = result.split('|');
                    if (type === 'product') {
                        edit[0].innerHTML = arr[0];
                    } else {
                        edit[0].value = arr[0];
                    }
                    for (var i = 1, max = arr.length; i < max; i++) {
                        edit[i].value = arr[i];
                        //                    alert(arr[i]);
                    }
                });
                openModal(type + '-edit-modal');
            }

            function deleteEntity(id, type) {
                var anwser = confirm("Do you want to delete " + type + " with id =" + id);
                var url;
                if (anwser) {
                    if (type === 'product') {
                        url = "delete?id=" + id;
                    }
                    if (type === 'category') {
                        url = "../category/delete?id=" + id;
                    }
                    if (type === 'brand') {
                        url = "../brand/delete?id=" + id;
                    }

                    window.location.href = url;
                }
            }
            function setSearchKey(searchKey, searchBar) {
//                alert(value);
                var key = document.getElementById(searchKey);
                var search = document.getElementById(searchBar);
                key.value = search.value;
                submitForm("search-form");
            }



            function openBox(id) {
                var box = document.getElementById(id);
                if (box.style.display == 'block') {
                    box.style.display = "none";
                } else {
                    box.style.display = "block";
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
                closeBox(id + "-search-box");
            }


        </script>
    </body>
</html>
