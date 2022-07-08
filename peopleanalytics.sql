#How many leavers per department this company has 

SELECT COUNT(Department), Department
FROM hrdata
WHERE Termd = 1
GROUP BY Department;
#Creating a procedure  for depts with more leavers

CREATE DEFINER=`root`@`localhost` PROCEDURE `dept with more leavers`()
BEGIN(
SELECT ManagerName,
	   Department,
	   COUNT(CASE WHEN Termd= 1 THEN 1 END) as leavers,
       ((COUNT(CASE WHEN Termd= 1 THEN 1 END))/(COUNT(EmpID))*100)percentage_leavers
FROM hrdata
GROUP BY ManagerName,Department
ORDER BY leavers DESC;
END)

### Manager with most leavers 
### Percentaje of leavers against total employees under their names

SELECT ManagerName,
	   Department,
	   COUNT(CASE WHEN Termd= 1 THEN 1 END) as leavers,
       ((COUNT(CASE WHEN Termd= 1 THEN 1 END))/(COUNT(EmpID))*100)percentage_leavers
FROM hrdata
GROUP BY ManagerName,Department
ORDER BY leavers DESC;


#Calculating AVG tenure FOR  EMPLOYEES WHO LEFT
SELECT AVG(timestampdiff(YEAR,DateofHire, DateofTermination)) as tenure
from hrdata
WHERE Termd =1;

#Calculating tenure FOR  ACTIVE EMPLOYEES 

SELECT AVG(timestampdiff(YEAR,DateofHire,"2019-01-01 00:00:00"))
FROM hrdata
WHERE Termd =0;

#Average salary of leavers by department

SELECT AVG(Salary) as avg_salary, Department
from hrdata
WHERE Termd =1
GROUP BY Department
ORDER BY Department;

#Average salary of active employees by department

SELECT AVG(Salary) as avg_salary, Department
from hrdata
WHERE Termd =0
GROUP BY Department
ORDER BY Department;

#Average Absences of leavers by department

SELECT ROUND(AVG(Absences),0) as avg_abs, Department
from hrdata
WHERE Termd =1
GROUP BY Department
ORDER BY Department;

#Average Absences of Active employees by department

SELECT ROUND(AVG(Absences),0) as avg_abs, Department
from hrdata
WHERE Termd =0
GROUP BY Department
ORDER BY Department;

