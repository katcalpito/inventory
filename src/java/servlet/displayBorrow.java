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
public class displayBorrow extends HttpServlet {

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
                String display = config.getInitParameter("display");

                if (conn != null){
                    PreparedStatement ps = conn.prepareStatement(display);
                    ResultSet rs = ps.executeQuery();

                    request.setAttribute("itemlist", rs);
                    request.setAttribute("message", null);

                    request.getRequestDispatcher("listBorrow.jsp").forward(request,response);

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
