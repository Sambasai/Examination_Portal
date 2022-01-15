# Project Phase 4

---

Welcome to the JEE-Main Examination Portal, an all India standardized computer-based test for admission to various technical undergraduate programs in engineering, architecture, and planning across India.

### Database Features:

+ Maintains all necessary information related to the JEE-Main examination which is used
  as a means to admit students into the top colleges all over the country. 
+ Maintains the data of all the registered students who are attempting the exam. 
+ Keeps track of the performance and results of each student at each phase and students can hence easily access
  their results after every paper. 
+ Helps the organizing committee and employees of the NTA keep track of the status of the exam at various centers all over the nation. 
+ Used by various college/university officials to observe the result trends of various students which helps in
  the admission process as well.

## Commands 

## --------Update Operations--------

**1. Add Student to Database**  

We collect the students Application_no, Gender, Aadhar_no, DOB, Nationality, Category, Email, Fname, Mname, Lname and store the information in the Students entity type table.  

```sql
/*Students are added to the database after they register for any examination.*/
INSERT INTO Students
VALUES      (Application_no, Gender, Aadhar_no, DOB, Nationality, State, Category, Email, Fname, Mname, Lname , Fees_Status);

```

**2. Add Staff Member to Database**  

We collect the staffs Id, Jobtype, Fname, Mname, Lname, Center_no and store the information in the Staff super-class table and respective Jobtype sub-class table.  

```sql
/*Staff members are added to the database in order to assign them to their respective centers.*/
INSERT INTO Staff
VALUES      ( Id, Jobtype, Fname, Mname, Lname, Center_no);

/*IF Jobtype = Technicians*/
INSERT INTO Technicians
VALUES      ( Id, Mobile_no, Aadhar_no, Grade);

/*IF Jobtype = Invigilators*/
INSERT INTO Invigilators
VALUES      ( Id, Mobile_no, Aadhar_no, Qualifications);

/*IF Jobtype = Security*/
INSERT INTO Security
VALUES      ( Id, Agency);
```

**3. Remove Student from Database**  

We remove the stored information of a student based on the unique keys Application_no.  

```sql
/*Students who want to opt-out after registering can be removed from the database.*/
DELETE FROM Students
WHERE       Application_no = Application_no;
```

**4. Update the results of Student**  

We collect the students Application_no, Phase, Mathematics, Physics, Chemistry, General_aptitude, Planning, Drawing, Total_marks, AIR and store the information in the Results entity type table.  

```sql
/*Updating the results entity for each student after he/she gives an examination shift.*/
INSERT INTO Results
VALUES      ( Application_no, Phase, Mathematics, Physics, Chemistry, General_aptitude, Planning, Drawing, Total_marks, AIR );
```

**5. Update Address details of Student**  

We collect the latest address details of a student and update the information in the Address_student table based on the Application_no.  

```sql
/*Updating the address details of students who have relocated after registration.*/
UPDATE  Address_student
SET     Address = Address
WHERE   Application_no = Application_no;
```

---

## --------Query Operations--------

**6. Display information about all students**  

Retrieves and displays the complete information of all the students registered for the examination.  

```sql
/*Retrieve the complete data tuples of students from the database.*/
SELECT  *
FROM    Students;
```

**7. Retrieve information about students based on their performance**  

Displays the names of all the students who scored greater than the threshold percentage.  

```sql
/*Names of all students who scored greater than a certain percentage in any of the shifts.*/
SELECT  Students.Application_no,Students.Fname, Students.Mname, Students.Lname, MAX(((Total_marks/300)*100)) AS Percentage
FROM              Students, Results
WHERE             SStudents.Application_no = Results.Application_no AND ((Total_marks/300)*100)>{perc} 
GROUP BY          Application_no"
```

**8. Maximum Score obtained by a student among all shifts**  

Displays the name and the maximum score secured by a certain student in all the phases.  

```sql
/*Maximum score secured by a particular student all phases.*/
SELECT      Results.Application_no,MAX(Results.Total_marks) AS Total_Marks
FROM        Students, Results
WHERE       Results.Application_no = Application_no;
GROUP BY    Results.Application_no
```

**9. Display information about students from given state**  

Searches and displays the complete information of all the students from a certain state.  

```sql
/*Search for all the students from a particular State.*/
SELECT  *
FROM    Students
WHERE   State = State;
```

**10. Retrieve topper list based on the category they belong to**  

Retrieves and displays the category, phase and maximum score secured by students based on category and phase.  

```sql
/*Maximum score secured by a student in each category */
SELECT      T.Category,Students.Application_no,Fname,Mname,Lname,T.Highest_Marks
FROM        Students,Results,(SELECT Students.Category,MAX(Results.Total_marks) AS Highest_Marks FROM Students, Results WHERE Students.Application_no = Results.Application_no GROUP BY Students.Category) AS T
WHERE T.Category = Students.Category  AND Highest_Marks = Results.Total_marks AND Students.Application_no = Results.Application_no
```

---

**11. Exit**  

Exits the program.

### Contributors:

+ **Sanyam Shah** 

+ **Sambasai Reddy**

+ **Dhanush Reddy**