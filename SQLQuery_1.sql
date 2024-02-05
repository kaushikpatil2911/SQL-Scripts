CREATE DATABASE SQLDatabase

DROP DATABASE SQLDatabase

ALTER DATABASE SQLDatabase Set SINGLE_USER with ROLLBACK IMMEDIATE
/*When Database is in use and cannot drop it*/

CREATE TABLE [dbo].[tblPerson] (
    [ID]       INT           NOT NULL,
    [Name]     NVARCHAR (50) NULL,
    [Email]    NVARCHAR (50) NULL,
    [GenderID] INT           NULL,
    CONSTRAINT [PK_tblPerson] PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[tblGender] (
    [ID]     INT           NOT NULL,
    [Gender] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_tblGender] PRIMARY KEY CLUSTERED ([ID] ASC)
);

SELECT * FROM dbo.tblGender
SELECT * FROM dbo.tblPerson

ALTER TABLE tblPerson ADD CONSTRAINT FK_tblPerson_GenderID
FOREIGN KEY (GenderID) REFERENCES tblGender(ID)
/*Foreign Key for Database Integrity*/

CREATE TABLE [dbo].[tblPerson] (
    [ID]       INT           NOT NULL,
    [Name]     NVARCHAR (50) NULL,
    [Email]    NVARCHAR (50) NULL,
    [GenderID] INT           NULL,
    CONSTRAINT [PK_tblPerson] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_tblPerson_GenderID] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[tblGender] ([ID])
);

ALTER TABLE tblPerson ADD CONSTRAINT DEFAULT_tblPerson_GenderID
DEFAULT 3 FOR GenderID

INSERT INTO tblPerson (ID,Name,Email) VALUES (7,'CDE','CDE@GMAIL.COM')

ALTER TABLE tblPerson ADD Gender NVARCHAR(50) NULL
CONSTRAINT DEFAULT_tblPerson_Gender DEFAULT 'N/A'

SELECT * FROM dbo.tblGender
SELECT * FROM dbo.tblPerson

ALTER TABLE tblPerson
DROP CONSTRAINT DEFAULT_tblPerson_Gender

DELETE FROM tblGender WHERE ID=2
/*The DELETE statement conflicted with the REFERENCE constraint "FK_tblPerson_GenderID". 
The conflict occurred in database "SQLPrep", table "dbo.tblPerson", column 'GenderID'.*/
/*Casacading Referential Integrity*/
/*Can change to No Action, Cascade, DEFAULT and NULL*/

ALTER TABLE tblPerson ADD Age INT NULL

INSERT INTO tblPerson (ID,Name,Email,GenderID,PhoneNumber,AGE) VALUES (8,'Liz','liz@GMAIL.COM',2,'N/A',25)

UPDATE tblPerson SET Age=-87
WHERE Name='Liz'
/*The UPDATE statement conflicted with the CHECK constraint "CK_tblPerson_AGE". 
The conflict occurred in database "SQLPrep", table "dbo.tblPerson", column 'AGE'.
*/

ALTER TABLE tblPerson ADD CONSTRAINT CK_tblPerson_AGE
CHECK (AGE > 0 AND AGE < 150)

CREATE TABLE [dbo].[tblPerson1] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50) NULL,
    [Email]       NVARCHAR (50) NULL,
    [GenderID]    INT           CONSTRAINT [DEFAULT_tblPerson1_GenderID] DEFAULT ((3)) NULL,
    [PhoneNumber] NVARCHAR (50) CONSTRAINT [DEFAULT_tblPerson1_Gender] DEFAULT ('N/A') NULL,
    CONSTRAINT [PK_tblPerson1] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_tblPerson1_GenderID] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[tblGender] ([ID])
);

SELECT * FROM dbo.tblGender
SELECT * FROM dbo.tblPerson
SELECT * FROM dbo.tblPerson1

INSERT INTO tblPerson1 (Name,Email,GenderID) VALUES ('ABC','ABC@GMAIL.COM',2)
INSERT INTO tblPerson1 (Name,Email,GenderID) VALUES ('CDE','CDE@GMAIL.COM',1)

DELETE FROM tblPerson1 WHERE ID=9

SET IDENTITY_INSERT tblPerson1 ON

INSERT INTO tblPerson1 (ID,Name,Email,GenderID) VALUES (1,'ABC','ABC@GMAIL.COM',2)

SET IDENTITY_INSERT tblPerson1 OFF

DELETE FROM tblPerson1

DBCC CHECKIDENT('tblPerson1',RESEED,0)

CREATE TABLE TEST1
(
    ID int IDENTITY(1,1),
    [Value] NVARCHAR(50)
)

CREATE TABLE TEST2
(
    ID int IDENTITY(1,1),
    [Value] NVARCHAR(50)
)

INSERT INTO TEST1 VALUES ('X')

SELECT * FROM TEST1
SELECT * FROM TEST2

INSERT INTO TEST1 VALUES ('Y')

SELECT SCOPE_IDENTITY()
SELECT @@IDENTITY
SELECT IDENT_CURRENT('TEST2')

