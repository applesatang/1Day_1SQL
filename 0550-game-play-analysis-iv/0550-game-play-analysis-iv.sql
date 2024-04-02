SELECT ROUND(COUNT(DISTINCT A.player_id)/@all,2) AS fraction
FROM (SELECT player_id,device_id,games_played,min(event_date) as event_date , @all
      FROM Activity , (SELECT @all:= COUNT(DISTINCT player_id) FROM Activity) R
      GROUP BY player_id) A 
JOIN Activity B ON A.player_id = B.player_id
WHERE DATEDIFF(B.event_date,A.event_date) = 1