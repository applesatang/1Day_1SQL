# Write your MySQL query statement below
WITH RANK_SYS AS(SELECT ID, SALARY , DENSE_RANK() OVER (ORDER BY salary DESC) ALL_RANK
FROM Employee)
SELECT CASE R.ALL_RANK WHEN "2" THEN E.SALARY ELSE NULL END AS SecondHighestSalary
FROM Employee E Left Join RANK_SYS R ON E.id = R.id 
ORDER BY SecondHighestSalary DESC
LIMIT 1


