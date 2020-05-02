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
        
        
        <script>
        $(document).ready(function() {
    $('#example').DataTable();
} );
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
     try{%>
     <% ResultSet itemlist = (ResultSet)request.getAttribute("itemlist");%>
    <body style="padding: 0; margin: 0">
    <center>        
        <div class="container" style="padding:0; margin:0; width: 100%">
        <p style="color:red"><%if(request.getAttribute("message")!=null){%><%=request.getAttribute("message")%><%} else {%></p>
            <table id="example" class="table table-striped table-bordered" style="width:100%">
            <thead style="width: 100%">
                <th style="width: 5%">ID</th>
                <th style="width: 10%">Serial</th>
                <th style="width: 15%">Name</th>
                <th style="width: 5%">Control</th>
                <th style="width: 10%">Borrow Date</th>
                <th style="width: 10%">Specified Return</th>
                <th style="width: 10%">Actual Return</th>
                <th style="width: 15%">Borrower</th>
                <th style="width: 10%">Employee</th>
                <th style="width: 10%">Status</th>
            </thead>
            
         <%while (itemlist.next()){%>
            <tr>
                <td><%=itemlist.getInt("ITEM_ID")%></td>
                <td><%=itemlist.getString("SERIAL")%></td>
                <td><%=itemlist.getString("NAME")%></td>
                <td><%=itemlist.getString("CONTROL")%></td>
                <td><%if (itemlist.getDate("BORROW_DATE") != null){%><%=itemlist.getDate("BORROW_DATE")%><%}%></td>
                <td><%if (itemlist.getDate("SPECIFIED_RETURN_DATE") != null){%><%=itemlist.getDate("SPECIFIED_RETURN_DATE")%><%}%></td>
                <td><%if (itemlist.getDate("ACTUAL_RETURN_DATE") != null){%><%=itemlist.getDate("ACTUAL_RETURN_DATE")%><%}%></td>
                <td><%if (itemlist.getString("BORROWER_ID") != null){%><%=itemlist.getString("BORROWER_ID")%><%}%></td>
                <td><%if (itemlist.getString("EMPLOYEE_SIGN") != null){%><%=itemlist.getString("EMPLOYEE_SIGN")%><%}%></td>
                <td><%if (itemlist.getDate("BORROW_DATE") == null){%>
                        <p style="color:green">In Warehouse</p>
                    <%} else if (itemlist.getDate("BORROW_DATE") != null && itemlist.getDate("ACTUAL_RETURN_DATE") == null) {%>
                        <p style="color: gold">With Client</p>
                    <%} else if (itemlist.getDate("BORROW_DATE") != null && itemlist.getDate("ACTUAL_RETURN_DATE") != null) {%>
                        <p style="color:green">In Warehouse</p>
                    <%}%>
                </td>
            </tr>
            
            
          
            <%}}%>
        
        <tfoot>
                <th>ID</th>
                <th>Serial</th>
                <th>Name</th>
                <th>Control</th>
                <th>Borrow Date</th>
                <th>Specified Return</th>
                <th>Actual Return</th>
                <th>Borrower</th>
                <th>Employee</th>
                <th>Status</th>
            </tfoot>
        </table>
        </div>
    </center>
    </body>
    <%} catch (Exception e) {
        response.sendRedirect("dashboard.jsp");
    }
     
     } else { 
        response.sendRedirect("error.jsp");
    }%>
</html>