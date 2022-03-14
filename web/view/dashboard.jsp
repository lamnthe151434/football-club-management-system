<%-- 
    Document   : dashboard
    Created on : Mar 4, 2022, 2:26:52 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</head>
<style>

    body{
        overflow: auto;
        background: #EEEEEE;
    }
    .main-content {
        margin-left: 280px;
        margin-right: 50px;
    }
    .main-content .top, 
    .main-content .middle, 
    .main-content .bottom {
        padding: 20px;
        border-radius: 5px;
        /*border: 1px solid #000;*/
        border-right: 10px;
        box-shadow: 0px 0px 2px 2px #ccc;
        margin-bottom: 20px;
        margin-top: 20px;
        background: #fff;
    }
    /*    .main-content .middle {
              padding: 10px;
            border: 1px solid #000;
        }
        .main-content .bottom {
              padding: 10px;
            border: 1px solid #000;
        }*/

    .content-title {
        text-transform: uppercase;
    }
    .main-content .middle .search-group {
        position: relative;
        margin-bottom: 20px;
    }
    .main-content .bottom .search-group {
        position: relative;
        margin-bottom: 20px;
    }


    .main-content .middle .total,
    .main-content .middle .content-title ,
    .main-content .bottom .content-title ,
    .main-content .middle .period, 
    .main-content .bottom .period{
        display: inline-block;
    }

    .main-content .middle .period,
    .main-content .bottom .period
    {
        position: absolute;
        right: 0;
    }



</style>
<body>
    <div class="header" >
        <h2 class="title" >Tổng quan</h2>
    </div>
    <div class="navigator" >
        <jsp:include page="slider.jsp" />
    </div>
    <div class="main-content">
        <div class="top" >
            <h4 class="content-title" >Kết quả bán hàng hôm nay</h4>
            <div></div>
        </div>
        <div class="middle" >
            <div class="search-group" >
                <h4 class="content-title" >Doanh thu ${requestScope.selectedPeriod}</h4>
                <span class="total" id="total" >0</span>
                <select id="period1" class="period" name="period1" >
                    <c:set var="x" value="1" ></c:set>
                    <c:forEach var="p" begin="0" end="${requestScope.periods.size()}" items="${requestScope.periods}" >
                        <option value="${x}"
                                <c:if test="${p.equals(requestScope.selectedPeriod)}" >
                                    selected="selected"
                                </c:if>>${p}
                        </option>
                        <c:set var="x" value="${x+1}" ></c:set>
                    </c:forEach>
                </select>
            </div>
            <div class="chart" >
                <canvas id="verticalChart" width="380" height="150"></canvas>
            </div>
        </div>
        <div class="bottom" >
            <div class="search-group" >
                <h4 class="content-title" >Top 10 hàng hóa bán chạy ${requestScope.selectedPeriod}</h4>
                <select id="baseOn"  >
                    <c:set var="y" value="1" ></c:set>
                    <c:forEach var="b" begin="0" end="${requestScope.baseOn.size()}" items="${requestScope.baseOn}" >
                        <option value="${y}"
                                <c:if test="${b.equals(requestScope.selectedBaseOn)}" >
                                    selected="selected"
                                </c:if>>${b}
                        </option>
                        <c:set var="y" value="${y+1}" ></c:set>
                    </c:forEach>
                </select>
                <select id="period2" class="period" name="period2" >
                    <c:set var="x" value="1" ></c:set>
                    <c:forEach var="p" begin="0" end="${requestScope.periods.size()}" items="${requestScope.periods}" >
                        <option value="${x}"
                                <c:if test="${p.equals(requestScope.selectedPeriod)}" >
                                    selected="selected"
                                </c:if>>${p}
                        </option>
                        <c:set var="x" value="${x+1}" ></c:set>
                    </c:forEach>
                </select>
            </div>
            <div class="chart" >
                <canvas id="horizontalChart" width="380" height="150"></canvas>
            </div>
        </div>

    </div>
    <div class="data-container" >
        <input type="hidden" id="x-value" value="${requestScope.xValues}" />
        <input type="hidden" id="y-value" value="${requestScope.yValues}" />
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js" >
</script>
<script>


    var x = document.getElementById('x-value').value;
    var y = document.getElementById('y-value').value;
    var xValue = x.split(', ');
    var yValue = y.split(', ');

    const ctx1 = document.getElementById('verticalChart').getContext('2d');
    const myChart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: xValue,
            datasets: [{
                    label: '',
                    data: yValue,
                    backgroundColor: [
                        'rgba(0, 0, 255, 0.7)'
                    ],
                    borderColor: [
                        'rgba(0, 0, 255, 1)'
                    ],
                    borderWidth: 1,
                    barPercentage: 0.9,
                    barThickness: 50,
                    barLength: 2,
                }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    const ctx2 = document.getElementById('horizontalChart').getContext('2d');
    const myChart2 = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
            datasets: [{
                    label: '',
                    axis: 'y',
                    label: 'My First Dataset',
                    data: [65, 59, 80, 81, 56, 55, 40, 11, 10, 14],
                    fill: false,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)'
                    ],
                    borderWidth: 1,
//                    barPercentage: 0.9,
//                    barThickness: 50,
//                    barLength: 2,
                }]
        },
        options: {
            indexAxis: 'y',
        }
    });
</script>

</html>