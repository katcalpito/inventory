<%-- 
    Document   : add
    Created on : 04 29, 20, 1:47:04 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="account" scope="session" class="model.account" />
<html>
    <head>
        <script type="text/javascript" src="qrcode.js"></script>
        <script type="text/javascript" src="html2canvas.min.js"></script>
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
        p {
            font-family: "Raleway", sans-serif;
        }
        h1{
            font-size: 65px;
        }
        .main-button {
            width: 250px;
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
        .sec-button {
            width: 120px;
            height: 30px;
            background-color: #86c1fc;
            border-radius: 5px;
            outline: none;
            border: 0px;
            color: white;
            font-family: "Raleway", sans-serif;
            font-size: 11px;
        }
        .sec-button:hover {
            background-color: #73b9ff;
        }
        input[type=text] {
            width: 250px;
            height: 50px;
            padding: 0 10px;
            background-color: rgba(255,255,255,0.92);
            border: 1px solid lightgrey;
        }
        textarea{
            width: 250px;
            height: 50px;
            padding: 0 10px;
            background-color: rgba(255,255,255,0.92);
            border: 1px solid lightgrey;
        }
        input[type=number] {
            width: 80px;
            height: 50px;
            padding: 0 10px;
            background-color: rgba(255,255,255,0.92);
            border: 1px solid lightgrey;
        }
        input[type=date] {
            width: 200px;
            height: 50px;
            padding: 0 10px;
            background-color: rgba(255,255,255,0.92);
            border: 1px solid lightgrey;
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
        <form action="create" method="POST"><br>
            Serial Number:<br> <input type="text" name="serial" required/><br><br>
            Name: <br><input type="text" name="name" required/><br><br>
            Description: <br><textarea name="description"></textarea><br><br>
            Initial Quantity: <br><input type="number" name="quantity" required/><br><br>
            Borrowable? <br><input type="radio" name="borrowable" value="true"> Yes <input type="radio" name="borrowable" value="false" checked> No
            <p style="color:red">Setting item as borrowable automatically assigns control numbers. You may edit this later on.</p><br><br>
            <button type="submit" class="main-button">Add Product</button>
        </form>
    </center>
    </body>
    <%} else { 
        response.sendRedirect("error.jsp");
    }%>
</html>