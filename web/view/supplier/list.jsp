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
        .container .main-content .middle table td:nth-of-type(1),
        .container .main-content .middle table td:nth-of-type(2)
        {
            width: 110px;
        }

        .container .main-content .middle thead {
            position: sticky;
            top:0;
            background-color: #009879;
            color: #ffffff;
        }

        .container .main-content .middle table td {
            width: 100px;
            padding: 10px;
            word-wrap: break-word; 
            /*height: 30px;*/
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

        .modal .supplier-insert-modal, 
        .modal .supplier-edit-modal {
            position: absolute;
            padding: 15px 35px 15px 35px;
            border-radius: 10px;
            background: #FDFDFE;
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 99;
            top: 11vh;
            left: 60vh;
            width: 40vw;
            height: 70vh;

        }
        .modal .supplier-edit-modal .modal-content table td span:hover,
        .modal .supplier-insert-modal .modal-content table td span:hover{
            border-bottom: 1px solid blue; 
        }

        .modal .supplier-insert-modal .modal-content ,
        .modal .supplier-edit-modal .modal-content  {
            margin-top: 10px;
            position: relative;
            background: #fff;
        }


        .modal .supplier-insert-modal .modal-content input,
        .modal .supplier-edit-modal .modal-content input,
        .modal .supplier-insert-modal .modal-content .textarea,
        .modal .supplier-edit-modal .modal-content .textarea
        {
            width: 95.5%;
            padding: 10px;
            /*height: 30px;*/
            margin-top: 5px;
            background: #fff;
            border:none;
            outline: none;
            border-bottom: 1px solid #C7C7C7;           
            background: #fff;
        }

        .modal .supplier-insert-modal .modal-content .radio ,
        .modal .supplier-edit-modal .modal-content .radio 

        {
            width: 20px;
            padding: 0px;
            margin: 0px;
        }

        .modal .supplier-insert-modal .modal-content .textarea,
        .modal .supplier-edit-modal .modal-content .textarea{
            resize: none;
        }

        .modal .supplier-edit-modal .modal-content table td:nth-child(1),
        .modal .supplier-insert-modal .modal-content table td:nth-child(1) {
            padding:10px 10px 10px 0px;
            width: 150px;
            /*border: 1px solid #000;*/
        }

        .modal .supplier-insert-modal .modal-content table tr:nth-child(8) td, 
        .modal .supplier-edit-modal .modal-content table tr:nth-child(8) td {
            /*border: 1px solid #000;*/
            /*box-sizing: border-box;*/
            text-align: right;
            width: 460px;
        }

        .modal .supplier-insert-modal .modal-content table tr:nth-child(4) td:nth-child(2) ,
        .modal .supplier-edit-modal .modal-content table tr:nth-child(4) td:nth-child(2) 
        {
            border-bottom:  1px solid #C7C7C7;    
            padding: 12px;
            width: 445px;
        }
        .modal .supplier-insert-modal .modal-content table tr:nth-child(4) td:nth-child(1),
        .modal .supplier-edit-modal .modal-content table tr:nth-child(4) td:nth-child(1)
        {
            padding: 12px 12px 12px 0px;
        }

        .modal .supplier-edit-modal .modal-content table tr:nth-child(8) td button,
        .modal .supplier-insert-modal .modal-content table tr:nth-child(8) td button{
            margin-top: 10px;
            padding:5px 10px 5px 10px;
            width: 160px;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            margin-left: 45px;
        }

        .modal .supplier-edit-modal .modal-content table tr:nth-child(8) td button:hover,
        .modal .supplier-insert-modal .modal-content table tr:nth-child(8) td button:hover {
            box-shadow: 0px 0px 2px 2px #ccc;
        }

        .modal .supplier-insert-modal .modal-content table tr:nth-child(8) td button:nth-of-type(3),
        .modal .supplier-edit-modal .modal-content table tr:nth-child(8) td button:nth-of-type(3) {
            margin-right: 0px;
            background: rgb(0, 0, 200);
        }
        .modal .supplier-insert-modal .modal-content table tr:nth-child(8) td button:nth-of-type(2),
        .modal .supplier-edit-modal .modal-content table tr:nth-child(8) td button:nth-of-type(2) {
            background: rgb(0, 200, 0);


        }
        .modal .supplier-insert-modal .modal-content table tr:nth-child(8) td button:nth-of-type(1),
        .modal .supplier-edit-modal .modal-content table tr:nth-child(8) td button:nth-of-type(1) {
            background: rgb(200, 0, 0);
            margin-left: 5px;
        }

        .table-title {
            font-size: 17px;
            font-weight: 600;
        }

        .modal .supplier-edit-modal .modal-content table td:nth-child(2),
        .modal .supplier-insert-modal .modal-content table td:nth-child(2) {
            padding: 10px 0px 0x 0px;
            width: 440px;
            box-sizing: border-box;
            /*border: 1px solid #000;*/

        }
        .modal .supplier-edit-modal .modal-content input:focus,
        .modal .supplier-insert-modal .modal-content input:focus {
            border-bottom: 1px solid blue;
            box-shadow: 0px  2px #ccc;
        }

        .modal .supplier-edit-modal .modal-content table td span,
        .modal .supplier-insert-modal .modal-content table td span {
            padding: 10px;
            width: 95.5%;
            display: inline-block;
            border-bottom: 1px solid #C7C7C7; 
            cursor: pointer;
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
        <div class="header" >
            <h2 class="title" >Nhà cung cấp</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="../slider.jsp" />
        </div>
        <div class="search-section" >
            <form id="search-form" action="list" method="POST" >
                <input type="hidden" id="search-key" name ="searchKey" value="${requestScope.searchKey}" />
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
                            <input id="search-bar" value="${requestScope.searchKey}" type="text" placeholder="Tìm kiếm theo mã hoặc tên nhà cung cấp"
                                   name="search">
                            <button type="button" onclick="setSearchKey('search-key', 'search-bar')"><i class="fa fa-search"></i></button>         
                        </div>
                        <div class ="btn-add" >
                            <button onclick="openModal('supplier-insert-modal')">Thêm nhà cung cấp</button>
                        </div>
                    </div>
                </div>
                <div class ="middle" >
                    <c:if test="${requestScope.suppliers.size() > 0}" >

                        <table>
                            <thead>
                                <tr>
                                    <td class="sort-by" onclick="sortBy('Supplier_ID', 0)">
                                        <span>Mã nhà cung cấp</span>
                                        <c:if  test="${requestScope.sortBy == 'Supplier_ID' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Supplier_Name', 1)">
                                        <span>Tên nhà cung cấp</span>
                                        <c:if  test="${requestScope.sortBy == 'Supplier_Name' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('DOB', 2)">
                                        <span>Ngày sinh</span>
                                        <c:if  test="${requestScope.sortBy == 'DOB' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Gender', 3)">
                                        <span>Giới tính</span>
                                        <c:if  test="${requestScope.sortBy == 'Gender' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Phone', 4)">
                                        <span>Số điện thoại</span>
                                        <c:if  test="${requestScope.sortBy == 'Phone' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td class="sort-by" onclick="sortBy('Address', 5)">
                                        <span>Dịa chỉ</span>
                                        <c:if  test="${requestScope.sortBy == 'Address' 
                                                       && requestScope.sortType != '0'}">
                                            <c:if test="${requestScope.sortType == '1'}">
                                                <i class="fa fa-arrow-up"></i>
                                            </c:if>
                                            <c:if test="${requestScope.sortType == '2'}">
                                                <i class="fa fa-arrow-down"></i>
                                            </c:if>
                                        </c:if> 
                                    </td>
                                    <td>Ghi chú</td>
                                    <td>Hành động</td>
                                </tr>
                            </thead>
                            <tbody id="supplier-list">
                                <c:set var="suppliers" value="${requestScope.suppliers}" ></c:set>
                                <c:forEach begin="0" end="${suppliers.size()}" items="${suppliers}" var="c" >
                                    <tr>
                                        <td>${c.supplierID}</td>
                                        <td>${c.supplierName}</td>
                                        <td>
                                            <c:if test="${c.dob != '0001-01-01'}" >
                                                ${c.dob}
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${c.gender}" >
                                                Nam
                                            </c:if>
                                            <c:if test="${!c.gender}" >
                                                Nữ
                                            </c:if>
                                        </td>
                                        <td>${c.phone}</td>
                                        <td>${c.address}</td>
                                        <td>${c.description}</td>
                                        <td>
                                            <button onclick="edit(${c.supplierID})"><i class="fa fa-pencil" ></i></button>
                                            <button onclick="deleteEntity(${c.supplierID})"><i class="fa fa-trash" ></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                        <c:if test="${requestScope.suppliers.size() == 0}" >
                            <div>
                                <p>Không tìm thấy nhà cung cấp</p>
                            </div>
                        </c:if>
                </div>
                <c:if test="${requestScope.suppliers.size() >= 10 || requestScope.pageIndex >= 2}" >
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
                        <span>${requestScope.track}</span>
                        <div class ="pagger" id ="pagger" > </div>
                    </div>
                </c:if>
            </div>
        </div>
        <div class ="modal" >
            <div class ="supplier-insert-modal" id ="supplier-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm mới nhà cung cấp</h2>
                    <button class ="btn-close" onclick="closeModal('supplier-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form id="supplier-insert-form" action ="insert" method ="POST" >
                        <table>
                            <tr>
                                <td class="table-title" >Mã nhà cung cấp</td>
                                <td  ><span>Mã tự động</span></td>
                            </tr>
                            <tr>
                                <td class="table-title">Tên nhà cung cấp</td>
                                <td ><input type ="text" name ="supplierName" class ="supplier-insert"  /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Ngày sinh</td>
                                <td>
                                    <input type="date"  name="dob" class ="supplier-insert"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Giới tính</td>
                                <td  >
                                    <input class="radio" type ="radio" name ="gender" value="1"  class ="supplier-insert" > Nam
                                    <input style="margin-left: 15px;" class="radio" type ="radio" name ="gender" value="0"  class ="supplier-insert" > Nữ
                                </td>


                            </tr>
                            <tr>
                                <td class="table-title">Số điện thoại</td>
                                <td > 
                                    <input type ="number" name ="phone" class ="supplier-insert" value=""  />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Địa chỉ</td>
                                <td >  <input type ="text" name ="address" class ="supplier-insert" /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Ghi chú</td>
                                <td > <textarea class="textarea" rows="4" cols="30" name ="description" class ="supplier-insert" ></textarea></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <button type="button" onclick="setSubmitType('0', true, 'supplier-insert')"  >Đóng</button>
                                    <button type="button" onclick="setSubmitType('0', false, 'supplier-insert')" >Lưu</button>
                                    <button type="button" onclick="setSubmitType('1', false, 'supplier-insert')" >Lưu và thêm mới</button>
                                    <input type="hidden" name="submitType" id="submit-type" value="${requestScope.submitType}" />
                                </td>

                            </tr>
                        </table>

                    </form>
                </div>
            </div>
        </div>
        <div class ="modal" >
            <div class ="supplier-edit-modal" id ="supplier-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Chỉnh sửa thông tin nhà cung cấp</h2>
                    <button class ="btn-close" onclick="closeModal('supplier-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form id="supplier-edit-form" action ="edit" method ="POST" >
                        <table>
                            <tr>
                                <td class="table-title" >Mã nhà cung cấp</td>
                                <td>
                                    <span class="supplier-edit" ></span>
                                    <input type ="hidden" class ="check-exist"  />
                                    <input name="supplierID" type="hidden" class="supplier-edit" />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Tên nhà cung cấp</td>
                                <td ><input type ="text" name ="supplierName" class="supplier-edit"  /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Ngày sinh</td>
                                <td>
                                    <input type="date"  name="dob" class="supplier-edit"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Giới tính</td>
                                <td  >
                                    <input class="radio supplier-edit" type ="radio" name ="gender" value="1"  > Nam
                                    <input class="radio supplier-edit" style="margin-left: 15px;"  type ="radio" name ="gender" value="0"   > Nữ
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Số điện thoại</td>
                                <td > 
                                    <input type ="hidden" class ="check-exist"  />
                                    <input type ="text" name ="phone" class="supplier-edit"  />
                                </td>
                            </tr>
                            <tr>
                                <td class="table-title">Địa chỉ</td>
                                <td >  <input type ="text" name ="address" class="supplier-edit" /></td>
                            </tr>
                            <tr>
                                <td class="table-title">Ghi chú</td>
                                <td > <textarea class="textarea supplier-edit" rows="4" cols="30" name ="description"></textarea></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <button type="button" onclick="closeModal('supplier-edit-modal')"  >Đóng</button>
                                    <button type="button" onclick="setSubmitType('0', false, 'supplier-edit')">Lưu</button>
                                </td>

                            </tr>
                        </table>

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
    </body>
    <script>


        <c:if test="${requestScope.suppliers.size() >= 10 || requestScope.pageIndex >= 2}" >
        pagger('pagger',${requestScope.pageIndex},
            ${requestScope.selectedPageSize},
            ${requestScope.totalPage}, 2);
        </c:if>


        <c:if test="${requestScope.submitType.equals('1')}">
        openModal('supplier-insert-modal');
        </c:if>

        var supplierList = document.getElementById('supplier-list');
        var trs = supplierList.children;
        for (var i = 0, max = trs.length; i < max; i++) {
            tds = trs[i].children;
            tds[0].innerHTML = formatSupplierId(tds[0].innerHTML);
        }

//        function insertSupplier() {
//            var supplier = document.getElementsByClassName('supplier-insert');
//            if (!checkInputSupplier(supplier)) {
//                return;
//            }
//            if (checkExistSupplier(supplier[0].value, supplier[4].value)) {
//                generateMessage("Nhà cung cấp đã tồn tại");
//                return;
//            }
//        }

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
                var status = checkInputSupplier(inputType);
                if (status) {
                    checkExistSupplier(inputType)
                }
            }
        }

        function checkExistSupplier(inputType) {
            var supplier = document.getElementsByClassName(inputType);
            var name = "", phone = "";
            if (inputType === "supplier-insert") {
                name = supplier[0].value;
                if (supplier[4] == null) {
                    phone = "";
                } else {
                    phone = supplier[4].value;
                }
            } else {
                name = supplier[1].value;
                phone = supplier[6].value;
            }
            var checkExist = document.getElementsByClassName("check-exist");
            var currentName = checkExist[0].value;
            var currentPhone = checkExist[1].value;
            var url = "check?supplierName=" + name + "&phone=" + phone;
            url += "&currentSupplierName=" + currentName + "&currentPhone=" + currentPhone;
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                if (result === "false") {
                    generateWarning('Nhà cung cấp đã tồn tại');
                } else {
                    submitForm(inputType + "-form");
                }
            });
        }

       

        function checkInputSupplier(inputType) {
            var supplier = document.getElementsByClassName(inputType);
            var name = "", phone = "";
            if (inputType === "supplier-insert") {

                name = supplier[0].value;
                if (supplier[4] == null) {
                    phone = "";
                } else {
                    phone = supplier[4].value;
                }
            } else {
                name = supplier[1].value;
                phone = supplier[6].value;
            }
//            alert("(" + name + ")");
            if (name == "") {
                generateWarning("Chưa nhập tên nhà cung cấp");
                return false;
            }

            return true;
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

        function submitPageSize(id) {
            var size = document.getElementById(id).value;
            window.location.href = "?pageIndex=1&pageSize=" + size;
        }
        function openModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'supplier-insert-modal') {
                modal[0].style.transform = "scale(1)";
            } else if (id === 'supplier-edit-modal') {
                modal[1].style.transform = "scale(1)";
            } else if (id === 'delete-confirm-modal') {
                modal[2].style.transform = "scale(1)";
            }
            box.style.transform = "scale(1)";
        }

        function closeModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'supplier-insert-modal') {
                modal[0].style.transform = "scale(0)";
            } else if (id === 'supplier-edit-modal') {
                modal[1].style.transform = "scale(0)";
            } else if (id === 'delete-confirm-modal') {
                modal[2].style.transform = "scale(0)";
            }
            box.style.transform = "scale(0)";

        }




        function edit(id) {
            var url = "edit?id=" + id;
            var checkExist = document.getElementsByClassName('check-exist');
            var edit = document.getElementsByClassName('supplier-edit');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var arr = result.split('|');

                edit[0].innerHTML = formatSupplierId(arr[0]);
                edit[1].value = arr[1];
                edit[2].value = arr[2];
                if (arr[3] === "0001-01-01") {
                    edit[3].value = "";
                } else {
                    edit[3].value = arr[3];
                }
//                alert(arr[4]);
                if (arr[4] === "true") {
                    edit[4].checked = "checked";
                } else {
                    edit[5].checked = "checked";
                }

                edit[6].value = arr[5];
                edit[7].value = arr[6];
                edit[8].value = arr[7];

                checkExist[0].value = arr[2];
                checkExist[1].value = arr[5];

            });
            openModal('supplier-edit-modal');
        }
        function setSearchKey(searchKey, searchBar) {
//                alert(value);
            var key = document.getElementById(searchKey);
            var search = document.getElementById(searchBar);
            key.value = search.value;
            submitForm("search-form");
        }


        function formatSupplierId(id) {
            var len = (id + "").length;
            switch (len) {
                case 1:
                    return "SP0000" + id;
                case 2:
                    return "SP000" + id;
                case 3:
                    return "SP00" + id;
                case 4:
                    return "SP0" + id;
                default:
                    return "SP" + id;
            }

        }

        function deleteEntity(id) {
            var messageTitle = document.getElementById('message-title');
            messageTitle.innerHTML = "Mọi thông tin liên quan đến nhà cung cấp sẽ bị xóa, bạn có muốn tiếp tục?";
            var buttonDelete = document.getElementById('button-delete');
            var url = "delete?id=" + id;
            buttonDelete.onclick = function () {
                window.location.href = url;
            };
            openModal("delete-confirm-modal");
        }

    </script>
</html>
