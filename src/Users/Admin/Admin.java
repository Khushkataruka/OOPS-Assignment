package Users.Admin;

import java.sql.*;
import java.util.Scanner;

public class Admin {

    private static Connection con;
    private static Scanner sc;

    Admin(Connection con, Scanner sc) {
        this.con = con;
        this.sc = sc;
    }

    public static void getShow() {
        while (true) {
            System.out.println("****Available Operation****");
            System.out.println("1. Manage Student Records");
            System.out.println("2. Manage Course Catalouge");
            System.out.println("3. Assign Professor");
            System.out.println("4. Quit/Exit");
            System.out.println("Select the operation you want to perform ");
            int choice = sc.nextInt();
            switch (choice) {
                case 1:
                    ManageStudenttRecords.manageStudentRecords(con, sc);
                    break;
            }
        }
    }
}
