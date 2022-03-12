<%@page import="java.util.ArrayList"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">      
        <title>Product</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="../js/code.js" type="text/javascript"></script>
    </head>
    <style>
        *, body{
            margin:0;
            padding:0;
            max-width: 100vw;
        }

        body {
            background: #FFFFFF;
        }

        .header {
            border-bottom: 1px solid black;
        }

        .header .title {
            padding: 20px 0 20px 100px; 
            font-size: 30px;
            font-weight: 400;
        }

        .container {
            margin-left: 90px;
            padding: 0px 15px 15px 15px;
        }

        .container .top .horizontal-search,
        .container .top .btn-add {
            display: inline-block;
        }

        .container .top .btn-add button {
            height: 40px;
            width: 150px;
            border-radius: 10px;
            background: #fff;
            color: #3D3D3D;
        }

        .container .top .btn-add button:hover {
            background: #000;
            color: #fff;
        }

        .container .top .btn-add {
            position: absolute;
            right: 0;
        }

        .container .top .horizontal-search form  {
            position: relative;
        }

        .container .header .title {
            padding-top: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid black;
        }


        .container .top .horizontal-search input {
            display: block;
            width: 300px; 
            font-size: 15px;
            color: #000;
            padding: 10px ;
            padding-left: 50px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-sizing: border-box;
        }

        .container .top .horizontal-search form button {
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 50px;
            background: transparent;
            border: transparent;
            font-size: 15px;
            color: #6D6D6D;
            cursor: pointer;
            outline: 0;
        }

        .container .top .group-search {
            position: relative;
            margin: 15px 15px 15px 15px;
        }

        .container .top .container .bottom {
            margin: 15px 15px 15px 0;
        }

        .container .top .group-search .category, 
        .container .top .group-search .brand{
            display: inline-block;
            margin-right:10px; 
        }

        .container .top .group-search .category form select,  
        .container .top .group-search .brand form select {
            width: 80px;
            height: 30px;
            border-radius: 10px;
        }

        .container .main-content .middle {
            height: 66vh;
            width: 92vw;
            overflow: auto;
        }
        .container .main-content .middle table {
            width: 1500px;
            display: block;
            border-collapse: collapse;
            outline: none;
            font-weight: normal;
            font-size: 17px;
            table-layout: fixed;
        }

        .container .middle table thead th, 
        .container .middle table tbody td {
            padding: 15px 15px 15px 15px;
            border-top: 1px solid #ccc;
            text-align: left;
        }
        .container .middle table thead th:nth-of-type(1) {
            width: 30px;
        }
        .container .middle table thead th:nth-of-type(2), 
        .container .middle table thead th:nth-of-type(3),
        .container .middle table thead th:nth-of-type(4),
        .container .middle table thead th:nth-of-type(5){
            width: 180px;
        }
        .container .middle table thead th:nth-of-type(6), 
        .container .middle table thead th:nth-of-type(7),
        .container .middle table thead th:nth-of-type(8),
        .container .middle table thead th:nth-of-type(9){
            width: 100px;
        }


        .container .bottom {
            position: relative;
            top: 15px;
        }

        .container .bottom .pageSize, 
        .container .bottom .pagger {
            display: inline-block;
            position: absolute;
        }

        .container .bottom  span {
            position: absolute;
            left: 50vw;
        }

        .container .bottom .pagger {
            right: 10vw;
        }

        .selected-page {
            font-weight: bold;
            background: #ccc;
        }

        .container .bottom .pagger a {
            text-decoration: none;
            padding: 5px;
            border: 1px solid grey;
            margin-right: 5px;
            cursor: pointer;
        }
        .container .bottom .pagger a:hover {
            background: #ccc;
        }

        .modal {
            position: fixed;
            left: 0;
            top: 0;
            display: block;
            background: rgba(0, 0, 0, 0.3);
            height: 100%;
            width: 100%;
            transform: scale(0);
            transition-duration: 0s;
            z-index: 2;
        }



        .modal .invoice-insert-modal, 
        .modal .category-insert-modal,
        .modal .brand-insert-modal,
        .modal .category-edit-modal,
        .modal .brand-edit-modal,
        .modal .product-edit-modal {
            position: absolute;
            padding: 15px 35px 15px 35px;
            border-radius: 10px;
            background: #FDFDFE;
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 3;
        }



        .modal .invoice-insert-modal,
        .modal .product-edit-modal
        {
            top: 10vh;
            left: 30vh;
            width: 65vw;
            height: 65vh;
        }

        .modal .category-insert-modal,
        .modal .brand-edit-modal,
        .modal .category-edit-modal,
        .modal .brand-insert-modal
        {
            top: 23vh;
            left: 81vh;
            width: 17vw;
            height: 25vh;
        }


        .modal .modal-header {
            position: relative;
        }

        .modal .modal-header .title, 
        .modal .modal-header .btn-close {
            display: inline-block;

        }

        .modal .modal-header .btn-close  {
            position: absolute;
            font-weight: bold;
            font-size: 25px;
            top: 10px;
            right: 0;
            border: none;
            background: none;
            color: #837DEC;
        }

        .modal .modal-header .btn-close:hover {
            color: black;
        }

        .modal .modal-header .title {
            font-weight: bold;
            color: #837DEC;
            padding: 10px 10px 10px 0;
        }

        .modal .modal-header {
            border-bottom: 2px solid #837DEC;   
        }

        .modal .brand-insert-modal .modal-content,
        .modal .category-insert-modal .modal-content,
        .modal .brand-edit-modal .modal-content,
        .modal .category-edit-modal .modal-content {
            margin-top: 15px;
        }

        .modal .invoice-insert-modal .modal-content ,
        .modal .product-edit-modal .modal-content  {
            margin-top: 25px;
        }
        .modal .invoice-insert-modal .modal-content .row,
        .modal .product-edit-modal .modal-content .row {
            display: block;
            margin-bottom: 25px;
        }

        .modal .invoice-insert-modal .modal-content .row .column,
        .modal .product-edit-modal .modal-content .row .column {
            display: inline-block;
            margin-right: 110px;
        }


        .modal .invoice-insert-modal .modal-content .row .column:nth-of-type(3),
        .modal .invoice-insert-modal .modal-content .row .column:nth-of-type(6),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(3),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(6) {
            margin-right: 0px;
        }
        .modal .invoice-insert-modal .modal-content .row .column:nth-of-type(2),
        .modal .invoice-insert-modal .modal-content .row .column:nth-of-type(4),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(2),
        .modal .product-edit-modal .modal-content .row .column:nth-of-type(4) {
            margin-right: 90px;

        }

        .modal .invoice-insert-modal .modal-content .row .column input,
        .modal .product-edit-modal .modal-content .row .column input
        {
            width: 250px;
            height: 35px;
            margin-top: 5px;
        }

        .modal .category-insert-modal .modal-content input,
        .modal .brand-insert-modal .modal-content input,
        .modal .brand-edit-modal .modal-content input ,
        .modal .category-edit-modal .modal-content input {
            width: 255px;
            height: 35px;
            margin-top: 5px;
        }


        .modal .invoice-insert-modal .modal-content .row .column .btn-add,
        .modal .product-edit-modal .modal-content .row .column .btn-add
        {
            cursor: pointer;
            color: blue;
            font-size: 20px;
            font-weight: bold;
            padding: 5px;
        }

        .modal .invoice-insert-modal .modal-content .row .column .btn-add:hover,
        .modal .product-edit-modal .modal-content .row .column .btn-add:hover
        {
            color: #fff;
            background: #ccc;
            border-radius: 5px;
        }

        .modal .btn-save,
        .modal .btn-save {
            width: 255px;
            height: 35px;
            margin-top: 20px;
            background: #837DEC;
            cursor: pointer;
            box-sizing: border-box;
            padding: 5px;
            text-align: center;
            border: 1px solid black;
            border-radius: 5px;
            color: #fff;
        }

        .modal .btn-save:hover, 
        .modal .btn-save:hover {
            background: #ccc;
            color: #000;
        }

        ::-webkit-scrollbar {
            width: 10px;
            height: 10px;
            border-radius: 5px;
        }

        ::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #000;
        }

        .modal .invoice-insert-modal .modal-content .row .column .category-container,
        .modal .invoice-insert-modal .modal-content .row .column .brand-container,
        .modal .product-edit-modal .modal-content .row .column .category-container,
        .modal .product-edit-modal .modal-content .row .column .brand-container {
            position: relative;
            margin: 0;
            display: inline-block;
        }

        .modal .invoice-insert-modal .modal-content .row .column .category-container #category-insert-box,
        .modal .invoice-insert-modal .modal-content .row .column .brand-container #brand-insert-box,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-box,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-box
        {
            position: absolute;
            top: 45px;
            height: 0px;
            width: 252px;
            overflow: auto;
            background: #fff;
            border-left: 1px solid #000;
            border-right: 1px solid #000;
            /*border-bottom:  1px solid #000;*/
            transition: all 0.5s ease;
            box-sizing: border-box;   
        }

        .modal .invoice-insert-modal .modal-content .row .column .category-container #category-insert-box,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-box {
            z-index: 2;
        }
        .modal .invoice-insert-modal .modal-content .row .column .brand-container #brand-insert-box,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-box {
            z-index: 2;
        }

        .modal .invoice-insert-modal .modal-content .row .column .category-container #category-insert-box span,
        .modal .invoice-insert-modal .modal-content .row .column .brand-container #brand-insert-box span,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-box span,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-box span
        {
            transform: scale(1);
            cursor: pointer;
            border-bottom: 1px solid #000;
            display: inline-block;
            width: 252px;
            height: 20px;
            padding: 5px;
            margin: 0px;
            visibility: visible;
        }
        .modal .invoice-insert-modal .modal-content .row .column .category-container #category-insert-box span:hover,
        .modal .invoice-insert-modal .modal-content .row .column .brand-container #brand-insert-box  span:hover,
        .modal .product-edit-modal .modal-content .row .column .category-container #category-edit-box span:hover,
        .modal .product-edit-modal .modal-content .row .column .brand-container #brand-edit-box  span:hover
        {
            background: #ccc;
            color: #fff;
            z-index: 99;
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

        .container .main-content .top .group-search .brand {
            position: relative;
            padding-bottom: 10px;
            left: 300px;
        }

        .container .main-content .top .group-search .category {
            position: relative;
            padding-bottom: 10px;
        }

        .container .main-content .top .group-search .brand .brand-container,
        .container .main-content .top .group-search .category .category-container {
            position: absolute;
            height: 0px;
        }


        .container .main-content .top .group-search .brand .brand-container #brand-box,
        .container .main-content .top .group-search .category .category-container #category-box {
            position: absolute;
            top: 35px;
            height: 0px;
            width: 252px;
            overflow: auto;
            background: #fff;
            border-left: 1px solid #000;
            border-right: 1px solid #000;
            /*border-bottom:  1px solid #000;*/
            transition: all 0.5s ease;
            box-sizing: border-box;   
        }
        .container .main-content .top .group-search .brand .brand-container #brand-box span,
        .container .main-content .top .group-search .category .category-container #category-box span {
            cursor: pointer;  
        }
        .container .main-content .top .group-search .brand .btn-add,
        .container .main-content .top .group-search .category .btn-add {
            position: absolute;
            right: 0px;
            left: 180px;
            cursor: pointer;
            width: 10px;
            /*display: inline;*/
            /*border: 1px solid #000;*/
        }
        .container .main-content .top .group-search .brand .btn-add:hover,
        .container .main-content .top .group-search .category .btn-add:hover {
            background: #ccc;
        }


    </style>
    <body>


        <div id ="header" class ="header" >
            <h2 class ="title" >Product</h2>
        </div>
        <div class="slider-menu">
            <ul>
                <section class="setting">

                </section>
                <section class="dashboard">
                    <li onclick="" class="slider-item"><i class="fa fa-dashboard"></i>Dashboard</li>
                </section>
                <section class="product" ></section>
                <li onclick="changePage('../../product/list')" class="slider-item"><i class="fa fa-book"></i>Product</li>
                <section class="invoice">
                    <li onclick="changePage('../../invoice/list')" class="slider-item"><i class="fa fa-money"></i>Invoice</li>
                </section>
                <section class="order">
                    <li onclick="changePage('../../product/list')" class="slider-item"><i class="fa fa-shopping-cart"></i>Order</li>
                </section>
                <section class="report">
                    <li onclick="changePage('../../report/show')" class="slider-item"><i class="fa fa-bar-chart"></i>Report</li>
                </section>
            </ul>
        </div>
        <div id ="container" class ="container">
            <div class ="main-content" >
                <div class ="top" >
                    <div class ="group-search" >
                        <div class ="horizontal-search" >
                            <form action="" method = "POST" >
                                <input type="text" placeholder="Search..." name="search">
                                <button type="submit"><i class="fa fa-search"></i></button>         
                            </form>
                        </div>
                        <div class ="btn-add" >
                            <button onclick="openModal('invoice-insert-modal')">Add new product</button>
                        </div>
                    </div>
                    <div class ="group-search" >
                        <form id ="search-product" action="list" method="GET" >
                            <div class ="category" >
                                <div class ="category-container" onmouseover="openBox('category-box')" onmouseout="closeBox('category-box')"  >
                                    <input id ="category-id" name ="categoryID" type ="hidden"  
                                           value ="${requestScope.category.categoryID}" />
                                    <input id ="category-name" name ="categoryName"  
                                           value ="${requestScope.category.categoryName}" 
                                           type ="text" onkeyup="search(this.value, 'category')" 
                                           placeholder="Choose category"/>
                                    <div id = "category-box">
                                        <table>
                                            <tr>
                                                <td><span onclick="setValue('-1', 'All categories', 'category')" 
                                                          class ="category-value">All categories</span></td>
                                            </tr>
                                            <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                                <tr>
                                                    <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category')" class ="category-value">${c.categoryName}</span></td>
                                                    <td><button type="button" onclick="edit(${c.categoryID}, 'category')" >Edit</button></td>
                                                    <td><button type ="button" onclick="deleteEntity(${c.categoryID}, 'category')">Delete</button></td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                                <span onclick="openModal('category-insert-modal')" class ="btn-add" >+</span>
                            </div >
                            <div class ="brand" >
                                <div class ="brand-container" onmouseover="openBox('brand-box')" onmouseout="closeBox('brand-box')"  >
                                    <input id ="brand-id" name ="brandID" type ="hidden"
                                           value ="${requestScope.brand.brandID}" />
                                    <input id ="brand-name" name ="brandName" 
                                           value ="${requestScope.brand.brandName}"
                                           type ="text" onkeyup="search(this.value, 'brand')" placeholder="Choose brand"/>
                                    <div id = "brand-box">
                                        <table>
                                            <tr>
                                                <td><span onclick="setValue('-1', 'All brands', 'brand')" 
                                                          class ="brand-value">All brands</span></td>
                                            </tr>
                                            <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                                <tr>
                                                    <td><span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand')" class ="brand-value">${b.brandName}</span></td>
                                                    <td><button type="button"  onclick="edit(${b.brandID}, 'brand')" >Edit</button></td>
                                                    <td><button type="button"  onclick="deleteEntity(${b.brandID}, 'brand')">Delete</button></td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                                <span onclick="openModal('brand-insert-modal')" class ="btn-add" >+</span>
                            </div>
                        </form>
                    </div>
                </div>
                <div class ="middle" >
                    <table>
                        <thead>
                            <tr>
                                <th><input type ="checkbox" /></th>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Cost</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="product-list">
                            <c:set var="products" value="${requestScope.products}"  ></c:set>
                            <c:forEach var="p" begin="0" end="${products.size()}" items="${products}" >
                                <tr>
                                    <td><input type ="checkbox" /></td>
                                    <td>${p.productID}</td>
                                    <td>${p.productName}</td>
                                    <td>${p.category.categoryName}</td>
                                    <td>${p.brand.brandName}</td>
                                    <td>${p.cost}</td>
                                    <td>${p.price}</td>
                                    <td>${p.quantity}</td>
                                    <td>
                                        <button onclick="edit(${p.productID}, 'product')">Edit</button>
                                        <button onclick="deleteEntity(${p.productID}, 'product')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class ="bottom" >
                    <div class ="pageSize" >
                        Rows per page <select name ="pageSize" id ="pageSize" onchange="submit('pageSize')">
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
                    <div class ="pagger" id ="pagger" > </div>
                </div>
            </div>

        </div>
        <div class ="modal" >
            <div class ="invoice-insert-modal" id ="invoice-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Insert Product</h2>
                    <button class ="btn-close" onclick="closeModal('invoice-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form action ="" method ="POST" >
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Product ID</span> <br/>
                                <input type ="text" name ="productID" class ="product-insert"  />
                            </div>
                            <div class ="column"  > 
                                <span>Category</span> <br/>
                                <div class ="category-container"  onmouseover="openBox('category-insert-box')" onmouseout="closeBox('category-insert-box')">
                                    <input id ="category-insert-name" class ="product-insert" type ="text" onkeyup="search(this.value, 'category-insert')" />
                                    <input id ="category-insert-id" class ="product-insert" type ="hidden" name ="category" >
                                    <div id="category-insert-box" >
                                        <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                            <span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-insert')" class ="category-value" >${c.categoryName}</span> <br/>
                                        </c:forEach>
                                    </div>
                                </div>
                                <span onclick="openModal('category-insert-modal')" class ="btn-add" >+</span>
                            </div>
                            <div class ="column" > 
                                <span>Cost</span> <br/>
                                <input type ="text" name ="cost" class ="product-insert"  />
                            </div>
                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Product Name</span> <br/>
                                <input type ="text" name ="productName" class ="product-insert"  />
                            </div>
                            <div class ="column" > 
                                <span>Brand</span> <br/>
                                <div class ="brand-container" onmouseover="openBox('brand-insert-box')" onmouseout="closeBox('brand-insert-box')"  >
                                    <input id ="brand-insert-name" class ="product-insert"
                                           type ="text" onkeyup="search(this.value, 'brand-insert')" placeholder="Choose categor"/>
                                    <input id ="brand-insert-id" class ="product-insert" type ="hidden" name ="brand"  >
                                    <div id = "brand-insert-box">
                                        <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                            <span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand-insert')" class ="brand-value">${b.brandName}</span><br/>
                                        </c:forEach>
                                    </div>
                                </div>
                                <span onclick="openModal('brand-insert-modal')" class ="btn-add" >+</span>
                            </div>
                            <div class ="column"> 
                                <span>Price</span> <br/>
                                <input type ="text" name ="price" class ="product-insert" />
                            </div>
                        </div>
                        <div class ="btn-group" >
                            <input type="submit" value ="Save" class ="product-input" />
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class ="modal" >
            <div class ="product-edit-modal" id ="product-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Edit Product</h2>
                    <button class ="btn-close" onclick="closeModal('product-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form action ="edit" method ="POST" >
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Product ID</span> <br/>
                                <span class ="product-edit"></span>
                                <input type ="hidden" name ="productID" class ="product-edit" />
                            </div>
                            <div class ="column"  > 
                                <span>Category</span> <br/>
                                <div class ="category-container"  onmouseover="openBox('category-edit-box')" onmouseout="closeBox('category-edit-box')">
                                    <input id ="category-edit-name" class ="product-edit" type ="text" onkeyup="search(this.value, 'category-edit')" />
                                    <input id ="category-edit-id" class ="product-edit" type ="hidden" name ="categoryID" >
                                    <div id="category-edit-box" >
                                        <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                            <span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-edit')" class ="category-value" >${c.categoryName}</span> <br/>
                                        </c:forEach>
                                    </div>
                                </div>
                                <span onclick="openModal('category-insert-modal')" class ="btn-add" >+</span>
                            </div>
                            <div class ="column" > 
                                <span>Cost</span> <br/>
                                <input type ="text" name ="cost" class ="product-edit"/>
                            </div>
                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Product Name</span> <br/>
                                <input type ="text" name ="productName" class ="product-edit"  />
                            </div>
                            <div class ="column" > 
                                <span>Brand</span> <br/>
                                <div class ="brand-container" onmouseover="openBox('brand-edit-box')" onmouseout="closeBox('brand-edit-box')"  >
                                    <input id ="brand-edit-name" class ="product-edit"
                                           type ="text" onkeyup="search(this.value, 'brand-edit')" placeholder="Choose categor"/>
                                    <input id ="brand-edit-id" type ="hidden" name ="brandID" class ="product-edit" >
                                    <div id = "brand-edit-box">
                                        <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                            <span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand-edit')" class ="brand-value">${b.brandName}</span><br/>
                                        </c:forEach>
                                    </div>
                                </div>
                                <span onclick="openModal('brand-insert-modal')" class ="btn-add" >+</span>
                            </div>
                            <div class ="column"> 
                                <span>Price</span> <br/>
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
                    <h2 class ="title" >Insert Category</h2>
                    <button class ="btn-close" onclick="closeModal('category-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" >  
                    <form action="" >
                        <!--<span>Category Name</span>-->
                        <input type ="text" placeholder="Category name" name ="categoryName" id ="category-insert-input" class ="category-insert" /> 
                    </form>
                </div>
                <div onclick="insert('category-insert')" class ="btn-save"> <span>Save</span></div>
            </div>
        </div>

        <div class ="modal" > 
            <div class ="brand-insert-modal" id ="brand-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Insert Brand</h2>
                    <button class ="btn-close" onclick="closeModal('brand-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <form action="" >
                        <!--<span>Brand Name</span>-->
                        <input type ="text" placeholder="Brand name" name ="brandName" id ="brand-insert-input"  class ="brand-insert" /> 
                    </form>
                </div>
                <div onclick="insert('brand-insert')" class ="btn-save"> <span>Save</span></div>
            </div>
        </div>
        <div class ="modal"  > 
            <div class ="category-edit-modal" id ="category-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Edit Category</h2>
                    <button class ="btn-close" onclick="closeModal('category-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >  
                    <form action="../category/edit" method="POST" >
                        <!--<span>Category Name</span>-->
                        <input type ="hidden" name ="categoryID"  class ="category-edit" /> 
                        <input type ="text" placeholder="Category name" name ="categoryName" class ="category-edit" /> 
                        <button>Save</button>
                    </form>
                </div>
            </div>
        </div>

        <div class ="modal" > 
            <div class ="brand-edit-modal" id ="brand-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Edit Brand</h2>
                    <button class ="btn-close" onclick="closeModal('brand-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <form action="../brand/edit" method="POST" >
                        <!--<span>Brand Name</span>-->
                        <input type ="hidden"  name ="brandID" class ="brand-edit" /> 
                        <input type ="text" placeholder="Brand name" name ="brandName"  class ="brand-edit" /> 
                        <button>Save</button>
                    </form>
                </div>
            </div>
        </div>



    </div>

</body>
</html>
