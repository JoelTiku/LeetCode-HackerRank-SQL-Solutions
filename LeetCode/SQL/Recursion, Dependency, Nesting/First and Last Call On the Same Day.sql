/*
1972. First and Last Call On the Same Day
Hard

Table: Calls

+--------------+----------+
| Column Name  | Type     |
+--------------+----------+
| caller_id    | int      |
| recipient_id | int      |
| call_time    | datetime |
+--------------+----------+
(caller_id, recipient_id, call_time) is the primary key for this table.
Each row contains information about the time of a phone call between caller_id and recipient_id.
 

Write an SQL query to report the IDs of the users whose first and last calls on any day were with the same person. Calls are counted regardless of being the caller or the recipient.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Calls table:
+-----------+--------------+---------------------+
| caller_id | recipient_id | call_time           |
+-----------+--------------+---------------------+
| 8         | 4            | 2021-08-24 17:46:07 |
| 4         | 8            | 2021-08-24 19:57:13 |
| 5         | 1            | 2021-08-11 05:28:44 |
| 8         | 3            | 2021-08-17 04:04:15 |
| 11        | 3            | 2021-08-17 13:07:00 |
| 8         | 11           | 2021-08-17 22:22:22 |
+-----------+--------------+---------------------+
Output: 
+---------+
| user_id |
+---------+
| 1       |
| 4       |
| 5       |
| 8       |
+---------+
Explanation: 
On 2021-08-24, the first and last call of this day for user 8 was with user 4. User 8 should be included in the answer.
Similarly, user 4 on 2021-08-24 had their first and last call with user 8. User 4 should be included in the answer.
On 2021-08-11, user 1 and 5 had a call. This call was the only call for both of them on this day. 
Since this call is the first and last call of the day for both of them, they should both be included in the answer.

*/



WITH CTE1
AS
(
	SELECT caller_id, recipient_id, call_time
	FROM calls

	UNION ALL
	
	SELECT recipient_id AS caller_id, caller_id AS recipient_id, call_time
	FROM calls

	/*
	+---------------+---------------+--------------------------------+
	|caller_id		|  recipient_id |		call_time		         |
	+---------------+---------------+--------------------------------+
	|	8			|		4   	|		2021-08-24 17:46:07.000  |
	|	4			|	    8		|		2021-08-24 19:57:13.000  |
	|	5			|	    1		|		2021-08-11 05:28:44.000  |
	|	8			|		3		|		2021-08-17 04:04:15.000  |
	|	11			|		3		|		2021-08-17 13:07:00.000  |
	|	8			|	    11		|		2021-08-17 22:22:22.000  |
	|	4			|		8		|		2021-08-24 17:46:07.000  |
	|	8			|		4		|		2021-08-24 19:57:13.000  |
	|	1			|  		5		|		2021-08-11 05:28:44.000  |
	|	3			|		8		|		2021-08-17 04:04:15.000  |
	|	3			|		11		|		2021-08-17 13:07:00.000  |
	|	11			|		8		|		2021-08-17 22:22:22.000  |
	+---------------+---------------+--------------------------------+
	*/
),
CTE2
AS
(
	SELECT *,
		   ROW_NUMBER() OVER(PARTITION BY caller_id, CAST(call_time as date) ORDER BY call_time) R1,
		   ROW_NUMBER() OVER(PARTITION BY caller_id, CAST(call_time as date) ORDER BY call_time Desc) R2
	FROM CTE1

	/*
	+-----------+---------------+----------------------------+-----------+-----------+
	|caller_id  |  recipient_id |		call_time			 |	  R1	 | 	 R2 	 |
	+-----------+---------------+----------------------------+-----------+-----------+
	|	1		|	 5		    |	2021-08-11 05:28:44.000	 |	  1		 | 	  1		 |
	|	3		|	 11			|	2021-08-17 13:07:00.000	 |	  2		 | 	  1		 |
	|	3		|	 8		    |	2021-08-17 04:04:15.000	 |	  1		 | 	  2		 |
	|	4		|	 8			|	2021-08-24 19:57:13.000  |	  2		 | 	  1		 |
	|	4		|	 8			|	2021-08-24 17:46:07.000  |	  1      |	  2		 |
	|	5		|	 1			|	2021-08-11 05:28:44.000  |	  1		 | 	  1		 |
	|	8		|	 11			|	2021-08-17 22:22:22.000  |	  2		 | 	  1		 |
	|	8		|	 3			|	2021-08-17 04:04:15.000  |	  1		 | 	  2		 |
	|	8		|	 4			|	2021-08-24 19:57:13.000  |	  2		 | 	  1		 |
	|	8		|	 4			|	2021-08-24 17:46:07.000  |	  1		 | 	  2	     |
	|	11		|	 8			|	2021-08-17 22:22:22.000  |	  2		 | 	  1		 |
	|	11		|	 3			|	2021-08-17 13:07:00.000  |	  1		 | 	  2		 |
	+-----------+---------------+----------------------------+-----------+-----------+
	*/
)

SELECT DISTINCT caller_id AS user_id
FROM CTE2
WHERE R1 = 1 OR R2 = 1
GROUP BY caller_id, CAST(call_time as date)
HAVING COUNT(distinct recipient_id) <= 1