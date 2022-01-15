DROP DATABASE IF EXISTS `EE`;
CREATE SCHEMA `EE`;
USE `EE`;

DROP TABLE IF EXISTS `Students`;
CREATE TABLE `Students`
(
    `Application_no` int(9)   NOT NULL AUTO_INCREMENT,
    `Gender`         char(1),
    `Aadhar_no`      char(12) NOT NULL,
    `DOB`            date,
    `Nationality`    varchar(50),
    `State`          varchar(50),
    `Category`       varchar(50)  DEFAULT 'General',
    `Email`          varchar(100) DEFAULT 'xyz@gmail.com',
    `Fname`          varchar(50),
    `Mname`          varchar(50),
    `Lname`          varchar(50),
    `Fees_Status`    varchar(10),
    PRIMARY KEY (`Application_no`),
    UNIQUE KEY `Aadhar_No` (`Aadhar_no`)
);

LOCK TABLES `Students` WRITE;
INSERT INTO `Students`
VALUES (100000001, 'M', '123456789123', '2002-06-28', 'Indian', 'Gujarat', DEFAULT, 'a@gmail.com', 'Sanyam',
        'Jigneshbhai', 'Shah', 'PAID'),
       (100000002, 'M', '456789123456', '2003-03-23', 'Indian', 'Telangana', 'General', 'b@gmail.com', 'Sambasai',
        'Reddy', 'Andem', 'PAID'),
       (100000003, 'M', '789123456789', '2002-11-15', 'Indian', 'Telangana', 'General', 'c@gmail.com', 'Dhanush',
        'Reddy', 'Nagireddy', 'PAID'),
       (100000004, 'F', '112233445566', '2003-07-12', 'Indian', 'Maharashtra', 'Backward', 'd@gmail.com', 'Neha',
        'Maha', 'Chowdhary', 'NOT PAID'),
       (100000005, 'M', '778899112233', '2002-12-28', 'Indian', 'Karnataka', 'General', 'e@gmail.com', 'Srikar',
        'Bhavesh', 'Desu', 'PAID'),
       (100000006, 'M', '445566778899', '2002-08-23', 'Indian', 'Haryana', 'Backward', 'f@gmail.com', 'Rahul', 'Mothi',
        'Goud', 'PAID'),
       (100000007, 'F', '100000001444', '2003-07-27', 'Foreign', 'New Jersey', DEFAULT, 'g@gmail.com', 'Lucy',
        'Abraham', 'Levine', 'PAID');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Results`;
CREATE TABLE `Results`
(
    `Application_no`   int(9) NOT NULL,
    `Phase`            int(1) NOT NULL,
    `Mathematics`      int(3),
    `Physics`          int(3),
    `Chemistry`        int(3),
    `General_aptitude` int(3),
    `Planning`         int(3),
    `Drawing`          int(3),
    `Total_marks`      int(3),
    `AIR`              int(7),
    PRIMARY KEY (`Application_no`, `Phase`),
    CONSTRAINT `Results_ibfk_1` FOREIGN KEY (`Application_no`) REFERENCES `Students` (`Application_no`) ON DELETE CASCADE
);

LOCK TABLES `Results` WRITE;
INSERT INTO `Results`
VALUES (100000001, '1', '95', '95', '95', '0', '0', '0', '285', '200'),
       (100000002, '1', '80', '85', '100', '0', '0', '0', '265', '300'),
       (100000003, '1', '70', '80', '90', '0', '0', '0', '240', '1000'),
       (100000004, '1', '35', '45', '55', '0', '0', '0', '135', '57892'),
       (100000005, '1', '100', '100', '100', '0', '0', '0', '300', '1'),
       (100000006, '1', '100', '0', '0', '60', '0', '75', '235', '1230'),
       (100000007, '1', '100', '0', '0', '80', '85', '0', '265', '420'),
       (100000005, '2', '100', '0', '0', '80', '0', '65', '245', '1230'),
       (100000001, '2', '90', '85', '100', '0', '0', '0', '275', '200'),
       (100000002, '2', '85', '85', '100', '0', '0', '0', '270', '300'),
       (100000007, '2', '100', '0', '0', '80', '75', '0', '255', '420'),
       (100000006, '2', '100', '0', '0', '80', '65', '0', '245', '420'),
       (100000003, '2', '85', '95', '100', '0', '0', '0', '280', '250'),
       (100000004, '2', '90', '85', '88', '0', '0', '0', '263', '336');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Students_DOB`;

