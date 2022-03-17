<%-- 
    Document   : sell
    Created on : Mar 15, 2022, 12:15:17 AM
    Author     : ADMIN
--%>

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
    <style>

        body{
            overflow: auto;
            background: #EEEEEE;
        }
        .container .top,
        .container .left,
        .container .right {
            padding: 20px;
            margin-bottom: 20px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0px 0px 2px 2px #ccc;
        }

        .container .top {
            margin-top: 20px;
            position: relative;
        }
        .container .top .horizontal-search {
            position: relative;
        }

        /*        .container .top .horizontal-search button {
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
                }*/


        .container .top .horizontal-search input {
            width: 700px;
        }
        .container .left {
            float: left;
            width: 62%;

        }
        .container .right {
            float: right;
            width: 30%;
            height: 450px;
            overflow: auto;
        }

        .container .left .wrapper {
            height: 450px;
            overflow: auto;
        }

        .container .left table {
            font-size: 17px;
            text-align: left;
            width: 100%;
            table-layout: fixed;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-collapse: collapse;
            /*box-sizing: border-box;*/
        }


        .container .left table thead{
            position: sticky;
            top:0;
            background-color: #009879;
            color: #ffffff;
        }

        .container .left table td {
            padding: 10px;
            word-wrap: break-word;    
        }

        .container .left table tr {
            border-bottom: 1px solid #dddddd;
        }

        .container .left table tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .container .top .result {
            height: 75px;
            overflow: auto;
            width: 700px;
            box-shadow: 0px 0px 2px 2px #ccc;
            position: absolute;
            z-index: 10;
            background: #fff;
            display: none;
        }

       

        .container .top .result .no-result {
            text-align: center;
            padding: 5px;
            padding-top: 17px;
            height: 65px;
            cursor: pointer;

        }

        .container .top .result .product-result:hover {
            background: #ccc;
        }
         .container .top .result .product-result {
            padding: 5px;
            /*border: 1px solid #000;*/
            height: 65px;
            cursor: pointer;


        }
        
        .container .top .result .product-result span, 
        .container .top .result .no-result span{
            display: inline-block;
            margin-right: 10px; 
            width: 170px;
            /*border: 1px solid #000;*/
            padding: 5px;

        }
        .container .left table {
            table-layout: fixed;
        }
        .container .left table td {
            word-wrap: break-word;
        }

        .container .left table td input {
            padding-left: 5px;
            padding-top: 3px;
            padding-bottom: 3px;
            padding-right: 5px;
            width: 120px;
        }

        .container .left table td:nth-child(1) {
            width: 10px;
            text-align: center;
            /*border: 1px solid #000;*/
        }
        .container .left table td:nth-child(2) {
            width: 22px;
            /*text-align: center;*/
            /*border: 1px solid #000;*/
        }
        .container .left table td:nth-child(3) {
            width: 65px;
        }
        .container .left table td:nth-child(4) {
            width: 65px;
        }
        .container .left table td:nth-child(5) {
            width: 50px;
        }
        .container .left table td:nth-child(6) {
            width: 50px;
        }
        .container .left table td:nth-child(7) {
            width: 135px;
        }
        .container .left table td:nth-child(8) {
            width: 70px;
        }




    </style>
    <body>
        <div class="header" >
            <h2 class="title" >Bán hàng</h2>
        </div>
        <div class="navigation" >
            <jsp:include page="slider.jsp" />
        </div>
        <div class="container" >
            <div class="top" >
                <div class="horizontal-search" >
                    <input onkeyup="searchProduct(this.value)" id="search" type="text" placeholder="Theo mã hoặc tên hàng" >
                    <button><i class="fa fa-search"></i></button>         
                </div>
                <div class="result" id ="result" >

                </div>
            </div>
            <div class="left" id="left" >
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
                        <tbody id="cart" class="cart" >

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="right" >
                <div class="current-date row" >
                    <span>${requestScope.currentTime}</span>
                </div>
                <div class="customer-search row" >
                    <input onkeyup="" id="search" type="text" placeholder="Tìm kiếm khách hàng" >
                    <button><i class="fa fa-search"></i></button>      
                </div>
                <div>
                    <table>
                        <tr>
                            <td>Tổng tiền hàng</td>
                            <td>
                                <span id="total" name="total" >0</span> 
                                <input type="hidden" id="total-text" name="total" />
                            </td>
                        </tr>
                        <tr onclick="openDiscountBox()" >
                            <td>Giảm giá</td>
                            <td>
                                <span id="discount" >0</span>
                            </td>
                        </tr>
                        <tr>
                            <td>Khách cần trả</td>
                            <td><span id="must-pay" name="mustPay" >0</span></td>
                        </tr>
                        <tr>
                            <td>Khách thanh toán</td>
                            <td>
                                <input id="paid" onkeyup="setPaid(this.value)" value="0" type="text" name="paid"  />
                            </td>
                        </tr>
                        <tr>
                            <td>Tiền thừa trả khách</td>
                            <td>
                                <span id="return" name ="return" >0</span> 
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <span>thanh toán</span>
                </div>
                <div>
                    <label>Giảm giá</label>
                    <input id="input-discount" onkeyup="setDiscount(this.value)" type="text" name="discount" value="0"  /> 
                    <input  type="hidden" id="sign" value="1"  /> 
                    <span onclick="setSign('1')" >VND</span>
                    <span onclick="setSign('0')">%</span>
                </div>
            </div>
        </div>
    </body>
    <script>

        var ordinalNumber = 1;
        function setSign(value) {
            var sign = document.getElementById('sign');
            sign.value = value;
        }
        function setPaid(paid) {
            var returnBox = document.getElementById('return');
            var inputPay = document.getElementById('paid');
            var status = checkInputNumber(paid);
            if (status === false || inputPay.value === "") {
                inputPay.value = "0";
            } else {
                if (paid.charAt(0) === '0' && paid.length > 1) {
                    paid = paid.replace('0', '');
                }
                var mustPay = parseFloat(document.getElementById('must-pay').innerHTML);
                inputPay.value = paid;
                if (mustPay === 0) {
                    returnBox.innerHTML = 0;
                } else {
                    var customerPaid = parseFloat(paid);
                    returnBox.innerHTML = customerPaid - mustPay;
                }
            }

        }


        function setDiscount(discount) {
            var totalBox = document.getElementById('total');
            var input = document.getElementById('input-discount');
            var mustPay = document.getElementById('must-pay');
            var total = parseFloat(totalBox.innerHTML);
            var disc;
            var sign = document.getElementById('sign').value;
            if (sign == '1') {
                var status = checkInputNumber(discount);
                if (status == false || input.value === "") {
                    input.value = "0";
                } else {
                    if (discount.charAt(0) === '0' && discount.length > 1) {
                        discount = discount.replace('0', '');
                    }
                    disc = parseFloat(discount);
                    if (disc > total) {
                        disc = total;
                        input.value = total;
                    } else {
                        input.value = discount;
                    }
                    total -= disc;
                }

            }
            if (sign == '0') {
                total -= total * (dics / 100);
            }
            if (total < 0) {
                total = 0;
            }
            mustPay.innerHTML = total;
        }

        function searchProduct(searchKey) {
//            var searchKey = document.getElementById('search').value;
            var url = "product/search?searchKey=" + searchKey;
            var box = document.getElementById('result');
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

        function checkExistProduct(productID) {
            var cart = document.getElementById('cart');
            var products = cart.children;
            for (var i = 0, max = products.length; i < max; i++) {
                var productAttributes = products[i].children;
                var formattedProductId = formatProductId(productID);
                if (productAttributes[2].innerHTML === formattedProductId) {
                    var inputQuantity = productAttributes[6].children;
                    var currenQuantity = parseInt(inputQuantity[1].value);
                    currenQuantity += 1;
                    inputQuantity[1].value = currenQuantity;
                    setAmount(inputQuantity[1].value, productID);
                    return true;
                }
            }
            return false;
        }

        function checkInputNumber(quantity) {
            for (var i = 0, max = quantity.length; i < max; i++) {
                var ch = quantity[i];
                if (ch < '0' || ch > '9') {
                    return false;
                }
            }
            if (quantity === "") {
                return false;
            }
            return true;
        }

        function addTo(productID) {
            var cart = document.getElementById('cart');
            var searchBar = document.getElementById('search');
            var box = document.getElementById('result');
            if (!checkExistProduct(productID)) {
                var url = "product/search?id=" + productID;
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    var data = result.split('|');
                    if (data.length === 10) {
                        var product = concatProduct(data);
//                        cart.innerHTML += product;
                        cart.insertAdjacentHTML('beforeend', product);
//                        alert(cart.innerHTML);
                        ordinalNumber += 1;
                    }
                });
            }
            // reset value of search bar and search result box
            searchBar.value = "";
            box.style.display = "none";
            box.innerHTML = "";
        }

        function setAmount(quantity, id) {
            var product = document.getElementById(id);
            var childs = product.children;
            var unitPrice = parseFloat(childs[5].innerHTML);
            var status = checkInputNumber(quantity);
            var input = childs[6].children;
            if (!status) {
                input[1].value = "0";
                quantity = "0";
            }
            if (quantity.charAt(0) === '0' && quantity.length > 1) {
                quantity = quantity.replace('0', '');
            }
            input[1].value = quantity;
//            alert(input[0].value);
            var enterQuantity = parseInt(quantity);
            var amount = unitPrice * enterQuantity;
            if (quantity !== "") {
                childs[7].innerHTML = amount;
            } else {
                childs[7].innerHTML = "";
            }

            setTotalAmount();
        }



        function setTotalAmount() {
            var totalAmount = 0;
            for (var i = 1, max = ordinalNumber; i < max; i++) {
                var product = document.getElementById(i);
                var childs = product.children;
                var currentAmount = childs[7].innerHTML;
                if (currentAmount !== "") {
                    var amount = parseFloat(currentAmount);
                    totalAmount += amount;
                }
            }
            var total = document.getElementById('total');
            total.innerHTML = totalAmount;
            var discount = document.getElementById('input-discount').value;
            setDiscount(discount);
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


        function concatProduct(data) {
            var str = "";
            str += "<tr id=\"" + ordinalNumber + "\" >";
            str += "<td>" + " <button type =\"button\" onclick=\"deleteFrom('" + ordinalNumber + "')\"><i class=\"fa fa-trash\" ></i></button>" + "</td>";
            str += "<td>" + ordinalNumber + "</td>";
            str += "<td>" + formatProductId(data[0]) + "</td>";
            str += "<td>" + data[2] + "<input type=\"hidden\" name =\"id\" value =\""
                    + data[0] + "\"" + "/></td>";
            str += "<td>" + data[5] + "</td>";
            str += "<td>" + data[6] + "</td>";
            str += "<td><button onclick=\"increaseQuantity(" + ordinalNumber + ")\" ><i class =\"fa fa-arrow-up\"></i></button>"
                    + "<input maxlength =\"12\" onkeyup =\"setAmount(this.value,'"
                    + ordinalNumber + "')\"type=\"text\" name =\"quantity\" value=\"0\" />" +
                    "<button onclick=\"decreaseQuantity(" + ordinalNumber + ")\"><i class =\"fa fa-arrow-down\"></i></button>" + "</td>";
            str += "<td>0</td>";
            str += "</tr>";
            return str;
        }

        function increaseQuantity(id) {
            var product = document.getElementById(id);
            var productAttributes = product.children;
            var inputQuantity = productAttributes[6].children;
            var currentQuantity = parseInt(inputQuantity[1].value);
            currentQuantity += 1;
            inputQuantity[1].value = currentQuantity;
            setAmount(inputQuantity[1].value, id);
        }
        function decreaseQuantity(id) {
            var product = document.getElementById(id);
            var productAttributes = product.children;
            var inputQuantity = productAttributes[6].children;
            var currentQuantity = parseInt(inputQuantity[1].value);
            if (currentQuantity > 0) {
                currentQuantity -= 1;
                inputQuantity[1].value = currentQuantity;
            }
            setAmount(inputQuantity[1].value, id);
        }


        function deleteFrom(position) {
            var list = document.getElementById("cart");
            var removeChild = document.getElementById(position);
            var childs = list.children;
            list.removeChild(removeChild);
            for (var i = 0, max = childs.length; i < max; i++) {
                var childId = childs[i].id;
                if (childId > position) {
                    var ch = childs[i].children;
                    childId -= 1;
                    childs[i].id = childId;
                    ch[1].innerHTML = childId;
                    var newChild = document.createElement('td');
                    newChild.innerHTML = "<button type =\"button\" onclick =\"deleteFrom('" + childId + "')\"><i class=\"fa fa-trash\" ></i></button>";
                    childs[i].replaceChild(newChild, ch[0]);
                }
            }
            ordinalNumber -= 1;
            setTotalAmount();
        }



    </script>
</html>
