<!doctype html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.sql.*" %>
<%@include file="conn.jsp" %>

<%

Connection connection = null;
Statement statement = null;

%>
<%
String meterid = "ori";
String date = null;
String consumpid = "no record";
String consumption = "no record";
String monthg = request.getParameter("month");


    

connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"canviodb", "root", "");
statement=connection.createStatement();
String sql ="select * from smartmeter where userID='" +session.getAttribute("userid")+"'";

ResultSet resultSet = statement.executeQuery(sql);
while(resultSet.next()){
     meterid = resultSet.getString("meterID");
  }

/*
if(request.getParameter("month")!=null){
 
    out.println("alert('ssdd');");
ResultSet resultSet2 = statement.executeQuery("SELECT * FROM `consumption` WHERE month(dateTime) ='"+request.getParameter("month")+"';");
while(resultSet2.next()){
        consumpid = resultSet2.getString("comsumptionID"); 
        consumption = resultSet2.getString("consumption"); 
     }
}
*/


%>


<!doctype html>
<html lang="en">
   
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Electrical Consumption</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="assets/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="assets/css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="assets/css/pe-icon-7-stroke.css" rel="stylesheet" />
    
    

</head>
<body>

<div class="wrapper">
    <div class="sidebar" data-color="purple" data-image="assets/img/sidebar-5.jpg">

    <!--   you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple" -->


    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="dashboard.jsp" class="simple-text">
                    Canviocity
                     
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="dashboard.jsp">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li>
                    <a href="user.jsp">
                        <i class="pe-7s-user"></i>
                        <p>User Profile</p>
                    </a>
                </li>
                <li >
                    <a href="complaint.jsp">
                        <i class="pe-7s-note2"></i>
                        <p>Complaint</p>
                    </a>
                </li>
                <li class="active">
                    <a href="consumption.jsp">
                        <i class="pe-7s-rocket"></i>
                        <p>Consumptions</p>
                    </a>
                </li>
				<li class="active-pro">
                    <a href="upgrade.html">
                        <i class="pe-7s-rocket"></i>
                        <p>Upgrade to PRO</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>

    <div class="main-panel">
		        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Dashboard</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-dashboard"></i>
								<p class="hidden-lg hidden-md">Dashboard</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-globe"></i>
                                    <b class="caret hidden-lg hidden-md"></b>
									<p class="hidden-lg hidden-md">
										5 Notifications
										<b class="caret"></b>
									</p>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
                        <li>
                           <a href="">
                                <i class="fa fa-search"></i>
								<p class="hidden-lg hidden-md">Search</p>
                            </a>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                  <!--declare session-->
                                  
                                  <p><% out.println(session.getAttribute("userid"));%><b class="caret"></b></p>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="user.jsp">Profile</a></li>
                                <li><a href="#">Setting</a></li>
                                <li><a href="logout.jsp">Logout</a></li>
                              </ul>
                        </li>
						<li class="separator hidden-lg"></li>
                    </ul>
                </div>
            </div>
        </nav>

<!---Start Complaint--->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <center><h4 class="title" >Electrical Consumption</h4>
                                <p class="category">Customer Service</p></center>
                            </div>
                            
                            <div class="content">
                                
                                    <div class="typo-line">
                                        <form action="CoServlet" method='post'>
                                            

                                             <div>
                                                 <h5>For :</h5> <select name="month">
                                                     <option disabled selected value> -- Select month-- </option>
                                                    <option value="1">January</option>
                                                    <option value="2">February</option>
                                                    <option value="3">March</option>
                                                    <option value="4">April</option>
                                                    <option value="5">May</option>
                                                    <option value="6">June</option>
                                                    <option value="7">July</option>
                                                    <option value="8">August</option>
                                                    <option value="9">September</option>
                                                    <option value="10">October</option>
                                                    <option value="11">November</option>
                                                    <option value="12">December</option>
                                                    
                                                </select>
                                               
                                             </div>
                                            
                                             <br>
                                             <br>
                                             <input class="btn btn-info btn-fill pull-center" type="submit" value="Submit"/>
                                             <br>
                                             <br>
                                             

                                             <form>
                                             <div class='form-row'>
                                                 <div> <h5>Result :</h5>  <h4>Meter ID : <%=meterid%></h4>
                                                         <% 
                                                             if(request.getAttribute("consumpid")!=null){
                                                             out.println("<h4>Consumption ID:"+request.getAttribute("consumpid")+"</h4>");
                                                             }
                                                             else 
                                                                 out.println("<h4>Total Consumption: No Record </h4>");  
                                                             out.println("<h4>Month:"+request.getAttribute("month")+"</h4>");
                                                             if(request.getAttribute("consumption")!=null){
                                                             out.println("<h4>Total Consumption:"+request.getAttribute("consumption")+"</h4>");  
                                                             }
                                                             else 
                                                                 out.println("<h4>Total Consumption: No Record </h4>");  
                                                             
                                                         
                                                       
                                                           
                                                        %>
                                                 </div>
               
                                             </div>
                                                     
                                             </form> 
                                               
                                             
                                        </form>
                                    </div>
                                
                            </div>
                        </div>                
                    </div>           
                </div>                 
            </div>                    
        </div>
                                
 <!---End Editing Part--->                               
        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>
                        <li>
                            <a href="#">
                                Home
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Company
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Portfolio
                            </a>
                        </li>
                        <li>
                            <a href="#">
                               Blog
                            </a>
                        </li>
                    </ul>
                </nav>
                <p class="copyright pull-right">
                    &copy; <script>document.write(new Date().getFullYear())</script> Team Canviocity, made with love for a future
                </p>
            </div>
        </footer>


    </div>
</div>


</body>

        <!--   Core JS Files   -->
    <script src="assets/js/jquery.3.2.1.min.js" type="text/javascript"></script>
	<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Charts Plugin -->
	<script src="assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>

    <!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<script src="assets/js/light-bootstrap-dashboard.js?v=1.4.0"></script>

	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="assets/js/demo.js"></script>

</html>

