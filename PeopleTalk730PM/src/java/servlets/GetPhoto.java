/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author k
 */
public class GetPhoto extends HttpServlet {

    
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        HashMap h=(HashMap)session.getAttribute("UserDetails");
        if(h!=null){
            try {
                ServletContext application=getServletContext();
                db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
                if(db==null){
                    db=new db.DBClass(); 
                    application.setAttribute("DBCon", db);
                }
                String e=request.getParameter("email");
                //System.out.println(e);
                ResultSet rs=db.getUser(e);
                if(rs!=null){
                    response.getOutputStream().write(rs.getBytes(10));
                }else{
                    response.getOutputStream().write(null);
                }
                response.getOutputStream().flush();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }else{
            session.setAttribute("msg","Plz Login First!");
            response.sendRedirect("home.jsp");
        }
    }

}
