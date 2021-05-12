package data;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.stream.Stream;
import java.util.*;
import java.util.List;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.mysql.jdbc.Statement;

public class Pdfgen {
	
public static void sendMail() throws URISyntaxException, IOException, DocumentException {
	Document document = new Document();
	
	PdfWriter.getInstance(document, new FileOutputStream("C:/Users/Pranav/Desktop/MAIL/report.pdf"));
	String to = "inventory.manager.def@gmail.com";
	String from = "invvvmanager@gmail.com";
	
	Connection con;
	PreparedStatement pst,pst1;
	ResultSet rs;
	String nearexp = null;
	String exp = null;
	String ls = null;
	String ns = null;

	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost/userinv", "root", "");
		Statement st = (Statement) con.createStatement();
		
		String query1 = "SELECT COUNT(*) FROM products WHERE expdate = DATE_ADD(CURDATE(), INTERVAL 3 DAY) or expdate = DATE_ADD(CURDATE(), INTERVAL 2 DAY) or expdate = DATE_ADD(CURDATE(), INTERVAL 1 DAY)";
		rs = st.executeQuery(query1);
		while (rs.next()) {
			nearexp = rs.getString(1);	
		}
		
		String query2 = "SELECT COUNT(*) FROM products WHERE expdate <= DATE(NOW())";
		rs = st.executeQuery(query2);
		while (rs.next()) {
			exp = rs.getString(1);
		}
		
		String query3 = "SELECT COUNT(*) FROM products WHERE qty > 0 and qty <= 50";
		rs = st.executeQuery(query3);
		while (rs.next()) {
			ls = rs.getString(1);
		}
		
		String query4 = "SELECT COUNT(*) FROM products WHERE qty = 0";
		rs = st.executeQuery(query4);
		while (rs.next()) {
			ns = rs.getString(1);
		}
	}catch(ClassNotFoundException e) {
		e.printStackTrace();
	}catch (SQLException e) {
		e.printStackTrace();
	}
	
	
	
	
	
	
	document.open();
	Paragraph paragraph = new Paragraph("STOCK DETAILS");
	paragraph.setAlignment(Paragraph.ALIGN_CENTER);
	document.add(paragraph);
	Paragraph paragraph1 = new Paragraph(" ");
	document.add(paragraph1);
	PdfPTable table = new PdfPTable(2);
	PdfPCell newcell = new PdfPCell(new Phrase("PROCUCT STATUS"));
	newcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	newcell.setBackgroundColor(BaseColor.LIGHT_GRAY);
	table.addCell(newcell);
	PdfPCell newcell1 = new PdfPCell(new Phrase("PRODUCT COUNT"));
	newcell1.setHorizontalAlignment(Element.ALIGN_CENTER);
	newcell1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	table.addCell(newcell1);
	PdfPCell newcell2 = new PdfPCell(new Phrase("Nearing Expiry"));
	newcell2.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell2);
	PdfPCell newcell3 = new PdfPCell(new Phrase(nearexp));
	newcell3.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell3);
	PdfPCell newcell4 = new PdfPCell(new Phrase("Expired"));
	newcell4.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell4);
	PdfPCell newcell5 = new PdfPCell(new Phrase(exp));
	newcell5.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell5);
	PdfPCell newcell6 = new PdfPCell(new Phrase("Less Stock"));
	newcell6.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell6);
	PdfPCell newcell7 = new PdfPCell(new Phrase(ls));
	newcell7.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell7);
	PdfPCell newcell8 = new PdfPCell(new Phrase("Out Of Stock"));
	newcell8.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell8);
	PdfPCell newcell9 = new PdfPCell(new Phrase(ns));
	newcell9.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(newcell9);	
	document.add(table);
	document.close();  
	 
	String host = "smtp.gmail.com";

    // Get system properties
    Properties properties = System.getProperties();
    
    // Setup mail server
    properties.setProperty("mail.smtp.host", host);
    properties.setProperty("mail.defaultEncoding","UTF-8");
    properties.setProperty("mail.smtp.auth","true");
    properties.setProperty("mail.user","invvvmanager@gmail.com");
    properties.setProperty("mail.password","pra12345");
    //properties.setProperty("mail.smtp.starttls.required","true");
    properties.setProperty("mail.smtp.starttls.enable","true");
    properties.setProperty("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
    properties.setProperty("mail.smtp.socketFactory.fallback","false");
    properties.setProperty("mail.smtp.port","465");
    properties.setProperty("mail.smtp.socketFactory.port","465");
    // Get the default Session object.
    Session session = Session.getDefaultInstance(properties);

    try {
       // Create a default MimeMessage object.
       MimeMessage message = new MimeMessage(session);

       // Set From: header field of the header.
       message.setFrom(new InternetAddress(from));

       // Set To: header field of the header.
       message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));

       // Set Subject: header field
       message.setSubject("Inventory Manager");

       // Create the message part 
       BodyPart messageBodyPart = new MimeBodyPart();

       // Fill the message
       messageBodyPart.setText("Stock Report !");
       
       // Create a multipar message
       Multipart multipart = new MimeMultipart();

       // Set text message part
       multipart.addBodyPart(messageBodyPart);

       // Part two is attachment
       messageBodyPart = new MimeBodyPart();
       String filename = "C:/Users/Pranav/Desktop/MAIL/report.pdf";
       DataSource source = new FileDataSource(filename);
       messageBodyPart.setDataHandler(new DataHandler(source));
       messageBodyPart.setFileName(filename);
       multipart.addBodyPart(messageBodyPart);

       // Send the complete message parts
       message.setContent(multipart );

       // Send message
       Transport.send(message, "invvvmanager@gmail.com", "pra12345");
       System.out.println("Sent message successfully....");
    } catch (MessagingException mex) {
       mex.printStackTrace();
    }
}
}