CREATE TABLE `Students_DOB`
(
    `DOB` date NOT NULL,
    `Age` int(2),
    PRIMARY KEY (`DOB`)
);

LOCK TABLES `Students_DOB` WRITE;
INSERT INTO `Students_DOB`
VALUES ('2002-06-28', '19'),
       ('2003-03-23', '18'),
       ('2002-11-15', '18'),
       ('2003-07-12', '18'),
       ('2002-12-28', '18'),
       ('2002-08-23', '19'),
       ('2003-07-27', '18');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Parent_Guardian`;
CREATE TABLE `Parent_Guardian`
(
    `Application_no` int(9)      NOT NULL,
    `Fname`          varchar(50),
    `Mname`          varchar(50),
    `Lname`          varchar(50),
    `DOB`            date,
    `Guardian`       varchar(50) NOT NULL,
    `Occupation`     varchar(50),
    `Mobile_no`      char(10)    ,
    `Annual_income`  char(10),
    `Qualifications` varchar(100),
    PRIMARY KEY (`Application_no`, `Guardian`),
    KEY `Fname` (`Fname`),
    KEY `Mname` (`Mname`),
    KEY `Lname` (`Lname`),
    CONSTRAINT `Parent_Guardian_ibfk_1` FOREIGN KEY (`Application_no`) REFERENCES `Students` (`Application_no`) ON DELETE CASCADE
);

LOCK TABLES `Parent_Guardian` WRITE;
INSERT INTO `Parent_Guardian`
VALUES (100000001, 'Acharya', 'Jigneshbhai', 'Shah', '1980-05-24', 'Father', 'Engineer', '9192939495', '20,00,000',
        'B.tech and M.tech in CS'),
       (100000001, 'Achyuta', 'Jigneshbhai', 'Shah', '1981-04-24', 'Mother', 'Housewife', '9192939484', '0',
        'B.Sc in sci'),
       (100000002, 'Venkat', 'Reddy', 'Andem', '1975-07-29', 'Father', 'IT engineer', '9887665443', '15,00,000', 'MBA'),
       (100000002, 'Anitha', 'Reddy', 'Andem', '1977-09-27', 'Mother', 'Housewife', '9887665432', '0',
        'M.Sc in computers'),
       (100000003, 'Dhananjay', 'Reddy', 'Nagireddy', '1976-05-12', 'Father', 'Accounting', '9887662345', '17,00,000',
        'B.Com'),
       (100000003, 'Lakshmi', 'Reddy', 'Nagireddy', '1979-11-22', 'Mother', 'Housewife', '9887663456', '0',
        '12th pass'),
       (100000004, 'Rahul', 'Suresh', 'Chowdhary', '1972-12-25', 'Uncle', 'Business', '9862663456', '25,00,000', 'MBA'),
       (100000005, 'Akshit', 'Bhavesh', 'Desu', '1985-03-24', 'Father', 'Doctor', '9807660456', '30,00,000', 'MBBS'),
       (100000005, 'Lakshmi', 'Srilatha', 'Desu', '1986-01-22', 'Mother', 'Doctor', '9887663400', '20,00,000', 'MBBS'),
       (100000006, 'Anand', 'Patel', 'Goud', '1976-02-25', 'Father', 'Receptionist', '9787363400', '10,00,000',
        'B.Com'),
       (100000006, 'Laghari', 'Patel', 'Goud', '1979-01-12', 'Mother', 'Nurse', '9887669469', '20,00,000', 'MBBS'),
       (100000007, 'Adam', 'Josh', 'Levine', '1969-06-09', 'Guardian', 'Singer', '1327669469', '200,00,000', 'B.art');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Education_details`;
CREATE TABLE `Education_details`
(
    `Application_no`     int(9) NOT NULL,
    `Board_roll_no`      int(9) ,
    `10_or_12`           int(2) NOT NULL,
    `School_board`       varchar(50),
    `Place_of_schooling` varchar(50),
    `Pass_status`        varchar(50),
    PRIMARY KEY (`Application_no`, `10_or_12`),
    KEY `10_or_12` (`10_or_12`),
    CONSTRAINT `Education_details_ibfk_1` FOREIGN KEY (`Application_no`) REFERENCES `Students` (`Application_no`) ON DELETE CASCADE
);

