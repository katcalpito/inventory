<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="account" scope="session" class="model.account" />
<html>
    <head>
        <script type="text/javascript" src="assets/qrcode.js"></script>
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
            width: 180px;
            height: 40px;
            background-color: #45a2ff;
            border-radius: 5px;
            outline: none;
            border: 0px;
            color: white;
            font-family: "Raleway", sans-serif;
            font-size: 13px;
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
            width: 200px;
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
    <%
       ResultSet item = (ResultSet)request.getAttribute("item");
       int id = 0;
    %>
    <body>
    <center>
        <p style="color:red"><%if(request.getAttribute("message")!=null){%><%=request.getAttribute("message")%><%}%></p>
        
        <%while (item.next()){
            id = item.getInt("id");%><br>
            
            ID: <%=id%><br>
            Serial Code: <%=item.getString("serial")%><br>
            Name: <%=item.getString("name")%><br>
            Description: <%=item.getString("description")%><br>
            Date Added: <%=item.getString("dateadded")%><br>
            Quantity: <%=item.getString("quantity")%><br>
            Borrowable: <%if (item.getBoolean("borrowable") == true){%>Yes<%} else {%>No<%}%><br><br>
            QR Code:
            <%}%><br><br>
        <div id="qrcode"></div><br>
    <script>
        function createQrCode()
        {
            var userInput = "<%=id%>";

            var qrcode = new QRCode("qrcode", {
                text: userInput,
                width: 256,
                height: 256,
                colorDark: "black",
                colorLight: "white",
                correctLevel : QRCode.CorrectLevel.H
            });
        }

        window.onload=createQrCode();
    </script>
    </center>
    </body>
    <%
    } else { 
        response.sendRedirect("error.jsp");
    }%>
</html>