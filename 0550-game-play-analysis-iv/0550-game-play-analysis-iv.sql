# Write your MySQL query statement below
SELECT ROUND(COUNT(DISTINCT A.player_id)/@all,2) AS fraction
FROM Activity A 
-- LEFT JOIN Activity B ON A.player_id = B.player_id
JOIN (SELECT * FROM Activity, (SELECT @all:= COUNT(DISTINCT player_id) FROM Activity) R) B ON A.player_id = B.player_id
WHERE DATEDIFF(B.event_date,A.event_date) = 1
