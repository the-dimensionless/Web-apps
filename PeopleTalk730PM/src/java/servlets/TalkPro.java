/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

 @MultipartConfig
public class TalkPro extends HttpServlet {

   
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    HttpSession session=request.getSession();
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
        try{
    String e=(String)h.get("email");
    String temail=request.getParameter("temail");
    String m=request.getParameter("msg");
    
    Part p=request.getPart("ufile");
    String fname;
    java.io.InputStream is;
    if(p!=null){
        is = p.getInputStream();
        fname=p.getSubmittedFileName();
    }else{
        is=null;
        fname=null;
    }
    ServletContext application=getServletContext();
    db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
    if(db==null){
        db=new db.DBClass(); 
        application.setAttribute("DBCon", db);
    }
    String s=db.insertMsg(e,temail,m,fname,is);
    
    if(s.equalsIgnoreCase("Done")){
        session.setAttribute("msg","Message Send Done.");
    }else if(s.equalsIgnoreCase("Error")){
        session.setAttribute("msg","Message Send Failed.");
    }else if(s.equalsIgnoreCase("Exception")){
        session.setAttribute("msg","Message Send Failed.(Exception Occured)");
    }
   response.sendRedirect("talk.jsp?temail="+temail);
        }catch(Exception e){
            e.printStackTrace();
        }
    }else{
        session.setAttribute("msg","Plz Login First!");
        response.sendRedirect("home.jsp");
    }
    }

}
