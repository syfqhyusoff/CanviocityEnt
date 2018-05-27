<%-- 
    Document   : dashboard
    Created on : Apr 12, 2018, 11:07:23 PM
    Author     : IMPOSSIBLEOO7
--%>
<%@page language="java" session="true" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.sql.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@include file="conn.jsp" %>
<%-- query and data from database --%>
 <% 
            String meterid = null;
            String category= null;
            String city= null;
            String negeri= null;
            String typepelan= null;
            Date remainingplan= null;
            double consump = 0 ;
            String monthpelan = null;
            String monthconsump = null;
            String dataPoints = null;
            String performance=null;

                Statement st = con.createStatement();
                ResultSet rs;
                rs = st.executeQuery("select * from smartmeter where userID='"+ session.getAttribute("userid")+"';" );  

                while(rs.next()){
                  meterid =  rs.getString("meterID");
                  category= rs.getString("category");
                city= rs.getString("City");
                negeri= rs.getString("Negeri");
                

            }
                ResultSet rs2;
                rs2 = st.executeQuery("select * from pelan where meterID='"+meterid+"' and status like 'active';" );  

                while(rs2.next()){
                remainingplan = rs2.getDate("endDate");
                typepelan = rs2.getString("type");
                
                }
                
                ResultSet rs3;
                rs3 = st.executeQuery("select * from consumption where meterID='"+meterid+"';" );
                while(rs3.next()){
                consump = rs3.getDouble("consumption");
                }
                
                 ResultSet rs4;
                rs4 = st.executeQuery("select consumption ,(CASE "+ 
                        "WHEN month(dateTime)=1 THEN 'January' " + 
                        "WHEN month(dateTime)=2 THEN 'February'" +
                        "WHEN month(dateTime)=3 THEN 'March'" +
                        "WHEN month(dateTime)=4 THEN 'April'" +
                        "WHEN month(dateTime)=5 THEN 'May'" +
                        "WHEN month(dateTime)=6 THEN 'June'" +
                        "WHEN month(dateTime)=7 THEN 'July'" +
                        "WHEN month(dateTime)=8 THEN 'August'" +
                        "WHEN month(dateTime)=9 THEN 'September'" +
                        "WHEN month(dateTime)=10 THEN 'October'" +
                        "WHEN month(dateTime)=11 THEN 'November'" +
                        "WHEN month(dateTime)=12 THEN 'December'" +
                        "ELSE 'The month error '" +
                         "END ) as monthly" +
                        " from consumption where meterID='"+meterid + "' ORDER BY dateTime DESC limit 1;" );
                while(rs4.next()){
                monthpelan = rs4.getString("monthly");
                monthconsump = rs4.getString("consumption");
                }
                  
          
                Gson gsonObj = new Gson();
                Map<Object,Object> map = null;
                List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
 
           
                    
                    
                String xVal, yVal;
                ResultSet rs5;

                        rs5 = st.executeQuery("select consumption ,(CASE "+ 
                        "WHEN month(dateTime)=1 THEN 'January' " + 
                        "WHEN month(dateTime)=2 THEN 'February'" +
                        "WHEN month(dateTime)=3 THEN 'March'" +
                        "WHEN month(dateTime)=4 THEN 'April'" +
                        "WHEN month(dateTime)=5 THEN 'May'" +
                        "WHEN month(dateTime)=6 THEN 'June'" +
                        "WHEN month(dateTime)=7 THEN 'July'" +
                        "WHEN month(dateTime)=8 THEN 'August'" +
                        "WHEN month(dateTime)=9 THEN 'September'" +
                        "WHEN month(dateTime)=10 THEN 'October'" +
                        "WHEN month(dateTime)=11 THEN 'November'" +
                        "WHEN month(dateTime)=12 THEN 'December'" +
                        "ELSE 'The month error '" +
                         "END ) as month" +
                        " from consumption where meterID='"+meterid + "' ORDER BY dateTime asc;" );

                    while(rs5.next()){
                            xVal = rs5.getString("month");
                            yVal = rs5.getString("consumption");
                            map = new HashMap<Object,Object>(); map.put("label", xVal); map.put("y", Double.parseDouble(yVal)); list.add(map);
                            dataPoints = gsonObj.toJson(list);
                    }
                    
                     
                ResultSet rs6;
                rs6 = st.executeQuery("select * from smartmeter where meterID='"+meterid+"';" );
                while(rs6.next()){
                performance = rs6.getString("performance");
                }
             
         %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Canviocity| Dashboard</title>

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

    <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->

    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="dashboard.jsp" class="simple-text">
                   	CanvioCity 
                </a>
            </div>

            <ul class="nav">
                <li class="active">
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
                <li>
                    <a href="complaint.jsp">
                        <i class="pe-7s-note2"></i>
                        <p>Complaint</p>
                    </a>
                </li>

                <li >
                    <a href="consumption.jsp">
                        <i class="pe-7s-rocket"></i>
                        <p>Consumption</p>
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


        <div class="content">
              <center><h3 class="title" >Meter Details</h3>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4" style="height: inherit">
                        <div class="card">

                            <div class="header">
                                <h3 class="title">User Info</h3>
                                <p class="category">User type : <%=typepelan%></p>
                            </div>
                            <div class="content">
                                <div class="row" style="margin : 10px; font-size:20px;">
        
                                </div>
                               	<div class="row" style="margin : 10px; font-size:20px;">
                                	Meter ID : <%=meterid%>
                                </div>
                                <div class="row" style="margin : 10px; font-size:20px;">
                                	Area : <%=city%>, <%=negeri%>
                                </div>
                                <div class="row" style="margin : 10px; font-size:20px;">
                                	Plan duration : until <%=remainingplan%> 
                                </div>

                                <div class="footer">
                                    <div class="legend">
                                       
                                    </div>
                                    <hr>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
					
               <div class="col-md-4" style="height: inherit">
                        <div class="card">

                            <div class="header">
                                <h4 align="center" class="title">Electricity Consumption</h4>
                                
                            </div>
                            <div class="content">
                                <div class="row" style="margin : 10px; font-size:20px;">
                                	Overview : <%=monthpelan%>
                                </div>
                               	<div class="row" style="margin : 10px; font-size:20px;">
                                	This Month : <%=monthconsump%> Kwh
                                </div>
                                <div class="row" style="margin : 10px; font-size:20px;">
                                	Bill : RM 21.80
                                </div>
								

                                <div class="footer">
                                    <div class="legend">
                                       <a href="consumption.jsp" ><p class="category">View more</p></a>
                                    </div>
                                    <hr>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
					    <div class="col-md-4">
                        <div class="card">

                            <div class="header">
                                <h4 class="title">Overall Performance</h4>
                                <p class="category">This Month Performance</p>
                            </div>
                            <div class="content">
                 <% 
                
                if(performance.equals("Good"))
