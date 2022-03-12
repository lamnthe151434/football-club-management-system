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

        .modal .import-invoice-insert-modal, 
        .modal .import-invoice-edit-modal {
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
            height: 75vh;
        }
        .modal .import-invoice-insert-modal .modal-content ,
        .modal .import-invoice-edit-modal .modal-content  {
            margin-top: 25px;
        }
        .modal .import-invoice-insert-modal .modal-content .btn-group,
        .modal .import-invoice-edit-modal .modal-content .btn-group  {
            clear: both;
        }


        .modal .import-invoice-insert-modal .modal-content .column,
        .modal .import-invoice-edit-modal .modal-content .column {
            display: inline-block;
            /*border: 1px solid #000;*/
            /*padding: 10px;*/
        }

        .modal .import-invoice-insert-modal .modal-content .column:nth-of-type(2) {
            width: 700px;
            height: 300px;
            float: right;
        }
        .modal .import-invoice-insert-modal .modal-content .column:nth-of-type(2) .row label {
            text-align: center;
            width: 700px;
            /*border: 1px solid #000;*/
            display: inline-block;
        }
        .modal .import-invoice-insert-modal .modal-content .column:nth-of-type(1) {
            float: left;
        }


        .modal .import-invoice-insert-modal .modal-content .column .row input,
        .modal .import-invoice-edit-modal .modal-content .column .row input
        {
            width: 245px;
            height: 35px;
            margin-top: 5px;
            margin-bottom: 40px;
            border: 1px solid #000;
        }

        .modal .import-invoice-insert-modal .modal-content .column .row textarea, 
        .modal .import-invoice-edit-modal .modal-content .column .row textarea {
            overflow: scroll;
            resize: none;
            margin-top: 5px;
            margin-bottom: 35px;
            border: 1px solid #000;
        }

        span.import-invoice-edit, 
        span.import-invoice-insert{
            display: inline-block;
            width: 254px;
            height: 37px;
            padding: 5px;
            margin-top: 5px;
            border: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
        }

        .modal .import-invoice-insert-modal .modal-content .column .row .search-product, 
        .modal .import-invoice-edit-modal .modal-content .column .row .search-product {
            width: 700px;
            margin-bottom: 0px; 
        }



        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box,
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box
        {
            width: 700px;
            height: 341px;
            overflow: auto;
            border: 1px solid #000;

        }
        .modal .import-invoice-insert-modal .modal-content .column  #insert-product-box table, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table{
            /*margin-top: 15px;*/
            font-size: 15px;
            text-align: left;
            width: 750px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-collapse: collapse;
            /*border: 1px solid #000;*/
        }

        .modal  .import-invoice-insert-modal .modal-content .column #insert-product-box table thead, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table thead{
            position: sticky;
            top:0;
            background-color: #009879;
            color: #ffffff;
        }

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table th, 
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table th, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td{
            padding: 10px;
            height: 25px;
        }

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table tbody tr, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table tbody tr{
            border-bottom: 1px solid #dddddd;
        }

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table tbody tr:nth-of-type(odd), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table tbody tr:nth-of-type(odd){
            background-color: #f3f3f3;
        }

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table tbody tr:nth-of-type(even), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table tbody tr:nth-of-type(even){
            background-color: #f3f3f3;
        }


        #insert-search-box #insert-search-result,
        #edit-search-box #edit-search-result{
            position: absolute;
            top: 80px;
            left: 20px;
            z-index: 10;
            width: 270px;
            height: 170px;
            background: #fff;
            display: none;
            border: 1px solid #000;
            box-shadow: 2px 2px 2px solid #000;
            border-radius: 10px;
            padding: 10px;
        }

        #insert-search-box #insert-search-result table,
        #edit-search-box #edit-search-result table

        {
            text-align: left;
        }

        #insert-search-box #insert-search-result table td,
        #insert-search-box #insert-search-result table th,
        #edit-search-box #edit-search-result table td,
        #edit-search-box #edit-search-result table th

        {
            padding: 2px;
        }
        #insert-search-box #insert-search-result td button,
        #edit-search-box #edit-search-result td button
        {
            text-align: right;
        }


        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container {
            position: relative;
            display: inline-block;
            /*border: 1px solid #000;*/
            box-sizing: border-box;
            border-collapse: collapse;
            margin-top: 5px;
        }


        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container #insert-supplier-name,
        .modal .import-invoice-edit-modal .modal-content .column  .row .supplier-container #edit-supplier-name
        {
            display: inline-block;
            width: 250px;
            height: 38px;
            padding: 8px;
            border: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
            margin-bottom: 40px;
        }
        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container #insert-supplier-search-box, 
        .modal .import-invoice-edit-modal .modal-content .column  .row .supplier-container #edit-supplier-search-box{
            position: absolute;
            top: 0px;
            left: 0px;
            height: 170px;
            width: 250px;
            background: #fff;
            /*border: 1px solid #000;*/
            box-shadow: 0px 0px 2px 2px #ccc;
            box-sizing: border-box;   
            display: none;
        }
        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container #insert-supplier-search-box input, 
        .modal .import-invoice-edit-modal .modal-content .column  .row .supplier-container #edit-supplier-search-box input

        {
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
        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container #insert-supplier-box,
        .modal .import-invoice-edit-modal .modal-content .column  .row .supplier-container #edit-supplier-box 

        {
            overflow: auto;
            height: 165px;
            width: 250px;
        }
        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container #insert-supplier-box span,
        .modal .import-invoice-edit-modal .modal-content .column  .row .supplier-container #edit-supplier-box span 

        {
            cursor: pointer;
            display: inline-block;
            width: 245px;
            height: 20px;
            padding: 5px;
            margin: 0px;
        }
        .modal .import-invoice-insert-modal .modal-content .column  .row .supplier-container #insert-supplier-box span:hover,
        .modal .import-invoice-edit-modal .modal-content .column  .row .supplier-container #edit-supplier-box span:hover
        {
            background: #FFCD1F;
            color: #000;
        }

        .container .main-content .top .group-search:nth-of-type(2) {
            position: relative;
        }

        .container .main-content .top .group-search:nth-of-type(2) .time-search,
        .container .main-content .top .group-search:nth-of-type(2) .status-search {
            position: relative;
            /*position: absolute;*/
            width: 230px;
            /*border: 1px solid #ccc;*/
            border: 2px solid #ccc;
            display: inline-block;    
            cursor: pointer;
        }

        .container .main-content .top .group-search:nth-of-type(2) .time-search {
            margin-right: 80px;
        }

        .container .main-content .top .group-search:nth-of-type(2) .time-search #time-range,
        .container .main-content .top .group-search:nth-of-type(2) .status-search #status-box {
            position: absolute;
            top: 31px;
            width: 230px;
            height: 100px;
            z-index: 2;
            background: #fff;
            padding: 5px;
            box-shadow: 0px 0px 2px 2px #ccc;
            box-sizing: border-box;
            display: none;
            transition: 0.3s ease;
        }
        .container .main-content .top .group-search:nth-of-type(2) .time-search #time-range input
        {
            margin-bottom: 5px;
        }
        .container .main-content .top .group-search:nth-of-type(2) .status-search input {
            margin-bottom: 5px;
            margin-right: 5px;
        }

        .container .main-content .top .group-search:nth-of-type(2) .time-search span,
        .container .main-content .top .group-search:nth-of-type(2) .status-search span {
            display: inline-block;
            width: 230px;
            padding: 5px 5px 5px 5px; 

        }

        .container .main-content .top .group-search:nth-of-type(2) .time-search:hover,
        .container .main-content .top .group-search:nth-of-type(2) .status-search:hover {
            box-shadow: 0px 0px 2px 2px #ccc;
        }


    </style>
    <body>
        <div class="header" >
            <h2 class="title" >Phiếu nhập hàng</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="../../slider.jsp" />
        </div>
        <div id ="container" class ="container">
            <div class ="main-content" >
                <div class ="top" >
                    <form action="search" method="POST" > 
                        <div class ="group-search" >
                            <div class ="horizontal-search" >
                                <input type="text" placeholder="Theo mã phiếu nhập hàng" value="${requestScope.invoiceID}" name="id">
                                <button type="button"><i class="fa fa-search"></i></button>         
                            </div>
                            <div class ="btn-add" >
                                <button type="button" onclick="openModal('import-invoice-insert-modal')">Nhập hàng</button>
                            </div>
                        </div>
                        <div class ="group-search" >
                            <div class ="time-search" >
                                <span onclick="openBox('time-range')">Thời gian</span>
                                <div id="time-range">
                                    <table>
                                        <tr>
                                            <td>Từ ngày: </td>
                                            <td> <input type="date" name="from" value="${requestScope.from}" /></td>
                                        </tr>
                                        <tr>
                                            <td>Đếm ngày: </td>
                                            <td><input type="date" name="to" value="${requestScope.to}" /></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><button type="submit" >Tìm kiếm</button></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="status-search" >
                                <span onclick="openBox('status-box')" >Trạng thái</span>
                                <div id="status-box" >
                                    <table>
                                        <tr>
                                            <td><input type="checkbox" name="status" value="0" /></td>
                                            <td>Phiếu tạm</td>
                                        </tr>
                                        <tr>
                                            <td><input type="checkbox" name="status" value="1" /></td>
                                            <td>    Đã nhập hàng</td>
                                        </tr>
                                        <tr>
                                            <td> <input type="checkbox" name="status" value="2" /></td>
                                            <td>Đã hủy</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class ="middle" >
                    <table>
                        <thead>
                            <tr>
                                <td>Mã nhập hàng</td>
                                <td>Thời gian</td>
                                <td>Nhà cung cấp</td>
                                <td>Tổng tiền hàng</td>
                                <td>Ghi chú</td>
                                <td>Trạng thái</td>
                                <td>Hàng động</td>
                            </tr>
                        </thead>
                        <tbody id="import-invoice-list">
                            <c:set var="import-invoices" value="${requestScope.importInvoices}" ></c:set>
                            <c:forEach begin="0" end="${importInvoices.size()}" items="${importInvoices}" var="ii" >
                                <tr>
                                    <td>${ii.importInvoiceID}</td>
                                    <td>${ii.date}</td>
                                    <td>${ii.supplier.supplierName}</td>
                                    <td>${ii.getTotal()}</td>
                                    <td>${ii.description}</td>
                                    <td>
                                        <c:if test="${ii.status == -1}"  >
                                            Đã hủy
                                        </c:if> 
                                        <c:if test="${ii.status == 0}"  >
                                            Phiếu tạm
                                        </c:if> 
                                        <c:if test="${ii.status == 1}"  >
                                            Đã nhập hàng
                                        </c:if> 
                                    </td>
                                    <td>
                                        <c:if test="${ii.status == -1}"  >

                                        </c:if> 
                                        <c:if test="${ii.status >= 0}"  >
                                            <button onclick="editInvoice()">Edit</button>
                                        </c:if> 
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
            <div class ="import-invoice-insert-modal" id ="import-invoice-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm hóa đơn</h2>
                    <button class ="btn-close" onclick="closeModal('import-invoice-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form id="invoice-form" action ="insert" method ="POST" >
                        <div class="column"  > 
                            <div class="row" >
                                <label>Ngày nhập</label> <br />
                                <input type="date" value="${requestScope.today}" name="date" />
                            </div>
                            <div class="row" >
                                <label>Nhà cung cấp</label> <br />
                                <div class ="supplier-container">
                                    <span onclick="openBox('insert-supplier-search-box')" id="insert-supplier-name" >---Chọn nhà cung cấp---</span>
                                    <input id ="insert-supplier-id" name ="supplierID" type ="hidden" />
                                    <div id = "insert-supplier-search-box">
                                        <input type ="text" onkeyup="searchSupplier('insert', this.value)"  placeholder="Tìm kiếm nhà cung cấp"/>
                                        <div id="insert-supplier-box" >
                                            <table>
                                                <c:forEach var="c" begin="0" end="${suppliers.size()}" items="${suppliers}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.supplierID}', '${c.supplierName}', 'insert')" class ="supplier-value">${c.supplierName}</span></td>
