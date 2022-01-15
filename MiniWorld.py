import subprocess as sp

import pymysql.cursors

import pandas as pd
from tabulate import tabulate

def connectDatabase():
    connection = pymysql.connect(host='localhost',
                                 port=30306,
                                 user="root",
                                 password="Stkabir2002",
                                 db='EE',
                                 cursorclass=pymysql.cursors.DictCursor)
    if connection.open:
        print("Connected")
    else:
        print("Failed to connect")
    return connection

def displayOperations():
    print("\n--------Update Operations--------")
    print("1. Add Student to Database")
    print("2. Add Staff Member to Database")
    print("3. Remove Student from Database ")
    print("4. Update the results of Student")
    print("5. Update Address details of Student")
    print("\n--------Query Operations--------")
    print("6. Display information about all students")
    print("7. Retrieve information about students based on their performance")
    print("8. Maximum Score obtained by a student among all shifts")
    print("9. Display information about students from given state")
    print("10. Retrieve topper list based on the category they belong to")
    print("----------------------------------------")
    print("11. Exit")

def addStudent():
    try:
        print("Please Enter Student Details")
        fname = (input("First Name: "))
        mname = input("Middle Name: ")
        lname = (input("Last Name: "))
        address = (input("Your Address: "))
        state = input("State: ")
        gender = (input("Gender: "))
        aadhar = (input("Aadhar Number: "))
        dob = (input("Date of birth: "))
        nation = (input("Nationality: "))
        category = (input("Category: "))
        email = input("Email ID: ")
        gua = input("Guardian(Father/Mother/Guardian): ")
        fees = input("Fees (PAID/NOT PAID): ")

        query = f"INSERT INTO Students(Gender,Aadhar_no,DOB,Nationality,State,Category,Email,Fname,Mname,Lname,Fees_Status) VALUES ('{gender}','{aadhar}','{dob}','{nation}','{state}','{category}','{email}','{fname}','{mname}','{lname}','{fees}');"
        cur.execute(query)
        con.commit()
        query = f"SELECT Application_no FROM Students WHERE Aadhar_no = '{aadhar}'"
        cur.execute(query)
        con.commit()
        id = cur.fetchall()
        ID = int(id[0]['Application_no'])
        query = f"INSERT INTO Results(Application_no,Phase) VALUES ({ID},1)"
        cur.execute(query)
        con.commit()
        query = f"INSERT INTO Results(Application_no,Phase) VALUES ({ID},2)"
        cur.execute(query)
        con.commit()
        query = f"INSERT INTO Parent_Guardian(Application_no,Guardian) VALUES ({ID},'{gua}')"
        cur.execute(query)
        con.commit()
        query = f"INSERT INTO Education_details(Application_no,10_or_12) VALUES ({ID},10)"
        cur.execute(query)
        con.commit()
        query = f"INSERT INTO Education_details(Application_no,10_or_12) VALUES ({ID},12)"
        cur.execute(query)
        con.commit()
        query = f"INSERT INTO Address_student(Application_no,Address) VALUES ({ID},'{address}')"
        cur.execute(query)
        con.commit()
        query = f"DELETE FROM Students_DOB"
        cur.execute(query)
        con.commit()
        query = f"INSERT INTO Students_DOB SELECT DOB,year(NOW())-year(DOB) AS Age FROM Students"
        cur.execute(query)
        con.commit()
        print("Student added successfully!!")
    except Exception as E:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", E)

def addStaff():
    try:
        print("Please Enter Staff Details")
        fname = (input("First name: "))
        mname = (input("Middle Name: "))
        lname = (input("Last Name: "))
        centerno = int(input("Center Number: "))
        job = (input("Job Name(Technician/Invigilator/Security): "))
        query = f"INSERT INTO Staff(Jobtype,Fname,Mname,Lname,Center_no) VALUES ('{job}','{fname}','{mname}','{lname}',{centerno})"
        cur.execute(query)
        con.commit()
        query = f"SELECT Id FROM Staff WHERE Jobtype = '{job}' AND Fname = '{fname}' AND Lname = '{lname}' AND Mname = '{mname}'"
        cur.execute(query)
        con.commit()
        id = cur.fetchall()
        ID = int(id[0]['Id'])
        if job == "Technician":
            mobile = int(input("Mobile Number: "))
            aadhar = (input("Aadhar Number: "))
            grade = (input("Grade: "))
            query = f"INSERT INTO Technicians(Id,Mobile_no,Aadhar_no,Grade) VALUES ({ID},{mobile},'{aadhar}','{grade}')"
            cur.execute(query)
            con.commit()
        elif job == "Invigilator":
            mobile = int(input("Mobile Number: "))
            aadhar = (input("Aadhar Number: "))
            qual = (input("Qualifications: "))
            query = f"INSERT INTO Invigilators(Id,Mobile_no,Aadhar_no,Qualifications) VALUES ({ID},{mobile},'{aadhar}','{qual}')"
            cur.execute(query)
            con.commit()
        elif job == "Security":
            agency = (input("Agency: "))
            query = f"INSERT INTO Security(Id, Agency) VALUES ({ID},'{agency}')"
            cur.execute(query)
            con.commit()
        print("Staff added successfully!!")
    except Exception as E:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", E)

def delStudent():
    try:
        ID = int(input("Enter Application ID: "))
        query = f"DELETE FROM Students WHERE Application_no = {ID}"
        cur.execute(query)
        con.commit()
    except Exception as E:
        con.rollback()
        print("Failed to delete from database")
        print(">>>>>>>>>>>>>", E)

