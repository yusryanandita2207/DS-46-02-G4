package DAO;

  import java.lang.reflect.Field;
    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Statement;
    import java.util.ArrayList;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/ticketting_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    private Connection con;
        private Statement stmt;
        private boolean isConnected;
        private String message;
        protected String table;
        protected String primaryKey;
        protected String select = "*";
        private String where = "";
        private String join = "";
        private String otherQuery = "";

    public static Connection getConnection() {
        Connection connection = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return connection;
    }
    
    public void disconnect() {
    try {
      stmt.close();
                con.close();
            } catch (SQLException e) {
                message = e.getMessage();
            }
        }
    
            
}