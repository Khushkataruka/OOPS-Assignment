CREATE DATABASE Universitymanagement;

use UniversityManagement;

-- Table for Student
CREATE TABLE student (
    sid VARCHAR(25) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(60) NOT NULL,
    phone_number VARCHAR(10) UNIQUE CHECK (phone_number REGEXP '^[0-9]{10}$'),
    degreeType VARCHAR(20) NOT NULL,
    branch VARCHAR(40) NOT NULL,
    semester INT CHECK (semester BETWEEN 0 AND 8),
    dob DATE NOT NULL,
    enrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE availableCourses (
    course_id VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(40) NOT NULL,
    branch VARCHAR(40) NOT NULL,
    semester INT CHECK (semester BETWEEN 1 AND 8)
);

CREATE TABLE enrolledStudents (
    course_id VARCHAR(20),
    student_id VARCHAR(25),
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES availableCourses(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(sid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE complaint (
    complaint_id SERIAL PRIMARY KEY,  -- Auto-incrementing complaint ID
    sid VARCHAR(25),
    description VARCHAR(100) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Resolved')),
    complaint_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sid) REFERENCES student(sid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE professor (
    pid VARCHAR(25) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(60) NOT NULL,
    phone_number VARCHAR(10) UNIQUE CHECK (phone_number REGEXP '^[0-9]{10}$'),
    department VARCHAR(40) NOT NULL,
    hire_date DATE NOT NULL,
    enrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(40) NOT NULL,
    credits INT NOT NULL,
    semesterNo INT CHECK (semesterNo BETWEEN 1 AND 8)
);

CREATE TABLE Schedule (
    semNo INT CHECK (semNo BETWEEN 1 AND 8),
    branch VARCHAR(40) NOT NULL,
    c_id VARCHAR(10),
    prof_id VARCHAR(10),
    day ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    start_time varchar(20),
    end_time varchar(20),
    PRIMARY KEY (semNo, branch, c_id),
    FOREIGN KEY (c_id) REFERENCES courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prof_id) REFERENCES professor(pid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE results (
 semNo INT CHECK (semNo BETWEEN 1 AND 8),
    sid VARCHAR(25),
    cid VARCHAR(10),
    total_credits INT NOT NULL,
    credits_obtained INT NOT NULL,
    grade VARCHAR(4) NOT NULL,
    PRIMARY KEY (semNo, sid, cid),
	FOREIGN KEY (cid) REFERENCES courses(course_id) ,
    FOREIGN KEY (sid) REFERENCES student(sid) 
);


CREATE TABLE assignProfessors (
    course_id VARCHAR(10),
    prof_id VARCHAR(10),
    enrollmentLimit int default 60,
    PRIMARY KEY (course_id, prof_id),
    FOREIGN KEY (course_id) REFERENCES availableCourses(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prof_id) REFERENCES professor(pid) ON DELETE CASCADE ON UPDATE CASCADE
);





-- Insert student data for all 8 semesters with hashed passwords and valid Indian mobile numbers (50 entries)
INSERT INTO student (sid, name, email, password, phone_number, degreeType, branch, semester, dob, enrollmentDate) VALUES
-- Semester 1
('U20CS001', 'Aarav Sharma', 'u20cs001@coed.svnit.ac.in', '$2a$10$7F1eqhuw9EQdjFjFGuApmeU5.aJ7CHXqXZmZ9giEjQGiPBgh3G6Y.', '9876543210', 'Bachelors', 'CS', 1, '2002-03-15', '2023-09-01 10:00:00'),
('U20AI002', 'Vihaan Gupta', 'u20ai002@coed.svnit.ac.in', '$2a$10$Q45Akp1EMVoZVFNZuf5MhuG3TVCa0OglUvMH1tmXSPn.VP7yzKKaO', '9123456789', 'Bachelors', 'AI', 1, '2002-07-22', '2023-09-01 10:00:00'),
('U21CS003', 'Aditya Patel', 'u21cs003@coed.svnit.ac.in', '$2a$10$35iR9fSbADq9dzcnKd9syuy6sv.pTGghyJTVI5FOWwXLMfHNBP/jq', '9123456734', 'Masters', 'CS', 1, '2001-02-10', '2023-09-01 10:00:00'),
('U21AI004', 'Aanya Verma', 'u21ai004@coed.svnit.ac.in', '$2a$10$XHrpTb7s7P0YeVULUd.TcuCjbHoS.eUeM3/TiEDrOW8H6M/OA0JuW', '9098765432', 'Masters', 'AI', 1, '2001-11-05', '2023-09-01 10:00:00'),
('U20CS005', 'Raghav Kumar', 'u20cs005@coed.svnit.ac.in', '$2a$10$XzFJE0UTYVepZ89s8bG5EuDgSfzCxyCzGxsRclvUJdM8.XFEG.UXK', '9823456789', 'Bachelors', 'CS', 1, '2002-04-09', '2023-09-01 10:00:00'),
('U20AI006', 'Aryan Joshi', 'u20ai006@coed.svnit.ac.in', '$2a$10$YfgDKP09shAOqZItxfpqjuRcZsda0zRkICXaEDb4OLWoIpc9PD0Qy', '9312345678', 'Bachelors', 'AI', 1, '2002-06-14', '2023-09-01 10:00:00'),

-- Semester 2
('U21CS007', 'Krishna Mehta', 'u21cs007@coed.svnit.ac.in', '$2a$10$.G4NSF/NltuGqNuqS8ozcO3SP8TbJDUpBFVgYPYwog0y4OAKWRjv6', '9123445678', 'Masters', 'CS', 2, '2001-01-27', '2023-09-01 10:00:00'),
('U21AI008', 'Saanvi Nair', 'u21ai008@coed.svnit.ac.in', '$2a$10$hd2Ut/0LPdyCKaNjRz7FveXiyBWEpDq/6WQLWZ6V9pUPZFTQd1Z6W', '9987654321', 'Masters', 'AI', 2, '2000-11-12', '2023-09-01 10:00:00'),
('U22CS009', 'Anaya Singh', 'u22cs009@coed.svnit.ac.in', '$2a$10$yBn6fJ/4P1qOKPQPG/hHdOknzft5HdI25sXkCwKpUn5bVCVuOvTB2', '9812345678', 'Bachelors', 'CS', 2, '2003-05-05', '2023-09-01 10:00:00'),
('U22AI010', 'Rohit Verma', 'u22ai010@coed.svnit.ac.in', '$2a$10$d.x6NOJAX/6Z7eK8xoq7Pu5gbFVC/TuQaWhzYPH6ZPysZJKV5IwJW', '9612345678', 'Bachelors', 'AI', 2, '2003-09-21', '2023-09-01 10:00:00'),
('U23CS011', 'Aisha Patel', 'u23cs011@coed.svnit.ac.in', '$2a$10$OeEYrsQKRa2hDwm3FBscROovLsGHgHY0A8uG5EzR6xyB8Oxd7cHnW', '9898765432', 'Masters', 'CS', 2, '2002-10-13', '2023-09-01 10:00:00'),
('U23AI012', 'Devansh Kumar', 'u23ai012@coed.svnit.ac.in', '$2a$10$NEl4UzRMOF8T3KMoHgQzXO9F6PFR1Mv/9xOxhOXzkO/ja10wwjJae', '9198765432', 'Masters', 'AI', 2, '2002-08-05', '2023-09-01 10:00:00'),

-- Semester 3
('U22CS013', 'Pooja Iyer', 'u22cs013@coed.svnit.ac.in', '$2a$10$xqge8U8DsDOxlHZpy3F7eOtqTIecE9YvO.OCXxjZabFMuoQBxpeAu', '9543216789', 'Bachelors', 'CS', 3, '2003-01-12', '2023-09-01 10:00:00'),
('U22AI014', 'Krishna Rao', 'u22ai014@coed.svnit.ac.in', '$2a$10$EJ3IQ/8IgiNo0UGgNl47he8/qJ0AOfkbWnhgWly8PxOKOqMLoFNGy', '9123456745', 'Bachelors', 'AI', 3, '2003-03-30', '2023-09-01 10:00:00'),
('U21CS015', 'Rohini Singh', 'u21cs015@coed.svnit.ac.in', '$2a$10$1KJY3HFoDMPBdykn/2Wcje/L/EKYrKgEp6fpMlRxQUKrhgZQpzzg2', '9871234560', 'Masters', 'CS', 3, '2001-11-25', '2023-09-01 10:00:00'),
('U21AI016', 'Devika Joshi', 'u21ai016@coed.svnit.ac.in', '$2a$10$d0YHdCbbiVE.VpCwv.pZVepSbdxEm4Xvbs9qYQUXqJrEJrA8hbMEu', '9876543201', 'Masters', 'AI', 3, '2000-09-30', '2023-09-01 10:00:00'),

-- Semester 4
('U20CS017', 'Shivani Agarwal', 'u020cs17@coed.svnit.ac.in', '$2a$10$Zl9Sv.DHBDx.JLpsguTWuOqXx/p.vlhCNMDlG.HYX1wPSOTPl3wzG', '9832123456', 'Bachelors', 'CS', 4, '2002-07-15', '2023-09-01 10:00:00'),
('U20AI018', 'Arun Yadav', 'u20ai018@coed.svnit.ac.in', '$2a$10$Kpe5.tADboJb.xXwHdFoSO9k.2HOFF5pp4fbgGhWyDLNR4FKf4FRe', '9654321098', 'Bachelors', 'AI', 4, '2002-10-19', '2023-09-01 10:00:00'),

-- Semester 5
('U20CS019', 'Kavya Reddy', 'u20cs019@coed.svnit.ac.in', '$2a$10$3vd2z3e4gcpSeau5VZyOHe/BQHh7gFb5k.O1AT6HG8mXSPsAR07Li', '9776543210', 'Bachelors', 'CS', 5, '2002-06-11', '2023-09-01 10:00:00'),
('U20AI020', 'Tanvi Menon', 'u20ai020@coed.svnit.ac.in', '$2a$10$1m5XSDUeSBvTuYy75OW1j.yNfdUqaxPsSnXkZeu/rW1RSgLZpFZti', '9723456780', 'Bachelors', 'AI', 5, '2002-01-22', '2023-09-01 10:00:00'),
('U21CS021', 'Harsh Sharma', 'u21cs021@coed.svnit.ac.in', '$2a$10$YNi4EUl4.P8U93YJm2p2KeS2NWvdZ1FofbWVGuRO6Of/RkC6GzH6K', '9882345678', 'Masters', 'CS', 5, '2001-05-14', '2023-09-01 10:00:00'),
('U21AI022', 'Ishaan Choudhury', 'u21ai022@coed.svnit.ac.in', '$2a$10$M2gtwb05s/4f9wD9dYjM2OO1JDCR6J/6g7TOUQlU1MLWyX1F4Z9S2', '9315678901', 'Masters', 'AI', 5, '2001-09-30', '2023-09-01 10:00:00'),

-- Semester 6
('U20CS023', 'Gaurav Rani', 'u20cs023@coed.svnit.ac.in', '$2a$10$1RjEkN7CekC.Ff65chfFS.zWzPiTWdJ.Ft01LzL0k2mJbDrt03o4y', '9867543210', 'Bachelors', 'CS', 6, '2002-03-01', '2023-09-01 10:00:00'),
('U20AI024', 'Siddharth Verma', 'u20ai024@coed.svnit.ac.in', '$2a$10$6MyZPee9qj1REafYt30W.O1/xFWEGOzxXyAxzV12sw3EdTQ0TBuDe', '9834125678', 'Bachelors', 'AI', 6, '2002-02-18', '2023-09-01 10:00:00'),

-- Semester 7
('U21CS025', 'Neha Shah', 'u21cs025@coed.svnit.ac.in', '$2a$10$zYx5x0F4My6c2G7IPQBlO.x9i/d3z.nWl9KgvGtG7HpT1bOrRDwvW', '9798765432', 'Masters', 'CS', 7, '2001-03-20', '2023-09-01 10:00:00'),
('U21AI026', 'Siddharth Reddy', 'u21ai026@coed.svnit.ac.in', '$2a$10$PeB0b.x5rUPWc7G0B0ohtO8wDlk9Uj3e1DOhCMs.W0KZ5M8V1T7dK', '9787654321', 'Masters', 'AI', 7, '2001-04-30', '2023-09-01 10:00:00'),

-- Semester 8
('U20CS027', 'Advik Iyer', 'u20cs027@coed.svnit.ac.in', '$2a$10$JthSw5s.fOn8Vz3epU6yE.PwzPYknDsy/pw1HTBf3yW6v5zG5q4tC', '9712345678', 'Bachelors', 'CS', 8, '2002-01-14', '2023-09-01 10:00:00'),
('U20AI028', 'Anjali Patil', 'u20ai028@coed.svnit.ac.in', '$2a$10$Y5XWzBrqYV5waqiw2oVZqeOHe5XUtptVoC0S9jI.L5f5G3/ZbEBd6', '9756123456', 'Bachelors', 'AI', 8, '2002-08-30', '2023-09-01 10:00:00'),
('U21CS029', 'Tanishq Agarwal', 'u21cs029@coed.svnit.ac.in', '$2a$10$HHzM7Y5Olx69ihUtZ2r7b.n4NX.WxlRPKGhMXJQjOnXzMDrX8PZZC', '9643219870', 'Masters', 'CS', 8, '2001-06-11', '2023-09-01 10:00:00'),
('U21AI030', 'Nikhil Gupta', 'u21ai030@coed.svnit.ac.in', '$2a$10$1rv5EGLsbzSzrUOEiHK5Oev9z6RP4Emvn/XFXwR7/10veCiw4JdA6', '9125687490', 'Masters', 'AI', 8, '2001-12-18', '2023-09-01 10:00:00'),
('U20CS031', 'Siddharth Joshi', 'u20cs031@coed.svnit.ac.in', '$2a$10$uDUN/tW/CC2wYa0xF1EtPeAin8vqYmiy7yB.fgxfxghAfId5V8d1y', '9856123450', 'Bachelors', 'CS', 1, '2002-01-14', '2023-09-01 10:00:00'),
('U20AI032', 'Aditi Singh', 'u20ai032@coed.svnit.ac.in', '$2a$10$4QzpGBWcK8Xa.NjT9zSoS.6v./60BboT5F1U4WzKLdCEcJ4IrN8yK', '9798654321', 'Bachelors', 'AI', 1, '2002-08-25', '2023-09-01 10:00:00'),
('U21CS033', 'Vishal Kumar', 'u21cs033@coed.svnit.ac.in', '$2a$10$Vp0w6WNOt.yLi3xGZb8P3e3ZXI2W9/oAR9TqAy5XqX6Hsa1Xt4ObO', '9785342170', 'Masters', 'CS', 2, '2001-03-07', '2023-09-01 10:00:00'),
('U21AI034', 'Riya Verma', 'u21ai034@coed.svnit.ac.in', '$2a$10$Vq.z9Pb6FDoHZWoH4/o/QeLGe3wJrx04X3Cp.EzSWgfDSG34.4NaC', '9812345771', 'Masters', 'AI', 2, '2001-10-10', '2023-09-01 10:00:00'),
('U22CS035', 'Arav Ahuja', 'u22cs035@coed.svnit.ac.in', '$2a$10$EflK89xAIXLiC4NYqi.JNO3Jj8km9YJKd27W8aVg/ihtlOnMDUeHi', '9882365470', 'Bachelors', 'CS', 3, '2003-03-17', '2023-09-01 10:00:00'),
('U22AI036', 'Naina Sharma', 'u22ai036@coed.svnit.ac.in', '$2a$10$Dxl7Cu9/uLMtHloXZfZ0MecE5W/CC8We3sC/ACD/MCyZ/FgWeC.wF', '9598743210', 'Bachelors', 'AI', 3, '2003-05-02', '2023-09-01 10:00:00'),
('U23CS037', 'Rehan Ansari', 'u23cs037@coed.svnit.ac.in', '$2a$10$4C0zE4dADHDXk4T2Ib91iOfr0cpE.BuTOVHe/l36EifKKSk5ax8S2', '9718925467', 'Masters', 'CS', 4, '2002-10-15', '2023-09-01 10:00:00'),
('U23AI038', 'Ritika Sharma', 'u23ai038@coed.svnit.ac.in', '$2a$10$8WlFKzHIfXk2jllmOLO.xe2RMdDHFJQqJ.rVpg1Ut8JWenTgoIEiK', '9614328756', 'Masters', 'AI', 4, '2002-01-29', '2023-09-01 10:00:00'),
('U24CS039', 'Kabir Choudhury', 'u24cs039@coed.svnit.ac.in', '$2a$10$Dkp3N0bb4UAK7iDs9U4WbOdK.PRT2dcIDT4dFDY.I22bUoYDQb4hC', '9567894320', 'Bachelors', 'CS', 5, '2003-05-25', '2023-09-01 10:00:00'),
('U24AI040', 'Kaira Gupta', 'u24ai040@coed.svnit.ac.in', '$2a$10$AgcOKnpJqvntGGe5SM6Q7OHzFRt1Nr9E0Q9ZUBw0Emc9Ph1CDvG6a', '9887654321', 'Bachelors', 'AI', 5, '2003-02-20', '2023-09-01 10:00:00'),
('U25CS041', 'Om Shukla', 'u25cs041@coed.svnit.ac.in', '$2a$10$Lg1GCxz9Y.AbhTz4gyMaH.se30H7tHbwlP2GHEa5PIq93H9UAKtd2', '9443214567', 'Masters', 'CS', 6, '2001-06-15', '2023-09-01 10:00:00'),
('U25AI042', 'Siddhi Tiwari', 'u25ai042@coed.svnit.ac.in', '$2a$10$1ax5xZ7PHTmJSK5oD7pgCec5SHJSYpCM2qOvZesfWCR3NHoCgs3sS', '9198234567', 'Masters', 'AI', 6, '2000-04-05', '2023-09-01 10:00:00'),
('U26CS043', 'Kanishk Agarwal', 'u26cs043@coed.svnit.ac.in', '$2a$10$X8bo2JHh1KNdZG0br16r1uXfy.GBXYMyFoeDi.pz.m1VW7RJ2MroO', '9801234567', 'Bachelors', 'CS', 7, '2002-08-28', '2023-09-01 10:00:00'),
('U26AI044', 'Diksha Pandey', 'u26ai044@coed.svnit.ac.in', '$2a$10$9IcT/13GCL.RF0G5.sv4P./WmW.rTqkPZJInjzAmF5Mo6v6AbBFOe', '9276543210', 'Bachelors', 'AI', 7, '2003-03-30', '2023-09-01 10:00:00'),
('U27CS045', 'Rudra Kumar', 'u27cs045@coed.svnit.ac.in', '$2a$10$U8nRfWeDToZ3DNsM0jUg0u/mbhU4TRM/qaEnGfSrrCMrvbOtIzIMK', '9082345678', 'Masters', 'CS', 8, '2001-02-20', '2023-09-01 10:00:00'),
('U27AI046', 'Aarvi Sharma', 'u27ai046@coed.svnit.ac.in', '$2a$10$E7w/0/dnv5EsXcGZyZve8u1wZ9Zyzx27QthnTHT7AzM/bp7NydLpe', '9671234560', 'Masters', 'AI', 8, '2001-12-31', '2023-09-01 10:00:00'),
('U28CS047', 'Vedika Bansal', 'u28cs047@coed.svnit.ac.in', '$2a$10$4slcO6KpUL5KQWq5Wkr8qO/6wZbByph7MjQFbcSlHqqkM0F6yOzqG', '9356789123', 'Bachelors', 'CS', 6, '2003-09-01', '2023-09-01 10:00:00'),
('U28AI048', 'Bhavesh Patel', 'u28ai048@coed.svnit.ac.in', '$2a$10$Y8aPtNkuSfn/NWyE2C9uUeH36l1t5vLq3u8lgKlo8dL.F.t.1z/9u', '9445671230', 'Bachelors', 'AI', 6, '2003-10-10', '2023-09-01 10:00:00'),
('U29CS049', 'Lavanya Nair', 'u29cs049@coed.svnit.ac.in', '$2a$10$3CS9I8/ff8BNhiAykP7mTuCkBpkjpDoykqIoBvztbJyxazodPku6W', '9723412345', 'Masters', 'CS', 5, '2001-05-05', '2023-09-01 10:00:00'),
('U29AI050', 'Suryansh Iyer', 'u29ai050@coed.svnit.ac.in', '$2a$10$ECv7Vh.Ga3Bq0.nF3PH7J.gYPWw51pbWiYzwC6h2Zt7waX48CivqW', '9889901099', 'Masters', 'AI', 5, '2001-07-21', '2023-09-01 10:00:00');

INSERT INTO availableCourses (course_id, course_name, branch, semester) VALUES
-- Semester 1
('CS101', 'Introduction to Programming', 'CS', 1),
('CS102', 'Mathematics I', 'CS', 1),
('CS103', 'Engineering Physics', 'CS', 1),
('CS104', 'Basic Electronics', 'CS', 1),
('CS105', 'Environmental Studies', 'CS', 1),

-- Semester 2
('CS201', 'Data Structures', 'CS', 2),
('CS202', 'Discrete Mathematics', 'CS', 2),
('CS203', 'Digital Logic Design', 'CS', 2),
('CS204', 'Computer Organization', 'CS', 2),
('CS205', 'Mathematics II', 'CS', 2),

-- Semester 3
('CS301', 'Algorithms', 'CS', 3),
('CS302', 'Database Management Systems', 'CS', 3),
('CS303', 'Operating Systems', 'CS', 3),
('CS304', 'Theory of Computation', 'CS', 3),
('CS305', 'Object-Oriented Programming', 'CS', 3),

-- Semester 4
('CS401', 'Computer Networks', 'CS', 4),
('CS402', 'Software Engineering', 'CS', 4),
('CS403', 'Compiler Design', 'CS', 4),
('CS404', 'Mathematics III', 'CS', 4),
('CS405', 'Artificial Intelligence', 'AI', 4),

-- Semester 5
('CS501', 'Web Development', 'CS', 5),
('CS502', 'Cyber Security', 'CS', 5),
('CS503', 'Data Science', 'AI', 5),
('CS504', 'Big Data Technologies', 'AI', 5),
('CS505', 'Cloud Computing', 'CS', 5),

-- Semester 6
('CS601', 'Mobile Application Development', 'CS', 6),
('CS602', 'Machine Learning', 'AI', 6),
('CS603', 'Natural Language Processing', 'AI', 6),
('CS604', 'Computer Vision', 'AI', 6),
('CS605', 'Data Visualization', 'CS', 6),

-- Semester 7
('CS701', 'Blockchain Technology', 'CS', 7),
('CS702', 'Distributed Systems', 'CS', 7),
('CS703', 'Internet of Things', 'CS', 7),
('CS704', 'Advanced Algorithms', 'CS', 7),
('CS705', 'Parallel Computing', 'CS', 7),

-- Semester 8
('CS801', 'Project Management', 'CS', 8),
('CS802', 'Entrepreneurship', 'CS', 8),
('CS803', 'Ethics in Technology', 'CS', 8),
('CS804', 'Research Methodologies', 'CS', 8),
('CS805', 'Final Year Project', 'CS', 8),

-- Additional Courses
('AI101', 'Introduction to Artificial Intelligence', 'AI', 1),
('AI102', 'Introduction to Machine Learning', 'AI', 2),
('AI201', 'Deep Learning', 'AI', 3),
('AI202', 'Reinforcement Learning', 'AI', 4),
('AI301', 'Data Mining', 'AI', 5),
('AI302', 'Robotics', 'AI', 6),
('AI401', 'AI Ethics', 'AI', 7),
('AI402', 'AI in Healthcare', 'AI', 8),
('AI501', 'AI for Business', 'AI', 8),
('AI502', 'Advanced Topics in AI', 'AI', 8),

-- Additional CS Courses
('CS106', 'Introduction to Data Science', 'CS', 1),
('CS107', 'Software Testing', 'CS', 3),
('CS108', 'User Interface Design', 'CS', 4),
('CS109', 'Digital Signal Processing', 'CS', 6),
('CS110', 'Human-Computer Interaction', 'CS', 7),
('CS111', 'Information Retrieval', 'CS', 6),
('CS112', 'Game Development', 'CS', 5),
('CS113', 'Cloud Architecture', 'CS', 8),
('CS114', 'Virtual Reality', 'CS', 8);


INSERT INTO enrolledStudents (course_id, student_id) VALUES
('CS101', 'U20CS001'),
('CS102', 'U21CS003'),
('CS103', 'U20CS005'),
('CS104', 'U22CS009'),
('CS105', 'U21CS007'),
('CS106', 'U23CS011'),
('CS107', 'U24CS039'),
('CS108', 'U22CS013'),
('CS109', 'U20CS017'),
('CS110', 'U21CS015'),
('CS111', 'U21CS025'),
('CS112', 'U21CS021'),
('CS113', 'U22CS035'),
('CS114', 'U21CS029'),
('CS201', 'U20CS019'),
('CS202', 'U22CS009'),
('CS203', 'U23CS037'),
('CS204', 'U21CS033'),
('CS205', 'U20CS023'),
('CS301', 'U20CS027'),
('CS302', 'U21CS003'),
('CS303', 'U20CS001'),
('CS304', 'U22CS009'),
('CS305', 'U21CS007'),
('CS401', 'U21CS021'),
('CS402', 'U21CS025'),
('CS403', 'U21CS029'),
('CS404', 'U21CS033'),
('CS405', 'U20CS031'),
('CS501', 'U20CS017'),
('CS502', 'U23CS011'),
('CS503', 'U22CS013'),
('CS504', 'U22CS035'),
('CS505', 'U21CS003'),
('CS601', 'U20CS005'),
('CS602', 'U24CS039'),
('CS603', 'U20CS023'),
('CS604', 'U21CS007'),
('CS605', 'U21CS015'),
('CS701', 'U21CS021'),
('CS702', 'U21CS025'),
('CS703', 'U21CS029'),
('CS704', 'U21CS033'),
('CS705', 'U22CS035'),
('AI101', 'U20CS001'),
('AI102', 'U21CS003'),
('AI201', 'U20CS005'),
('AI202', 'U22CS009'),
('AI301', 'U20CS017'),
('AI302', 'U21CS015');


-- Inserting data into the professor table with hashed passwords
INSERT INTO professor (pid, email, name, password, phone_number, department, hire_date) VALUES
-- Already provided 8 entries, adding 22 more
('P001', 'p001@coed.svnit.ac.in', 'Dr. Amit Sharma', '$2y$10$zVh8dFJcMxaA7Hn8W8TP0uvH6xDS3Yez0yMdsbCVPwhJaiB1WJbmW', '9876543210', 'Computer Science', '2010-06-12'),
('P002', 'p002@coed.svnit.ac.in', 'Prof. Sita Verma', '$2y$10$zEhXYfC.zg3SOFnUlV8gtulAqZyH5g/PQ.ASuwGAozRuJl5HAYmCS', '9876543211', 'Artificial Intelligence', '2012-08-25'),
('P003', 'p003@coed.svnit.ac.in', 'Dr. Rajesh Gupta', '$2y$10$.fKqRCH5eOEPTgdFnzFYeOOAVguF/XGgpyIxAk73oN.JRH/HSAs8y', '9876543212', 'Data Science', '2015-01-15'),
('P004', 'p004@coed.svnit.ac.in', 'Dr. Neeta Mehta', '$2y$10$yfTbrfAxIg8wXpuLjZEkReZRNa3E6oJfdYOPcFvKnEhNL8d1PGKWO', '9876543213', 'Electrical Engineering', '2011-04-05'),
('P005', 'p005@coed.svnit.ac.in', 'Prof. Vikram Joshi', '$2y$10$fr/U2PhfnHiPfFR7r.cmi.SI4EVYO27d5hPCvT4a.bQDFnOkVfXOe', '9876543214', 'Mechanical Engineering', '2014-09-19'),
('P006', 'p006@coed.svnit.ac.in', 'Dr. Priya Singh', '$2y$10$pFTpzCqUKB1XIvRYWYyLteA9w3AeMhHrFaD/V0vAnJhTdrll3u.VC', '9876543215', 'Civil Engineering', '2013-07-10'),
('P007', 'p007@coed.svnit.ac.in', 'Dr. Arjun Rao', '$2y$10$TjNdKzE2RfD7OMfI1vPqje5uYOssjGh5rKWevsfgTf0IgN9irJfW.', '9876543216', 'Information Technology', '2016-02-22'),
('P008', 'p008@coed.svnit.ac.in', 'Prof. Kavita Bhatia', '$2y$10$4mDsRBbkW5P9mG5XU7GhzeUVusPHNC56ZnEMjKXHfTFJOsM5I1Qaa', '9876543217', 'Artificial Intelligence', '2018-11-14'),

-- Adding 22 more entries
('P009', 'p009@coed.svnit.ac.in', 'Dr. Mahesh Patel', '$2y$10$trFBGc1QmYRPfOR9D.bQEuAVbxHTtM7KETSh1EFAlQGds8cKiAk8W', '9876543218', 'Physics', '2012-03-05'),
('P010', 'p010@coed.svnit.ac.in', 'Prof. Sunita Reddy', '$2y$10$qUCBI94.OQOSVmS1r5xG3.Omsj7roRk/XPQn4E9XhU7Hze7HzM7ve', '9876543219', 'Mathematics', '2011-11-30'),
('P011', 'p011@coed.svnit.ac.in', 'Dr. Rakesh Saxena', '$2y$10$aeFbHrMhfsl5PpkfkZr8Vu.LVP1cgeTP5PL5bhW0zMWnpkVRsD7Oq', '9876543220', 'Chemistry', '2015-08-19'),
('P012', 'p012@coed.svnit.ac.in', 'Prof. Vandana Kulkarni', '$2y$10$BoeIYMgVpj3l.lUIJdDrDeqRg/Ck82kXv5sSfbTSunukOe3cDJmVu', '9876543221', 'Biotechnology', '2016-05-27'),
('P013', 'p013@coed.svnit.ac.in', 'Dr. Deepak Mishra', '$2y$10$e7MdYpNjVpTQAvWBG7vFjui0.qO7fybBlssIZVd8hr7dIMb02i2Be', '9876543222', 'Computer Science', '2017-09-14'),
('P014', 'p014@coed.svnit.ac.in', 'Prof. Ritu Bhalla', '$2y$10$HsUmG4AlyThpDYdgKgNt3eWQWxsEQRfTZxk6sRXr5.Q6TGm0kLPBa', '9876543223', 'Information Technology', '2014-01-11'),
('P015', 'p015@coed.svnit.ac.in', 'Dr. Arun Chopra', '$2y$10$5.g5txOzmDE29WfEJLaUQuZ2ghuH1ZsQwHQN3/Mdm5XYLVpypfycC', '9876543224', 'Mechanical Engineering', '2019-04-22'),
('P016', 'p016@coed.svnit.ac.in', 'Prof. Sangeeta Yadav', '$2y$10$gWzErXdN9MdiZoe6Ep93tO1RQ7pu/jtbBd7hn96NO0Qs2HF.JCTCO', '9876543225', 'Electrical Engineering', '2013-02-14'),
('P017', 'p017@coed.svnit.ac.in', 'Dr. Nilesh Joshi', '$2y$10$QYoE9SaeVtnzBOxyovG5z.Tv5nW.TfUlCeFLZT5KYYbSiKlWV0E7y', '9876543226', 'Civil Engineering', '2018-07-01'),
('P018', 'p018@coed.svnit.ac.in', 'Prof. Prachi Agarwal', '$2y$10$AalC4e3CT9oG/SmWvKB69eVEorj/fYTxSBC7lMGJbyfz4/LrWsFfS', '9876543227', 'Biotechnology', '2017-06-23'),
('P019', 'p019@coed.svnit.ac.in', 'Dr. Manoj Desai', '$2y$10$dPA3BfYPzzlv6wGFmYt0c.XTsbAlWkI5LmwNdZUpKPExhgiQyCStO', '9876543228', 'Physics', '2020-01-02'),
('P020', 'p020@coed.svnit.ac.in', 'Prof. Neha Grover', '$2y$10$RiCx.oKHxmXIf4vFoWnPKuITZUS0hAnVmcbP52Fg.fvKmBh3vQiQG', '9876543229', 'Mathematics', '2016-09-08'),
('P021', 'p021@coed.svnit.ac.in', 'Dr. Rajiv Patel', '$2y$10$H7RL/l8bf5v9Fwx5YrQa9eHIXGTxydO0.RTVDOrOqO3mta5x/yTZ6', '9876543230', 'Chemistry', '2015-03-03'),
('P022', 'p022@coed.svnit.ac.in', 'Prof. Pooja Jain', '$2y$10$s3OiROFrBQg7nD/E5RcqcOxGpV/JmxOwN41p.HtGZYuWYB0Y2gWgq', '9876543231', 'Artificial Intelligence', '2019-05-17'),
('P023', 'p023@coed.svnit.ac.in', 'Dr. Ashok Pandey', '$2y$10$LJmY.I1XtNdWrt2/DaU6cuaX1gfDeEDLudldRbZDWViDqT2N.mQaG', '9876543232', 'Data Science', '2020-07-24'),
('P024', 'p024@coed.svnit.ac.in', 'Prof. Meena Nair', '$2y$10$wY9wd4.QpWbdU/oqgfHZquQpCkLsDLmDguZAr.F52DRtxIKwnwrcm', '9876543233', 'Electrical Engineering', '2012-12-30'),
('P025', 'p025@coed.svnit.ac.in', 'Dr. Suresh Tripathi', '$2y$10$.mftLBoXbGWbFdHkgxTGxuEVG25m6O4AtSeM3EOPE8y/U..9Afq7q', '9876543234', 'Mechanical Engineering', '2011-11-18'),
('P026', 'p026@coed.svnit.ac.in', 'Prof. Jyoti Das', '$2y$10$BoG9kAyWo/JwFFvZPxxy3O40d7yP2WhZy3rk8/z6Yg/sb/ZkS3HpW', '9876543235', 'Information Technology', '2014-10-10'),
('P027', 'p027@coed.svnit.ac.in', 'Dr. Rajan Kapoor', '$2y$10$tS4dAqfIMAfM7CTSVS3iLOyjt3KOANPD9CFwD3LwAcjEo0/IgEKli', '9876543236', 'Civil Engineering', '2019-03-13'),
('P028', 'p028@coed.svnit.ac.in', 'Prof. Shruti Sharma', '$2y$10$p/N2/CplxW9RrHZ1hXRL0.jcbR5K8nAxDoDezYXhncYXc0dxdGv8W', '9876543237', 'Artificial Intelligence', '2021-11-15'),
('P029', 'p029@coed.svnit.ac.in', 'Dr. Neeraj Kumar', '$2y$10$wD/xi4rtdfSeAwOdHbV9YeJ6cw9/ZrSzzJmrIuytDAJ8/z.wkj1ti', '9876543238', 'Physics', '2013-12-20'),
('P030', 'p030@coed.svnit.ac.in', 'Prof. Suman Joshi', '$2y$10$7Kmbdf59OhfhFyLgWgb9Lu9FG8Uov6H/HzZopH5t4IitktW94NEXy', '9876543239', 'Computer Science', '2020-04-04');

-- Inserting data into the courses table
INSERT INTO courses (course_id, course_name, credits, semesterNo) VALUES
-- Using provided data
('CS101', 'Introduction to Programming', 3, 1),
('CS102', 'Discrete Mathematics', 3, 1),
('CS103', 'Computer Networks', 4, 3),
('CS104', 'Web Development', 4, 2),
('CS105', 'Computer Graphics', 4, 5),
('CS106', 'Cloud Computing', 3, 6),
('CS107', 'Cybersecurity Fundamentals', 4, 4),
('AI101', 'Introduction to AI', 3, 1),
('AI102', 'Deep Learning', 4, 5),
('AI103', 'Natural Language Processing', 4, 6),

-- Adding additional courses to extend the dataset
('CS108', 'Operating Systems', 4, 3),
('CS109', 'Software Engineering', 3, 4),
('CS110', 'Data Structures and Algorithms', 4, 2),
('CS201', 'Machine Learning', 4, 5),
('CS202', 'Database Management Systems', 3, 3),
('CS203', 'Artificial Intelligence', 4, 6),
('CS204', 'Mobile Application Development', 3, 5),
('CS205', 'Compiler Design', 4, 6),
('CS301', 'Big Data Analytics', 4, 7),
('CS302', 'Internet of Things', 3, 6),
('AI201', 'Robotics', 4, 3),
('AI202', 'AI Ethics', 3, 4),
('AI301', 'Computer Vision', 4, 5),
('AI302', 'AI for Healthcare', 3, 6),
('AI401', 'AI in Autonomous Systems', 4, 7),
('AI402', 'AI for Business', 3, 6),
('AI501', 'AI in Cybersecurity', 4, 8),
('AI502', 'AI in Finance', 3, 8);

INSERT INTO courses (course_id, course_name, credits, semesterNo) VALUES
('CS101', 'Introduction to Programming', 3, 1);


-- Inserting data into the Schedule table with provided course_id and pid
-- Inserting 5 valid entries into the Schedule table
INSERT INTO Schedule (semNo, branch, c_id, prof_id, day, start_time, end_time) VALUES
(1, 'CS', 'CS101', 'P001', 'Monday', '09:00', '10:00'),
(1, 'CS', 'CS102', 'P002', 'Tuesday', '10:00', '11:00'),
(2, 'AI', 'AI101', 'P006', 'Wednesday', '11:00', '12:00'),
(2, 'AI', 'AI102', 'P007', 'Thursday', '12:00', '13:00'),
(3, 'CS', 'CS103', 'P003', 'Friday', '13:00', '14:00');

-- Inserting data into the results table with specified grades and ensuring failed grades have 0 credits obtained
INSERT INTO results (semNo, sid, cid, total_credits, credits_obtained, grade) VALUES
(1, 'U20AI002', 'AI101', 3, 3, 'AA'),
(1, 'U20AI006', 'AI102', 3, 3, 'AA'),
(4, 'U20AI018', 'AI201', 4, 3, 'AB'),
(5, 'U20AI020', 'AI202', 4, 4, 'AA'),
(6, 'U20AI024', 'AI301', 4, 2, 'BC'),
(8, 'U20AI028', 'AI302', 4, 4, 'AA'),
(1, 'U20AI032', 'AI401', 3, 3, 'AA'),
(1, 'U20CS001', 'CS101', 3, 3, 'AA'),
(1, 'U20CS005', 'CS102', 3, 2, 'BC'),
(4, 'U20CS017', 'CS201', 4, 4, 'AA'),
(5, 'U20CS019', 'CS202', 4, 3, 'AB'),
(6, 'U20CS023', 'CS203', 4, 3, 'BC'),
(8, 'U20CS027', 'CS204', 4, 0, 'FF'), -- Failed
(1, 'U20CS031', 'CS205', 3, 3, 'AA'),
(1, 'U21AI004', 'AI101', 3, 3, 'AA'),
(2, 'U21AI008', 'AI102', 3, 3, 'AA'),
(3, 'U21AI016', 'AI201', 4, 3, 'AB'),
(5, 'U21AI022', 'AI202', 4, 4, 'AA'),
(7, 'U21AI026', 'AI301', 4, 3, 'BB'),
(8, 'U21AI030', 'AI302', 4, 4, 'AA'),
(2, 'U21AI034', 'AI401', 3, 3, 'AA'),
(1, 'U21CS003', 'CS101', 3, 3, 'AA'),
(2, 'U21CS007', 'CS102', 3, 2, 'BC'),
(3, 'U21CS015', 'CS201', 4, 4, 'AA'),
(5, 'U21CS021', 'CS202', 4, 4, 'AA'),
(7, 'U21CS025', 'CS203', 4, 3, 'BB'),
(8, 'U21CS029', 'CS204', 4, 3, 'CC'),
(2, 'U21CS033', 'CS205', 3, 0, 'FF'), -- Failed
(2, 'U22AI010', 'AI101', 3, 3, 'AA'),
(3, 'U22AI014', 'AI102', 3, 3, 'AA'),
(3, 'U22AI036', 'AI201', 4, 3, 'AB'),
(2, 'U22CS009', 'CS101', 3, 3, 'AA'),
(3, 'U22CS013', 'CS102', 3, 3, 'AA'),
(3, 'U22CS035', 'CS201', 4, 4, 'AA'),
(2, 'U23AI012', 'AI102', 3, 2, 'BC'),
(4, 'U23AI038', 'AI201', 4, 4, 'AA'),
(2, 'U23CS011', 'CS101', 3, 3, 'AA'),
(4, 'U23CS037', 'CS202', 4, 3, 'AB'),
(5, 'U24AI040', 'AI301', 4, 4, 'AA'),
(5, 'U24CS039', 'CS203', 4, 3, 'BC'),
(6, 'U25AI042', 'AI401', 3, 3, 'AA'),
(6, 'U25CS041', 'CS205', 4, 0, 'FF'), -- Failed
(7, 'U26AI044', 'AI101', 3, 3, 'AA'),
(7, 'U26CS043', 'CS101', 3, 2, 'DD'),
(8, 'U27AI046', 'AI202', 4, 4, 'AA'),
(8, 'U27CS045', 'CS202', 4, 3, 'BB'),
(6, 'U28AI048', 'AI401', 3, 3, 'AA'),
(6, 'U28CS047', 'CS203', 4, 4, 'AA'),
(5, 'U29AI050', 'AI301', 4, 4, 'AA'),
(5, 'U29CS049', 'CS201', 4, 3, 'BC');


-- Inserting data into the assignProfessors table
INSERT INTO assignProfessors (course_id, prof_id,enrollmentLimit) VALUES
('AI101', 'P001',40),
('AI102', 'P002',50),
('AI201', 'P003',60),
('AI202', 'P004',70),
('AI301', 'P005',50),
('AI302', 'P006',50),
('AI401', 'P007',50),
('AI402', 'P008',60),
('AI501', 'P009',45),
('AI502', 'P010',40),
('CS101', 'P011',50),
('CS102', 'P012',50),
('CS103', 'P013',50),
('CS104', 'P014',60),
('CS105', 'P015',40),
('CS106', 'P016',50),
('CS107', 'P017',60),
('CS108', 'P018',50),
('CS109', 'P019',40),
('CS110', 'P020',50),
('CS111', 'P021',45),
('CS112', 'P022',60),
('CS113', 'P023',55),
('CS114', 'P024',45),
('CS201', 'P025',50),
('CS202', 'P026',60),
('CS203', 'P027',50),
('CS204', 'P028',60),
('CS205', 'P029',55),
('CS301', 'P030',60);

CREATE TABLE syllabus(
	c_id varchar(20) not null primary key,
	syllabus varchar(100) not null ,
	FOREIGN KEY (c_id) REFERENCES courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO syllabus (c_id, syllabus) VALUES
('CS101', 'Introduction to Programming, Variables, Loops, Functions'),
('CS102', 'Data Structures: Arrays, Linked Lists, Trees, Graphs'),
('AI101', 'AI Basics, Neural Networks, Search Algorithms'),
('AI201', 'Machine Learning: Supervised, Unsupervised Learning'),
('CS201', 'Algorithms: Sorting, Searching, Dynamic Programming'),
('CS301', 'Operating Systems: Processes, Memory Management, File Systems');

-- drop database universitymanagement;






-- This will add 30 course records in total.


-- select * from complaint;

create table Admin(
username varchar(20) primary key,
password varchar(20) not null
);

select * from assignprofessors where pid="P001";
insert into admin(username,password) values("Admin","password");

-- select * from student where semester>1;

-- select * from results where sid='U20AI018';
-- select password from student where sid='U20CS001';
-- -- drop database universitymanagement;
--  SELECT assignProfessors.course_id as course_id,courses.course_name as course_name FROM Courses
--                        INNER JOIN assignProfessors ON Courses.course_id=assignProfessors.course_id
--                        WHERE prof_id='P001';
--                        
--                        
-- select password from professors where email='';
SELECT DISTINCT r.cid
FROM results r
LEFT JOIN courses c ON r.cid = c.course_id
WHERE c.course_id IS NULL;

SELECT password FROM professor where email="p001@coed.svnit.ac.in";
SELECT password FROM student where email="u20cs001@coed.svnit.ac.in";

select * from availablecourses where course_id='CS907';