<!--                                                        <td><button class="action" type="button" onclick="edit(${c.supplierID}, 'supplier')" ><i class="fa fa-pencil" ></i></button></td>-->
                                                        <!--<td><button class="action" type ="button" onclick="deleteEntity(${c.supplierID}, 'supplier')"><i class ="fa fa-trash" ></i> </button></td>-->
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                    <button type="button" onclick="openModal('supplier-insert-modal')"  class ="btn-add"><i class="fa fa-plus" ></i></button>
                                </div>
                            </div >
                            <div class="row" >
                                <label>Tổng tiền hàng</label> <br />
                                <input id="insert-total" type="text" name="totalAmount" />
                            </div>
                            <div class="row" >
                                <label>Ghi chú</label><br />
                                <textarea id="insert-desciption" name="desciption" rows="4" cols="31"></textarea>
                            </div>
                        </div>
                        <div class="column"  > 
                            <div id="insert-search-box" class="row" >
                                <label>Thêm hàng vào hóa đơn</label> <br />
                                <input onkeyup ="productSearch('insert', this.value)" type="text" 
                                       name="searchProduct" class="search-product" 
                                       placeholder="Tìm kiếm hàng hóa bằng mã hàng hoặc tên hàng"/>
                                <div class="search-result" id="insert-search-result"  >
                                </div>
                            </div>
                            <div id ="insert-product-box" >
                                <table>
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>STT</th>
                                            <th>Mã hàng</th>
                                            <th>Tên hàng</th>
                                            <td>ĐVT</td>
                                            <th>Đơn giá</th>
                                            <th>Số lương</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody id="insert-product-list" >

                                    </tbody>
                                </table>
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
            <div class ="import-invoice-edit-modal" id ="import-invoice-edit-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm hóa đơn</h2>
                    <button class ="btn-close" onclick="closeModal('import-invoice-edit-modal')" >x</button>
                </div>
                <div class ="modal-content" >
                    <form id="invoice-edit-form" action ="insert" method ="POST" >
                        <div class="column"  > 
                            <div class="row" >
                                <label>Ngày nhập</label> <br />
                                <input type="date"  name="date" class ="import-invoice-edit" />
                            </div>
                            <div class="row" >
                                <label>Nhà cung cấp</label> <br />
                                <div class ="supplier-container">
                                    <span  id="edit-supplier-name" class ="import-invoice-edit" onclick="openBox('edit-supplier-search-box')"  ></span>
                                    <input id ="edit-supplier-id" name ="supplierID" type ="hidden" class ="import-invoice-edit" />
                                    <div id = "edit-supplier-search-box">
                                        <input type ="text" onkeyup="searchSupplier('edit', this.value)"  placeholder="Tìm kiếm nhà cung cấp"/>
                                        <div id="edit-supplier-box" >
                                            <table>
                                                <c:forEach var="c" begin="0" end="${suppliers.size()}" items="${suppliers}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.supplierID}', '${c.supplierName}', 'edit')" class ="supplier-value">${c.supplierName}</span></td>