def updateRes():
    try:
        ID = int(input("Application ID: "))
        phase = int(input("Enter Phase Number (1/2): "))
        math = int(input("Mathematics: "))
        phys = int(input("Physics: "))
        chem = int(input("Chemistry: "))
        gena = int(input("General Aptitude: "))
        plan = int(input("Planning: "))
        draw = int(input("Drawing: "))
        totm = int(input("Total Marks: "))
        air = int(input("AIR: "))
        query = f"UPDATE Results SET Phase = {phase},Mathematics={math},Physics={phys},Chemistry={chem},General_aptitude={gena},Planning = {plan},Drawing = {draw},Total_marks = {totm}, AIR = {air} WHERE Application_no = {ID} AND Phase = '{phase}'"
        cur.execute(query)
        con.commit()
    except Exception as E:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", E)

def updateAddr():
    try:
        ID = int(input("Application ID: "))
        addr = input("New Address: ")
        query = f"UPDATE Address_student SET Address = '{addr}' WHERE Application_no = {ID}"
        cur.execute(query)
        con.commit()
    except Exception as E:
        con.rollback()
        print("Failed to delete from database")
        print(">>>>>>>>>>>>>", E)

def displayStudents():
    try:
        quer = f"SELECT * FROM Students"
        # pd.options.display.max_columns = 500
        # SQL_Query = pd.read_sql(quer, con)
        # df = pd.DataFrame(SQL_Query, columns=['Application_no', 'Gender', 'Aadhar_no','DOB','Nationality','State','Category','Email','Fname','Mname','Lname','Fees_Status'])
        # print(df)
        cur.execute(quer)
        con.commit()
        output = cur.fetchall()
        print(tabulate(output,headers="keys",tablefmt='psql'))
    except Exception as E:
        con.rollback()
        print(">>>>>>>>>>>>>", E)

def projection():
    try:
        perc = int(input("Enter the percentage above which students should be listed (0-100): "))
        quer = f"SELECT Students.Application_no,Students.Fname, Students.Mname, Students.Lname, MAX(((Total_marks/300)*100)) AS Percentage FROM Students,Results WHERE Students.Application_no = Results.Application_no AND ((Total_marks/300)*100)>{perc} GROUP BY Application_no"
        # SQL_Query = pd.read_sql_query(quer, con)
        # df = pd.DataFrame(SQL_Query, columns=['Application_no','Fname', 'Mname' ,'Lname','Percentage'])
        # print(df)
        cur.execute(quer)
        con.commit()
        output = cur.fetchall()
        print(tabulate(output, headers="keys", tablefmt='psql'))
    except Exception as E:
        con.rollback()
        print(">>>>>>>>>>>>>", E)

def checkMax():
    try:
        app = input("Enter Application Number of the student: ")
        quer = f"SELECT Results.Application_no,MAX(Results.Total_marks) AS Total_Marks FROM Students, Results WHERE Results.Application_no = {app} GROUP BY Results.Application_no"
        # SQL_Query = pd.read_sql_query(quer, con)
        # df = pd.DataFrame(SQL_Query, columns=['Application_no', 'Total_Marks'])
        # print(df)
        cur.execute(quer)
        con.commit()
        output = cur.fetchall()
        print(tabulate(output, headers="keys", tablefmt='psql'))
    except Exception as E:
        con.rollback()
        print(">>>>>>>>>>>>>", E)

def stateWise():
    try:
        app = input("Enter State: ")
        quer = f"SELECT * FROM Students WHERE State = '{app}'"
        # SQL_Query = pd.read_sql_query(quer, con)
        # df = pd.DataFrame(SQL_Query, columns=['Application_no', 'Gender', 'Aadhar_no','DOB','Nationality','Category','Email','Fname','Lname'])
        # print(df)
        cur.execute(quer)
        con.commit()
        output = cur.fetchall()
        if output:
            print(tabulate(output, headers="keys", tablefmt='psql'))
        else:
            x = f"No student from {app}"
            print(x)
    except Exception as E:
        con.rollback()
        print(">>>>>>>>>>>>>", E)

def topperList():
    try:
        quer = f"SELECT T.Category,Students.Application_no,Fname,Mname,Lname,T.Highest_Marks FROM Students,Results,(SELECT Students.Category,MAX(Results.Total_marks) AS Highest_Marks FROM Students, Results WHERE Students.Application_no = Results.Application_no GROUP BY Students.Category) AS T WHERE T.Category = Students.Category  AND Highest_Marks = Results.Total_marks AND Students.Application_no = Results.Application_no"
        # SQL_Query = pd.read_sql_query(quer, con)
        # df = pd.DataFrame(SQL_Query, columns=['Category', 'Phase', 'Marks'])
        # print(df)
        cur.execute(quer)
        con.commit()
        output = cur.fetchall()
        print(tabulate(output, headers="keys", tablefmt='psql'))
    except Exception as E:
        con.rollback()
        print(">>>>>>>>>>>>>", E)

def dispatch(c):
    if c == 1:
        addStudent()
    elif c == 2:
        addStaff()
    elif c == 3:
        delStudent()
    elif c == 4:
        updateRes()
    elif c == 5:
        updateAddr()
    elif c == 6:
        displayStudents()
    elif c == 7:
        projection()
    elif c == 8:
        checkMax()
    elif c == 9:
        stateWise()
    elif c == 10:
        topperList()


# Global
while 1:
    sp.call('clear', shell=True)

    try:
        con = connectDatabase()
        with con.cursor() as cur:
            while 1:
                displayOperations()
                ch = int(input("Enter choice> "))
                sp.call('clear', shell=True)
                if ch == 11:
                    con.close()
                    exit()
                else:
                    sp.call('clear', shell=True)
                    dispatch(ch)
                    input("Enter any key to CONTINUE>")

    except Exception as e:
        sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Check Username and Password")
        input("Press Enter to reset the connection")
