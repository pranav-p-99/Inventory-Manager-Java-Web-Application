<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
%>

<%@page import="java.sql.*" %> 
 
 
<% 
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
        pst = con.prepareStatement("truncate table cart");
        pst.executeUpdate();
        response.sendRedirect("cart.jsp");
%>