/*CREATE TRIGGER TRForInsert on TEST1 FOR INSERT
AS
BEGIN
INSERT INTO TEST2 VALUES ('YYYY')
END
*/

INSERT INTO TEST1 VALUES ('Z')

INSERT INTO TEST1 VALUES ('XYZ')

INSERT INTO TEST2 VALUES ('XXXX')

ALTER TABLE tblPerson
ADD CONSTRAINT UK_tblPerson_Name UNIQUE(Name)

SELECT * FROM dbo.tblGender
SELECT * FROM dbo.tblPerson

INSERT INTO tblPerson (ID,Name) VALUES (9,'Liz')
/*Violation of UNIQUE KEY constraint 'UK_tblPerson_Name'. Cannot insert duplicate key in object 'dbo.tblPerson'. 
The duplicate key value is (Liz).*/

CREATE TABLE [dbo].[tblPerson] (
    [ID]          INT           NOT NULL,
    [Name]        NVARCHAR (50) NULL,
    [Email]       NVARCHAR (50) NULL,
    [GenderID]    INT           CONSTRAINT [DEFAULT_tblPerson_GenderID] DEFAULT ((3)) NULL,
    [PhoneNumber] NVARCHAR (50) CONSTRAINT [DEFAULT_tblPerson_Gender] DEFAULT ('N/A') NULL,
    [AGE]         INT           NULL,
    CONSTRAINT [PK_tblPerson] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_tblPerson_AGE] CHECK ([AGE]>(0) AND [AGE]<(150)),
    CONSTRAINT [FK_tblPerson_GenderID] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[tblGender] ([ID]),
    CONSTRAINT [UK_tblPerson_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

SELECT * FROM dbo.tblGender
SELECT * FROM dbo.tblPerson

SELECT DISTINCT City FROM tblPerson

SELECT DISTINCT Age, City FROM tblPerson

SELECT * FROM tblPerson WHERE CITY='Boston'

SELECT * FROM tblPerson WHERE CITY != 'Boston'

SELECT * FROM tblPerson WHERE Age IN (25,26,27)

SELECT * FROM tblPerson WHERE AGE BETWEEN 20 AND 25

SELECT * FROM tblPerson WHERE City LIKE 'M%'

SELECT * FROM tblPerson WHERE Email LIKE '%@%'

SELECT * FROM tblPerson WHERE City NOT LIKE 'B%'

SELECT * FROM tblPerson WHERE Email LIKE '___@gmail.com'

SELECT * FROM tblPerson WHERE Name LIKE '[PK]%'

SELECT * FROM tblPerson WHERE Name LIKE '[^PK]%'

SELECT * FROM tblPerson WHERE City IN ('Mumbai','Austin') AND Age < 27 ORDER BY Age

SELECT TOP 3 * FROM tblPerson

SELECT TOP 20 PERCENT * FROM tblPerson

SELECT TOP 20 PERCENT Name, Age FROM tblPerson ORDER BY Age DESC

SELECT * FROM dbo.tblGender
SELECT * FROM dbo.tblPerson

INSERT INTO tblPerson (Name,Email,GenderID,Age,City) VALUES ('Kaush','kaush@gmail.com',1,25,'Austin')

SELECT SUM(Salary) FROM tblPerson

SELECT MIN(Salary) FROM tblPerson

SELECT MAX(Salary) FROM tblPerson

SELECT City,GenderID, SUM(Salary) AS TotalSalary FROM tblPerson GROUP BY City,GenderID ORDER BY City

SELECT City,GenderID, SUM(Salary) AS TotalSalary, COUNT(ID) AS NumEmployees
FROM tblPerson 
GROUP BY City,GenderID 
HAVING GenderID=2 
ORDER BY City

SELECT City,GenderID, SUM(Salary) AS TotalSalary, COUNT(ID) AS NumEmployees
FROM tblPerson 
WHERE GenderID=2 
GROUP BY City,GenderID 
ORDER BY City

/* Where = Before Aggregation, Filter rows
   Having = After Aggregation, Filter groups*/

/*Difference between WHERE and HAVING clause:
1. WHERE clause can be used with - Select, Insert, and Update statements, where as HAVING clause can only be used with the Select statement.
2. WHERE filters rows before aggregation (GROUPING), where as, HAVING filters groups, after the aggregations are performed.
3. Aggregate functions cannot be used in the WHERE clause, unless it is in a sub query contained in a HAVING clause, whereas, aggregate functions can be used in Having clause.*/

Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron')
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')
Go

Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)
Go

SELECT * FROM dbo.tblEmployee
SELECT * FROM dbo.tblDepartment

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
LEFT JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
RIGHT JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
FULL JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
CROSS JOIN tblDepartment

/*(INNER) JOIN: Returns records that have matching values in both tables
LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table*/

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
LEFT JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID
WHERE tblDepartment.ID IS NULL

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
RIGHT JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID
WHERE tblEmployee.DepartmentId IS NULL

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
FULL JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID
WHERE tblEmployee.DepartmentId IS NULL
OR tblDepartment.ID IS NULL

