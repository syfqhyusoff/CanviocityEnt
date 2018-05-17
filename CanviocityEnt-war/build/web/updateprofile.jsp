<%-- 
    Document   : updateprofile
    Created on : Apr 17, 2018, 10:22:06 PM
    Author     : Ikhwan Faris
--%>

<%@ page import ="java.sql.*" %>
<%@include file="conn.jsp" %>
<%
    String userid = (String)session.getAttribute("userid"); 
    String newemail = request.getParameter("newemail");
    String newphonenum = request.getParameter("newnum");
    String newaddress = request.getParameter("newaddress");
    String newpostcode = request.getParameter("newpostal");
    String newCity = request.getParameter("newcity");
    String newNegeri1 = request.getParameter("newstate");
if(userid != null)
{
PreparedStatement ps = null;
try
{

con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+"canviodb", "root", "");
String sql="Update user set phonenum=?,address=?,postcode=?,City=?,Negeri=?,email=? where userID='"+ session.getAttribute("userid")+"'";
    ps = con.prepareStatement(sql);
    ps.setString(1, newphonenum);
    ps.setString(2, newaddress);
    ps.setString(3, newpostcode);
    ps.setString(4, newCity);
    ps.setString(5, newNegeri1);
    ps.setString(6, newemail);
    
int i = ps.executeUpdate();
if(i > 0)
{
out.print("Record Updated Successfully");
response.sendRedirect("user.jsp");
}
else
{
out.print("There is a problem in updating Record.");
} 
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}
%>
