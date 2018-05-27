<%-- 
    Document   : conn
    Created on : Mar 22, 2018, 2:05:54 AM
    Author     : syfqh
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%            

//Connect to the database
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/canviodb","root", "");
%>

                          
   