LOCK TABLES `Education_details` WRITE;
INSERT INTO `Education_details`
VALUES (100000001, '123456789', '10', 'CBSE', 'Ahmedabad', 'PASS'),
       (100000002, '456789123', '10', 'CBSE', 'Hyderabad', 'PASS'),
       (100000001, '123456788', '12', 'CBSE', 'Ahmedabad', 'PASS'),
       (100000002, '456789124', '12', 'CBSE', 'Hyderabad', 'PASS'),
       (100000003, '789123456', '10', 'State Board', 'Secunderabad', 'PASS'),
       (100000003, '789123457', '12', 'State Board', 'Secunderabad', 'PASS'),
       (100000004, '112233445', '10', 'ICSE', 'Mumbai', 'FAIL'),
       (100000004, '112233446', '12', 'ISC', 'Mumbai', 'PASS'),
       (100000005, '778899112', '10', 'ICSE', 'Bangalore', 'PASS'),
       (100000005, '778899113', '12', 'CBSE', 'Bangalore', 'PASS'),
       (100000006, '445566778', '10', 'CBSE', 'Chennai', 'PASS'),
       (100000006, '445566779', '12', 'CBSE', 'Ooty', 'PASS'),
       (100000007, '100000001', '12', 'IB', 'Seattle', 'PASS'),
       (100000007, '111222334', '10', 'IGCSE', 'New York', 'PASS');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Address_student`;
CREATE TABLE `Address_student`
(
    `Application_no` int(9)       NOT NULL,
    `Address`        varchar(500) NOT NULL,
    PRIMARY KEY (`Application_no`),
    KEY `Address` (`Address`),
    CONSTRAINT `Address_student_ibfk_1` FOREIGN KEY (`Application_no`) REFERENCES `Students` (`Application_no`) ON DELETE CASCADE
);

LOCK TABLES `Address_student` WRITE;
INSERT INTO `Address_student`
VALUES (100000001, 'Shop No C /78, Saibaba Nagar, 90 Feet Rd, Dharavi, Ahmedabad, Gujarat'),
       (100000002, '31-4-77/3/26/a5, Tolichowki, Hyderabad, Telangana'),
       (100000003, '16-5-1165, Hasmath Gunj Sultan Bazar, Koti, Telangana'),
       (100000004, '115/6 A, Shivaji Marg, Najafgarh Road, Mumbai, Maharashtra'),
       (100000005, '029/809, Hommamdem, Coconut Garden Street, T Dasarahalli, Bangalore, Karnataka'),
       (100000006, '79, Thirupalli Street Sowcarpet, Ooty, Tamilnadu'),
       (100000007, '59 Hilldale Street South Richmond Hill, New York');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Exam_type`;
CREATE TABLE `Exam_type`
(
    `Paper_name`       varchar(20) NOT NULL,
    `Mathematics`      int(3),
    `Physics`          int(3),
    `Chemistry`        int(3),
    `General_aptitude` int(3),
    `Planning`         int(3),
    `Drawing`          int(3),
    `Marks`            int(3),
    PRIMARY KEY (`Paper_name`)
);

LOCK TABLES `Exam_type` WRITE;
INSERT INTO `Exam_type`
VALUES ('Technology', '100', '100', '100', '0', '0', '0', '300'),
       ('Architecture', '100', '0', '0', '100', '0', '100', '300'),
       ('Planning', '100', '0', '0', '100', '100', '0', '300');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Examination_details`;
CREATE TABLE `Examination_details`
(
    Examination_ID VARCHAR(3) NOT NULL,
    Phase          INT(1),
    Couse_name     VARCHAR(20),
    Shift          CHAR(1),
    PRIMARY KEY (Examination_ID)
);

LOCK TABLES `Examination_details` WRITE;
INSERT INTO `Examination_details`
VALUES ('1TM', '1', 'Technology', 'M'),
       ('1TE', '1', 'Technology', 'E'),
       ('2TM', '2', 'Technology', 'M'),
       ('2TE', '2', 'Technology', 'E'),
       ('1AM', '1', 'Architecture', 'M'),
       ('1AE', '1', 'Architecture', 'E'),
       ('2AM', '2', 'Architecture', 'M'),
       ('2AE', '2', 'Architecture', 'E'),
       ('1PM', '1', 'Planning', 'M'),
       ('1PE', '1', 'Planning', 'E'),
       ('2PM', '2', 'Planning', 'M'),
       ('2PE', '2', 'Planning', 'E');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Exams`;
