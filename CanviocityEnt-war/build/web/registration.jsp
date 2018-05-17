<%-- 
    Document   : registration
    Created on : Mar 21, 2018, 1:06:48 AM
    Author     : syfqh
--%>

<%@ page import ="java.sql.*" %>
<%@include file="conn.jsp" %>
<%
    String meterid = request.getParameter("meterID");    

    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String postcode = request.getParameter("postcode");
    String City = request.getParameter("City");
    String Negeri = request.getParameter("Negeri");

    
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into user(userID,name,phonenum, uname, address,postcode, City, Negeri, email, pass, regdate) values ('" + user +"','" + name +"','" + phonenum +"','" + user +  "','" + address +"','" + postcode +"','" + City +"','" + Negeri +  "','" + email  + "','" + pwd + "', CURDATE())");
    
    if (i > 0) {
         st.executeUpdate("update smartmeter set userID='"+user+"' where meterid ='"+meterid+"';");
        
        //session.setAttribute("userid", user);
        response.sendRedirect("index.html");
       //out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.html");
    }
%>
