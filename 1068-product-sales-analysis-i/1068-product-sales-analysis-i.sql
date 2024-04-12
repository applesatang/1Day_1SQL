# Write your MySQL query statement below
SELECT P.Product_name, S.year, S.price
FROM sales S LEFT JOIN product P ON S.product_id = P.product_id
