/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
public class update extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
            ServletConfig config = getServletConfig();
            ServletContext context = getServletContext();
            Class.forName(context.getInitParameter("jdbcClassName"));
            String dbusername = context.getInitParameter("dbUserName");
            String dbpassword = context.getInitParameter("dbPassword");
            StringBuffer url = new StringBuffer(context.getInitParameter("jdbcDriverURL"))
                .append("://")
                .append(context.getInitParameter("dbHostName"))
                .append(":")
                .append(context.getInitParameter("dbPort"))
                .append("/")
                .append(context.getInitParameter("databaseName"))
                .append("?")
                .append("useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=GMT&useSSL=false");
            Connection conn = 
              DriverManager.getConnection(url.toString(),dbusername,dbpassword);
            String update_inventory = config.getInitParameter("update_inventory");
            String see_details = config.getInitParameter("see_details");
            String borrow = config.getInitParameter("borrow");
            String borrowed = config.getInitParameter("borrowed");
            String update_control = config.getInitParameter("update_control");
            String update_return = config.getInitParameter("update_return");
            
            if (conn != null){                
                String button = request.getParameter("button");
                int item_id = Integer.parseInt(request.getParameter("id"));
                if (button.equals("quantity")){
                    int stocktoadd = Integer.parseInt(request.getParameter("stocktoadd"));
                    
                    PreparedStatement ps = conn.prepareStatement(update_inventory);
                    ps.setInt(1, stocktoadd);
                    ps.setInt(2, item_id);
                    
                    String message = null;
                
                    try {
                        ps.executeUpdate();
                    } catch (Exception e){
                        message = "Failed to update stock. Number entered will result in a negative value.<br>Check item details and try again.";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("scan.jsp").forward(request,response);
                    }
                    
                    message = "Stock quantity successfully updated.";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("scan.jsp").forward(request,response);
                    ps.close();
                } else if (button.equals("generate")) {
                    PreparedStatement ps = conn.prepareStatement(see_details);
                    ps.setInt(1,item_id);
                    ResultSet rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        rs.beforeFirst(); 
                        request.setAttribute("item", rs);
                        request.getRequestDispatcher("generate.jsp").forward(request,response);
                    } else {
                        request.setAttribute("message", "Item not in inventory.");
                        request.getRequestDispatcher("scan.jsp").forward(request,response);
                    }
                    rs.close();
                    ps.close();
                } else if (button.equals("send")){
                    PreparedStatement ps = conn.prepareStatement(borrow);
                    ps.setInt(1,item_id);
                    ResultSet rs = ps.executeQuery();
                    boolean borrowable = false;
                    int control_number = Integer.parseInt(request.getParameter("control"));
                    String destination = request.getParameter("destination");
                    String borrow_date = request.getParameter("rentdate");
                    String return_date = request.getParameter("returndate");
                    String message = null;
                    
                    while (rs.next()){
                        if (rs.getBoolean("BORROWABLE") == true){
                            borrowable = true;
                        }
                    }
                    
                    if (borrowable == true){
                        boolean borrow_check = false;
                        PreparedStatement ps1 = conn.prepareStatement(borrowed);
                        ps1.setInt(1, item_id);
                        ps1.setInt(2, control_number);
                        
                        ResultSet rs1 = ps1.executeQuery();
                        
                        while (rs1.next()){
                            if (rs1.getDate("borrow_date") == null){
                                borrow_check = true;
                            }
                        }
                        
                        if (borrow_check == true){
                            PreparedStatement ps2 = conn.prepareStatement(update_control);
                            ps2.setString(1, borrow_date);
                            ps2.setDate(2, null);
                            if (return_date.equals("")){
                                ps2.setDate(3, null);
                            } else {
                                ps2.setString(3, return_date);
                            }
                            ps2.setInt(4, 1);
                            ps2.setString(5, "admin");
                            ps2.setInt(6, item_id);
                            ps2.setInt(7, control_number);

                            ps2.executeUpdate();
                            message = "Rent details updated.";
                            request.setAttribute("message", message);
                            request.getRequestDispatcher("scan.jsp").forward(request,response);
                            ps.close();
                            ps2.close();
                            rs.close();
                        } else {
                            message = "Item scanned is currently rented by a client. Try again.";
                            request.setAttribute("message", message);
                            request.getRequestDispatcher("scan.jsp").forward(request,response);
                            ps1.close();
                            rs1.close();
                            ps.close();
                            rs.close();
                        }
                    } else {
                        message = "Item scanned is not borrowable. Try again.";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("scan.jsp").forward(request,response);
                        ps.close();
                        rs.close();
                    }
                } else if (button.equals("received")){
                    int control = Integer.parseInt(request.getParameter("control_received"));
                    PreparedStatement ps = conn.prepareStatement(borrow);
                    ps.setInt(1,item_id);
                    ResultSet rs = ps.executeQuery();
                    boolean borrowable = false;
                    String message = null;
                    
                    while (rs.next()){
                        if (rs.getBoolean("BORROWABLE") == true){
                            borrowable = true;
                        }
                    }
                    
                    if (borrowable == true){
                        boolean borrow_check = false;
                        PreparedStatement ps1 = conn.prepareStatement(borrowed);
                        ps1.setInt(1, item_id);
                        ps1.setInt(2, control);
                        
                        ResultSet rs1 = ps1.executeQuery();
                        
                        while (rs1.next()){
                            if (rs1.getDate("borrow_date") != null){
                                borrow_check = true;
                            }
                        }
                        
                        if (borrow_check == true){
                            PreparedStatement ps2 = conn.prepareStatement(update_return);
                            ps2.setString(1, "admin");
                            ps2.setInt(2, item_id);
                            ps2.setInt(3, control);

                            ps2.executeUpdate();
                            message = "Rent details updated.";
                            request.setAttribute("message", message);
                            request.getRequestDispatcher("scan.jsp").forward(request,response);
                            ps.close();
                            ps2.close();
                            ps1.close();
                            rs.close();
                            rs1.close();
                        } else {
                            message = "Item scanned has not been rented to any client. Try again.";
                            request.setAttribute("message", message);
                            request.getRequestDispatcher("scan.jsp").forward(request,response);
                            ps1.close();
                            rs1.close();
                            ps.close();
                            rs.close();
                        }
                    } else {
                        message = "Item scanned is not borrowable. Try again.";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("scan.jsp").forward(request,response);
                        ps.close();
                        rs.close();
                    }
                }
                conn.close();
            } else {
                request.getRequestDispatcher("index.html").forward(request,response);
            }
            
            } catch (Exception e){
                out.print(e.toString());
            }
        } 
    }
    
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(create.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(create.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