CREATE TABLE `Exams`
(
    `Examination_ID` varchar(3)  NOT NULL,
    `Application_no` int(9)      NOT NULL,
    `Paper_name`     varchar(20) NOT NULL,
    PRIMARY KEY (`Examination_ID`, `Application_no`, `Paper_name`),
    CONSTRAINT `Exams_ibfk_1` FOREIGN KEY (`Examination_ID`) REFERENCES `Examination_details` (`Examination_ID`) ON DELETE CASCADE,
    CONSTRAINT `Exams_ibfk_2` FOREIGN KEY (`Paper_name`) REFERENCES `Exam_type` (`Paper_name`) ON DELETE CASCADE,
    CONSTRAINT `Exams_ibfk_3` FOREIGN KEY (`Application_no`) REFERENCES `Students` (`Application_no`) ON DELETE CASCADE
);

LOCK TABLES `Exams` WRITE;
INSERT INTO `Exams`
VALUES ('1TM', '100000001', 'Technology'),
       ('2TE', '100000001', 'Technology'),
       ('1TE', '100000002', 'Technology'),
       ('2TM', '100000002', 'Technology'),
       ('1TE', '100000003', 'Technology'),
       ('2TE', '100000003', 'Technology'),
       ('1TM', '100000004', 'Technology'),
       ('1PE', '100000004', 'Planning'),
       ('2TM', '100000004', 'Technology'),
       ('1TM', '100000005', 'Technology'),
       ('2AE', '100000005', 'Architecture'),
       ('2AM', '100000006', 'Architecture'),
       ('1AM', '100000005', 'Architecture'),
       ('1AE', '100000006', 'Architecture'),
       ('2PM', '100000005', 'Planning'),
       ('1PM', '100000007', 'Planning'),
       ('2PE', '100000007', 'Planning');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Fees`;
CREATE TABLE `Fees`
(
    `Examination_ID` varchar(3) NOT NULL,
    `Category`       varchar(50),
    `Nationality`    varchar(50),
    `Fees`           int(10),
    PRIMARY KEY (`Examination_ID`, `Category`, `Nationality`),
    CONSTRAINT `Fees_ibfk_1` FOREIGN KEY (`Examination_ID`) REFERENCES `Exams` (`Examination_ID`) ON DELETE CASCADE
);

LOCK TABLES `Fees` WRITE;
INSERT INTO `Fees`
VALUES ('1TM', 'General', 'Indian', '600'),
       ('1TE', 'General', 'Indian', '600'),
       ('2TM', 'General', 'Indian', '600'),
       ('2TE', 'General', 'Indian', '600'),
       ('1AM', 'General', 'Indian', '600'),
       ('1AE', 'General', 'Indian', '600'),
       ('2AM', 'General', 'Indian', '600'),
       ('2AE', 'General', 'Indian', '600'),
       ('1PM', 'General', 'Indian', '600'),
       ('1PE', 'General', 'Indian', '600'),
       ('2PM', 'General', 'Indian', '600'),
       ('2PE', 'General', 'Indian', '600'),
       ('1TM', 'Reserved', 'Indian', '300'),
       ('1TE', 'Reserved', 'Indian', '300'),
       ('2TM', 'Reserved', 'Indian', '300'),
       ('2TE', 'Reserved', 'Indian', '300'),
       ('1AM', 'Reserved', 'Indian', '300'),
       ('1AE', 'Reserved', 'Indian', '300'),
       ('2AM', 'Reserved', 'Indian', '300'),
       ('2AE', 'Reserved', 'Indian', '300'),
       ('1PM', 'Reserved', 'Indian', '300'),
       ('1PE', 'Reserved', 'Indian', '300'),
       ('2PM', 'Reserved', 'Indian', '300'),
       ('2PE', 'Reserved', 'Indian', '300'),
       ('1TM', 'General', 'Foreign', '900'),
       ('1TE', 'General', 'Foreign', '900'),
       ('2TM', 'General', 'Foreign', '900'),
       ('2TE', 'General', 'Foreign', '900'),
       ('1AM', 'General', 'Foreign', '900'),
       ('1AE', 'General', 'Foreign', '900'),
       ('2AM', 'General', 'Foreign', '900'),
       ('2AE', 'General', 'Foreign', '900'),
       ('1PM', 'General', 'Foreign', '900'),
       ('1PE', 'General', 'Foreign', '900'),
       ('2PM', 'General', 'Foreign', '900'),
       ('2PE', 'General', 'Foreign', '900');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Center`;
