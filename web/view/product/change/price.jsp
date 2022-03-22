<%-- 
    Document   : list
    Created on : Mar 5, 2022, 10:38:45 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel ="stylesheet" href="../../css/mystyle.css" />
        <script src="../../js/code.js" type="text/javascript"></script>
    </head>
    <style>

        body{
            overflow: hidden;
        }

        .modal {
            background: rgba(0, 0, 0, 0.1);
        }
        .modal .change-price-modal {
            position: absolute;
            padding: 15px 35px 15px 35px;
            border-radius: 10px;
            background: #FDFDFE;
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 99;
            top: 50vh;
            left: 38.5vh;
            width: 45vh;
            height: 25vh;
            border: 1px solid blue;
            box-shadow: 0px 0px 2px 2px #ccc;
        }

        .modal .change-price-modal .modal-content  {
            margin-top: 20px;
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



        .container .main-content .top .group-search .brand .brand-container #brand-search-name,
        .container .main-content .top .group-search .category .category-container #category-search-name{
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

        .container .main-content .middle thead{
            position: sticky;
            top:0;
            background-color: #009879;
            color: #ffffff;
        }

        .container .main-content .middle table td{
            width: 100px;
            padding: 10px;
            word-wrap: break-word;    
        }



        .container .main-content .middle table td:nth-child(1),
        .container .main-content .middle table td:nth-child(2),
        .container .main-content .middle table td:nth-child(3),
        .container .main-content .middle table td:nth-child(4) {
            width: 70px;
        }

        .container .main-content .middle table td:nth-child(5) {
            width: 50px;
        }

        .container .main-content .middle table td input {
            padding: 4px;
        }

        .warning {
            position: absolute;
            right: 15px;
            bottom: 15px;
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

        .first, 
        .second,
        .third, 
        .fourth{
            margin-bottom: 10px;
        }
        button {
            text-align: center;

            padding: 5px;
            background: #fff;
            border-radius: 5px;
        }
        button:hover {
            box-sizing: 0px 0px 2px 2px #ccc;;
        }

        .fourth{
            text-align: right;

        }

        .fourth button {
            margin-left: 10px;
        }

        .expression-sign {
            background: #fff;
        }
        input {
            padding: 5px;
        }

        .btn:hover {
            background: #ccc;
        }

        .sort-by {
            cursor: pointer;
        }


    </style>
    <body ondblclick="fadeOutMessage()" >
        <div class="header" >
            <h2 class="title" >Thay đổi giá</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="../../slider.jsp" />
        </div>
        <div class="search-section" >
            <form id="search-form" action="price" method="POST" >
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
        <div id ="container" class ="container" onmousedown="cursorPosition(event)" onmouseup="cursorPosition(event)">
            <div class ="main-content" >
                <div class ="top" >
                    <div class ="group-search" >
                        <div class ="horizontal-search" >
                            <input id="search-bar" value="${requestScope.searchKey}" type="text" placeholder="Tìm kiếm theo tên hoặc mã hàng" name="search">
                            <button type="button" onclick="setSearchKey('search-key', 'search-bar')"><i class="fa fa-search"></i></button>         
                        </div>
                    </div>
                    <div class ="group-search" >
                        <form id ="search-product" action="list" method="GET" >
                            <div class ="category" >
                                <div class ="category-container">
                                    <span>Nhóm hàng: </span>
                                    <span id="category-search-name" onclick="openBox('category-search-box')" >${requestScope.category.categoryName}</span>
                                    <input id ="category-search-id" name ="categoryID" type ="hidden"  
                                           value ="${requestScope.category.categoryID}" />
                                    <div id = "category-search-box">
                                        <input type ="text" onkeyup="search(this.value, 'category-search')"  placeholder="Tìm kiếm nhóm hàng"/>
                                        <div id="category-box" >
                                            <table>
                                                <tr>
                                                    <td><span onclick="setValue('-1', 'Tất cả', 'category-search')" 
                                                              class ="category-value">Tất cả</span></td>
                                                </tr>
                                                <c:forEach var="c" begin="0" end="${categories.size()}" items="${categories}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.categoryID}', '${c.categoryName}', 'category-search')" class ="category-value">${c.categoryName}</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div >
                            <div class ="brand" >
                                <div class ="brand-container"  >
                                    <span>Thương hiệu: </span>
                                    <span id="brand-search-name" onclick="openBox('brand-search-box')" >${requestScope.brand.brandName}</span>
                                    <input id ="brand-search-id" name ="brandID" type ="hidden"
                                           value ="${requestScope.brand.brandID}" />
                                    <div id ="brand-search-box" >
                                        <input type ="text" onkeyup="search(this.value, 'brand-search')" placeholder="Tìm kiếm thương hiệu" />
                                        <div id = "brand-box" >
                                            <table >
                                                <tr>
                                                    <td><span onclick="setValue('-1', 'Tất cả', 'brand-search')" 
                                                              class ="brand-value">Tất cả</span></td>
                                                </tr>
                                                <c:forEach var="b" begin="0" end="${brands.size()}" items="${brands}" >
                                                    <tr>
                                                        <td class="first-td" ><span onclick="setValue('${b.brandID}', '${b.brandName}', 'brand-search')" class ="brand-value">${b.brandName}</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
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
                                    <td class="sort-by" onclick="sortBy('Quantity', 4)">
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
                                    <td>Giá nhập</td>
                                    <td>Giá bán</td>
                                </tr>
                            </thead>
                            <tbody id="product-list">
                                <c:set var="products" value="${requestScope.products}" ></c:set>
                                <c:forEach begin="0" end="${products.size()}" items="${products}" var="p" >
                                    <tr>
                                        <td>P000${p.productID}</td>
                                        <td>${p.productName}</td>
                                        <td>${p.category.categoryName}</td>
                                        <td>${p.brand.brandName}</td>
                                        <td>${p.quantity}</td>
                                        <td><input onblur="editPrice(${p.productID}, this.value, 'cost')" ondblclick="openModal('change-price-modal', ${p.productID}, 'cost')" type="number" value="${p.cost}"  /></td>
                                        <td><input onblur="editPrice(${p.productID}, this.value, 'price')" ondblclick="openModal('change-price-modal', ${p.productID}, 'price')" type="number" value="${p.price}" /> </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${requestScope.products.size() == 0}" >
                        <p>Không tìm thấy hàng hóa</p>
                    </c:if>
                </div>
                <c:if test="${requestScope.products.size() >= 10 || requestScope.pageIndex >= 2}" >
                    <div class ="bottom" >
                        <div class ="pageSize" >
                            Số bản ghi <select name ="pageSize" id ="pageSize" onchange="submitPageSize('pageSize')">
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
                </c:if>
            </div>
        </div>
        <div class ="modal" >
            <div class ="change-price-modal" id ="change-price-modal" >
                <div class ="modal-content" >
                    <form id="edit" action ="price" method ="POST" >
                        <div class ="change-price-box" >
                            <div class ="first" >
                                <input  type="hidden" id ="product-id" name ="productID" />
                                <input  type="hidden" id ="price-type" name ="priceType" />
                                <span id ="type" ></span>
                                <select name ="baseType" >
                                    <option value="price" id ="price" >Giá bán</option>
                                    <option value="cost" id="cost" >Giá nhập</option>
                                </select>
                            </div>
                            <div class="second">
                                <input id="expression-sign" type="hidden" name="expressionSign" value="+" />
                                <button style="background: rgb(0, 255, 0); color: rgb(255, 255, 255);" class="expression-sign" type="button" onclick="setExpressionSign('expression-sign', '+', 0)" >+</button>
                                <button style="background: rgb(255, 255, 255);" class="expression-sign" type="button" onclick="setExpressionSign('expression-sign', '-', 1)" >-</button>
                                <input id="input-price" onkeyup="checkInput('input-price')" type="number" min="0" value="0" name="setPrice" />
                                <input id="expression-unit" type="hidden" name="expressionUnit" value="VND" />
                                <button style="background: rgb(0, 255, 0); color: rgb(255, 255, 255);" class ="expression-unit" onclick="setExpressionUnit('expression-unit', 'VND', 0)" type="button"  >VND</button>
                                <button style="background: rgb(255, 255, 255);" class="expression-unit"  onclick="setExpressionUnit('expression-unit', '%', 1)"type="button" >%</button>

                            </div>
                            <div class="third">
                                <input type="checkbox" name="applyAll" value="1" /> <label>Áp dụng công thức này cho ${requestScope.totalProduct} hàng hóa trong cửa hàng?</label>
                            </div>
                            <div class="fourth" >
                                <button class="btn" style="background: #fff;" type="submit" onclick="submitForm(edit)" >Chấp nhận</button>
                                <button class="btn" style="background: #fff;" type="button" onclick="closeModal('change-price-modal')" >Bỏ qua</button>
                            </div>
                        </div>


                    </form>
                </div>
            </div>
        </div>
        <div class="warning" id="warning" >

        </div>

    </body>
    <script>

        <c:if test="${status == true}" >
        generateWarning("Thay đổi giá thành công!");
        </c:if>

         <c:if test="${(requestScope.products.size() >= 10 
                      || requestScope.pageIndex >= 2) 
                      && requestScope.totalPage > 1}" >
        pagger('pagger',${requestScope.pageIndex},
              ${requestScope.selectedPageSize},
              ${requestScope.totalPage}, 2);
        </c:if>

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
            var mesage = document.getElememessagentById(id);
            mesage.style.animationName = "fadeOut";
        }

        function fadeOutMessage() {
            var warningBox = document.getElementById("warning");
            var messageBox = warningBox.children;
            for (var i = messageBox.length - 1, max = 0; i >= max; i--) {
                warningBox.removeChild(messageBox[i]);
            }

        }



        function cursorPosition(event) {
            var x = event.clientX;
            var y = event.clientY;
            var box = document.getElementById('change-price-modal');
            var top;
            if (x > 1200) {
                x -= 150;
            }
            if (y > 460) {
                top = (y - 250) + "px";
            } else {
                top = (y + 20) + "px"
            }


            var left = (x - 200) + "px";
            box.style.top = top;
            box.style.left = left;
//            alert("x = " + x + ",y = " + y);
        }

        function setExpressionSign(id, value, position) {
            var type = document.getElementById(id);
            type.value = value;
            var button = document.getElementsByClassName('expression-sign');
            var white = "rgb(255, 255, 255)";
            var green = "rgb(0, 255, 0)";
            var black = "rgb(0, 0, 0)";

            var other = 0;
            if (position == 1)
                other = 0;
            else
                other = 1;

            if (button[position].style.background === white) {
                button[position].style.background = green;
                button[position].style.color = white;
                button[other].style.background = white;
                button[other].style.color = black;
            }
        }

        function setExpressionUnit(id, value, position) {
            var type = document.getElementById(id);
            type.value = value;
            var button = document.getElementsByClassName('expression-unit');
            var white = "rgb(255, 255, 255)";
            var green = "rgb(0, 255, 0)";
            var black = "rgb(0, 0, 0)";

            var other = 0;
            if (position == 1)
                other = 0;
            else
                other = 1;

            if (button[position].style.background === white) {
                button[position].style.background = green;
                button[position].style.color = white;
                button[other].style.background = white;
                button[other].style.color = black;
            }
        }

        function editPrice(id, price, type) {
            var url = "../edit/price?id=" + id + "&price=" + price + "&type=" + type;
            var modal = document.getElementById('change-price-modal');
            if (modal.style.transform == "scale(1)") {
            } else {
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    if (parseInt(result) == 1) {
                        generateWarning('Thay đổi giá thành công');
                    }
                });
            }

        }

        function openModal(boxId, productId, type) {
            var box = document.getElementById(boxId);
            var modal = document.getElementsByClassName('modal');
            modal[0].style.transform = "scale(1)";
            box.style.transform = "scale(1)";

            document.getElementById('product-id').value = productId;
            document.getElementById('price-type').value = type;

            if (type === "cost")
                type = "Giá nhập";
            else
                type = "Giá bán";
            document.getElementById('type').innerHTML = type + " mới = ";
        }

        function closeModal(boxId) {
            var box = document.getElementById(boxId);
            var modal = document.getElementsByClassName('modal');
            modal[0].style.transform = "scale(0)";
            box.style.transform = "scale(0)";
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

        function searchProduct() {
            var category = document.getElementById('category-search-id');
            var brand = document.getElementById('brand-search-id');
            var categorySearch = document.getElementById('category-search');
            var brandSearch = document.getElementById('brand-search');
            categorySearch.value = category.value;
            brandSearch.value = brand.value;
            var form = document.getElementById('search-form');
            form.submit();
        }

        function setValue(idValue, nameValue, id) {
            var inputId = document.getElementById(id + '-id');
            var inputName = document.getElementById(id + '-name');
            inputId.value = idValue;
            inputName.innerHTML = nameValue;
            searchProduct();
        }

        function search(value, type) {
            var boxType = type;
            type = type.split("-")[0];
            var url = "../../" + type + "/search?keyword=" + value;
            url += "&boxType=" + boxType;
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var box = document.getElementById(type + '-box');
                box.innerHTML = result;
            });
        }

        function checkInput(id) {
            var input = document.getElementById(id);
            if (input.value === "") {
                input.value = "0";
            }
            if (input.value.length > 1 && (input.value).charAt(0) === '0') {
                input.value = (input.value).replace('0', '');
            }
        }



    </script>
</html>
