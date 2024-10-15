package Users.Admin;

import Exceptions.InvalidInputException;

import java.sql.*;
import java.util.Scanner;

public class ManageStudenttRecords {
   private static String rollNo;

     static void manageStudentRecords(Connection con, Scanner sc) {
        while (true) {
            System.out.println("****Available Operation****");
            System.out.println("1. Get Personal Details");
            System.out.println("2. Change Details");
            System.out.println("3. ");
            System.out.println("4. Handle Complaints");
            System.out.println("5. Quit/Exit");
            System.out.println("Select the operation you want to perform ");
            int choice = sc.nextInt();

            switch (choice) {
                case 1:
                    getDetails(con, sc);
                    break;
                case 2:
                    changeDetails(con, sc);
                    break;

                case 4:
                    handleComplaints(con, sc);
                    break;
                default:
                    throw new InvalidInputException("Invalid Choice");
            }
        }
    }

    //function to retrive details of student
    private static void getDetails(Connection con, Scanner sc) {
        sc.nextLine();
        System.out.println("Enter Roll Number of Student: ");
        String rollNum = sc.nextLine();

        String query = "SELECT * FROM student WHERE sid=?";

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, rollNum);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String sid = rs.getString("sid");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phoneNo = rs.getString("phone_number");
                String degreeTypr = rs.getString("degreeType");
                String dob = rs.getString("dob");
                String branch = rs.getString("branch");
                int sem = rs.getInt("semester");
                String date = rs.getString("enrollmentDate");

                System.out.println("+----------+--------+---------------------------+-------------+------------+--------+----------+---------------------+------------+");
                System.out.println("|  SID     | NAME   |  EMAIL                    |PHONE NUMBER | DEGREETYPE | BRANCH | SEMESTER | ENROLLMENTDATE      |  DOB       |");
                System.out.println("+----------+--------+---------------------------+-------------+------------+--------+----------+---------------------+------------+");
                System.out.printf("|%-10s|%-8s|%-27s|%-13s|%-12s|%-8s|%-10s|%-21s|%-12s", sid, name, email, phoneNo, degreeTypr, branch, sem, date, dob);
                System.out.println();
                System.out.println("+----------+--------+---------------------------+-------------+------------+--------+----------+---------------------+------------+");


            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    //function to change details of student
    private static void changeDetails(Connection con, Scanner sc) {
        // Taking roll number as input
        System.out.println("Enter Roll Number ");
        rollNo = sc.next();

        // Selecting details
        System.out.println("Select Detail you want to change ");
        System.out.println("1. DOB\n2. Password\n3. Phone Number");
        int choice = sc.nextInt();
        String attribute;
        Date newdob;
        String oldP;
        String newNumber = null; // Initialize to avoid potential null references

        switch (choice) {
            case 1:
                attribute = "dob";
                break;
            case 2:
                attribute = "password";
                break;
            case 3:
                attribute = "phone_number"; // Change to match your database field

                break;
            default:
                throw new InvalidInputException("Invalid Choice");
        }

        // Checking various cases of choice
        try {
            String query = "UPDATE student SET " + attribute + " = ? WHERE sid = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(2, rollNo);

            switch (choice) {
                case 1:
                    System.out.println("Enter new DOB (yyyy-mm-dd)");
                    sc.nextLine(); // Consume leftover newline
                    newdob = Date.valueOf(sc.nextLine());
                    ps.setDate(1, newdob);
                    break;
                case 2:
                    System.out.println("Enter your old password:");
                    sc.nextLine(); // Consume leftover newline
                    oldP = sc.nextLine();

                    String pwquery = "SELECT password FROM student WHERE sid = ?";
                    try (PreparedStatement ps1 = con.prepareStatement(pwquery)) {
                        ps1.setString(1, rollNo);
                        ResultSet rs = ps1.executeQuery();

                        if (rs.next()) {
                            if (rs.getString("password").equals(oldP)) {
                                System.out.println("Enter new password:");
                                String newp = sc.nextLine();
                                ps.setString(1, newp);
                            } else {
                                System.out.println("Wrong Password");
                                return; // Exit if the password is wrong
                            }
                        } else {
                            System.out.println("Data not Found");
                            return; // Exit if no data found
                        }
                    }
                    break;
                case 3:
                    System.out.println("Enter new Phone Number: ");
                    newNumber = sc.next();
                    ps.setString(1, newNumber);
                    break;
                default:
                    throw new InvalidInputException("Invalid choice");
            }

            int rowsAffected = ps.executeUpdate();
            System.out.println(rowsAffected > 0 ? "Updation Successful" : "Can't be Updated");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private static void handleComplaints(Connection con, Scanner sc) {
        System.out.println("Enter Roll No: ");
        rollNo =sc.next();
        rollNo.toUpperCase();
        String query = "SELECT description,status FROM complaint WHERE sid=?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, rollNo);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                System.out.println("Complaint Not Found");
            } else {
                while (rs.next()) {
                    String description=rs.getString("description");
                    System.out.println(description);
                    if (rs.getString("status").equalsIgnoreCase("pending")) {
                        String statusQuery = String.format("UPDATE complaint SET status='%s'", "resolved");
                        PreparedStatement ps1 = con.prepareStatement(statusQuery);
                        int rowsAffected = ps1.executeUpdate();
                        System.out.println(rowsAffected > 0 ? "Description:\n"+description+"\nComplaint Managed Succesfully" : "Complant could not be resolved,come again later");
                    }
                    else{
                        System.out.println( "Description:\n"+description+"\nComplaint status:resolved" );
                    }
                }

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}

