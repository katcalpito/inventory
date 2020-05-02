<%-- 
    Document   : login
    Created on : 11 21, 19, 11:25:14 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Inventory</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Raleway:400 |Montserrat:900|Oleo+Script&display=swap" rel="stylesheet">
    <style>
        body{
            color: black;
            overflow:hidden;
            background-position-x: center;
            background-size: 900px;
            background-repeat: no-repeat;
            font-family: "Raleway", sans-serif;
        }
        h1{
            font-size: 65px;
        }
        .main-button {
            width: 220px;
            height: 50px;
            background-color: #45a2ff;
            border-radius: 5px;
            outline: none;
            border: 0px;
            color: white;
            font-family: "Raleway", sans-serif;
            font-size: 15px;
        }
        .main-button:hover {
            background-color: #3297fc;
        }
        input {
            width: 300px;
            height: 50px;
            padding: 0 10px;
            background-color: rgba(255,255,255,0.92);
            border: 1px solid grey;
        }
        p {
            font-family: "Arial", sans-serif;
            font-size: 12px;
        }
        body {
            -webkit-animation: fadein 1s; /* Safari, Chrome and Opera > 12.1 */
               -moz-animation: fadein 1s; /* Firefox < 16 */
                -ms-animation: fadein 1s; /* Internet Explorer */
                 -o-animation: fadein 1s; /* Opera < 12.1 */
                    animation: fadein 1s;
        }

        @keyframes fadein {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        /* Firefox < 16 */
        @-moz-keyframes fadein {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        /* Safari, Chrome and Opera > 12.1 */
        @-webkit-keyframes fadein {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        /* Internet Explorer */
        @-ms-keyframes fadein {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        /* Opera < 12.1 */
        @-o-keyframes fadein {
            from { opacity: 0; }
            to   { opacity: 1; }
        }
        </style>
    </head>
    
    <body>
    <center>
        <div class='row' style='margin: 150px 0 0 0'>
            <p style="color:red"><%if(request.getAttribute("message")!=null){%><%=request.getAttribute("message")%><%}%></p>
            <form method="POST" action="login">
                <input type="text" name="username" placeholder="Username"/><br>
                <input style='margin: 10px 0 0 0' type="password" name="password" placeholder="Password"/><br><br><br>
                <button type="submit" class="main-button" name="button" value="login">Login</button>
            </form>
        </div>
    </center>
    </body>
</html>
