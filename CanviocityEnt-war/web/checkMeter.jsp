<%-- 
    Document   : exists
    Created on : Apr 15, 2018, 6:07:41 PM
    Author     : syfqh
--%>

<%@ page import="java.io.*,java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<% 
                    String meter=request.getParameter("meterID");

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/canviodb","root", "");
                    Statement st=con.createStatement();
                    ResultSet rs = st.executeQuery("select * from smartmeter where meterID='"+meter+"'");  // this is for name
                    if(rs.next())
                    {    
                        out.println("<font color=green>");
                        out.println("Valid");
                        out.println("</font>");

                    }else {
                        out.println("<font color=red>");
                        out.println("Invalid");
                        out.println("</font>");

                    }
rs.close();
st.close();
con.close();
%> 