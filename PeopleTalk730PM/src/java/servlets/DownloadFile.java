/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class DownloadFile extends HttpServlet {

   
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            int p=Integer.parseInt(request.getParameter("pid"));
            ServletContext application=getServletContext();
            db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
            if(db==null){
                db=new db.DBClass(); 
                application.setAttribute("DBCon", db);
            }
            ResultSet rs=db.getFile(p);
            if(rs!=null)
            {
                String fname=rs.getString(1);
                response.setContentType("APPLICATION/OCTET-STREAM");   
                response.setHeader("Content-Disposition","attachment; filename="+fname); 
                response.getOutputStream().write(rs.getBytes(2)); 
                
            }
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
