package Users.Admin;

import Exceptions.InvalidInputException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class ManageCourseCatalog {

    public static void  manageCourseCatalog(Connection connection,Scanner scanner){
        int choice=0;
        while (choice!=4){
            System.out.println("****Available Operation****");
            System.out.println("1. Add a Course");
            System.out.println("2. Delete a Course");
            System.out.println("3. View Course");
            System.out.println("4. Quit/Exit");
            System.out.println("Select the operation you want to perform ");
             choice = scanner.nextInt();

            switch (choice){
                case 1:
                    addCourse(connection,scanner);
                    break;
                case 2:
                    deleteCourse(connection,scanner);
                    break;
                case 3:
                    viewCourse(connection,scanner);
                    break;
                case 4:
                    System.out.println("Exiting...");
                    try {
                        Thread.sleep(2000);
                    } catch (InterruptedException e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                default:
                    throw new InvalidInputException("Invalid Choice");
            }
        }
    }

    public static void addCourse(Connection connection,Scanner scanner) {
        System.out.println("Enter the semester:");
        int semester = scanner.nextInt();
        scanner.nextLine();  // Consume newline character
        System.out.println("Enter the course ID:");
        String course_id = scanner.nextLine();
        System.out.println("Enter the course name:");
        String course_name = scanner.nextLine();
        System.out.println("Enter the course credits:");
        int credits = scanner.nextInt();
        scanner.nextLine();  // Consume newline character

        try {
            // SQL query to insert a new course into the database
            String query = "INSERT INTO courses (course_id, course_name, credits, semesterNo) VALUES (?, ?, ?, ?)";
            PreparedStatement prepstmt = connection.prepareStatement(query);
            prepstmt.setString(1, course_id);
            prepstmt.setString(2, course_name);
            prepstmt.setInt(3, credits);
            prepstmt.setInt(4, semester);
            int affectedRows = prepstmt.executeUpdate();

            if (affectedRows > 0) {
                System.out.println("Course added successfully.");
            } else {
                System.out.println("Course addition failed.");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    /**
     * Method to delete a course from the university based on course ID.
     */
    public static void deleteCourse(Connection connection,Scanner scanner) {
        System.out.println("Enter the course ID:");
        scanner.nextLine();
        String course_id = scanner.nextLine();

        try {
            // SQL query to delete a course by course_id
            String query = "DELETE FROM courses WHERE course_id = ?";
            PreparedStatement prepstmt = connection.prepareStatement(query);
            prepstmt.setString(1, course_id);
            int affectedRows = prepstmt.executeUpdate();

            if (affectedRows > 0) {
                System.out.println("Course deleted successfully.");
            } else {
                System.out.println("Course deletion failed.");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    /**
     * Method to view details of a specific course by course ID.
     */
    public static void viewCourse(Connection connection,Scanner scanner) {
        System.out.println("Enter the course ID:");
        scanner.nextLine();
        String course_id = scanner.nextLine();

        try {
            // SQL query to retrieve course details by course_id
            String query = "SELECT * FROM courses WHERE course_id = ?";
            PreparedStatement prepstmt = connection.prepareStatement(query);
            prepstmt.setString(1, course_id);
            ResultSet rs = prepstmt.executeQuery();

            // Display course details if found
            while (rs.next()) {
                int semester = rs.getInt("semesterNo");
                System.out.println("Semester: " + semester);
                String courseId = rs.getString("course_id");
                System.out.println("Course ID: " + courseId);
                String courseName = rs.getString("course_name");
                System.out.println("Course Name: " + courseName);
                int credits = rs.getInt("credits");
                System.out.println("Credits: " + credits);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
