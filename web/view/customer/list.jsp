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
        <link rel ="stylesheet" href="../mycss/style.css" />
        <script src="../js/code.js" type="text/javascript"></script>
    </head>
    <style>

        .container .middle table thead th:nth-of-type(1),
        .container .middle table tbody td:nth-of-type(1) {
            width: 10px;
            text-align: center;
        }

        .container .middle table thead th:nth-of-type(2),
        .container .middle table tbody td:nth-of-type(2),
        .container .middle table thead th:nth-of-type(3),
        .container .middle table tbody td:nth-of-type(3),
        .container .middle table thead th:nth-of-type(4),
        .container .middle table tbody td:nth-of-type(4),
        .container .middle table thead th:nth-of-type(5),
        .container .middle table tbody td:nth-of-type(5),
        .container .middle table thead th:nth-of-type(6),
        .container .middle table tbody td:nth-of-type(6){
            width: 150px;
            overflow: auto;
            display: inline-block;
        }

        .container .middle table thead th:nth-of-type(7),
        .container .middle table tbody td:nth-of-type(7)
        {
            width: 100px;
            overflow: auto;
            display: inline-block;
            text-align: center;
        }

        .modal .customer-insert-modal, 
        .modal .customer-edit-modal {
            position: absolute;
            padding: 15px 35px 15px 35px;
            border-radius: 10px;
            background: #FDFDFE;
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 99;
            top: 10.5vh;
            left: 38.5vh;
            width: 65vw;
            height: 65vh;
        }
        .modal .customer-insert-modal .modal-content ,
        .modal .customer-edit-modal .modal-content  {
            margin-top: 25px;
        }


        .modal .customer-insert-modal .modal-content .row,
        .modal .customer-edit-modal .modal-content .row {
            display: block;
            margin-bottom: 25px;
        }

        .modal .customer-insert-modal .modal-content .row .column,
        .modal .customer-edit-modal .modal-content .row .column {
            display: inline-block;
            margin-right: 110px;
        }

        .modal .customer-insert-modal .modal-content .row .column:nth-of-type(3),
        .modal .customer-insert-modal .modal-content .row .column:nth-of-type(6),
        .modal .customer-edit-modal .modal-content .row .column:nth-of-type(3),
        .modal .customer-edit-modal .modal-content .row .column:nth-of-type(6) {
            margin-right: 0px;
        }
        .modal .customer-insert-modal .modal-content .row .column:nth-of-type(2),
        .modal .customer-insert-modal .modal-content .row .column:nth-of-type(4),
        .modal .customer-edit-modal .modal-content .row .column:nth-of-type(2),
        .modal .customer-edit-modal .modal-content .row .column:nth-of-type(4) {
            margin-right: 90px;

        }

        .modal .customer-insert-modal .modal-content .row .column input,
        .modal .customer-edit-modal .modal-content .row .column input
        {
            width: 250px;
            height: 35px;
            margin-top: 5px;
        }
        span.customer-edit, 
        span.customer-insert{
            display: inline-block;
            width: 254px;
            height: 37px;
            padding: 5px;
            margin-top: 5px;
            border: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
        }


    </style>
    <body>
        <div class="header" >
            <h2 class="title" >Customer</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="../slider.jsp" />
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
                            <button onclick="openModal('customer-insert-modal')">Add new customer</button>
                        </div>
                    </div>
                </div>
                <div class ="middle" >
                    <table>
                        <thead>
                            <tr>
                                <th><input type ="checkbox" /></th>
                                <th>Customer ID</th>
                                <th>Customer Name</th>
                                <th>Address</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="customer-list">
                            <c:set var="customers" value="${requestScope.customers}" ></c:set>
                            <c:forEach begin="0" end="${customers.size()}" items="${customers}" var="c" >
                                <tr>
                                    <td><input type ="checkbox" /></td>
                                    <td>KH000${c.customerID}</td>
                                    <td>${c.customerName}</td>
                                    <td>${c.address}</td>
                                    <td>${c.phone}</td>
                                    <td>${c.email}</td>
                                    <td>
                                        <button onclick="edit(${c.customerID})">Edit</button>
                                        <button onclick="deleteEntity(${c.customerID})">Delete</button>
                                    </td>
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
            <div class ="customer-insert-modal" id ="customer-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Insert Customer</h2>
                    <button class ="btn-close" onclick="closeModal('customer-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form action ="insert" method ="POST" >
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Customer ID</span> <br />
                                <span class ="customer-insert">Default</span>

                            </div>
                            <div class ="column"  > 
                                <span>Address</span> <br/>
                                <input type ="text" name ="address" class ="customer-insert"/>
                            </div>
                            <div class ="column" > 
                                <span>Phone</span> <br/>
                                <input type ="text" name ="phone" class ="customer-insert"/>
                            </div>
                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Customer Name</span> <br/>
                                <input type ="text" name ="customerName" class ="customer-insert"  />
                            </div>
                            <div class ="column" > 
                                <span>Gender</span> <br/>
                                <input type ="text" name ="gender" class ="customer-insert"  />
                            </div>
                            <div class ="column"> 
                                <span>Email</span> <br/>
                                <input type ="text" name ="email" class ="customer-insert"  />
                            </div>
                        </div>
                        <div class ="btn-group" >
                            <input type="submit" value ="Save" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class ="modal" >
            <div class ="customer-edit-modal" id ="customer-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Edit Customer</h2>
                    <button class ="btn-close" onclick="closeModal('customer-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form action ="edit" method ="POST" >
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Customer ID</span> <br />
                                <span class ="customer-edit">Default</span>
                                <input type ="hidden" name ="customerID" class ="customer-edit"/>
                            </div>
                            <div class ="column"  > 
                                <span>Address</span> <br/>
                                <input type ="text" name ="address" class ="customer-edit"/>
                            </div>
                            <div class ="column" > 
                                <span>Phone</span> <br/>
                                <input type ="text" name ="phone" class ="customer-edit"/>
                            </div>
                        </div>
                        <div class ="row" >
                            <div class ="column" > 
                                <span>Customer Name</span> <br/>
                                <input type ="text" name ="customerName" class ="customer-edit"  />
                            </div>
                            <div class ="column" > 
                                <span>Gender</span> <br/>
                                <input type ="text" name ="gender" class ="customer-edit"  />
                            </div>
                            <div class ="column"> 
                                <span>Email</span> <br/>
                                <input type ="text" name ="email" class ="customer-edit"  />
                            </div>
                        </div>
                        <div class ="btn-group" >
                            <input type="submit" value ="Save" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script>

        function submitPageSize(id) {
            var size = document.getElementById(id).value;
            window.location.href = "?pageIndex=1&pageSize=" + size;
        }
        function openModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'customer-insert-modal') {
                modal[0].style.transform = "scale(1)";
            } else if (id === 'customer-edit-modal') {
                modal[1].style.transform = "scale(1)";
            }
            box.style.transform = "scale(1)";
        }

        function closeModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'customer-insert-modal') {
                modal[0].style.transform = "scale(0)";
            } else if (id === 'customer-edit-modal') {
                modal[1].style.transform = "scale(0)";
            }
            box.style.transform = "scale(0)";

            var input = id.split('-modal')[0];
            if (id !== 'customer-edit-modal') {
                clearInputData(input);
            }
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

        function edit(id) {
            var url = "edit?id=" + id;
            var edit = document.getElementsByClassName('customer-edit');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var arr = result.split('|');
                edit[0].innerHTML = 'KH000' + arr[0];
                for (var i = 1, max = arr.length; i < max; i++) {
                    edit[i].value = arr[i];
                }
            });
            openModal('customer-edit-modal');
        }


        function deleteEntity(id) {
            var anwser = confirm("Do you want to delete customer with id =" + id);
            var url;
            if (anwser) {
                url = "delete?id=" + id;
                window.location.href = url;
            }
        }
    </script>
</html>
