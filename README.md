# University Management System

This project is a comprehensive, console-based University Management System developed in Java, utilizing JDBC for database connectivity with a MySQL backend. The system is built on Object-Oriented principles to manage various academic operations and provides dedicated portals for three distinct user roles: Administrators, Professors, and Students.

## Features

The system provides a different set of functionalities based on the user role.

### 🎓 Student Portal
- **Course Management**: Register for available courses, view registered courses, and drop courses.
- **Academic Tracking**: View academic records, including grades, SGPA, and CGPA for each semester.
- **Schedule Viewing**: Access a personalized class schedule for the current semester.
- **Complaint System**: Submit complaints or feedback to the administration.

### 👨‍🏫 Professor Portal
- **Course Administration**: Manage assigned courses, including updating the syllabus, schedule, credits, and enrollment limits.
- **Student Roster**: View a list of all students enrolled in assigned courses.

### ⚙️ Admin Portal
- **Student Record Management**: View and modify student personal details, assign grades, and handle student complaints.
- **Course Catalog Management**: Add new courses to the university catalog or remove existing ones.
- **Faculty Assignment**: Assign professors to teach specific courses.

## Technology Stack

- **Language**: Java
- **Database**: MySQL
- **Database Connectivity**: JDBC (Java Database Connectivity)
- **UI**: Console-based Command Line Interface (CLI)

## Database Schema

The system uses a relational database schema to manage data efficiently. Key tables include:

- `student`, `professor`, `admin`: Store user credentials and personal information.
- `courses`, `availableCourses`, `syllabus`: Define the course catalog and its content.
- `enrolledStudents`: Maps students to the courses they are registered for.
- `assignProfessors`: Maps professors to the courses they teach.
- `schedule`: Stores the timetable for courses.
- `results`: Manages student grades and academic performance.
- `complaint`: Tracks complaints submitted by students.

## Setup and Usage

Follow these steps to set up and run the project on your local machine.

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- MySQL Server

### 1. Database Setup

1.  Start your local MySQL server.
2.  Create a new database for the project.
    ```sql
    CREATE DATABASE Universitymanagement;
    ```
3.  Execute the `OOPs Assignment database.sql` script in your MySQL client. This script will create the necessary tables and populate them with sample data.

### 2. Application Configuration

1.  Navigate to the database configuration file: `src/DatabasePackage/Dbargs.java`.
2.  Update the `url`, `username`, and `pass` constants to match your MySQL database credentials.

    ```java
    public class Dbargs {
        private static final String url="jdbc:mysql://localhost:3306/universitymanagement";
        private static final String username="your_username";
        private static final String pass="your_password";
        // ...
    }
    ```

### 3. Running the Application

1.  Clone the repository:
    ```bash
    git clone https://github.com/khushkataruka/oops-assignment.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd oops-assignment
    ```
3.  Add the MySQL JDBC driver JAR file to your project's classpath. The project is configured to use `mysql-connector-j-9.0.0.jar`.
4.  Compile and run the `Main.java` file from your IDE or using the command line.
5.  Log in using the credentials provided in the database script.
    -   **Admin Login:** `Username: Admin`, `Password: password`
    -   **Student/Professor Login:** Use one of the email/password combinations from the `student` or `professor` tables in the SQL script.

## Project Structure

The project is organized into several packages to maintain a clean and scalable architecture.

```
└── src/
    ├── Main.java                   // Main entry point for the application
    ├── DatabasePackage/            // Handles database connection logic
    │   ├── DbConnection.java
    │   └── Dbargs.java
    ├── Exceptions/                 // Custom exception classes for error handling
    └── Users/                      // Core logic for different user roles
        ├── user.java               // User interface
        ├── Admin/                  // Admin-specific functionalities
        ├── Professor/              // Professor-specific functionalities
        └── Student/                // Student-specific functionalities
