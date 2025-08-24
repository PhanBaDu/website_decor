package data.driver;
import data.utils.Constants;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlDriver {
    private static Connection connection;

    private MySqlDriver() {
    }

    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); 
                connection = DriverManager.getConnection(Constants.URL, Constants.USERNAME, Constants.PASSWORD);
                System.out.println("Kết nối thành công tới database!");
            } catch (ClassNotFoundException | SQLException e) {
                System.err.println("Không thể kết nối CSDL: " + e.getMessage());
            }
        }
        return connection;
    }
}
