<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
        String temail=request.getParameter("temail");
        String e=(String)h.get("email");
        
        db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
        if(db==null){
            db=new db.DBClass(); 
            application.setAttribute("DBCon", db);
        }
        ResultSet rs=db.getUser(temail);
        String tname=rs.getString(2);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PeopleTalk</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/talk.css" rel="stylesheet">

   
  </head>
  
  <body data-spy="scroll" data-target="#my-navbar">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="profile.jsp">PeopleTalk</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div class="navbar-text"><p>Welcome: <%=(String)h.get("name")%></p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="Logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav><!-- end of navbar-->
	
	</br>
	</br>
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
                                    <img src="GetPhoto?email=<%=rs.getString(1)%>" height="150" width="150">
				</div>
				<div class="col-lg-7">
					<form action="" class="form-horizontal">
						<div class="form-group">
                                                    <label for="name" class="control-label">Name: <font color="grey"><%=rs.getString(2)%></font></label><br>
							<label for="email" class="control-label">Email:<font color="grey"> <%=rs.getString(1)%></font></label><br>
							<label for="phone" class="control-label">Phone: <font color="grey"><%=rs.getString(3)%></font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey"><%=rs.getString(4)%></font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey"><%=rs.getString(5)%></font></label><br>
							
						</div>
					</form>
				</div>
			</div>
		</div>
		<br>
                           <%
                String m=(String)session.getAttribute("msg");
                if(m!=null){
                %>
                    <div class="panel">
                        <div class="panel-body bg-warning text-center">
                            <%=m%>
                        </div>
                    </div>
                <%   
                    session.setAttribute("msg",null);
                }
                %>
		<div class="container text-center">
			<div class="panel panel-default">
				<div class="panel-body text-center">
					<form action="TalkPro" method="post" data-toggle="validator" enctype='multipart/form-data' class="form-horizontal">
						<div class="form-group">
							<label for="message" class="col-lg-2 control-label">Message:</label>
								<div class="col-lg-4">
									<textarea id="message" name="msg" class="form-control" rows="5" cols="50" required></textarea>
								</div>
						</div><!--end form group-->
							<div class="form-group">
							<label for="filetosend" class="col-lg-2 control-label">File to Send:</label>
								<div class="col-lg-4">
									<input type="file" name="ufile" class="form-control" id="filetosend"/>
								</div>
                                                        <input type="hidden" name="temail" value="<%=temail%>" />
								<div class="col-lg-2">
									<button type="submit" class="btn btn-primary">Send</button>
								</div>
						</div><!--end form group-->
					</form>
				</div>
			</div>
		</div>
		<div class="container text-center">
			<div class="panel panel-default">
				<div class="panel-body text-center">
					<div class="row">
						<div class="col-lg-6">
							<div class="panel panel-default">
								<div class="panel-heading text-center">
                                                                    <h5><%=h.get("name")%>'s Messages</h5>
								</div>
                                                                <%
                                                                 rs=db.getMsg((String)h.get("email"), temail);
                                                                 while(rs.next()){
                                                                %>
								<div class="panel-body text-left">
                                                                    <p><%=rs.getString(5)%></p>
									<div class="row">
										<font size="1">
										<div class="form-group">
                                                                                        <%
                                                                                            String fn=rs.getString(6);
                                                                                            if(fn!=null){
                                                                                        %>
											<div class="col-lg-2">
                                                                                            <label for="message" class="control-label">File: <a href="DownloadFile?pid=<%=rs.getInt(1)%>"> <%=fn%> </a></label>
											</div>
                                                                                        <%}%>
											<div class="col-lg-2">
												<label for="date" class="control-label">Date: <%=rs.getString(4)%></label>
											</div>
										</div>
										</font>
									</div>
									<hr>
								</div>
                                                                <%}%>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="panel panel-default">
								<div class="panel-heading text-center">
									<h5><%=tname%>'s Messages</h5>
								</div>
                                                                <%
                                                                 rs=db.getMsg( temail,(String)h.get("email"));
                                                                 while(rs.next()){
                                                                %>
								<div class="panel-body text-left">
									<p><%=rs.getString(5)%></p>
									<div class="row">
										<font size="1">
										<div class="form-group">
                                                                                        <%
                                                                                            String fn=rs.getString(6);
                                                                                            if(!fn.equals("")){
                                                                                        %>
											<div class="col-lg-2">
                                                                                            <label for="message" class="control-label">File: <a href="DownloadFile?pid=<%=rs.getInt(1)%>"> <%=fn%> </a></label>
											</div>
                                                                                        <%}%>
											<div class="col-lg-2">
												<label for="message" class="control-label">Date: <%=rs.getString(4)%></label>
											</div>
										</div>
										</font>
									</div>
									<hr>
								</div>
                                                             <%}%>                           
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<hr>
	
	<!--footer-->
	
	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-text pull-left">
				<p>Design and Develop by INCAPP</p>
			</div>
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-2.2.2.min.js"></script>
    <script src="js/validator.js"></script>
  </body>
</html>
<%
}else{
    session.setAttribute("msg","Plz Login First!");
response.sendRedirect("home.jsp");
}
%>