CREATE TABLE `Center`
(
    Center_no INT(10)      NOT NULL,
    Address   VARCHAR(100) NOT NULL,
    PRIMARY KEY (Center_no),
    UNIQUE (Center_no),
    UNIQUE (Address)
);

LOCK TABLES `Center` WRITE;
INSERT INTO `Center`
VALUES (100000001, 'Sphoorthy engg college, 90 Feet Rd, Dharavi, Ahmedabad, Gujarat'),
       (100000002, 'TCS ion, Tolichowki, Hyderabad, Telangana'),
       (100000003, 'Oracle tech, Hasmath Gunj Sultan Bazar, Koti, Telangana'),
       (100000004, 'Shivaji Marg, Najafgarh Road, Mumbai, Maharashtra'),
       (100000005, 'Hommamdem, Coconut Garden Street, T Dasarahalli, Bangalore, Karnataka');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Conducted_at`;
CREATE TABLE `Conducted_at`
(
    Examination_ID VARCHAR(12) NOT NULL,
    Center_no      INT(10)     NOT NULL,
    PRIMARY KEY (Examination_ID, Center_no),
    FOREIGN KEY (Examination_ID) REFERENCES `Examination_details` (Examination_ID) ON DELETE CASCADE,
    FOREIGN KEY (Center_no) REFERENCES Center (Center_no) ON DELETE CASCADE
);

LOCK TABLES `Conducted_at` WRITE;
INSERT INTO `Conducted_at`
VALUES ('1TM', '100000001'),
       ('2TE', '100000001'),
       ('1TE', '100000002'),
       ('2TM', '100000002'),
       ('1TE', '100000003'),
       ('2TE', '100000003'),
       ('1TM', '100000004'),
       ('2TM', '100000004'),
       ('1TM', '100000005'),
       ('2AE', '100000005'),
       ('1AE', '100000001'),
       ('2PM', '100000001'),
       ('1PM', '100000002'),
       ('2PE', '100000002');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Visit_to_appear_for`;
CREATE TABLE `Visit_to_appear_for`
(
    Application_no INt(10)     NOT NULL,
    Examination_ID VARCHAR(12) NOT NULL,
    Center_no      INT(10)     NOT NULL,
    PRIMARY KEY (Application_no, Examination_ID, Center_no),
    FOREIGN KEY (Application_no) REFERENCES Students (Application_no) ON DELETE CASCADE,
    FOREIGN KEY (Examination_ID) REFERENCES Examination_details (Examination_ID) ON DELETE CASCADE,
    FOREIGN KEY (Center_no) REFERENCES Center (Center_no) ON DELETE CASCADE
);

