# 1안 (1475ms)
-- SELECT ROUND(COUNT(DISTINCT A.player_id)/@all,2) AS fraction
-- FROM (SELECT player_id,device_id,games_played,min(event_date) as event_date
--       FROM Activity
--       GROUP BY player_id) A 
-- JOIN (SELECT * 
--       FROM Activity, (SELECT @all:= COUNT(DISTINCT player_id) FROM Activity) R) B ON A.player_id = B.player_id
-- WHERE DATEDIFF(B.event_date,A.event_date) = 1

# 2안 (1121ms)
-- SELECT ROUND(((CASE WHEN DATEDIFF(B.event_date,A.event_date) = 1 
--                     THEN @sum:=@sum+1 ELSE @sum := @sum+0 END)/c.all_count),2) as fraction
-- FROM (SELECT player_id,min(event_date) as event_date 
--       FROM Activity 
--       GROUP BY player_id) A 
-- LEFT JOIN Activity B ON A.player_id=B.player_id
-- JOIN (SELECT @sum:=0) as R
-- JOIN (SELECT COUNT(DISTINCT player_id)as all_count FROM Activity) C
-- ORDER BY fraction DESC
-- LIMIT 1

# 3안 
SELECT ROUND(COUNT(DISTINCT A.player_id)/@all,2) AS fraction
FROM (SELECT player_id,device_id,games_played,min(event_date) as event_date , @all
      FROM Activity , (SELECT @all:= COUNT(DISTINCT player_id) FROM Activity) R
      GROUP BY player_id) A 
JOIN Activity B ON A.player_id = B.player_id
WHERE DATEDIFF(B.event_date,A.event_date) = 1