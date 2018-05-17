
<%@ page import ="java.sql.*" %>
<%@include file="conn.jsp" %>
<%
    
    String category = request.getParameter("category");    
    String description = request.getParameter("description");
    
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into complaint(category, description, complaintTime, userID) "
            + "values ('" + category +"','" + description +"', CURRENT_DATE,'"+session.getAttribute("userid")+"');");
    
   if (i > 0) {
        
        response.sendRedirect("complaint.jsp");
    } else {
        response.sendRedirect("complaint.jsp");
    }
%>
