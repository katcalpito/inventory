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
public class create extends HttpServlet {

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
            String add = config.getInitParameter("add");
            String add_control = config.getInitParameter("add_control");
            String items_last_insert = config.getInitParameter("items_last_insert");
            
            if (conn != null){                
                String serial = request.getParameter("serial");
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                boolean borrowable = Boolean.valueOf(request.getParameter("borrowable"));
                String message = null;
                
                PreparedStatement ps = conn.prepareStatement(add);
                ps.setString(1, serial);
                ps.setString(2, name);
                ps.setString(3, description);
                ps.setInt(4, quantity);
                ps.setBoolean(5, borrowable);
                
                int success = ps.executeUpdate();
                
                if (success == 1){
                    PreparedStatement ps2 = conn.prepareStatement(items_last_insert);
                    ResultSet rs2 = ps2.executeQuery();
                    int id = 0;
                    
                    while (rs2.next()){
                        id = rs2.getInt("ID");
                    }
                    
                    if (borrowable == true){
                        PreparedStatement ps1 = conn.prepareStatement(add_control);
                        ps1.setInt(1, id);
                        
                        for (int i = 1; i <= quantity; i++){
                            ps1.setInt(2, i);
                            ps1.executeUpdate();
                        }
                        ps1.close();
                    }
                    message = "Item inserted into inventory.";
                    request.setAttribute("message", message);
                    request.setAttribute("item", rs2);
                    request.getRequestDispatcher("generate.jsp").forward(request,response);
                    
                    rs2.close();
                    ps.close();
                    ps2.close();
                    conn.close();
                } else {
                    request.getRequestDispatcher("index.html").forward(request,response);
                }
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
