package DatabasePackage;

import java.sql.*;

public class DbConnection {
    public static Connection connectdb() throws SQLException {
        String url = Dbargs.getUrl();
        String username = Dbargs.getUsername();
        String password = Dbargs.getpassword();
            Connection con = DriverManager.getConnection(url, username, password);
            return con;
        }
    }


