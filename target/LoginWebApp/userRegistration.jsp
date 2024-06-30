<%@ page import="java.sql.*"%>
<%
    // Database connection details
    String JDBC_DRIVER = System.getenv("DBC_DRIVER") != null ? System.getenv("DBC_DRIVER") : "com.mysql.cj.jdbc.Driver";
    String DB_URL = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : "jdbc:mysql://mysql:3306/";
    String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "sample";
    String USER = System.getenv("USER") != null ? System.getenv("USER") : "root";
    String PASS = System.getenv("PASS") != null ? System.getenv("PASS") : "Qwerty@12345";

    // Get form parameters
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Register JDBC driver
        Class.forName(JDBC_DRIVER);

        // Open a connection
        con = DriverManager.getConnection(DB_URL, USER, PASS);

        // Create database if it doesn't exist
        try (Statement stmt = con.createStatement()) {
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS " + DB_NAME);
            stmt.executeUpdate("USE " + DB_NAME);

            // Create USER table if it doesn't exist
            String createTableSQL = "CREATE TABLE IF NOT EXISTS USER " +
                "(id INTEGER not NULL AUTO_INCREMENT, " +
                " first_name VARCHAR(255), " + 
                " last_name VARCHAR(255), " + 
                " email VARCHAR(255), " + 
                " username VARCHAR(255), " + 
                " password VARCHAR(255), " + 
                " regdate DATE, " + 
                " PRIMARY KEY ( id ))";
            stmt.executeUpdate(createTableSQL);
        }

        // Prepare the insert statement
        String insertSQL = "INSERT INTO USER(first_name, last_name, email, username, password, regdate) VALUES (?, ?, ?, ?, ?, CURDATE())";
        pstmt = con.prepareStatement(insertSQL);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, userName);
        pstmt.setString(5, password); // Note: In a real application, you should hash the password

        // Execute the insert
        int i = pstmt.executeUpdate();

        if (i > 0) {
            response.sendRedirect("welcome.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }

    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    } finally {
        try {
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
        } catch(SQLException se) {
            se.printStackTrace();
        }
    }
%>