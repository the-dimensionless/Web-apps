<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PeopleTalk</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/custom.css" rel="stylesheet">
	
	<script language="Javascript" src="js/jquery.js"></script>
	<script type="text/JavaScript" src='js/state.js'></script>
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
	</nav>
	</br>
	</br>
		<div class="container">
			<section>
                            <%
                    String m=(String)session.getAttribute("msg");
                    if(m!=null){
                    %>
                        <div class="panel">
                            <div class="panel-body bg-danger text-center">
                                <%=m%>
                            </div>
                        </div>
                    <%   
                        session.setAttribute("msg",null);
                    }
                    %>
			<div class="row">
				<div class="col-lg-6">
					<div class="col-lg-4">
                                            <%
                db.DBClass db=(db.DBClass)application.getAttribute("DBCon");
                if(db==null){
                    db=new db.DBClass(); 
                    application.setAttribute("DBCon", db);
                }
                ResultSet rs=db.getUser((String)h.get("email"));
                if(rs.getBinaryStream(10).read()!=-1){
                 %>
                <img src="GetPhoto?email=<%=(String)h.get("email")%>" width="120" height="150">                            
                <%   
                }else{
                 %>
                <img src="img/xyz.jpg" width="120" height="150">                           
                <%    
                }
                                            %>
                                            
                                            
					</div>
					<div class="col-lg-6">
							<form action="" class="form-horizontal">
								<div class="form-group">
									<label for="email" class="control-label">Name: <font color="grey"><%=(String)h.get("name")%></font></label>
								</div><!--end form group-->
								<div class="form-group">
									<label for="name" class="control-label">Email:<font color="grey"> <%=(String)h.get("email")%></font></label>
								</div><!--end form group-->
								<div class="form-group">
									<label for="gender" class="control-label">Gender: <font color="grey"><%=(String)h.get("gender")%></font></label>
								</div><!--end form group-->
                                                                <div class="form-group">
									<label for="phone" class="control-label">Phone: <font color="grey"><%=(String)h.get("phone")%></font></label>
								</div><!--end form group-->
								<div class="form-group">
									<label for="dob" class="control-label">Date of Birth: <font color="grey"><%=(String)h.get("dob")%></font></label>
								</div>
								</div><!--end form group-->
								<div class="col-lg-10 form-group">
									<label for="state" class="control-label">Address: <font color="grey"><%=(String)h.get("area")%>, <%=(String)h.get("city")%>,<%=(String)h.get("state")%></font></label>
								</div><!--end form group-->
								<div class="form-group">
									<div class="col-lg-10 form-group">
										<button type="submit" class="btn btn-primary" formaction="editprofile.jsp">Edit Profile</button>
										<button type="submit" class="btn btn-primary" formaction="changepassword.jsp">Change Password</button>
									</div>		
								</div>
							</form>
					</div>
				<div class="col-lg-6">
					<div class="panel panel-default">
						<div class="panel-heading text-center">
							<h3>Search People</h3>
						</div>
						<div class="panel-body">
							<form action="peoplesearch.jsp" method="post" class="form-horizontal">
								<div class="form-group">
									<label for="state" class="col-lg-3 control-label">State:</label>
									<div class="col-lg-9">
										<select class="form-control" name='state' id="listBox" onchange='selct_district(this.value)'>
											
										</select>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="city" class="col-lg-3 control-label">City:</label>
										<div class="col-lg-9">
											<select class="form-control" name='city' id='secondlist'>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="area" class="col-lg-3 control-label">Area:</label>
									<div class="col-lg-9">
										
										<input type="text" name="area" class="form-control" id="area" placeholder="Enter your Area"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-10 col-lg-offset-3">
										<button type="search" class="btn btn-primary">Search</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
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
  </body>
</html>
<%
    }else{
        session.setAttribute("msg","Plz Login First");
        response.sendRedirect("home.jsp");
    }
%>