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
import javax.servlet.http.HttpSession;
import model.account;

/**
 *
 * @author user
 */
public class login extends HttpServlet {

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
            throws ServletException, IOException {
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
                String login = config.getInitParameter("login");
                String username = "";
                
                boolean loginvalid = false;
                account account = new account();

                HttpSession session = request.getSession(true);
                username = request.getParameter("username");
                String password = request.getParameter("password");

                PreparedStatement ps = conn.prepareStatement(login);
                ps.setString(1, username);

                ResultSet rs = ps.executeQuery();

                while(rs.next()){
                    if (username.equals(rs.getString("USERNAME")) && password.equals(rs.getString("PASSWORD"))){
                        loginvalid = true;
                        account.setDetails(username, rs.getString("NAME"), rs.getString("LEVEL"), rs.getString("MOBILE"));
                    } 
                }
                ps.close();
                rs.close();

                if (loginvalid == false){
                    request.setAttribute("message", "Incorrect username or password. Please try again.");
                    request.getRequestDispatcher("index.jsp").forward(request,response);
                } else {
                    session.setAttribute("account", account);
                    request.getRequestDispatcher("add.jsp");
                    request.getRequestDispatcher("list.jsp");
                    request.getRequestDispatcher("scan.jsp");
                    request.getRequestDispatcher("generate.jsp");
                    request.getRequestDispatcher("listBorrow.jsp");
                    request.getRequestDispatcher("dashboard.jsp").forward(request,response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
