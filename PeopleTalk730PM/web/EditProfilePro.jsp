<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
        db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
        if(db==null){
            db=new db.DBClass(); 
            application.setAttribute("DBCon", db);
        }
        Statement st=db.getSt();
        String email=(String)h.get("email");
    
        String name=request.getParameter("name");
        String gender=request.getParameter("gender");
        String d=request.getParameter("dob");
        String phone=request.getParameter("phone");
        String state=request.getParameter("state");
        String city=request.getParameter("city");
        String area=request.getParameter("area");
        if(!name.equalsIgnoreCase("")){
            st.executeUpdate("update user_info set name='"+name+"' where email='"+email+"'");
            h.put("name", name);
        }
        if(!gender.equalsIgnoreCase((String)h.get("gender"))){
            st.executeUpdate("update user_info set gen='"+gender+"' where email='"+email+"'");
            h.put("gender", gender);
        }
        if(!d.equalsIgnoreCase("")){
            java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy");
            java.util.Date dt=sdf.parse(d);
            java.sql.Date dob=new java.sql.Date(dt.getTime());
            st.executeUpdate("update user_info set dob='"+dob+"' where email='"+email+"'");
            h.put("dob", d);
        }
        if(!phone.equalsIgnoreCase("")){
            st.executeUpdate("update user_info set phone='"+phone+"' where email='"+email+"'");
            h.put("phone", phone);
        }
        if(!state.equalsIgnoreCase("select state")){
            st.executeUpdate("update user_info set state='"+state+"', city='"+city+"' where email='"+email+"'");
            h.put("state", state);
            h.put("city", city);
        }
        if(!area.equalsIgnoreCase("")){
            st.executeUpdate("update user_info set area='"+area+"' where email='"+email+"'");
            h.put("area", area);
        }
        response.sendRedirect("profile.jsp");
}else{
    session.setAttribute("msg","Plz Login First!");
response.sendRedirect("home.jsp");
}
%>