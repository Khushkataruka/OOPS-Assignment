package Users.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ViewSchedule {
    Connection con;

    ViewSchedule(Connection con) {
        this.con = con;
    }

    public void viewSchedule(int semester, String branch) {
        String query = "SELECT course_name, professor.pname AS professor_name, day, start_time, end_time "
                + "FROM Schedule "
                + "INNER JOIN Courses ON Schedule.c_id = Courses.course_id "
                + "INNER JOIN professor ON Schedule.prof_id = professor.pid "
                + "WHERE semNo = ? AND branch = ?";
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, semester);
            ps.setString(2, branch);
            ResultSet resultSet = ps.executeQuery();

            // Display the header of the table
            System.out.println("+------------------+-----------------+------+------------+----------+");
            System.out.println("| Course Name      | Professor Name   | Day  | Start Time | End Time |");
            System.out.println("+------------------+-----------------+------+------------+----------+");

            // Iterate through the ResultSet and display each row
            while (resultSet.next()) {
                String courseName = resultSet.getString("course_name");
                String professorName = resultSet.getString("professor_name");
                String day = resultSet.getString("day");
                String startTime = resultSet.getString("start_time");
                String endTime = resultSet.getString("end_time");

                System.out.printf("| %-16s | %-15s | %-4s | %-10s | %-8s |\n",
                        courseName, professorName, day, startTime, endTime);
            }
            System.out.println("+------------------+-----------------+------+------------+----------+");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        finally{
            if(ps!=null)
            {
                try {
                    ps.close();
                    ps=null;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

