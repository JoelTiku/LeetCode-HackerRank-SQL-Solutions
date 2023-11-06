/*
Write an SQL script to find out the ranges of numbers that are monotonically increasing - 2, 3, 5, 1, 4, 2, 7, 8
	ans - 2-5, 1-4, 2-8


input:
+----+
| id |
+----+
| 2  |
| 3  |
| 5  |
| 1  |
| 4  |
| 2  |
| 7  |
| 8  |
+----+

output:
+-------+-----+
| Start | End |
+-------+-----+
| 2     | 5   |
| 1     | 4   |
| 2     | 8   |
+-------+-----+
*/
SELECT t3.[Start], t3.[End]
FROM 
(
	SELECT LAG(t2.id, 1, -1) OVER(ORDER BY (SELECT NULL)) AS [Start], t2.id AS [End]
	FROM
	(
		SELECT *, 
			   CASE WHEN (t1.[lead1] - t1.id > 0) AND 
						 (t1.id - t1.[lag1] > 0)  AND 
						 (t1.[lead1] != -1) AND 
						 (t1.[lag1] != -1)
						 THEN 1
					ELSE -1
				END AS [rank]
		FROM
		(
			SELECT id, 
				   LEAD(id, 1, -1) OVER (ORDER BY (SELECT NULL)) AS [lead1],
				   LAG(id, 1, -1) OVER (ORDER BY (SELECT NULL)) AS [lag1]
			FROM MonotonicNumber
		)t1
	)t2
	WHERE t2.[rank] = -1
)t3
WHERE t3.[Start] < t3.[End] AND t3.[Start] != -1 
 












