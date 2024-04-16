# Write your MySQL query statement below
SELECT score, S.rank
FROM (SELECT DENSE_RANK() OVER (ORDER BY SCORE DESC) AS 'rank' , ID, score 
      FROM SCORES) S
ORDER BY S.rank