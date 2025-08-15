-- 1
SELECT COUNT(*) as [Students Number]
FROM Student
WHERE St_Age is not null;


-- 2
SELECT Distinct Ins_Name
FROM Instructor


--3
SELECT S.St_Id as [Student ID] , CONCAT(S.St_Fname , S.St_Lname) as [Student Full Name] , D.Dept_Name as [Department name]
FROM Student S , Department D
WHERE S.Dept_Id = D.Dept_Id;


-- 4
SELECT I.Ins_Name , D.Dept_Name
FROM Instructor I , Department D
WHERE I.Dept_Id = D.Dept_Id;


-- 5
SELECT S.St_Fname+' '+S.St_Lname as [Student Full Name] , C.Crs_Name as [Course Name]
FROM Student S , Stud_Course SC , Course C
WHERE S.St_Id = SC.St_Id and SC.Crs_Id = C.Crs_Id;


-- 6
SELECT T.Top_Name , COUNT(C.Crs_Id)
FROM Topic T , Course C
WHERE T.Top_Id = C.Top_Id
GROUP BY T.Top_Name;


-- 7
SELECT MAX(Salary) as [Max Instructor Salary] , MIN(Salary) as [Min Instructor Salary]
FROM Instructor;


-- 8
SELECT Ins_Name
FROM Instructor
WHERE Salary < (SELECT AVG(Salary) FROM Instructor);


-- 9
SELECT *
FROM (SELECT DENSE_RANK() OVER( ORDER BY SALARY ) as DR , D.Dept_Name
      FROM Instructor I , Department D
      WHERE I.Dept_Id = D.Dept_Id) as NewTable
WHERE DR = 1;


-- 10
SELECT Top(2) *
FROM (SELECT DISTINCT Salary
      FROM Instructor
      ORDER BY Salary) as NewTable


-- 11
SELECT I.Ins_Name , ISNULL(I.Salary , 'BONUS') -- NO BONUS INFOS
FROM Instructor I


-- 12
SELECT AVG(Salary) as [Avrage Salary)] FROM Instructor;


-- 13
SELECT CONCAT(ST.St_Fname ,' ', ST.St_Lname) as [Student Name] , CONCAT(SU.St_Fname ,' ', SU.St_Lname) as [Supervisor Name] , SU.St_Address  as [Supervisor Address] , SU.St_Age as [Supervisor Age]
FROM Student SU , Student ST
WHERE SU.St_Id = ST.St_super


-- 14
SELECT *
FROM ( SELECT Dept_id , Salary , DENSE_RANK() OVER( PARTITION BY Dept_id ORDER BY Salary DESC ) as DR
       FROM ( SELECT Dept_id , Salary
              FROM Instructor
              WHERE Salary is not null ) as NewTable ) as NewTable
WHERE DR IN( 1 , 2 );


-- 15
SELECT St_Id , [Full Name] , Dept_Id
FROM ( SELECT St_Id , CONCAT(St_Fname ,' ', St_Lname) as [Full Name] , Dept_Id , DENSE_RANK() OVER( PARTITION BY Dept_id ORDER BY NEWID() ) as DR
       FROM Student ) as NewTable
WHERE DR = 1