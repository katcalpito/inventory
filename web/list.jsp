<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="account" scope="session" class="model.account" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
        <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        
        <script type="text/javascript" src="assets/qrcode.js"></script>
         <style>
        body{
            color: black;
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
        <script>
            
            <%if(request.getAttribute("message")!=null){%>alert("<%=request.getAttribute("message")%>");<%}%>
        $(document).ready(function() {
    $('#example').DataTable();    
} );

$(document).ready(function() {
    $("#select").click(function(){
  $(".dlt").toggle();
});
});

function terms_changed(termsCheckBox){
    //If the checkbox has been checked
    if(termsCheckBox.checked){
        //Set the disabled property to FALSE and enable the button.
        document.getElementById("submit_button").disabled = false;
    } else{
        //Otherwise, disable the submit button.
        document.getElementById("submit_button").disabled = true;
    }
}
        </script>
        <style>
            table { 
  width: 100%; 
  border-collapse: collapse; 
}
thead, tfoot, th { 
  background: white; 
  color: black; 
  border: 1px solid black; 
}
td { 
  border-bottom: 1px solid lightgray; 
  text-align: left; 
}
        </style>
    </head>
    <% if (account.username != null) {
       %>
     <% ResultSet itemlist = (ResultSet)request.getAttribute("itemlist");%>
    <body style="padding: 0; margin: 0">
    <center>   
        <form action="delete" method="POST">
        <table style="border: 0px; width:250px">
            <tr>
                <td><button type="button" id="select" class="sec-button">Select</button></td>
                <td><button type="submit" id="submit_button"  class="sec-button" disabled>Delete</button></td>
            </tr>
        </table>
        <div class="row" style="padding:0; margin:0">
            <table id="example" class="table table-striped table-bordered" style="width:100%">
            <thead style="width: 100%">
                <th style="width: 5%">ID</th>
                <th style="width: 10%">Serial</th>
                <th style="width: 15%">Name</th>
                <th style="width: 30%">Description</th>
                <th style="width: 5%">Quantity</th>
                <th style="width: 10%">Date Added</th>
                <th style="width: 5%">Borrowable</th>
                <th style="width: 5%">QR</th>
                <th style="width: 2%;display: none" class="dlt"></th>
            </thead>
            
         <%while (itemlist.next()){%>
            <tr>
                <td><%=itemlist.getString("ID")%></td>
                <td><%=itemlist.getString("SERIAL")%></td>
                <td><%=itemlist.getString("NAME")%></td>
                <td><%=itemlist.getString("DESCRIPTION")%></td>
                <td><%=itemlist.getInt("QUANTITY")%></td>
                <td><%=itemlist.getDate("DATEADDED")%></td>
                <td><%if (itemlist.getBoolean("BORROWABLE") == true){%>Yes<%} else {%>No<%}%></td>
                <td><center><div style="cursor: pointer;" data-toggle="modal" data-target="#myModal<%=itemlist.getString("ID")%>" id="qrcode<%=itemlist.getString("ID")%>"></div></center></td>
                <td style="display: none" class="dlt"><input id="terms_and_conditions" onclick="terms_changed(this)" type="checkbox" name="delete" value="<%=itemlist.getString("ID")%>"></td>
            </tr>
            
              <div id="myModal<%=itemlist.getString("ID")%>" class="modal fade" role="dialog">
                <div class="modal-dialog">

                  <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-6">
                                <div id="Mqrcode<%=itemlist.getString("ID")%>"></div>
                            </div>
                            <div class="col-xs-6" style="text-align: left">
                                <%=itemlist.getString("ID")%><br>
                                <%=itemlist.getString("SERIAL")%><br>
                                <%=itemlist.getString("NAME")%><br>
                                <%=itemlist.getString("DESCRIPTION")%><br>
                                <%=itemlist.getInt("QUANTITY")%><br>
                                <%=itemlist.getDate("DATEADDED")%><br>
                                <%if (itemlist.getBoolean("BORROWABLE") == true){%>Yes<%} else {%>No<%}%>
                            </div>
                        </div>
                    </div>
                  </div>

                </div>
              </div>
                    
            <script>
                function createQrCode()
                {
                    var userInput = "<%=itemlist.getString("ID")%>";

                    var qrcode = new QRCode("qrcode<%=itemlist.getString("ID")%>", {
                        text: userInput,
                        width: 30,
                        height: 30,
                        colorDark: "black",
                        colorLight: "white",
                        correctLevel : QRCode.CorrectLevel.H
                    });
                    var Mqrcode = new QRCode("Mqrcode<%=itemlist.getString("ID")%>", {
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
            
          
            <%}%>
        
        <tfoot>
                <th>ID</th>
                <th>Serial</th>
                <th>Name</th>
                <th>Description</th>
                <th>Quantity</th>
                <th>Date Added</th>
                <th>Borrowable</th>
                <th>QR</th>
                <th style="display: none" class="dlt"></th>
            </tfoot>
        </table>
        </div>
        </form>
    </center>
    </body>
    <%
    } else { 
        response.sendRedirect("error.jsp");
    }%>
</html>