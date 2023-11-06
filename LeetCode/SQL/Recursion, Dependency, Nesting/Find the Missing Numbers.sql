/*
SELECT *
FROM MissingNumber

Find the missing numbers

Input:
+----+
| id |
+----+
| 2  |
+----+
| 5  |
+----+
| 8  |
+----+
| 17 |
+----+
| 20 |
+----+
| 23 |
+----+
| 29 |
+----+
| 41 |
+----+

Output: 
+----+
| id |
+----+
| 11 |
+----+
| 14 |
+----+
| 26 |
+----+
| 32 |
+----+
| 35 |
+----+
| 38 |
+----+
| 44 |
+----+
| 41 |
+----+
*/
WITH CTE
AS
(
	SELECT 2 AS ID

	UNION ALL

	SELECT ID + 3 AS ID
	FROM CTE
	WHERE ID <= 41
)
SELECT *
FROM CTE cte
LEFT JOIN MissingNumber mn
ON cte.ID = mn.id
WHERE mn.id IS NULL