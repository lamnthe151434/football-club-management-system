<%-- 
    Document   : list
    Created on : Mar 5, 2022, 10:38:45 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
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


        .container .main-content .middle {
            margin-left: 15px;
            width: 1200px;
            height: 450px;
            overflow: auto;
        }
        .container .main-content .middle table {
            /*margin-top: 15px;*/
            font-size: 17px;
            text-align: left;
            width: 1200px;
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
            width: 150px;
            padding: 10px;
            word-wrap: break-word;    
        }

        .container .main-content .middle table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .container .main-content .middle table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .modal .import-invoice-insert-modal, 
        .modal .import-invoice-edit-modal,
        .modal .import-invoice-view-modal{
            position: absolute;
            padding: 15px 35px 15px 35px;
            border-radius: 10px;
            background: #FDFDFE;
            transform: scale(0);
            transition-duration: 0.5s;
            z-index: 99;
            top: 5vh;
            left: 15vh;
            width: 82vw;
            height: 84.5vh;
        }
        .modal .import-invoice-insert-modal .modal-content,
        .modal .import-invoice-edit-modal .modal-content,
        .modal .import-invoice-view-modal .modal-content{
            margin-top: 25px;
            width: 100%;
        }
        .modal .import-invoice-insert-modal .modal-content .btn-group,
        .modal .import-invoice-edit-modal .modal-content .btn-group,
        .modal .import-invoice-view-modal .modal-content .btn-group{
            clear: both;
        }


        .modal .import-invoice-insert-modal .modal-content .column,
        .modal .import-invoice-edit-modal .modal-content .column,
        .modal .import-invoice-view-modal .modal-content .column{
            display: inline-block;
            /*border: 1px solid #000;*/
            /*padding: 10px;*/
        }

        /*        .modal-content {
                    border: 1px solid #ccc;
                }*/

        .modal .import-invoice-insert-modal .modal-content .column:nth-of-type(2),
        .modal .import-invoice-edit-modal .modal-content .column:nth-of-type(2),
        .modal .import-invoice-view-modal .modal-content .column:nth-of-type(2){
            width: 800px;
            height: 518px;
            float: right;
            /*margin-left: 50px;*/
            /*padding-left: 20px;*/
            /*padding-right: 20px;*/
            box-sizing: border-box;
            border: 1px solid #000;
            box-shadow: 0px 0px 2px 2px #ccc;
            border-radius: 10px;


        }

        .modal .import-invoice-insert-modal .modal-content .column:nth-of-type(2) span,
        .modal .import-invoice-edit-modal .modal-content .column:nth-of-type(2) span,
        .modal .import-invoice-view-modal .modal-content .column:nth-of-type(2) span {
            width: 100%;
            height: 30px;
            display: inline-block;
            text-align: center;
            padding-top: 10px;
            /*border: 1px solid #000;*/
        }

        /*        .modal .import-invoice-insert-modal .modal-content {
                    width: 75vw;
                    border: 1px solid #000;
                }*/

        .modal .import-invoice-insert-modal .modal-content .column:nth-of-type(1),
        .modal .import-invoice-edit-modal .modal-content .column:nth-of-type(1),
        .modal .import-invoice-view-modal .modal-content .column:nth-of-type(1) {
            float: left;
            border: 1px solid blue;
            box-shadow: 0px 0px 2px 2px #ccc;
            padding: 10px 20px 25px 20px;
            box-sizing: border-box;
            border-radius: 10px;

        }



        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info td input,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info td input
        {
            width: 180px;
            height: 35px;
            outline: none;
            border:none;
            border-bottom: 1px solid blue;
            padding-left: 8px;
            box-sizing: border-box;

        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info td input:focus,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info td input:focus
        {
            box-shadow: 0px 2px #ccc;

        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info td span,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info td span,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info td span
        {
            display: inline-block;
            width: 180px;
            height: 37px;
            border-bottom: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
        }

        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info textarea, 
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info textarea,
        .modal .import-invoice-view-modal .modal-content .column .edit-invoice-info textarea
        {
            width: 180px;
            height: 37px;
            overflow: scroll;
            resize: none;
            border:none;
            outline: none;
            border-bottom: 1px solid blue;
        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info textarea:focus, 
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info textarea:focus,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info textarea:focus
        {            box-shadow: 0px 2px #ccc;

        }


        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info  td ,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info  td ,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info  td 

        {
            padding: 1px;
            box-sizing: border-box;
        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info  td:nth-child(1),
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info  td:nth-child(1),
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info  td:nth-child(1)

        {
            width: 155px;
        }


        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info tr:nth-child(12) td ,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td ,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info tr:nth-child(12) td 

        {
            padding-top: 15px;
            /*border: 1px solid #000;*/
            box-sizing: border-box;
            text-align: center;
            justify-content: space-between;
        }

        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info tr:nth-child(12) td button,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td button,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info tr:nth-child(12) td button

        {
            padding: 5px;
            text-align: center;
            width: 155px;
            border-radius: 5px;
            color: #fff;

        }
        /*        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td button,
                {
                    width: 103px;
                }*/

        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info tr:nth-child(12) td button:hover ,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td button:hover ,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info tr:nth-child(12) td button:hover {
            box-shadow: 0px 0px 2px 2px #ccc;
        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info tr:nth-child(12) td button:nth-of-type(1) ,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td button:nth-of-type(1) ,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info tr:nth-child(12) td button {
            background: #0090DA;
            margin-right: 20px;
        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info tr:nth-child(12) td:nth-child(1) button:nth-of-type(2) ,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td:nth-child(1) button:nth-of-type(2) ,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info tr:nth-child(12) td:nth-child(1) button {
            background: rgb(0, 255, 0);
            margin-right: 20px;

        }

        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info tr:nth-child(12) td:nth-child(1) button:nth-of-type(3)
        {
            background: rgb(255, 0, 0);

        }



        .modal .import-invoice-insert-modal .modal-content .column .row .search-product, 
        .modal .import-invoice-edit-modal .modal-content .column .row .search-product {
            width: 100%;
            margin-bottom: 0px; 
            /*margin-top: 20px;*/
            padding: 10px;
            box-sizing: border-box;

        }



        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box,
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box,
        .modal .import-invoice-view-modal .modal-content .column #view-product-box

        {
            width: 100%;
            height: 77.7%;
            overflow: auto;
        }

        /*        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box {
                    height: 390px;
                }
                .modal .import-invoice-edit-modal .modal-content .column #edit-product-box {
                    height: 380px;
                }
        
                .modal .import-invoice-view-modal .modal-content .column #view-product-box {
                    height: 460px;
                }*/

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box,
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box {
            margin-top: 32px;
        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-invoice-info span,
        .modal .import-invoice-edit-modal .modal-content .column .edit-invoice-info span,
        .modal .import-invoice-view-modal .modal-content .column .view-invoice-info span {
            display: inline-block;
            width: 180px;
            height: 35px;
            padding: 8px 8px 0px 8px;
            border-bottom: 1px solid #000;
            box-sizing: border-box;
            cursor: pointer;
            word-wrap: break-word;
        }


        #insert-search-box, 
        #edit-search-box{
            position: relative;
        }
        #insert-search-box #insert-search-result,
        #edit-search-box #edit-search-result
        {
            padding: 0px;
            width: 100%;
            position: absolute;
            top: 40px;
            border: 1px solid #000;
            box-shadow: 0px 0px 2px 2px #ccc;
            height: 75px;
            cursor: pointer;
            overflow: auto;
            z-index: 11;
            background: #fff;
            box-sizing: border-box;
            display: none;
        }
        #insert-search-box #insert-search-result span,
        #insert-search-box #insert-search-result .no-result span,
        #edit-search-box #edit-search-result span,
        #edit-search-box #edit-search-result .no-result span
        {
            display: inline-block;
            margin-right: 10px; 
            width: 170px;
            /*border: 1px solid #000;*/
            padding: 5px;
            text-align: left;
        }

        #insert-search-box #insert-search-result .product-result:hover ,
        #insert-search-box #insert-search-result .product-result:hover 
        {
            background: #ccc;
        }
        #insert-search-box #insert-search-result .product-result ,
        #edit-search-box #edit-search-result .product-result
        {
            padding: 5px;
            /*border: 1px solid #000;*/
            height: 65px;
            cursor: pointer;


        }

        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer ,
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer 
        {
            position: absolute;
            top: 270px;
            left: 220px;
        }
        .modal .import-invoice-insert-modal .modal-content .column .insert-discount-box ,
        .modal .import-invoice-edit-modal .modal-content .column .edit-discount-box 
        {
            position: absolute;
            top: 220px;
            left: 135px;
            padding: 20px;
            background: #fff;
            display: none;
            box-shadow: 0px 0px 2px 2px #ccc;
            border-radius: 5px;

        }

        .insert-discount-box label ,
        .edit-discount-box label 
        {
            display: inline-block;
            /*padding: 20px;*/
            width: 70px;
            border: none;
            height: 20px;
            margin: 0px;
            /*border: 1px solid #000;*/

        }

        .insert-discount-box span,
        .edit-discount-box span
        {
            display: inline-block;
            /*padding: 20px;*/
            width: 40px;
            padding: 3px;
            border-radius: 5px;
            border: none;
            height: 20px;
            margin: 0px;
            background: gray;
            color: #fff;
            cursor: pointer;
            text-align: center;
        }
        .insert-discount-box span:hover ,
        .edit-discount-box span:hover 
        {
            background: #ccc;
        }

        .insert-discount-box input,
        .edit-discount-box input
        {
            width: 100px;
            padding: 4px;
        }


        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer .supplier-container,
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer .supplier-container
        {
            position: relative;
            display: inline-block;
            /*border: 1px solid #000;*/
            box-sizing: border-box;
            border-collapse: collapse;
        }



        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer .supplier-container #insert-supplier-search-box, 
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer .supplier-container #edit-supplier-search-box{
            position: absolute;
            top: 0px;
            left: 0px;
            height: 170px;
            width: 180px;
            background: #fff;
            /*border: 1px solid #000;*/
            box-shadow: 0px 0px 2px 2px #ccc;
            box-sizing: border-box;   
            display: none;
        }
        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer .supplier-container #insert-supplier-search-box input, 
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer .supplier-container #edit-supplier-search-box input

        {
            width: 170px;
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
        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer .supplier-container #insert-supplier-box,
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer .supplier-container #edit-supplier-box 

        {
            overflow: auto;
            height: 165px;
            width: 180px;
        }
        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer .supplier-container #insert-supplier-box span,
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer .supplier-container #edit-supplier-box span 

        {
            cursor: pointer;
            display: inline-block;
            width: 180px;
            height: 38px;
            padding: 5px;
            margin: 0px;
            border: none;
        }
        .modal .import-invoice-insert-modal .modal-content .column .supplier-container-outer .supplier-container #insert-supplier-box span:hover,
        .modal .import-invoice-edit-modal .modal-content .column .supplier-container-outer .supplier-container #edit-supplier-box span:hover
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



        .modal .import-invoice-insert-modal .modal-content .column  #insert-product-box table, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table,
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table
        {
            table-layout: fixed;
            font-size: 15px;
            text-align: left;
            width: 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-collapse: collapse;
            /*border: 1px solid #000;*/
        }

        .modal  .import-invoice-insert-modal .modal-content .column #insert-product-box table thead, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table thead,
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table thead

        {
            position: sticky;
            top:0;
            background-color: #009879;
            color: #ffffff;
        }

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td,
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td

        {
            word-wrap: break-word;
            padding: 10px;
            height: 25px;
        }


        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table tbody tr:nth-of-type(even), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table tbody tr:nth-of-type(even),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table tbody tr:nth-of-type(even)
        {
            background-color: #f3f3f3;
        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td input, 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td input,
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td input
        {
            padding-left: 5px;
            padding-top: 3px;
            padding-bottom: 3px;
            padding-right: 5px;
            width: 120px;
        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(1), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(1) {
            width: 10px;
            text-align: center;
        }


        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(2), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(2),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(1) 
        {
            width: 22px;
        }

        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(3), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(3),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(2)
        {
            width: 65px;
        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(4), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(4),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(3),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(4),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(5)

        {
            width: 65px;

        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(5), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(5)
        {
            width: 50px;
        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(6), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(6)
        {
            width: 50px;
        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(7), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(7),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(7)
        {
            width: 135px;
        }
        .modal .import-invoice-insert-modal .modal-content .column #insert-product-box table td:nth-child(8), 
        .modal .import-invoice-edit-modal .modal-content .column #edit-product-box table td:nth-child(8),
        .modal .import-invoice-view-modal .modal-content .column #view-product-box table td:nth-child(6)
        {
            width: 70px;
        }



        label {
            display: inline-block;
            width: 170px;
            border: 1px solid #000;
            height: 37px;
            margin: 0px;
        }


        .search-result{
            padding: 5px;
            /*border: 1px solid #000;*/
            height: 65px;
            cursor: pointer;


        }

        .search-result span, 
        .container .top .result .no-result span{
            display: inline-block;
            margin-right: 10px; 
            width: 170px;
            /*border: 1px solid #000;*/
            padding: 5px;

        }




    </style>
    <body>
        <div class="header" >
            <h2 class="title" >Phiếu nhập hàng</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="../../slider.jsp" />
        </div>
        <div class="search-section" >
            <form id="search-form" action="list" method="POST" >
                <input type="hidden" id="search-key" name ="searchKey" value="${requestScope.searchKey}" />
                <input type="hidden" id="from-date"  value="${requestScope.from}" name="from" />
                <input type="hidden" id="to-date" value="${requestScope.to}" name="to" />
                <input type="hidden" name="status" value="${requestScope.statuses}" />
                <input type="hidden" id="page-index" value="${requestScope.pageIndex}"  name="pageIndex" />
                <input type="hidden" id="page-size" value="${requestScope.selectedPageSize}"  name="pageSize"  />
            </form>
        </div>
        <div id ="container" class="container">
            <div class="main-content" >
                <div class="top" >
                    <div class="group-search" >
                        <div class="horizontal-search" >
                            <input id="search-bar" type="text" placeholder="Theo mã phiếu nhập hàng" value="${requestScope.searchKey}" name="id">
                            <button onclick="setSearchKey('search-key', 'search-bar')"><i class="fa fa-search"></i></button>         
                        </div>
                        <div class="btn-add" >
                            <button type="button" onclick="openModal('import-invoice-insert-modal')">Nhập hàng</button>
                        </div>
                    </div>
                    <div class="group-search" >
                        <div class="time-search" >
                            <span onclick="openBox('time-range')">Thời gian</span>
                            <div id="time-range">
                                <table>
                                    <tr>
                                        <td>Từ ngày: </td>
                                        <td> <input id="from" type="date" name="from" value="${requestScope.from}" /></td>
                                    </tr>
                                    <tr>
                                        <td>Đếm ngày: </td>
                                        <td><input id="to" type="date" name="to" value="${requestScope.to}" /></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><button type="button" onclick="setDate('search-form')" >Tìm kiếm</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="status-search" >
                            <span onclick="openBox('status-box')" >Trạng thái</span>
                            <div id="status-box" >
                                <table>
                                    <tr>
                                        <td><input type="checkbox" name="status" value="1" 
                                                   <c:if test="${requestScope.statuses.contains('1')}" >
                                                       checked ="checked"
                                                   </c:if>          
                                        </td>
                                        <td>Phiếu tạm</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="status" value="2" 
                                                   <c:if test="${requestScope.statuses.contains('2')}" >
                                                       checked ="checked"
                                                   </c:if>/></td>
                                        <td>    Đã nhập hàng</td>
                                    </tr>
                                    <tr>
                                        <td> <input type="checkbox" name="status" value="0"
                                                    <c:if test="${requestScope.statuses.contains('0')}" >
                                                        checked ="checked"
                                                    </c:if> /></td>
                                        <td>Đã hủy</td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><button type="button" onclick="setCheckboxes('status', 'search-form')" >Tìm kiếm</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="middle" >
                    <c:if test="${requestScope.importInvoices.size() > 0}" >
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
                                <c:set var="position" value="0" ></c:set>
                                <c:forEach begin="0" end="${importInvoices.size()}" items="${importInvoices}" var="ii" >
                                    <tr>
                                        <td>PN0${ii.importInvoiceID}</td>
                                        <td>${ii.date}</td>
                                        <td>${ii.supplier.supplierName}</td>
                                        <td>${ii.getMustPay()}</td>
                                        <td>${ii.description}</td>
                                        <td>
                                            <c:if test="${ii.status == 0}"  >
                                                Đã hủy
                                            </c:if> 
                                            <c:if test="${ii.status ==1}"  >
                                                Phiếu tạm
                                            </c:if> 
                                            <c:if test="${ii.status ==2}"  >
                                                Đã nhập hàng
                                            </c:if> 
                                        </td>
                                        <td >
                                            <c:if test="${ii.status == 0}"  >
                                                <button onclick="viewInvoice(${ii.importInvoiceID})">
                                                    <i class="fa fa-eye" ></i>
                                                </button>
                                            </c:if> 
                                            <c:if test="${ii.status >=1}"  >
                                                <button onclick="viewInvoice(${ii.importInvoiceID})">
                                                    <i class="fa fa-eye" ></i>
                                                </button>
                                                <button onclick="editInvoice(${ii.importInvoiceID}, ${position})">
                                                    <i class="fa fa-pencil" ></i>
                                                </button>
                                            </c:if> 
                                        </td>
                                    </tr>
                                    <c:set var="position" value="${position + 1}" ></c:set>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${requestScope.importInvoices.size() == 0}" >
                        <p>Không tìm thấy kết quả</p>
                    </c:if>
                </div>
                <c:if test="${requestScope.importInvoices.size() >= 10 || requestScope.pageIndex >= 2}" >
                    <div class="bottom" >
                        <div class="pageSize" >
                            Số bản ghi <select id="pageSize" name ="pageSize" id ="pageSize" onchange="setPageSize('pageSize')">
                                <c:set var="pageSizeOptions" value="${requestScope.pageSizeOptions}" ></c:set>  
                                <c:set var="selectedPageSize" value="${requestScope.selectedPageSize}" ></c:set>
                                <c:forEach var="pageSize" begin="0" end="${pageSizeOptions.size()}" items="${pageSizeOptions}" >
                                    <option value ="${pageSize}" 
                                            <c:if test="${selectedPageSize ==pageSize}" > 
                                                selected="selected"
                                            </c:if>> ${pageSize}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <span>${requestScope.track}</span>
                        <div class="pagger" id ="pagger" > </div>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="modal" >
            <div class="import-invoice-insert-modal" id ="import-invoice-insert-modal" >
                <div class="modal-header" >
                    <h2 class="title" >Thêm phiếu</h2>
                    <button class="btn-close" onclick="closeModal('import-invoice-insert-modal')" >x</button>
                </div>
                <div class="modal-content" >
                    <form id="insert-form" action ="insert" method ="POST" >
                        <div class="column"  > 
                            <table class="insert-invoice-info" >
                                <tr>
                                    <td colspan="2" style="text-align: center;" >Thông tin phiếu</td>
                                </tr>
                                <tr>
                                    <td>Mã phiếu nhập</td>
                                    <td>
                                        <span class="import-invoice-insert">Mã tự động</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Trạng thái</td>
                                    <td>
                                        <span class="import-invoice-insert">Phiếu tạm</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ngày nhập</td>
                                    <td>
                                        <input type="date" value="${requestScope.today}" class="import-invoice-insert" name="date" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nhà cung cấp</td>
                                    <td>
                                        <span class="import-invoice-insert" onclick="openBox('insert-supplier-search-box')" id="insert-supplier-name" >---Chọn nhà cung cấp---</span>
                                        <button type="button" onclick="openModal('supplier-insert-modal')"  class="btn-add"><i class="fa fa-plus" ></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tổng tiền hàng</td>
                                    <td>
                                        <span id="insert-total" class="import-invoice-insert">0</span>
                                        <input type="hidden" class="import-invoice-insert" id="insert-total-amount" name="totalAmount" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Giảm giá</td>
                                    <td> 
                                        <span onclick="openBox('insert-discount-box')" class="import-invoice-insert" id="insert-discount">0</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Cần trả nhà cung cấp</td>
                                    <td>
                                        <span class="import-invoice-insert" id="insert-pay">0</span>
                                        <input type="hidden" class="import-invoice-insert" id="insert-must-pay" name="mustPay" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tiền trả nhà cung cấp</td>
                                    <td> 
                                        <input id="insert-paid" type="text" onkeyup="setPaid('insert', this.value)" class="import-invoice-insert" name="paid" value="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tiền thừa nhận từ nhà cung cấp</td>
                                    <td>
                                        <span class="import-invoice-insert" id="insert-return">0</span>
                                        <input type="hidden" class="import-invoice-insert" id="insert-return-money" name="returnMoney" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ghi chú</td>
                                    <td>
                                        <textarea id="insert-desciption" name="desciption" rows="4" cols="31" class="import-invoice-insert"  ></textarea>
                                    </td>
                                </tr>
                                <tr>

                                    <td id="button-group" colspan="2" class="import-invoice-insert">
                                        <input id="insert-status" type="hidden" name ="status" />
                                        <button type="submit" onclick="checkInput('insert-form', 'insert-status', '1')">LƯU TẠM</button>
                                        <button type="submit" onclick="checkInput('insert-form', 'insert-status', '2')">HOÀN THÀNH</button>
                                    </td>

                                </tr>
                            </table>
                            <div class="insert-discount-box" id="insert-discount-box" >
                                <label>Giảm giá</label>
                                <input class="import-invoice-insert" id="insert-discount-input" onkeyup="setDiscount('insert', this.value)" type="text" name="discount" value="0"  /> 
                                <input type="hidden" id="insert-sign" value="1" name="discountType"   /> 
                                <span onclick="setSign('insert', '1')" class="insert-sign" >VND</span>
                                <span onclick="setSign('insert', '0')" class="insert-sign"  >%</span>
                            </div>
                            <div class="supplier-container-outer">
                                <div class="supplier-container">
                                    <input class="import-invoice-insert" id ="insert-supplier-id" name ="supplierID" type ="hidden" />
                                    <div id ="insert-supplier-search-box">
                                        <input type ="text" onkeyup="searchSupplier('insert', this.value)"  placeholder="Tìm kiếm nhà cung cấp"/>
                                        <div id="insert-supplier-box" >
                                            <table>
                                                <c:forEach var="c" begin="0" end="${suppliers.size()}" items="${suppliers}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.supplierID}', '${c.supplierName}', 'insert')" class="supplier-value">${c.supplierName}</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="column"  > 
                            <span>Thêm hàng vào phiếu nhập hàng</span>
                            <div id="insert-search-box" class="row" >
                                <!--<label>Thêm hàng vào hóa đơn</label> <br />-->
                                <input id="insert-search-bar" onkeyup ="productSearch('insert', this.value)" type="text" 
                                       name="searchProduct" class="search-product" 
                                       placeholder="Tìm kiếm hàng hóa theo mã hàng"/>
                                <div class="search-result" id="insert-search-result"  >
                                </div>
                            </div>
                            <div id ="insert-product-box" >
                                <div class="wrapper" >
                                    <table>
                                        <thead>
                                            <tr>
                                                <td style="width: 20px;" ></td>
                                                <td>STT</td>
                                                <td>Mã hàng</td>
                                                <td>Tên hàng</td>
                                                <td>ĐVT</td>
                                                <td>Đơn giá</td>
                                                <td>Số lượng</td>
                                                <td>Thành tiền</td>
                                            </tr>
                                        </thead>
                                        <tbody id="insert-product-list" class="import-invoice-insert" >

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="bottom" style="clear: both;" ></div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal" >
            <div class="import-invoice-edit-modal" id ="import-invoice-edit-modal" >
                <div class="modal-header" >
                    <h2 class="title" >Chỉnh sửa phiếu</h2>
                    <button class="btn-close" onclick="closeModal('import-invoice-edit-modal')" >x</button>
                </div>
                <div class="modal-content" >
                    <form id="edit-form" action ="edit" method ="POST" >
                        <div class="column"  > 
                            <table class="edit-invoice-info" >
                                <tr>
                                    <td colspan="2" style="text-align: center;" >Thông tin phiếu</td>
                                </tr>
                                <tr>
                                    <td>Mã phiếu nhập</td>
                                    <td>
                                        <span class="import-invoice-edit">Mã tự động</span>
                                        <input type="hidden" name="invoiceID" class="import-invoice-edit" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Trạng thái</td>
                                    <td>
                                        <span class="import-invoice-edit">Phiếu tạm</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ngày nhập</td>
                                    <td>
                                        <input type="date" value="${requestScope.today}" class="import-invoice-edit" name="date" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nhà cung cấp</td>
                                    <td>
                                        <span class="import-invoice-edit" onclick="openBox('edit-supplier-search-box')" id="edit-supplier-name" >---Chọn nhà cung cấp---</span>
                                        <input class="import-invoice-edit" id ="edit-supplier-id" name ="supplierID" type ="hidden" />
                                        <button type="button" onclick="openModal('supplier-edit-modal')"  class="btn-add"><i class="fa fa-plus" ></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tổng tiền hàng</td>
                                    <td>
                                        <span id="edit-total" class="import-invoice-edit">0</span>
                                        <input type="hidden" class="import-invoice-edit" id="edit-total-amount" name="totalAmount" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Giảm giá</td>
                                    <td> 
                                        <span onclick="openBox('edit-discount-box')" class="import-invoice-edit" id="edit-discount">0</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Cần trả nhà cung cấp</td>
                                    <td>
                                        <span class="import-invoice-edit" id="edit-pay">0</span>
                                        <input type="hidden" class="import-invoice-edit" id="edit-must-pay" name="mustPay" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tiền trả nhà cung cấp</td>
                                    <td> 
                                        <input id="edit-paid" type="text" onkeyup="setPaid('edit', this.value)" class="import-invoice-edit" name="paid" value="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tiền thừa nhận từ nhà cung cấp</td>
                                    <td>
                                        <span class="import-invoice-edit" id="return-edit">0</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ghi chú</td>
                                    <td>
                                        <textarea id="edit-desciption" name="desciption" rows="4" cols="31" class="import-invoice-edit"  ></textarea>
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="2" class="import-invoice-edit">

                                    </td>
                                </tr>
                            </table>
                            <div class="edit-discount-box" id="edit-discount-box" >
                                <label>Giảm giá</label>
                                <input class="import-invoice-edit" id="edit-discount-input" onkeyup="setDiscount('edit', this.value)" type="text" name="discount" value="0"  /> 
                                <input type="hidden" id="edit-sign" value="1" name="discountType"   /> 
                                <span onclick="setSign('edit', '1')" class="edit-sign" >VND</span>
                                <span onclick="setSign('edit', '0')" class="edit-sign"  >%</span>
                            </div>
                            <div class="supplier-container-outer">
                                <div class="supplier-container">
                                    <div id ="edit-supplier-search-box">
                                        <input type ="text" onkeyup="searchSupplier('edit', this.value)"  placeholder="Tìm kiếm nhà cung cấp"/>
                                        <div id="edit-supplier-box" >
                                            <table>
                                                <c:forEach var="c" begin="0" end="${suppliers.size()}" items="${suppliers}" >
                                                    <tr>
                                                        <td><span onclick="setValue('${c.supplierID}', '${c.supplierName}', 'edit')" class="supplier-value">${c.supplierName}</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="column"  > 
                            <span>Thêm hàng vào phiếu nhập hàng</span>
                            <div id="edit-search-box" class="row" >
                                <!--<label>Thêm hàng vào hóa đơn</label> <br />-->
                                <input id="edit-search-bar" onkeyup ="productSearch('edit', this.value)" type="text" 
                                       name="searchProduct" class="search-product" 
                                       placeholder="Tìm kiếm hàng hóa theo mã hàng"/>
                                <div class="search-result" id="edit-search-result"  >
                                </div>
                            </div>
                            <div id ="edit-product-box" >
                                <div class="wrapper" >
                                    <table>
                                        <thead>
                                            <tr>
                                                <td style="width: 20px;" ></td>
                                                <td>STT</td>
                                                <td>Mã hàng</td>
                                                <td>Tên hàng</td>
                                                <td>ĐVT</td>
                                                <td>Đơn giá</td>
                                                <td>Số lượng</td>
                                                <td>Thành tiền</td>
                                            </tr>
                                        </thead>
                                        <tbody id="edit-product-list" class="import-invoice-edit" >

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="bottom" style="clear: both;" ></div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal" >
            <div class="import-invoice-view-modal" id ="import-invoice-view-modal" >
                <div class="modal-header" >
                    <h2 class="title" >Xem thông tin phiếu</h2>
                    <button class="btn-close" onclick="closeModal('import-invoice-view-modal')" >x</button>
                </div>
                <div class="modal-content" >
                    <div class="column"  > 
                        <table class="view-invoice-info" >
                            <tr>
                                <td colspan="2" style="text-align: center;" >Thông tin phiếu</td>
                            </tr>
                            <tr>
                                <td>Mã phiếu nhập</td>
                                <td>
                                    <span class="import-invoice-view"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Trạng thái</td>
                                <td>
                                    <span class="import-invoice-view"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Ngày nhập</td>
                                <td>
                                    <span class="import-invoice-view"></span>                                    </td>
                            </tr>
                            <tr>
                                <td>Nhà cung cấp</td>
                                <td>
                                    <span class="import-invoice-view"></span>   
                                    <input type="hidden" id="view-supplier" class="import-invoice-view" />
                                    <button type="button" ><i class="fa fa-eye"></i></button>                                </td>
                                </td>
                            </tr>
                            <tr>
                                <td>Tổng tiền hàng</td>
                                <td>
                                    <span class="import-invoice-view"></span>                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td>Giảm giá</td>
                                <td> 
                                    <span class="import-invoice-view"></span>                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td>Cần trả nhà cung cấp</td>
                                <td>
                                    <span class="import-invoice-view"></span>                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td>Tiền trả nhà cung cấp</td>
                                <td> 
                                    <span class="import-invoice-view"></span>                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td>Tiền thừa nhận từ nhà cung cấp</td>
                                <td>
                                    <span class="import-invoice-view"></span>                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td>Ghi chú</td>
                                <td>
                                    <span class="import-invoice-view"></span>                                    </td>
                                </td>
                            </tr>

                        </table>
                    </div>
                    <div class="column"  > 
                        <span>Hàng trong phiếu</span>
                        <div id ="view-product-box" >
                            <div class="wrapper" >
                                <table>
                                    <thead>
                                        <tr>
                                            <td>STT</td>
                                            <td>Mã hàng</td>
                                            <td>Tên hàng</td>
                                            <td>ĐVT</td>
                                            <td>Đơn giá</td>
                                            <td>Số lượng</td>
                                            <td>Thành tiền</td>
                                        </tr>
                                    </thead>
                                    <tbody id="view-product-list" class="import-invoice-view" >

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="bottom" style="clear: both;" ></div>
                </div>
            </div>
        </div>



        <div class="modal" > 
            <div class="supplier-insert-modal" id ="supplier-insert-modal" >
                <div class="modal-header" >
                    <h2 class="title" >Thêm nhà cung cấp</h2>
                    <button class="btn-close" onclick="closeModal('supplier-insert-modal')" >x</button>
                </div>
                <div class="modal-content" > 
                    <form action="" >
                        <!--<span>Brand Name</span>-->
                        <input type ="text" placeholder="Tên nhà cung cấp hiệu" name ="supplierName" id ="supplier-insert-input"  class="supplier-insert" /> 
                    </form>
                </div>
                <div onclick="insert('supplier-insert')" class="btn-save"> <span>Save</span></div>
            </div>
        </div>
    </body>
    <script>
        <c:if test="${requestScope.importInvoices.size() >= 10 || requestScope.pageIndex >= 2}" >
        pagge r('pagger',${requestScope.pageIndex},
            ${requestScope.selectedPageSize},
            ${requestScope.totalPage}, 2
                );
        </c:if>




        var ordinalNumber = 1;
        function setSign(type, value) {
            var insertSign = document.getElementById(type + '-sign');
            var insertSignClass = document.getElementsByClassName(type + '-sign');
            if (value === "1") {
                insertSignClass[0].style.background = "green";
                insertSignClass[1].style.background = "#ccc";
            }
            if (value === "0") {
                insertSignClass[0].style.background = "#ccc";
                insertSignClass[1].style.background = "green";
            }
            insertSign.value = value;
        }
        function setPaid(type, paid) {
            var returnBox = document.getElementById(type + '-return'); // return back
            var inputPay = document.getElementById(type + '-paid'); // to supplier
//            alert(inputPay.value);
            var status = checkInputNumber(paid);
            if (status === false || inputPay.value === "") {
                inputPay.value = "0";
            } else {
                if (paid.charAt(0) === '0' && paid.length > 1) {
                    paid = paid.replace('0', '');
                }
                var mustPay = parseFloat(document.getElementById(type + '-pay').innerHTML);
                inputPay.value = paid;

                var customerPaid = parseFloat(paid);
                returnBox.innerHTML = customerPaid - mustPay;
            }
//            alert(inputPay.value);

        }


        function setDiscount(type, discount) {
            var totalBox = document.getElementById(type + '-total');
            var input = document.getElementById(type + '-discount-input');
            var discountSpan = document.getElementById(type + '-discount');
            var mustPayInput = document.getElementById(type + '-must-pay');
            var mustPay = document.getElementById(type + '-pay');
            var total = parseFloat(totalBox.innerHTML);
//            alert(input.value + "," + discountSpan.innerHTML + ", "
//                    + mustPayInput.value + ", " + mustPay.innerHTML);
            var disc;
            var insertSign = document.getElementById('insert-sign').value;
            if (insertSign == '1') {
                var status = checkInputNumber(discount);
                if (status == false || input.value === "") {
                    input.value = "0";
                } else {
                    if (discount.charAt(0) === '0' && discount.length > 1) {
                        discount = discount.replace('0', '');
                    }
                    disc = parseFloat(discount);
                    if (disc >= total) {
                        disc = total;
                        discountSpan.innerHTML = disc;
                        input.value = disc;
                    } else {
                        discountSpan.innerHTML = discount;
                        input.value = discount;
                    }
                    total -= disc;
                }

            }
            if (insertSign == '0') {
                total -= total * (disc / 100);
            }
            if (total < 0) {
                total = 0;
            }

            mustPayInput.value = total;
            mustPay.innerHTML = total;
            var inputPay = document.getElementById(type + '-paid'); // to supplier
            if (inputPay.value != "0") {
                setPaid(type, inputPay.value);
            }
        }

        function productSearch(type, searchKey) {
//            var searchKey = document.getElementById('search').value;
            var url = "../../product/search?searchKey=" + searchKey;
            url += "&type=" + type;
            var box = document.getElementById(type + '-search-result');
//            alert(searchKey.length);
            fetch(url, {method: 'POST'}).then(function (response) {
                return response.text();
            }).then(function (result) {
                if (searchKey !== '') {
                    box.style.display = "block";
                    box.innerHTML = result;
                } else {
                    box.style.display = "none";
                    box.innerHTML = "";
                }
            });
        }

        function checkExistProduct(type, productID) {
            var productList = document.getElementById(type + '-product-list');
            var products = productList.children;
            for (var i = 0, max = products.length; i < max; i++) {
                var productAttributes = products[i].children;
                var formattedProductId = formatProductId(productID);
                if (productAttributes[2].innerHTML === formattedProductId) {
                    var inputQuantity = productAttributes[6].children;
                    var currenQuantity = parseInt(inputQuantity[1].value);
                    currenQuantity += 1;
                    inputQuantity[1].value = currenQuantity;
                    setAmount(type, inputQuantity[1].value, productID);
                    return true;
                }
            }
            return false;
        }

        function checkInputNumber(number) {
            for (var i = 0, max = number.length; i < max; i++) {
                var ch = number[i];
                if (ch < '0' || ch > '9') {
                    return false;
                }
            }
            if (number === "") {
                return false;
            }
            return true;
        }

        function addTo(type, productID) {
//            alert(type);
            var productList = document.getElementById(type + '-product-list');
//            alert(productList.innerHTML);
            var searchBar = document.getElementById(type + '-search-bar');
            var box = document.getElementById(type + '-search-result');
            if (!checkExistProduct(type, productID)) {
                var url = "../../product/search?id=" + productID;
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var data = result.split('|');
//                    alert(data.length);
                    if (data.length === 10) {
                        var product = concatProduct(type, data);
//                        productList.innerHTML += product;
                        productList.insertAdjacentHTML('beforeend', product);
                        setAmount(type, 1, ordinalNumber);
//                        alert(productList.innerHTML);
                        ordinalNumber += 1;
                    }
                });
            }
            // reset value of search bar and search result box
            searchBar.value = "";
            box.style.display = "none";
            box.innerHTML = "";
        }

        function setAmount(type, quantity, id) {
            var productList = document.getElementById(type + '-product-list');
            var limit = productList.children.length;
            var product = document.getElementById(type + "-" + id);
            var childs = product.children;
            var unitPrice = parseFloat(childs[5].innerHTML);
            var status = checkInputNumber(quantity);
            var input = childs[6].children;
            if (!status) {
                input[1].value = "0";
                quantity = "1";
            }
//            if (quantity.charAt(0) === '0' && quantity.length > 1) {
//                quantity = quantity.replace('0', '');
//            }
            input[1].value = quantity;

//            alert(input[0].value);
            var enterQuantity = parseInt(quantity);
            var amount = unitPrice * enterQuantity;
            if (quantity !== "") {
                childs[7].innerHTML = amount;
//                alert(childs[7].innerHTML);
            } else {
                childs[7].innerHTML = "";
            }
            setTotalAmount(type, limit);
        }



        function setTotalAmount(type, limit) {
            var totalAmount = 0;
            for (var i = 1, max = limit; i <= max; i++) {
                var product = document.getElementById(type + "-" + i);
                var childs = product.children;
                var currentAmount = childs[7].innerHTML;
//                 alert(currentAmount);
                if (currentAmount !== "") {
                    var amount = parseFloat(currentAmount);
                    totalAmount += amount;
                }
            }
            var total = document.getElementById(type + '-total');
            var totalAm = document.getElementById(type + '-total-amount');
            total.innerHTML = totalAmount;

            totalAm.value = totalAmount;
            var discount = document.getElementById(type + '-discount-input').value;
//            alert(total.innerHTML + "," + totalAm.value + "," + discount + ", " + totalAmount);
            setDiscount(type, discount);
        }

        function formatProductId(productId) {
            var len = productId.length;
            switch (len) {
                case 1:
                    return "P0000" + productId;
                case 2:
                    return "P000" + productId;
                case 3:
                    return "P00" + productId;
                case 4:
                    return "P0" + productId;
                default:
                    return "P0000" + productId;
            }

        }

        function formatInvoiceId(id) {
            var len = id.length;
            switch (len) {
                case 1:
                    return "PN0000" + id;
                case 2:
                    return "PN000" + id;
                case 3:
                    return "PN00" + id;
                case 4:
                    return "PN0" + id;
                default:
                    return "PN0000" + id;
            }

        }
        function formatProductId(id) {
            var len = id.length;
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
                    return "P0000" + id;
            }

        }

        function concatProduct(type, data) {
//            alert(ordinalNumber);
            var str = "";
            str += "<tr id=\"" + type + "-" + ordinalNumber + "\" >";
            str += "<td>" + " <button type =\"button\" onclick=\"deleteFrom('" + type + "'," + ordinalNumber + ")\"><i class=\"fa fa-trash\" ></i></button>" + "</td>";
            str += "<td>" + ordinalNumber + "</td>";
            str += "<td>" + formatProductId(data[0]) + "</td>";
            str += "<td>" + data[2] + "<input type=\"hidden\" name =\"id\" value =\""
                    + data[0] + "\"" + "/></td>";
            str += "<td>" + data[5] + "</td>";
            str += "<td>" + data[7] + "</td>";
            str += "<td>"
                    + "<button type=\"button\" onclick=\"increaseQuantity('" + type + "'," + ordinalNumber + ")\" ><i class =\"fa fa-arrow-up\"></i></button>"
                    + "<input maxlength =\"12\" onkeyup =\"setAmount('" + type + "',this.value," + ordinalNumber
                    + ")\"type=\"text\" name =\"quantity\" value=\"1\" />" +
                    "<button type=\"button\" onclick=\"decreaseQuantity('" + type + "'," + ordinalNumber + ")\"><i class =\"fa fa-arrow-down\"></i></button>"
                    + "</td>";
            str += "<td>0</td>";
            str += "</tr>";
            return str;
        }

        function increaseQuantity(type, id) {
            var product = document.getElementById(type + "-" + id);
            var productAttributes = product.children;
            var inputQuantity = productAttributes[6].children;
            var currentQuantity = parseInt(inputQuantity[1].value);
            currentQuantity += 1;
            inputQuantity[1].value = currentQuantity;
            setAmount(type, inputQuantity[1].value, id);
        }
        function decreaseQuantity(type, id) {
            var product = document.getElementById(type + "-" + id);
            var productAttributes = product.children;
            var inputQuantity = productAttributes[6].children;
            var currentQuantity = parseInt(inputQuantity[1].value);
            if (currentQuantity > 1) {
                currentQuantity -= 1;
                inputQuantity[1].value = currentQuantity;
            }
            setAmount(type, inputQuantity[1].value, id);
        }


        function deleteFrom(type, position) {
            var list = document.getElementById(type + "-product-list");
            var removeChild = document.getElementById(type + "-" + position);
//            alert(position);
            var childs = list.children;
            list.removeChild(removeChild);
            for (var i = 1, max = childs.length; i < max; i++) {
                var childId = parseInt((childs[i].id).split(type + "-")[1]);
                if (childId > position) {
                    var ch = childs[i].children;
                    childId -= 1;
                    childs[i].id = type + "-" + childId;
                    ch[1].innerHTML = childId;
                    var newDeleteButton = document.createElement('td');
                    var newInputGroup = document.createElement('td');
                    var inputGroupChildren = ch[6].children;
                    var currentValue = inputGroupChildren[1].value;
                    //                    alert(inputGroupChildren[1].value);
                    newDeleteButton.innerHTML = "<button type =\"button\" onclick =\"deleteFrom('" + type + "'," + childId + ")\"><i class=\"fa fa-trash\" ></i></button>";
                    newInputGroup.innerHTML =
                            "<button type=\"button\" onclick=\"increaseQuantity('" + type + "'," + childId + ")\" ><i class =\"fa fa-arrow-up\"></i></button>"
                            + "<input maxlength =\"12\" onkeyup =\"setAmount('" + type + "',this.value," + childId
                            + ")\"type=\"text\" name =\"quantity\" value=\"" + currentValue + "\" />" +
                            "<button type=\"button\" onclick=\"decreaseQuantity('" + type + "'," + childId + ")\"><i class =\"fa fa-arrow-down\"></i></button>";
                    childs[i].replaceChild(newDeleteButton, ch[0]);
                    childs[i].replaceChild(newInputGroup, ch[6]);
                }
            }
            var limit = list.children.length;
            //            alert(limit);
            ordinalNumber -= 1;
            setTotalAmount(type, limit);
        }

        function setDate(formId) {
            var from = document.getElementById('from');
            var to = document.getElementById('to');
            var fromDate = document.getElementById('from-date');
            var toDate = document.getElementById('to-date');
            fromDate.value = from.value;
            toDate.value = to.value;
            //            alert(fromDate.value);
            //            alert(toDate.value);
            submitForm(formId);
        }

        function setCheckboxes(name, formId) {
            var boxes = document.getElementsByName(name);
            boxes[0].value = "";
            for (var i = 1, max = 4; i < max; i++) {
                if (boxes[i].checked) {
                    boxes[0].value += boxes[i].value;
                }
            }
            //            alert(boxes[0].value);
            submitForm(formId);
        }

        function checkInput(formId, statusId, value) {
            var form = document.getElementById(formId);
            var status = document.getElementById(statusId);
            status.value = value;
            form.submit();
        }


        function openModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'import-invoice-insert-modal') {
                ordinalNumber = 1;
                modal[0].style.transform = "scale(1)";
            } else if (id === 'import-invoice-edit-modal') {
                modal[1].style.transform = "scale(1)";
            } else if (id === 'import-invoice-view-modal') {
                modal[2].style.transform = "scale(1)";
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
            } else if (id === 'import-invoice-view-modal') {
                modal[2].style.transform = "scale(0)";
            }
            box.style.transform = "scale(0)";
            var input = id.split('-modal')[0];
            if (input === "import-invoice-insert") {
                clearData(input);
            }
        }

        function clearData(id) {
            //            alert('ok' + id);
            var input = document.getElementsByClassName(id);
            input[1].value = "${requestScope.today}";
            input[2].innerHTML = "--Chọn nhà cung cấp--";
            input[3].value = "";
            input[4].innerHTML = "";
            input[5].innerHTML = "0";
            input[6].value = "0";
            input[7].innerHTML = "0";
            input[8].innerHTML = "0";
            input[9].value = "0";
            input[10].value = "0";
            input[11].innerHTML = "0";
            input[12].value = "0";
            input[13].innerHTML = "";
            input[14].value = "0";
            input[15].innerHTML = "0";
            input[16].value = "0";
            ordinalNumber = 1;
        }

        function openBox(id) {
            var box = document.getElementById(id);
            if (box.style.display == 'block') {
                box.style.display = "none";
            } else {
                box.style.display = "block";
            }
        }

        function clearSearchBox(type) {
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

        function viewInvoice(id) {
            var url = "search?id=" + id;
            var edit = document.getElementsByClassName('import-invoice-view');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var arr = result.split('|');
                for (var i = 1, max = edit.length - 1; i < max; i++) {
                    if (i != 4) {
                        edit[i].innerHTML = arr[i];
                    }
                }
                edit[0].innerHTML = formatInvoiceId(arr[0]);

                edit[4].innerHTML = arr[4];
                var productList = document.getElementById('view-product-list');
                productList.innerHTML = arr[12];
            });
            openModal('import-invoice-view-modal');
        }


        function editInvoice(id, position) {
            var url = "edit?id=" + id;
            var edit = document.getElementsByClassName('import-invoice-edit');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var arr = result.split('|');
                //                alert(arr.length + ", " + edit.length);
                edit[0].innerHTML = formatInvoiceId(arr[0]);
                edit[2].innerHTML = arr[2];
                edit[4].innerHTML = arr[4];
                edit[6].innerHTML = arr[6];
                edit[8].innerHTML = arr[8];
                edit[9].innerHTML = arr[9];
                edit[12].innerHTML = arr[12];
                edit[14].innerHTML = arr[14];
                //                edit[17].innerHTML = arr[17];
                edit[1].value = arr[1];
                edit[3].value = arr[3];
                edit[5].value = arr[5];
                edit[7].value = arr[7];
                edit[10].value = arr[10];
                edit[11].value = arr[11];
                edit[13].value = arr[13];
                edit[15].value = arr[15];
                edit[16].value = arr[16];

                document.getE


                var productList = document.getElementById('edit-product-list');
                productList.innerHTML = "";
                var rows = arr[17].split("@");
                //                alert(rows.length);
                for (var i = 0, max = rows.length - 1; i < max; i++) {
                    var product = rows[i];
                    productList.insertAdjacentHTML('beforeend', product);
                    //                    setAmount(type, 1, ordinalNumber);
                }

                ordinalNumber = rows.length;

                var buttons = edit[14].children;
//                alert(edit[14].innerHTML);
                for (var i = 1, max = buttons.length; i < max; i++) {
                    if (arr[2] === "Đã nhập hàng") {
                        buttons[i].style.width = "155px";
                    } else {
                        buttons[i].style.width = "102px";
                    }
                }


            });
            openModal('import-invoice-edit-modal');
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


        function setValue(idValue, nameValue, id) {
            var inputId = document.getElementById(id + '-supplier-id');
            var inputName = document.getElementById(id + '-supplier-name');
            inputId.value = idValue;
            inputName.innerHTML = nameValue;
            closeBox(id + "-supplier-search-box");
        }
    </script>
</html>
