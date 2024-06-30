<%@ page import="java.sql.*"%>

<%
 String userName = request.getParameter("userName"); 
 
 String password = request.getParameter("password"); 

 
 String JDBC_DRIVER = System.getenv("DBC_DRIVER") != null ? System.getenv("DBC_DRIVER") : "com.mysql.cj.jdbc.Driver";
 String DB_URL = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : "jdbc:mysql://mysql:3306/";
 String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "sample";
 String ConnectionURL = DB_URL + DB_NAME;
 String USER = System.getenv("USER") != null ? System.getenv("USER") : "root";
 String PASS = System.getenv("PASS") != null ? System.getenv("PASS") : "Qwerty@12345";

 Class.forName (JDBC_DRIVER); 
 Connection con = DriverManager.getConnection(ConnectionURL, USER, PASS);
 Statement st = con.createStatement(); 
 ResultSet rs; 
 rs = st.executeQuery("select * from USER where username='" + userName + "' and password='" + password + "'");
	if (rs.next()) 
		{ 
			session.setAttribute("userid", userName); 
			response.sendRedirect("success.jsp"); 
		} 
	else 
		{ 
			out.println("Invalid password <a href='index.jsp'>try again</a>"); 
} 
%>
