package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;

import com.mysql.jdbc.Statement;

public class AddProductDao {
	public int addProducts(AddProducts p) throws ClassNotFoundException{
		Connection con;
		PreparedStatement pst;
		ResultSet rs;
		int result = 0;
		Class.forName("com.mysql.jdbc.Driver");
		try{
			con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
			pst = con.prepareStatement("insert into products(pname,qty,edible,expdate,pricepu)values(?,?,?,?,?)");
			pst.setString(1, p.getProductname());
			pst.setString(2, p.getQuantity());
			pst.setString(3, p.getType());
			pst.setString(4, p.getDate());
			pst.setString(5, p.getPrice());
			result = pst.executeUpdate();
			
			Statement st = (Statement) con.createStatement();

			HashSet<String> set = new HashSet();	
			String query = "select * from barcode";
			rs = st.executeQuery(query);
			while (rs.next()) {
				set.add(rs.getString("item"));
			}
			if(!set.contains(p.getProductname())){
				pst = con.prepareStatement("insert into barcode(item)values(?)");
				pst.setString(1, p.getProductname());
				pst.executeUpdate();	
			}
			
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
}
