<%-- 
    Document   : login
    Created on : Mar 21, 2018, 1:08:16 AM
    Author     : syfqh
--%>

<%@ page import ="java.sql.*" %>
<%@include file="conn.jsp" %>

<%
    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");

    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from user where uname='" + userid + "' and pass='" + pwd + "'");
   
    if (rs.next()) {
        session.setAttribute("userid", userid);
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("dashboard.jsp");
    } else {%>
        You are not logged in. Your username or password are incorrect<br/>
        <a href="index.html">Try Again</a>    
    <% }
%>
