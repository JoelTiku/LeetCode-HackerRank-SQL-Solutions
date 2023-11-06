/*
1164. Product Price at a Given Date
Medium

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write an SQL query to find the prices of all products on 2019-08-16. 
Assume the price of all products before any change is 10.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

WITH CTE 
AS
(
	SELECT product_id,
		   new_price,
	       ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS [RowNum]
	FROM Products
	WHERE change_date <= '2019-08-16'
	/*
	+------------+-----------+--------+
	| product_id | new_price | RowNum |
	+------------+-----------+--------+
	| 1          | 35        | 1      |
	| 1          | 30        | 2      |
	| 1          | 20        | 3      |
	| 2          | 50        | 1      |
	+------------+-----------+--------+
	*/
)
SELECT p.product_id,
       CASE WHEN cte.product_id IS NULL THEN 10 
	        ELSE cte.new_price 
	   END AS [price]
FROM (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN (SELECT * FROM CTE WHERE RowNum = 1) cte
ON p.product_id = cte.product_id
ORDER BY cte.new_price DESC