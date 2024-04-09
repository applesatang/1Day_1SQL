# Write your MySQL query statement below
SELECT C.name as Customers
FROM Orders O RIGHT JOIN Customers C
     ON O.customerID = C.id
WHERE O.id is null
    