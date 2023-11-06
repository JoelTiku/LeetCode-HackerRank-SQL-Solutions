/*
1549. The Most Recent Orders for Each Product
Medium

Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
+---------------+---------+
customer_id is the primary key for this table.
This table contains information about the customers.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| customer_id   | int     |
| product_id    | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information about the orders made by customer_id.
There will be no product ordered by the same user more than once in one day.
 

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| product_name  | varchar |
| price         | int     |
+---------------+---------+
product_id is the primary key for this table.
This table contains information about the Products.
 

Write an SQL query to find the most recent order(s) of each product.

Return the result table ordered by product_name in ascending order and in case of a tie by the product_id in ascending order. If there still a tie, order them by order_id in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+-----------+
| customer_id | name      |
+-------------+-----------+
| 1           | Winston   |
| 2           | Jonathan  |
| 3           | Annabelle |
| 4           | Marwan    |
| 5           | Khaled    |
+-------------+-----------+
Orders table:
+----------+------------+-------------+------------+
| order_id | order_date | customer_id | product_id |
+----------+------------+-------------+------------+
| 1        | 2020-07-31 | 1           | 1          |
| 2        | 2020-07-30 | 2           | 2          |
| 3        | 2020-08-29 | 3           | 3          |
| 4        | 2020-07-29 | 4           | 1          |
| 5        | 2020-06-10 | 1           | 2          |
| 6        | 2020-08-01 | 2           | 1          |
| 7        | 2020-08-01 | 3           | 1          |
| 8        | 2020-08-03 | 1           | 2          |
| 9        | 2020-08-07 | 2           | 3          |
| 10       | 2020-07-15 | 1           | 2          |
+----------+------------+-------------+------------+
Products table:
+------------+--------------+-------+
| product_id | product_name | price |
+------------+--------------+-------+
| 1          | keyboard     | 120   |
| 2          | mouse        | 80    |
| 3          | screen       | 600   |
| 4          | hard disk    | 450   |
+------------+--------------+-------+
Output: 
+--------------+------------+----------+------------+
| product_name | product_id | order_id | order_date |
+--------------+------------+----------+------------+
| keyboard     | 1          | 6        | 2020-08-01 |
| keyboard     | 1          | 7        | 2020-08-01 |
| mouse        | 2          | 8        | 2020-08-03 |
| screen       | 3          | 3        | 2020-08-29 |
+--------------+------------+----------+------------+
Explanation: 
keyboard's most recent order is in 2020-08-01, it was ordered two times this day.
mouse's most recent order is in 2020-08-03, it was ordered only once this day.
screen's most recent order is in 2020-08-29, it was ordered only once this day.
The hard disk was never ordered and we do not include it in the result table.
*/




SELECT t.product_name, t.product_id, t.order_id, t.order_date
FROM
(
	SELECT c.customer_id, c.[name], 
		   o.order_id, o.order_date, 
		   p.product_id, p.product_name, p.price, 
		   RANK() OVER(PARTITION BY p.product_name ORDER BY o.order_date DESC) AS [Ranking]
	FROM Customers c
	INNER JOIN Orders o
	ON c.customer_id = o.customer_id
	INNER JOIN Products p
	ON o.product_id = p.product_id

	/*
	+-----------+------------+-----------+--------------+---------------+----------------+--------+-----------+
	|customer_id |	name	 | order_id  |   order_date |	product_id  |	product_name |  price |	Ranking   |
	+-----------+------------+-----------+--------------+---------------+----------------+--------+-----------+
	|   2	    |  Jonathan	 |    6	     |   2020-08-01 | 	    1	    |	  keyboard   |	120   |	   1      |
	|   3	    |  Annabelle |    7	     |   2020-08-01 |	    1	    |	  keyboard   |	120   |	   1      |
	|   1	    |  Winston	 |    1	     |   2020-07-31 |	    1	    |	  keyboard   |	120   |	   3      |
	|   4	    |  Marwan	 |    4	     |   2020-07-29 |	    1	    |	  keyboard   |	120   |	   4      |
	|   1	    |  Winston	 |    8	     |   2020-08-03 |	    2	    |	  mouse	     |	80    |	   1      |
	|   2	    |  Jonathan	 |    2	     |   2020-07-30 |	    2	    |	  mouse	     |	80    |	   2      |
	|   1	    |  Winston	 |    10     |	 2020-07-15 |	    2	    |	  mouse	     |	80    |	   3      |
	|   1	    |  Winston	 |    5	     |   2020-06-10 |	    2	    |	  mouse	     |	80    |	   4      |
	|   3	    |  Annabelle |    3	     |   2020-08-29 |	    3	    |	  screen     |	600   |	   1      |
	|   2	    |  Jonathan	 |    9	     |   2020-08-07 |	    3	    |	  screen     |	600   |	   2      |
	+-----------+------------+-----------+--------------+---------------+----------------+--------+-----------+
	*/
)t
WHERE t.Ranking = 1
ORDER BY t.product_name, t.product_id, t.order_id


