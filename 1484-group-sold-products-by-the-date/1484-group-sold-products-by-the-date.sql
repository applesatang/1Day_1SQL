# Write your MySQL query statement below
SELECT sell_date, count(distinct product) as num_sold, group_concat(distinct product order by product) as products
FROM activities
GROUP BY sell_date