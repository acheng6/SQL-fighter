package univdb_transactiondemo_JDBC;

import java.io.IOException;
import java.sql.*;

public class Main_univdb_transactiondemo_JDBC {

//Java program to demonstrate use two ways to access data of the
//MySQL univDB_demo database
//The program flow is as follows:    
// 1.  The object of the program is to demonstrate an SQL transaction via JDBC.
// 2.  There are three segments:
//    a) Segment 1 deletes the records from previous executions
//       from the faculty and class tables
//    b Segment 2 adds a record to the faculty table.  This record is then
//       linked to a new record added to the class table.  This two-step transaction is
//       not committed unless both adds are successful.  If either fails, the
//       transaction is rolled back.
//    c) Segment 3 is similar to the Segment 2.   However the record added
//       to faculty is different, so it should be correctly added.  The record 
//       to be added to the class table is the same as in segment 2, so it
//       should fail.  In turn this forces the transaction to fail because
//       the "new" record already exists.  The transaction will be rolled
//       back.
//As of 03/31/19, this program requires a updated version of univdb, available on Canvas.

    public Main_univdb_transactiondemo_JDBC() {
    }
    public static void main(String[] args) throws IOException  
    {
        String newFacID = "F301";
        String newFacName = "Rose";
        String newDepartment = "CSC";
        String newFRank = "Assistant";
        
        String newClassNumber = "CSC350A";
        String newClassFacNumber = "F301";
        String newSchedule = "TT10";
        String newRoom = "M115";
        
        String newFacID2= "F302";
        String newFacName2 = "Tulip";
        String newDepartment2 = "CSC";
        String newFRank2 = "Assistant";
        
        String queryDeleteFaculty = "";
        String queryUpdateFaculty = "";
        String queryUpdateClass = "";
        Integer queryResult = 0;
        
    //prepare all statement transaction queries
         queryDeleteFaculty = "DELETE " +
                             "FROM faculty " +
                             "WHERE facid = ?;";
        queryUpdateFaculty = "INSERT " +
                       "INTO faculty (facid, fName, department, fRank) " +
                       "VALUES (?, ?, ?, ?);";
        queryUpdateClass = "INSERT " +
                     "INTO class (classNumber, facid, schedule, room) " +
                     "VALUES (?, ?, ?, ?);";
        
        
        try (Connection connection = DriverManager.getConnection(DBConstants.SOURCE_URL,
                                                                 DBConstants.SOURCE_USER_NAME,
                                                                 DBConstants.SOURCE_PASSWORD);
             PreparedStatement ps1 = connection.prepareStatement(queryDeleteFaculty);
             PreparedStatement ps2 = connection.prepareStatement(queryUpdateFaculty);
             PreparedStatement ps3 = connection.prepareStatement(queryUpdateClass);){
            
    //Segment 1.  If target records are alredy in tables, remove them. 
            System.out.println("Start Segment 1");
            ps1.setString(1, newFacID);
            queryResult = ps1.executeUpdate();
            if (queryResult > 0) {
                System.out.println("Segment 1 Old records cleaned up.");    
            } else {
                System.out.println("Segment 1 No records to delete.");    
           }
           System.out.println("End Segment 1");

        //Segment 2.  If add target records to tables. 
           System.out.println("\nStart Segment 2");
           connection.setAutoCommit(false);
            ps2.setString(1, newFacID);
            ps2.setString(2, newFacName);
            ps2.setString(3, newDepartment);
            ps2.setString(4, newFRank);
            
            queryResult = ps2.executeUpdate();
            
            if (queryResult == 1){
                try{
                    ps3.setString(1, newClassNumber);
                    ps3.setString(2, newClassFacNumber);
                    ps3.setString(3, newSchedule);
                    ps3.setString(4, newRoom);

                    queryResult = ps3.executeUpdate();
                    if (queryResult == 1){
                        connection.commit();
                        System.out.println("Segment 2 Updates Committed.");
                    } else {
                        connection.rollback();
                        System.out.println("Segment 2 Updates rolled back.");
                    }
                    connection.close();
                } catch (SQLException e2){
                    System.out.println(e2.getMessage());
                    System.out.println("Segment 2 Class Update(2) failed.");
                    connection.rollback();
                }
            } else {
                connection.close();
            }
        } catch (SQLException e) {
           System.out.println(e.getMessage());
           System.out.println("Segment 2 Faculty Update(1) failed.");
        }    
        System.out.println("End Segment 2");

     //Segment 3.  Add new record to faculty and duplicate record to class to force
     //tranasction to fail requiring a rollback of the tranaction. 
        System.out.println("\nStart Segment 3");
        queryUpdateFaculty = "INSERT " +
                       "INTO faculty (facid, fName, department, fRank) " +
                       "VALUES (?, ?, ?, ?);";
        queryUpdateClass = "INSERT " +
                     "INTO class (classNumber, facid, schedule, room) " +
                     "VALUES (?, ?, ?, ?);";
        try (Connection connection = DriverManager.getConnection(DBConstants.SOURCE_URL,
                                                                 DBConstants.SOURCE_USER_NAME,
                                                                 DBConstants.SOURCE_PASSWORD);
             PreparedStatement ps2 = connection.prepareStatement(queryUpdateFaculty);
             PreparedStatement ps3 = connection.prepareStatement(queryUpdateClass);){
            
            connection.setAutoCommit(false);
            ps2.setString(1, newFacID2);
            ps2.setString(2, newFacName2);
            ps2.setString(3, newDepartment2);
            ps2.setString(4, newFRank2);
            
            queryResult = ps2.executeUpdate();
            
            if (queryResult == 1){
                try{
                    ps3.setString(1, newClassNumber);
                    ps3.setString(2, newClassFacNumber);
                    ps3.setString(3, newSchedule);
                    ps3.setString(4, newRoom);

                    queryResult = ps3.executeUpdate();
                    if (queryResult == 1){
                        connection.commit();
                    } else {
                        connection.rollback();
                    }
                    connection.close();
                } catch (SQLException e2){
                    System.out.println(e2.getMessage());
                    connection.rollback();
                    System.out.println("Segment 3 Second update rollback");
                }
            } else {
                connection.close();
            }
        } catch (SQLException e) {
           System.out.println("Segment 3 Second update failed - " + e.getMessage());
        }    

        System.out.println("End Segment 3");
    }
}
