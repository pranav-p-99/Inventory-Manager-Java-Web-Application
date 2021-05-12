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
        String item_no = request.getParameter("item_no");
        Connection con;
        PreparedStatement pst,ps,p;
        ResultSet rs;
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
        
        ps = con.prepareStatement("select * from cart where item_no = ?");
        ps.setString(1, item_no);
        rs = ps.executeQuery();
        
        int q1 = 0;
        String qo = null;
        String item_name = null;
        while(rs.next()){
        	qo = rs.getString("expdate");
        	q1 = Integer.parseInt(rs.getString("qty"));
        	item_name = rs.getString("item_name");
        }
        
        ps = con.prepareStatement("select * from products where pname = ? and expdate=?");
        ps.setString(1, item_name);
        ps.setString(2,qo);
        rs = ps.executeQuery();
        
        int q2 = 0;
        while(rs.next()){
        	q2 = Integer.parseInt(rs.getString("qty"));
        }
        
        int q3 = q1+q2;
        String f = String.valueOf(q3);
        p = con.prepareStatement("update products set qty=? where pname=? and expdate=?");
        p.setString(1, f);
        p.setString(2,item_name);
        p.setString(3,qo);
        p.executeUpdate();
        
        
        
        pst = con.prepareStatement("delete from cart where item_no = ?");
        pst.setString(1, item_no);
        pst.executeUpdate();
        response.sendRedirect("cart.jsp");
%>