out.println("<h3 align='center' style='margin:auto;'> Good !</h3><div align='center'><img src='assets/img/Meter-Good.png' style='width:250px;height:150px;'></div>");
                else if(performance.equals("Poor")) 
out.println("<h3 align='center' style='margin:auto;'> Poor !</h3><div align='center'><img src='assets/img/Meter-Poor.png' style='width:250px;height:150px;'></div>");
                else if(performance.equals("Excellent")) 
out.println("<h3 align='center' style='margin:auto;'> Excellent !</h3><div align='center'><img src='assets/img/Meter-Excellent.png' style='width:250px;height:150px;'></div>");
                else if(performance.equals("Fair")) 
out.println("<h3 align='center' style='margin:auto;'> Fair !</h3><div align='center'><img src='assets/img/Meter-Fair.png' style='width:250px;height:150px;'></div>");
                %>                               
                                <div class="footer">
                                    
                                    <hr>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                
                </div>



                <div class="row">
                       <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Electricity Analytical Data</h4>
                                <p class="category">by Month</p>
                            </div>
                            <div class="content">
                                <div id="chartContainer" style="height: 370px; width: 100%;"></div>
                                <div class="footer">
                                    
                                    <hr>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
					
                
                   
                </div>
            </div>
        </div>


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
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
        <script type="text/javascript">
            window.onload = function() { 

            var chart = new CanvasJS.Chart("chartContainer", {
                    theme: "light2",
                    
                    axisX: {
                            title: "Month"
                    },
                    axisY: {
                            title: " Consumption (Kwh)"
                    },
                    data: [{
                            type: "line",
                            yValueFormatString: "#,##0mn tonnes",
                            dataPoints : <%out.print(dataPoints);%>
                    }]
            });
            chart.render();

            }
        </script>   
        

</html>
