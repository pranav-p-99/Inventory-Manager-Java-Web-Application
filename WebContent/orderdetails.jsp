<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
%>

<%@page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
 
 
<% 
		
		Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
        String q1 = "SELECT GROUP_CONCAT(CONCAT('Item:',item_name,' Qunatity:',qty,' Price Per Unit:',price,' Total Price:',total_ppu)) AS info from cart";
        Statement st = con.createStatement();
		rs = st.executeQuery(q1);
		String info = null;
		while (rs.next()) {
			info = rs.getString("info");
		}
		String date = new java.util.Date().toLocaleString();
		
		
		Map<String,List<String>> map = new HashMap();
		map.put("Item_name",new ArrayList<String>());
		map.put("Item_qty",new ArrayList<String>());
		map.put("Item_ppu",new ArrayList<String>());
		map.put("Item_tprice",new ArrayList<String>());
	    int c = 0;
	    float total = 0;
	    String ans = "";
		for(String s : info.split(",")){
		    for(String i : s.split(" ")){
		        if(i.indexOf(":") != -1){
		            int p = i.indexOf(":");
		            String temp = i.substring(p+1,i.length());
		            if(c == 0){
		                ans += "Item : " + temp;
		                c++;
		            }else if(c == 1){
		                ans += " || Qunatity : " + temp;
		                c++;
		            }else if(c == 2){
		                ans += " || Price Per Unit : " + temp;
		                c++;
		            }else if(c == 3){
		            	ans += " || Total Price : " + temp + "<br>";
		            	total += Float.parseFloat(temp);
		                c = 0;
		            }
		            
		        }
		    }
		}
		
		ans += "GRAND TOTAL : Rs. " + total +"/-";
		
		pst = con.prepareStatement("insert into orders(cust_name,order_date_time,order_details)values(?,?,?)");
		pst.setString(1, (String)session.getAttribute("email"));
		pst.setString(2, date);
		pst.setString(3, ans);
		pst.executeUpdate();
        response.sendRedirect("invoice.jsp");
		
		
%>
