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
public class delete extends HttpServlet {

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
            String delete_items = config.getInitParameter("delete_items");
            String delete_borrowable = config.getInitParameter("delete_borrowable");
            String display = config.getInitParameter("display");
            
            if (conn != null){                
                String[] id = request.getParameterValues("delete");
                
                String query = "";
                
                for(int i = 0; i < id.length; i++){
                    if (i == id.length-1){
                        query = query + id[i];
                    } else {
                        query = query + id[i] + ",";
                    }
                }
                
                PreparedStatement ps = conn.prepareStatement(delete_items);
                ps.setString(1, query);
                
                PreparedStatement ps1 = conn.prepareStatement(delete_borrowable);
                ps1.setString(1, query);
                
                ps.executeUpdate();
                ps1.executeUpdate();

                PreparedStatement ps2 = conn.prepareStatement(display);
                ResultSet rs = ps2.executeQuery();
                
                request.setAttribute("itemlist", rs);
                request.setAttribute("message", "Inventory updated.");
                
                request.getRequestDispatcher("list.jsp").forward(request,response);
                
                rs.close();
                ps.close();
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(delete.class.getName()).log(Level.SEVERE, null, ex);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(delete.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
