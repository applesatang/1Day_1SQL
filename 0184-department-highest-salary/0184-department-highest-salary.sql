# Write your MySQL query statement below
SELECT A.Department, A.Employee, A.Salary
FROM (SELECT E.id AS id, D.name AS Department, E.name AS Employee, E.Salary, 
             RANK() OVER (PARTITION BY E.departmentID ORDER BY SALARY DESC) AS R
      FROM Employee E 
      INNER JOIN Department D ON E.departmentID = D.id) A
WHERE A.R = 1
ORDER BY A.id