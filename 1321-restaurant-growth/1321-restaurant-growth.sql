-- # Write your MySQL query statement below
-- SELECT customer_id,visited_on,sum(su) over (order by visited_on)as ra,am
-- FROM (SELECT A.customer_id, A.visited_on, sum(A.amount)as su, B.amount as am
--       FROM Customer A
--       LEFT JOIN Customer B ON A.visited_on-7 >= B.visited_on 
--       GROUP BY visited_on) C

-- SELECT A.customer_id, A.visited_on, SUM(A.amount) as su, B.amount as am
-- FROM (SELECT customer_id, visited_on, sum(amount)as amount
--       FROM Customer
--       GROUP BY visited_on) A
-- LEFT JOIN Customer B on A.visited_on -7 = B.visited_on
WITH GROUP_DATE AS (SELECT customer_id, visited_on, sum(amount) as amount, ADDDATE(visited_on,INTERVAL 6 DAY) AS lim_date
                    FROM Customer
                    GROUP BY visited_on)
SELECT C.visited_on, C.su as amount , ROUND(C.su/7,2) as average_amount
FROM( SELECT A.visited_on, sum(B.amount) as su, ROW_NUMBER() OVER (ORDER BY A.visited_on) as ra
      FROM GROUP_DATE A
      JOIN GROUP_DATE B on A.visited_on >= B.visited_on AND A.visited_on <= B.lim_date
      GROUP BY A.visited_on
      ORDER BY A.visited_on ) C
WHERE ra >= 7