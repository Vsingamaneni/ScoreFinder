/*
package com.sports.cricket;

import java.io.IOException;
import java.sql.*;

*/
/**
 * A sample app that connects to a Cloud SQL instance and lists all available tables in a database.
 *//*

public class MySqlConnection {
    public static void main(String[] args) throws IOException, SQLException {
        // TODO: fill this in
        // The instance connection name can be obtained from the instance overview page in Cloud Console
        // or by running "gcloud sql instances describe <instance> | grep connectionName".
        String instanceConnectionName = "scorefinder-206414:asia-east1:scorefinderapp";

        // TODO: fill this in
        // The database from which to list tables.
        String databaseName = "sports";

        String username = "root";

        // TODO: fill this in
        // This is the password that was set via the Cloud Console or empty if never set
        // (not recommended).
        String password = "";

*/
/*        //[START doc-example]
        String jdbcUrl = String.format(
                "jdbc:mysql://google/%s?cloudSqlInstance=%s"
                        + "&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
                databaseName,
                instanceConnectionName);*//*


        //35.201.185.22 -- scorefinder
        //35.194.225.158 -- firstapp
        Connection connection = DriverManager.getConnection("jdbc:mysql://35.201.185.22:3306/sports", username, password);
        insert(connection);
        //dataSource.setUrl("jdbc:mysql://35.194.225.158:3306/sports");
        //[END doc-example]

        try (Statement statement = connection.createStatement()) {
            ResultSet resultSet = statement.executeQuery("SHOW TABLES");

            while (resultSet.next()) {
                System.out.println(resultSet.getString(1));
            }
        }
    }

    public static void insert(Connection conn) {
        String sql = "INSERT INTO RESTRICTIONS(securityCode,maxLimit) VALUES(?,?)";

        try (
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "vamsi");
            pstmt.setInt(2, 2000);
            pstmt.executeUpdate();
            System.out.println("Inserted successfully");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}*/
