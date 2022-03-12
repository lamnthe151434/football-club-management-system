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
            width: 45vw;
            height: 20vh;
        }

        .modal .change-price-modal .modal-content  {
            margin-top: 25px;
        }
        .header {
            margin-bottom: 27px;
        }

        .container .main-content .middle {
            height: 560px;
        }


        .container .middle table thead th:n-of-type(1),
        .container .middle table tbody td:n-of-type(1),
        .container .middle table thead th:n-of-type(2),
        .container .middle table tbody td:n-of-type(2),
        .container .middle table thead th:n-of-type(3),
        .container .middle table tbody td:n-of-type(3),
        .container .middle table thead th:n-of-type(4),
        .container .middle table tbody td:n-of-type(4) {
            width: 120px;
        }
        button {
            background: #fff;
        }


    </style>
    <body>
        <div class="header" >
            <h2 class="title" >Change Price</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="../../slider.jsp" />
        </div>
        <div id ="container" class ="container" onmousedown="cursorPosition(event)" onmouseup="cursorPosition(event)">
            <div class ="main-content" >
                <div class ="top" >

                </div>
                <div class ="middle" >
                    <table>
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Cost</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody id="product-list">
                            <c:set var="products" value="${requestScope.products}" ></c:set>
                            <c:forEach begin="0" end="${products.size()}" items="${products}" var="p" >
                                <tr>
                                    <td>P000${p.productID}</td>
                                    <td>${p.productName}</td>
                                    <td>${p.quantity}</td>
                                    <td><input ondblclick="openModal('change-price-modal', ${p.productID}, 'cost')" type="text" value="${p.cost}"  /></td>
                                    <td><input ondblclick="openModal('change-price-modal', ${p.productID}, 'price')" type="text" value="${p.price}" /> </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class ="bottom" >
                    <div class ="pageSize" >
                        Rows per page <select name ="pageSize" id ="pageSize" onchange="submitPageSize('pageSize')">
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
                    <span>${requestScope.trace}</span>
                    <div class ="pagger" id ="pagger" > </div>
                </div>
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
                                    <option value="price" id ="price" >Current Price</option>
                                    <option value="cost" id="cost" >Current Cost</option>
                                </select>
                            </div>
                            <div class="second">
                                <input id="expression-sign" type="hidden" name="expressionSign" value="+" />
                                <button class="expression-sign" type="button" onclick="setExpressionSign('expression-sign', '+')" >+</button>
                                <button class="expression-sign" type="button" onclick="setExpressionSign('expression-sign', '-')" >-</button>
                                <input type="number" name="setPrice" />
                            </div>
                            <div class="third">
                                <input id="expression-unit" type="hidden" name="expressionUnit" value="%" />
                                <button class ="expression-unit" onclick="setExpressionUnit('expression-unit', 'VND')" type="button"  >VND</button>
                                <button class="expression-unit"  onclick="setExpressionUnit('expression-unit', '%')"type="button" >%</button>
                            </div>
                        </div>

                        <div class="commit-action" >
                            <input type="checkbox" /> <label>Apply this formula for ${products.size()} products in store?</label>
                            <button type="button" onclick="submitForm()" >Accept</button>
                            <button type="button" onclick="closeModal('change-price-modal')" >Decline</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
    <script>

        function cursorPosition(event) {
            var x = event.clientX;
            var y = event.clientY;
            var box = document.getElementById('change-price-modal');
            var top;
            if (y > 520) {
                top = (y - 190) + "px";
            } else {
                top = (y + 20) + "px"
            }
            var left = (x - 200) + "px";
            box.style.top = top;
            box.style.left = left;
            //            alert(x + ", " + y);
        }

        function submitPageSize(id) {
            var size = document.getElementById(id).value;
            window.location.href = "?pageIndex=1&pageSize=" + size;
        }

        function submitForm() {
            var form = document.getElementById('edit');
            form.submit();
        }

        function setExpressionSign(id, value) {
            var type = document.getElementById(id);
            type.value = value;
            var button = document.getElementsByClassName('expression-sign');
            if (button[0].style.background !== '#ccc') {
                button[0].style.background = "#ccc";
                button[1].style.background = "#fff";
            }
            if (button[1].style.background !== '#ccc') {
                button[1].style.background = "#ccc";
                button[0].style.background = "#fff";
            }
        }

        function setExpressionUnit(id, value) {
            var type = document.getElementById(id);
            type.value = value;
            type.value = value;
            var button = document.getElementsByClassName('expression-unit');
            if (button[0].style.background !== '#ccc') {
                button[0].style.background = "#ccc";
                button[1].style.background = "#fff";
            }
        }

        function openModal(boxId, productId, type) {
            var box = document.getElementById(boxId);
            var modal = document.getElementsByClassName('modal');
            modal[0].style.transform = "scale(1)";
            box.style.transform = "scale(1)";

            document.getElementById('product-id').value = productId;
            document.getElementById('price-type').value = type;
            document.getElementById('type').innerHTML = "New " + type + " = ";
        }

        function closeModal(boxId) {
            var box = document.getElementById(boxId);
            var modal = document.getElementsByClassName('modal');
            modal[0].style.transform = "scale(0)";
            box.style.transform = "scale(0)";

            window.location
        }


        pagger('pagger',${requestScope.pageIndex},
        ${requestScope.selectedPageSize},
        ${requestScope.totalPage}, 2);

        function pagger(id, pageIndex, pageSize, totalPage, gap)
        {
            var container = document.getElementById(id);
            var result = '';
            var limit;
            // First
            result += '<a href="?pageIndex=1&pageSize=' + pageSize + '">&Lt;</a>';
            // Previous
            if (pageIndex > 1) {
                result += '<a href="?pageIndex=' + (pageIndex - 1) + '&pageSize=' + pageSize + '" >&LT;</a>';
            } else {
                result += '<a href="#">&LT;</a>';
            }

            if (pageIndex <= totalPage - 2)
                limit = pageIndex - gap;
            else if (pageIndex === totalPage)
                limit = pageIndex - (gap * 2);
            else
                limit = pageIndex - (gap + 1);
            for (var i = limit; i < pageIndex; i++)
            {
                if (i >= 1)
                {
                    result += '<a href="?pageIndex=' + i + '&pageSize=' + pageSize + '">' + i + '</a>';
                }
            }

            result += '<a class = "selected-page">' + pageIndex + '</a>';
            if (pageIndex > 2)
                limit = pageIndex + gap;
            else if (pageIndex == 1)
                limit = pageIndex + (gap * 2);
            else
                limit = pageIndex + gap + 1;
            for (var i = pageIndex + 1; i <= limit; i++)
            {
                if (i <= totalPage)
                {
                    result += '<a href="?pageIndex=' + i + '&pageSize=' + pageSize + '">' + i + '</a>';
                }
            }

            // Next
            if (pageIndex < totalPage) {
                result += '<a href="?pageIndex=' + (pageIndex + 1) + '&pageSize=' + pageSize + '" >&GT;</a>';
            } else
            {
                result += '<a href="#">&GT;</a>';
            }

            result += '<a href="?pageIndex=' + totalPage + '&pageSize=' + pageSize + '" >&Gt;</a>';
            container.innerHTML = result;
        }
    </script>
</html>
