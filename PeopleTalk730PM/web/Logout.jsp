<%@page import="java.util.HashMap"%>
<%
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
        session.invalidate();
    }else{
        session.setAttribute("msg","Plz Login First");
    }
    response.sendRedirect("home.jsp");
%>