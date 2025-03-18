/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author ADMIN
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    public Connection c;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=PerfumeTest;encrypt=true;trustServerCertificate=true";
            String username = "sa";
            String pass = "1";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            c = DriverManager.getConnection(url,username,pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void closeConnection() {
        try {
            if (c != null && !c.isClosed()) {
                c.close();
                System.out.println("Connection closed successfully.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}
