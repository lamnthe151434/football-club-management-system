<%-- 
    Document   : login
    Created on : Feb 5, 2022, 4:07:49 PM
    Author     : ADMIN
--%>

<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IEPX</title>
    </head>

    <c:set var = "status" value = "${requestScope.loginStatus}"  ></c:set>
    <c:if test="${status != null}" >
        <c:if test="${!status}" >
            <c:set var="message" value="* Incorrect Username or Password!" ></c:set>
        </c:if>
    </c:if>


    <style>
        body {
            background-color: #F0F2F5;
        }

        .container {
            background-color: #fff;
            width: 450px;
            height: 320px;
            margin-top: 25vh;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: auto;
            padding-top: 10px;
            border-radius: 10px;
            box-sizing: border-box;
        }

        .form_horizontal {
            font-family: 'lato', san-serif;
            text-align: center;
        }

        .form_horizontal .form_title {
            color: black;
            font-size: 23px;
            font-weight: 700;
            text-transform:  uppercase;
        }

        .form_horizontal .input_field {
            background-color: #fff;
            font-size: 15px;
            padding: 10px;
            border:1px solid #DDDFE2;
        }


        .form_horizontal .input_field::placeholder {
            color: #9EC2EC;
            font-size: 15px;
            text-transform:  capitalize;
        }


        .form_horizontal .input_field, 
        .form_horizontal .btn_login {
            box-sizing: border-box;
            width: 390px;
            height: 50px;
            margin-bottom: 10px;
            border-radius: 5px;
        }


        .input_field:focus {
            border: 1px solid #000;
            outline: 2px solid #DDDFE2;
        }

        .form_horizontal .btn_login {
            color: #fff;
            background-color: #1877F2;
            font-size: 15px;
            font-weight: 600;
            padding: 10px;
            border: none;
            text-transform: uppercase;
        }

        .form_horizontal .form_options {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .form-horizontal .form_options li a {
            color: #fff;
            margin: 0 0 10px;
            display: block;
            font-size: 12px;
        }

        a:hover {
            text-decoration: underline;
        }
        a:link {
            text-decoration: none;
        }
        .form_note {
            color: red;
            margin-bottom: 5px;
        }



    </style>
    <body>
        <div class ="container" >
            <form class ="form_horizontal" action="login" method="POST" >
                <div>
                    <h3 class ="form_title" >WELCOME!</h3>
                </div>
                <div class ="form_group" >
                    <input class ="input_field" type="text" name ="username" placeholder="username" /> <br/>
                    <input class ="input_field" type="password" name ="password" placeholder="password" />
                    <button class ="btn_login">LOG IN</button>
                </div>
                <div class ="form_note" >
                    <span>${message}</span>
                </div>
                <ul class ="form_options" >
                    <li><a href ="#" >Forgotten Username/Password?</li>
                </ul>
            </form>
        </div>
    </body>
</html>
