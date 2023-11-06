/*
1613. Find the Missing IDs
Medium

Input: 
Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Alice         |
| 4           | Bob           |
| 5           | Charlie       |
+-------------+---------------+
Output: 
+-----+
| ids |
+-----+
| 2   |
| 3   |
+-----+
Explanation: 
The maximum customer_id present in the table is 5, so in the range [1,5], IDs 2 and 3 are missing from the table.
*/
/*
SELECT *
FROM Customers
*/

/*** Using Recursive CTE ***/
WITH CTE_IDs
AS
(
SELECT 1 ID

UNION ALL

SELECT ID + 1 ID
FROM CTE_IDs
WHERE ID <= 5

		/*
		+-----+
		| ID  |
		+-----+
		| 1   |
		| 2   |
		| 3   |	  
		| 4   |     
		| 5   |	  
		| 6   |	  
		+-----+
		*/

)

SELECT ID AS ids
FROM CTE_IDs I
LEFT JOIN Customers C
ON I.ID = C.customer_id
WHERE I.ID NOT IN (SELECT customer_id FROM Customers) AND I.ID < (SELECT MAX(customer_id) FROM Customers)
