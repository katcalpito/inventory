<%-- 
    Document   : dashboard
    Created on : 04 29, 20, 12:47:04 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="account" scope="session" class="model.account" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory</title>
    </head>
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
     <% if (account.username != null) {%>
    <body>
    <center>
        <button type="button" class="main-button" onclick="window.location='scan.jsp';">Scan</button><br><br>
        <button type="button" class="main-button" onclick="window.location='add.jsp';">Add Item</button><br><br>
        <form action="display" method="POST">
            <button type="submit" class="main-button">Inventory</button>
        </form><br>
        <form action="displayBorrow" method="POST">
            <button type="submit" class="main-button">Borrowable</button>
        </form>
    </center>
    </body>
    <%} else { 
        response.sendRedirect("error.jsp");
    }%>
</html>
