<%-- 
    Document   : logout
    Created on : Mar 21, 2018, 1:09:35 AM
    Author     : syfqh
--%>

<%
session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.html");
%>