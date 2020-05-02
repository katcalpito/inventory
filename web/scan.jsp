
<jsp:useBean id="account" scope="session" class="model.account" />
<!DOCTYPE html>
<html>
  <head>
    <title>scan</title>
    <script type="text/javascript" src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js" ></script>	
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
        <link href="https://fonts.googleapis.com/css?family=Raleway:400 |Montserrat:900|Oleo+Script&display=swap" rel="stylesheet">
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
  <body>
    <video id="preview"></video>
    
    
        <!-- Modal -->
  <div class="modal fade" id="message" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-body">
            <center>
            <p style="color:red"><%=request.getAttribute("message")%></p>
            </center>
        </div>
      </div>
      
    </div>
  </div>
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-body">
            <form action="update" method="POST">
                <center>
                    <div class="row">
                        <div class="col-xs-4">
                            <button type="button" class="main-button" onclick="showQty()">Update Quantity</button><br><br>
                            <button type="button" class="main-button" onclick="showBrw()">Send to Client</button><br><br>
                            <button type="button" class="main-button" onclick="showRcv()">Set As Returned</button><br><br>
                            <button type="submit" class="main-button" onclick="showDts()" name="button" value="generate">See Item Details</button><br>
                        </div>
                        <div class="col-xs-8">
                            <div id="1" style="display:none">
                                Stock to add/subtract: <input id="stocktoadd" type="number" name="stocktoadd"/><br><br>
                                <button type="submit" class="sec-button" name="button" value="quantity">Add</button>
                            </div>
                            <div id="2" style="display: none">
                                Control Number: <input type="number" id="control" name="control"/><br>
                                Destination: <input type="text" id="destination" name="destination"/><br>
                                Rent Date: <input type="date" id="rentdate" name="rentdate"/><br>
                                Return Date (Optional): <input type="date" id="returndate" name="returndate"/><br><br>
                                <button type="submit"  class="sec-button" name="button" value="send">Update Database</button>
                            </div>
                            <div id="3" style="display:none">
                                Control Number: <input type="number" id="control_received" name="control_received"/><br><br>
                                <button type="submit" class="sec-button" name="button" value="received">Set Received</button>
                            </div>
                        </div>
                <input type="hidden" name="id" id="id" value=""/>
                </div>
                </center>
            </form>
        </div>
      </div>
      
    </div>
  </div>
    <script>
        <%if(request.getAttribute("message")!=null){%>
            $(window).on('load',function(){
                $('#message').modal('show');
            });
        <%}%>
        
        document.getElementById("rentdate").onchange = function () {
            document.getElementById("returndate").setAttribute("min", this.value);
        }

        function showQty(){
            document.getElementById('1').style.display='block';
            document.getElementById('2').style.display='none';
            document.getElementById('3').style.display='none';
            document.getElementById("control").required = false;
            document.getElementById("destination").required = false;
            document.getElementById("rentdate").required = false;
            document.getElementById("stocktoadd").required = true;
            document.getElementById("control_received").required = false;
        }
        
        function showDts(){
            document.getElementById("control").required = false;
            document.getElementById("destination").required = false;
            document.getElementById("rentdate").required = false;
            document.getElementById("stocktoadd").required = false;
            document.getElementById("control_received").required = false;
        }
        
        function showBrw(){
            document.getElementById('1').style.display='none';
            document.getElementById('2').style.display='block';
            document.getElementById('3').style.display='none';
            document.getElementById("control").required = true;
            document.getElementById("destination").required = true;
            document.getElementById("rentdate").required = true;
            document.getElementById("stocktoadd").required = false;
            document.getElementById("control_received").required = false;
        }
        
        function showRcv(){
            document.getElementById('1').style.display='none';
            document.getElementById('2').style.display='none';
            document.getElementById('3').style.display='block';
            document.getElementById("control").required = false;
            document.getElementById("destination").required = false;
            document.getElementById("rentdate").required = false;
            document.getElementById("stocktoadd").required = false;
            document.getElementById("control_received").required = true;
        }
        
        let scanner = new Instascan.Scanner(
            {
                video: document.getElementById('preview')
            }
        );
        scanner.addListener('scan', function(content) {
            $("#myModal").modal();
            $("#id").val( 
              content); 
             
        });
        Instascan.Camera.getCameras().then(cameras => 
        {
            if(cameras.length > 0){
              var selected = cameras[0];
              var i = 0;
              
               while (i < cameras.length){
                 if (cameras[i].name.indexOf('back') != -1) {
            alert(cameras[i].name);
                 selected = cameras[i];
        }
                 i++;
               };
              
                scanner.start(selected);
            } else {
                console.error("No camera exists.");
            }
        });
    </script>

 </body>
 <%} else { 
        response.sendRedirect("error.jsp");
    }%>
</html>