<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%
    String e=request.getParameter("email");
    db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
    if(db==null){
        db=new db.DBClass(); 
        application.setAttribute("DBCon", db);
    }
    ResultSet rs=db.getUser(e);
    if(rs!=null){
        String pass=rs.getString("pass");
        //mail send Code
        try{
            final String AEMAIL="";
            final String APASS="";
            String SEMAIL=e;
            String SUB="Password send Success";
            String BODY="Your Id: "+e+" <br/> Password= "+pass;
            Properties props=new Properties();
            props.put("mail.smtp.host","smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port","465");
            props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth","true");
            props.put("mail.smtp.port","465");
            Session ses=Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication(){
                            return new PasswordAuthentication(AEMAIL,APASS);
                        }
                    }
                    );

            Message message=new MimeMessage(ses);
            message.setFrom(new InternetAddress(AEMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SEMAIL));
            message.setSubject(SUB);
            message.setContent(BODY,"text/html" );

            Transport.send(message);
            session.setAttribute("msg","Mail Send Success. Check your mail to get password.");
            response.sendRedirect("home.jsp");
        }
        catch(Exception ex){
            ex.printStackTrace();
            session.setAttribute("msg","Mail send Failed("+ex+")!");
            response.sendRedirect("home.jsp");
        }
    }else{
        session.setAttribute("msg","Email Id is NOT Registered. Plz SignUP First!");
        response.sendRedirect("home.jsp");
    }
%>