import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:derby:C:\\Users\\hulle\\MyDB;create=true";
//    private static final String USER = ""; // Change if using a different user
//    private static final String PASSWORD = ""; // Set your MySQL password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
