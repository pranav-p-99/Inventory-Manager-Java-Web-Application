package data;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSet;
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String dbemail = null;
			String dbpassword = null;
			String dbname = null;
			String aemail = "invvvmanager@gmail.com";
			String apassword = "pra12345";
			String sql = "select * from users where email=? and password=?";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/userinv","root","");
			PreparedStatement pst = (PreparedStatement) con.prepareStatement(sql);
			pst.setString(1, email);
			pst.setString(2, password);			
			ResultSet rs = (ResultSet) pst.executeQuery();
			
			while(rs.next()){
				dbemail = rs.getString("email");
				dbpassword = rs.getString("password");
				dbname = rs.getString("name");
			}
			if(email.equals(dbemail) && password.equals(dbpassword)){
				HttpSession session = request.getSession();
				session.setAttribute("email",dbname);
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
				
			}else if(email.equals(aemail) && password.equals(apassword)){
				HttpSession session = request.getSession();
				session.setAttribute("email",aemail);
				RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
				rd.forward(request, response);
				
			}else{
				
				request.setAttribute("error", "Invalid Username Or Password !!");
				
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.include(request, response);
			}
				
		} catch (ClassNotFoundException e) {
				e.printStackTrace();
		} catch (SQLException e) {
				e.printStackTrace();
		}
	}

}
