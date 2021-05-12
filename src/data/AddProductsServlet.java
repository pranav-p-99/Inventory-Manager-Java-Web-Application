package data;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddProductsServlet")
public class AddProductsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	private AddProductDao pdao = new AddProductDao();
	
    public AddProductsServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher rd = request.getRequestDispatcher("prodedit.jsp");
		rd.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productname = request.getParameter("productname");
		String quantity = request.getParameter("quantity");
		String type = request.getParameter("type");
		String date = request.getParameter("date");
		String price = request.getParameter("price");
		
		AddProducts p = new AddProducts();
		p.setProductname(productname);
		p.setQuantity(quantity);
		p.setType(type);
		p.setDate(date);
		p.setPrice(price);
		
		try {
			pdao.addProducts(p);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("prodedit.jsp");
	}

}
