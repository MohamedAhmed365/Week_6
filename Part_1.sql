-- 1
SELECT D.Dependent_name as Name, D.Sex as Gender
From Dependent D , Employee E
WHERE E.SSN = D.ESSN and E.Sex = 'F' and D.Sex = 'F'

UNION ALL

SELECT D.Dependent_name as Name, D.Sex as Gender
From Dependent D , Employee E
WHERE E.SSN = D.ESSN and E.Sex = 'M' and D.Sex = 'M';


-- 2
SELECT P.Pname , SUM(W.Hours) as [Total Hours]
FROM Project P , Works_for W
WHERE P.Pnumber = W.Pno
GROUP BY P.Pnumber , P.Pname;


-- 3
SELECT D.Dname , D.Dnum , D.MGRSSN , D.[MGRStart Date]
FROM Employee E , Departments D
Where E.Dno = D.Dnum and E.SSN = (SELECT MIN(E.SSN)
                                  From Employee E);


-- 4
SELECT D.Dname , MAX(E.Salary) as [Max Salary] , MIN(E.Salary) as [Min Salary]
FROM Departments D , Employee E
WHERE E.Dno = D.Dnum
GROUP BY D.Dnum , D.Dname;


-- 5
SELECT E.Fname+' '+E.Lname as [Full Name]
FROM Employee E , Departments DT
WHERE E.SSN = DT.MGRSSN and E.SSN not in (SELECT ESSN
                                          FROM Dependent);


-- 6
SeLECT D.Dnum , D.Dname , COUNT(E.SSN) as [Num of Employees]
FROM Departments D , Employee E
WHERE D.Dnum = E.Dno
GROUP BY D.Dnum , D.Dname
HAVING AVG(E.Salary) < (SELECT AVG(Salary)
                        FROM Employee);


-- 7
SELECT E.Fname , E.Lname , E.Sex , E.Bdate , E.Address , E.Salary , E.Superssn , P.Pname , P.City , P.Plocation
FROM Employee E , Departments D , Project P
WHERE E.Dno = D.Dnum and D.Dnum = P.Dnum
ORDER BY D.Dname , E.Lname , E.Fname;


-- 8
SELECT MAX(Salary) as [Max 2 Salaries]
FROM Employee

UNION ALL

SELECT MAX(Salary)
FROM Employee
WHERE Salary != (SELECT MAX(Salary)
                 FROM Employee);


-- 9
SELECT Fname+' '+Lname as [Full Name]
From Employee , Dependent
WHERE Fname like Dependent_name or Lname like Dependent_name;


-- 10
UPDATE Employee
SET Salary += Salary * 30 / 100
WHERE SSN in (SELECT W.ESSn
              FROM Works_for W , Project P
              WHERE W.Pno = P.Pnumber and P.Pname = 'Al Rabwah');


-- 1
INSERT INTO Departments
VALUES ('DEPT IT' , 100 , 112233 , '01-11-2006');


-- 2

--a
UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = (SELECT Dnum
              FROM Departments
              WHERE MGRSSN = 968574);

--b
UPDATE Departments
SET MGRSSN = 968574
WHERE Dnum = 100;

--c
UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;

-- 3
DELETE FROM Dependent
WHERE ESSN = 223344;

UPDATE Employee
SET Superssn = 102672
WHERE Superssn = 223344;

UPDATE Departments
SET MGRSSN = 102672
WHERE MGRSSN = 223344;

UPDATE Works_for
SET ESSn = 102672
WHERE ESSn = 223344;

DELETE FROM Employee
WHERE SSN = 223344;