SELECT * FROM dbo.tblEmployee
SELECT * FROM dbo.tblDepartment

SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee E
LEFT JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee E
INNER JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee E
RIGHT JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee E
FULL JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee E
CROSS JOIN tblEmployee M

SELECT * FROM dbo.tblEmployee
SELECT * FROM dbo.tblDepartment

SELECT E.Name AS Employee, ISNULL(M.Name,'No Manager') AS Manager
FROM tblEmployee E
LEFT JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT E.Name AS Employee, COALESCE(M.Name,'No Manager') AS Manager
FROM tblEmployee E
LEFT JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT E.Name AS Employee, 
CASE
    WHEN M.Name IS NULL THEN 'No Manager' ELSE M.Name
END
AS Manager   
FROM tblEmployee E
LEFT JOIN tblEmployee M
ON E.ManagerID=M.ID

SELECT * FROM dbo.tblEmployee
SELECT * FROM dbo.tblDepartment

SELECT ID, COALESCE(Name, MiddleName, LastName) AS EmpNAME
FROM tblEmployee

CREATE TABLE tblIndiaCustomers
(
    ID int NOT NULL,
    Name NVARCHAR(50) NULL,
    Email NVARCHAR(50) NULL
);

CREATE TABLE tblUKCustomers
(
    ID int NOT NULL,
    Name NVARCHAR(50) NULL,
    Email NVARCHAR(50) NULL
);

CREATE TABLE tblUSCustomers
(
    ID int NOT NULL,
    Name NVARCHAR(50) NULL,
    Email NVARCHAR(50) NULL
);

SELECT * FROM dbo.tblIndiaCustomers
SELECT * FROM dbo.tblUKCustomers
SELECT * FROM dbo.tblUSCustomers

SELECT * FROM dbo.tblIndiaCustomers
UNION ALL
SELECT * FROM dbo.tblUKCustomers

SELECT * FROM dbo.tblIndiaCustomers
UNION
SELECT * FROM dbo.tblUKCustomers

/*Differences between UNION and UNION ALL (Common Interview Question)
From the output, it is very clear that, UNION removes duplicate rows, where as UNION ALL does not. 
When use UNION, to remove the duplicate rows, sql server has to to do a distinct sort, which is time consuming. 
For this reason, UNION ALL is much faster than UNION. 
If you want to sort, the results of UNION or UNION ALL, the ORDER BY caluse should be used on the last SELECT statement*/

SELECT * FROM dbo.tblIndiaCustomers
UNION ALL
SELECT * FROM dbo.tblUKCustomers
UNION ALL
SELECT * FROM dbo.tblUSCustomers
ORDER BY Name

/*Difference between JOIN and UNION
JOINS and UNIONS are different things. However, this question is being asked very frequently now. 
UNION combines the result-set of two or more select queries into a single result-set which includes all the rows from all the queries 
in the union, where as JOINS, retrieve data from two or more tables based on logical relationships between the tables. 
In short, UNION combines rows from 2 or more tables, where JOINS combine columns from 2 or more table.*/

SELECT * FROM tblEmployee

CREATE PROCEDURE spGetEmployeeGender
AS
BEGIN
    SELECT Name, Gender FROM tblEmployee
END

EXECUTE spGetEmployeeGender


CREATE PROCEDURE spByGenderDepartment 
@Gender NVARCHAR(20),
@DepartmentId INT
AS
BEGIN
    SELECT Name, Gender, DepartmentId from tblEmployee WHERE Gender = @Gender AND DepartmentId = @DepartmentId
END

spByGenderDepartment 'Male', 1
spByGenderDepartment 'Male', 2
spByGenderDepartment @Gender = 'Female', @DepartmentId = 3

sp_helptext spByGenderDepartment

ALTER PROCEDURE spByGenderDepartment 
@Gender NVARCHAR(20),
@DepartmentId INT
AS
BEGIN
    SELECT Name, Gender, DepartmentId from tblEmployee WHERE Gender = @Gender AND DepartmentId = @DepartmentId ORDER BY Name
END

DROP PROCEDURE spName


ALTER PROCEDURE spByGenderDepartment 
@Gender NVARCHAR(20),
@DepartmentId INT
WITH ENCRYPTION
AS
BEGIN
    SELECT Name, Gender, DepartmentId from tblEmployee WHERE Gender = @Gender AND DepartmentId = @DepartmentId ORDER BY Name
END

CREATE PROCEDURE spGetEmployeeCountByGender
@Gender NVARCHAR(20),
@EmployeeCount int OUTPUT
AS
BEGIN
    SELECT @EmployeeCount = COUNT(ID) FROM tblEmployee WHERE Gender = @Gender
END

DECLARE @EmployeeTotal int
EXECUTE spGetEmployeeCountByGender 'Male', @EmployeeTotal OUTPUT
PRINT @EmployeeTotal

sp_help spGetEmployeeCountByGender

sp_depends spGetEmployeeCountByGender