LOCK TABLES `Visit_to_appear_for` WRITE;
INSERT INTO `Visit_to_appear_for`
VALUES ('100000001', '1TM', '100000001'),
       ('100000001', '2TE', '100000001'),
       ('100000002', '1TE', '100000002'),
       ('100000002', '2TM', '100000002'),
       ('100000003', '1TE', '100000003'),
       ('100000003', '2TE', '100000003'),
       ('100000004', '1TM', '100000004'),
       ('100000004', '2TM', '100000004'),
       ('100000005', '1TM', '100000005'),
       ('100000005', '2AE', '100000005'),
       ('100000006', '1AE', '100000001'),
       ('100000006', '2PM', '100000001'),
       ('100000007', '1PM', '100000002'),
       ('100000007', '2PE', '100000002');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Staff`;
CREATE TABLE `Staff`
(
    Id        INT(9)      NOT NULL AUTO_INCREMENT,
    Jobtype   VARCHAR(20) NOT NULL,
    Fname     VARCHAR(10),
    Mname     VARCHAR(10),
    Lname     VARCHAR(10),
    Center_no INT(10)     NOT NULL,

    PRIMARY KEY (Id),
    UNIQUE (Id),
    FOREIGN KEY (Center_no)
        REFERENCES Center (Center_no) ON DELETE CASCADE
);

LOCK TABLES `Staff` WRITE;
INSERT INTO `Staff`
VALUES (100000001, 'Technician', 'Suresh', 'Pravin', 'Goud', '100000001'),
       (100000002, 'Technician', 'Ramesh', 'Karri', 'Reddy', '100000002'),
       (100000003, 'Technician', 'Mahesh', 'Totka', 'Acharya', '100000003'),
       (100000004, 'Technician', 'Rahul', 'Burman', 'Banerjee', '100000004'),
       (100000005, 'Invigilator', 'Levi', 'Smol', 'Ackerman', '100000001'),
       (100000006, 'Invigilator', 'Eren', 'Attack', 'Jeager', '100000002'),
       (100000007, 'Invigilator', 'Tanjiro', 'Demon', 'Kamado', '100000003'),
       (100000008, 'Invigilator', 'Killua', 'Lightning', 'Zoldyck', '100000004'),
       (100000009, 'Security', 'Basu', 'Bedi', 'Bhatt', '100000001'),
       (100000010, 'Security', 'Shukla', 'Dabhat', 'Verma', '100000002'),
       (100000011, 'Security', 'Dara', 'Dalal', 'Chowdary', '100000001'),
       (100000012, 'Security', 'Chabra', 'Dalal', 'Chawla', '100000002'),
       (100000013, 'Security', 'Amin', 'Deol', 'Datta', '100000003'),
       (100000014, 'Security', 'Lol', 'Kohli', 'Deshpande', '100000004');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Technicians`;
CREATE TABLE `Technicians`
(
    Id        INT(9)   NOT NULL,
    Mobile_no char(10) NOT NULL,
    Aadhar_no char(12) NOT NULL,
    Grade     CHAR(1)  NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE (Id),
    UNIQUE (Mobile_no),
    UNIQUE (Aadhar_no),
    FOREIGN KEY (Id) REFERENCES Staff (Id) ON DELETE CASCADE
);

LOCK TABLES `Technicians` WRITE;
INSERT INTO `Technicians`
VALUES (100000001, '9102837465', '112200998833', '1'),
       (100000002, '9102837466', '222200998833', '2'),
       (100000003, '9102837467', '332200998833', '1'),
       (100000004, '9102837468', '442200998833', '3');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Invigilators`;
CREATE TABLE `Invigilators`
(
    Id             INT(9)      NOT NULL,
    Mobile_no      char(10)    NOT NULL,
    Aadhar_no      char(12)    NOT NULL,
    Qualifications VARCHAR(10) NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE (Id),
    UNIQUE (Mobile_no),
    UNIQUE (Aadhar_no),
    FOREIGN KEY (Id) REFERENCES Staff (Id) ON DELETE CASCADE
);

LOCK TABLES `Invigilators` WRITE;
INSERT INTO `Invigilators`
VALUES (100000005, '9102837475', '112200998844', 'B.tech'),
       (100000006, '9102837476', '222200998844', 'B.Com'),
       (100000007, '9102837477', '332200998844', 'MBBS'),
       (100000008, '9102837478', '442200998844', '12th');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Security`;
CREATE TABLE `Security`
(
    Id     INT(9)      NOT NULL,
    Agency VARCHAR(10) NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE (Id),
    FOREIGN KEY (Id) REFERENCES Staff (Id) ON DELETE CASCADE
);

LOCK TABLES `Security` WRITE;
INSERT INTO `Security`
VALUES (100000009, 'A.P'),
       (100000010, 'Armour'),
       (100000011, 'Fireball'),
       (100000012, 'Shield'),
       (100000013, 'idk'),
       (100000014, 'idek');
UNLOCK TABLES;