<!--                                                        <td><button class="action" type="button" onclick="edit(${c.supplierID}, 'supplier')" ><i class="fa fa-pencil" ></i></button></td>-->
                                                        <!--<td><button class="action" type ="button" onclick="deleteEntity(${c.supplierID}, 'supplier')"><i class ="fa fa-trash" ></i> </button></td>-->
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                    <button type="button" onclick="openModal('supplier-insert-modal')"  class ="btn-add"><i class="fa fa-plus" ></i></button>
                                </div>
                            </div >
                            <div class="row" >
                                <label>Tổng tiền hàng</label> <br />
                                <input id="edit-total" type="text" name="totalAmount"  class ="import-invoice-edit"/>
                            </div>
                            <div class="row" >
                                <label>Ghi chú</label><br />
                                <textarea id="edit-desciption" name="desciption" rows="4" cols="31" class ="import-invoice-edit"  ></textarea>
                            </div>
                        </div>
                        <div class="column"  > 
                            <div id="edit-search-box" class="row" >
                                <label>Thêm hàng vào hóa đơn</label> <br />
                                <input onkeyup ="productSearch('edit', this.value)" type="text" 
                                       name="searchProduct" class="search-product" 
                                       placeholder="Tìm kiếm hàng hóa bằng mã hàng hoặc tên hàng"/>
                                <div class="search-result" id="edit-search-result"  >
                                </div>
                            </div>
                            <div id ="edit-product-box" >
                                <table>
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>STT</th>
                                            <th>Mã hàng</th>
                                            <th>Tên hàng</th>
                                            <td>ĐVT</td>
                                            <th>Đơn giá</th>
                                            <th>Số lương</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody id="edit-product-list" >

                                    </tbody>
                                </table>
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
            <div class ="supplier-insert-modal" id ="supplier-insert-modal" >
                <div class ="modal-header" >
                    <h2 class ="title" >Thêm nhà cung cấp</h2>
                    <button class ="btn-close" onclick="closeModal('supplier-insert-modal')" >x</button>
                </div>
                <div class ="modal-content" > 
                    <form action="" >
                        <!--<span>Brand Name</span>-->
                        <input type ="text" placeholder="Tên nhà cung cấp hiệu" name ="supplierName" id ="supplier-insert-input"  class ="supplier-insert" /> 
                    </form>
                </div>
                <div onclick="insert('supplier-insert')" class ="btn-save"> <span>Save</span></div>
            </div>
        </div>
    </body>
    <script>

        pagger('pagger',${requestScope.pageIndex},
        ${requestScope.selectedPageSize},
        ${requestScope.totalPage}, 2);

        var ordinalNumber = 0;



        function submitPageSize(id) {
            var size = document.getElementById(id).value;
            window.location.href = "?pageIndex=1&pageSize=" + size;
        }
        function openModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'import-invoice-insert-modal') {
                modal[0].style.transform = "scale(1)";
            } else if (id === 'import-invoice-edit-modal') {
                modal[1].style.transform = "scale(1)";
            }
            box.style.transform = "scale(1)";
        }

        function closeModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'import-invoice-insert-modal') {
                modal[0].style.transform = "scale(0)";
            } else if (id === 'import-invoice-edit-modal') {
                modal[1].style.transform = "scale(0)";
            }
            box.style.transform = "scale(0)";
            var input = id.split('-modal')[0];
            if (id !== 'import-invoice-edit-modal') {
                clearInputData(input);
            }
        }

        function openBox(id) {
            var box = document.getElementById(id);
            if (box.style.display == 'block') {
                box.style.display = "none";
            } else {
                box.style.display = "block";
            }
        }

        function clearInputData(type) {
            var list = document.getElementById(type + '-product-list');
            list.innerHTML = "";
            var search = document.getElementById(type + '-search-product');
            search.value = "";
        }

        function closeBox(id) {
            var box = document.getElementById(id);
            box.style.display = "none";
            if (id !== "insert-supplier-search-box") {
                var search = document.getElementById('search-product');
                search.value = "";
                box.innerHTML = "";
            }
        }

        pagger('pagger',${requestScope.pageIndex},
        ${requestScope.selectedPageSize},
        ${requestScope.totalPage}, 2);


        function edit(id) {
            var url = "edit?id=" + id;
            var edit = document.getElementsByClassName('import-invoice-edit');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var arr = result.split('|');
                edit[0].innerHTML = 'II000' + arr[0];
                for (var i = 1, max = arr.length; i < max; i++) {
                    edit[i].value = arr[i];
                }
            });
            openModal('import-invoice-edit-modal');
        }

        function generateRow(title, value) {
            var str = "";
            str += "<tr>";
            str += "<th>" + title + "</th>";
            str += "<td>" + value + "</td>";
            str += "</tr>";
            return str;
        }

        function generateContent(type, data) {
            var str = "";
            str += "<table>";
            str += generateRow('Mã hàng', data[0]);
            str += generateRow('Tên hàng', data[2]);
            str += generateRow('Nhóm hàng', data[4]);
            str += generateRow('Thương hiệu', data[5]);
            str += generateRow('Giá nhập', data[6]);
            str += generateRow('Giá bán', data[5]);
            str += "<tr>";
            str += "<td></td>";
            str += "<td>"
            str += "<button type=\"button\" onclick =\"addTo('" + type + "'," + data[0] + ")\">Thêm</button>"
            str += "<button  type=\"button\" onclick =\"closeBox('" + type + "-search-result')\" >Bỏ qua</button>";
            str += "</td>";
            str += "</tr>";
            str += "</table>";
            return str;
        }


        function concatProduct(type, data) {
            var str = "";
            str += "<tr id = \"" + type + "-" + ordinalNumber + "\" >";
            str += "<td>" + " <button type =\"button\" onclick=\"deleteFrom('" + type + "','" + type + "-" + ordinalNumber + "')\"><i class =\"fa fa-trash\" ></i></button>" + "</td>";
            str += "<td>" + ordinalNumber + "</td>";
            str += "<td>" + data[0] + "<input type=\"hidden\" name = \"id\" value = \""
                    + data[0] + "\"" + "</td>";
            str += "<td>" + data[2] + "</td>";
            str += "<td>" + data[5] + "</td>";
            str += "<td>" + data[6] + "</td>";
            str += "<td><input onkeyup = \"setAmount('" + type + "',this.value,'" + type + "-" + ordinalNumber + "')\" type=\"text\" name = \"quantity\"  /></td>";
            str += "<td></td>";
            str += "</tr>";
//            alert(type + "-" + ordinalNumber);
            return str;
        }

        function setAmount(type, quantity, id) {
            var product = document.getElementById(id);
            var childs = product.childNodes;
            var unitPrice = parseFloat(childs[5].innerHTML);
            var enterQuantity = parseInt(quantity);
            var amount = unitPrice * enterQuantity;
            if (quantity !== "") {
                childs[7].innerHTML = amount;
            } else {
                childs[7].innerHTML = "";
            }

            setTotalAmount(type);
        }

        function setTotalAmount(type) {
            var totalAmount = 0;
            for (var i = 1, max = ordinalNumber; i <= max; i++) {
                var product = document.getElementById(type + "-" + i);
                var childs = product.childNodes;
                var currentAmount = childs[7].innerHTML;
                if (currentAmount !== "") {
                    var amount = parseFloat(currentAmount);
                    totalAmount += amount;
                }
            }
            var total = document.getElementById(type + '-total');
            total.value = totalAmount;
        }



        function searchSupplier(type, keyword) {
            var url = "../../supplier/search?keyword=" + keyword;
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var box = document.getElementById(type + "-supplier-box");
                if (result === "") {
                    box.innerHTML = "Không tìm thấy nhà cung cấp!"
                    return;
                }
                box.innerHTML = result;
            });
        }


        function productSearch(type, productID) {
//            alert('dm');
            var url = "../../product/search?id=" + productID;
            var searchResult = document.getElementById(type + '-search-result');
            var data;
            var str = "";
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                data = result.split('|');
                if (data.length === 10) {
                    str = generateContent(type, data);
                } else {
                    str += "<span>Không tìm thấy hàng hóa!<span><br/>";
                    str += "<button onclick =\"closeBox('search-result')\" >Bỏ qua</button>";
                }
                searchResult.innerHTML = str;
            });


            if (productID !== "") {
                searchResult.style.display = "block";
            } else {
                searchResult.style.display = "none";
            }
        }

        function addTo(type, productID) {
            var list = document.getElementById(type + "-product-list");
            var url = "../../product/search?id=" + productID;
            var data;
            var str = "";
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                data = result.split('|');
                if (data.length === 10) {
                    ordinalNumber += 1;
                    str = concatProduct(type, data);
                }
                list.innerHTML += str;
            });
            closeBox(type + '-search-result');
            var search = document.getElementById(type + '-search-product');
            search.value = "";
        }

        function deleteFrom(type, position) {
            var list = document.getElementById(type + "-product-list");
            var removeChild = document.getElementById(type + "-" + position);
            var childs = list.childNodes;
            list.removeChild(removeChild);
            for (var i = 0, max = childs.length; i < max; i++) {
                var childId = childs[i].id;
                var currentId = parseInt(childId.split("-")[1]);
                if (currentId > position) {
                    var ch = childs[i].childNodes;
                    currentId -= 1;
                    childs[i].id = currentId;
                    ch[1].innerHTML = currentId;
                    var newChild = document.createElement('td');
                    newChild.innerHTML = "<button type = \"button\" onclick = \"deleteFrom('" + type + "'," + currentId + ")\"><i class=\"fa fa-trash\" ></i></button>";
                    childs[i].replaceChild(newChild, ch[0]);
                }
            }
            ordinalNumber -= 1;
            setTotalAmount(type);
        }


        function setValue(idValue, nameValue, id) {
            var inputId = document.getElementById(id + '-supplier-id');
            var inputName = document.getElementById(id + '-supplier-name');
            inputId.value = idValue;
            inputName.innerHTML = nameValue;
            closeBox(id + "-supplier-search-box");
        }

    </script>
</html>
