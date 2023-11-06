/*
1949. Strong Friendship
Medium

Table: Friendship

+-------------+------+
| Column Name | Type |
+-------------+------+
| user1_id    | int  |
| user2_id    | int  |
+-------------+------+
(user1_id, user2_id) is the primary key for this table.
Each row of this table indicates that the users user1_id and user2_id are friends.
Note that user1_id < user2_id.
 

A friendship between a pair of friends x and y is strong if x and y have at least three common friends.

Write an SQL query to find all the strong friendships.

Note that the result table should not contain duplicates with user1_id < user2_id.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Friendship table:
+----------+----------+
| user1_id | user2_id |
+----------+----------+
| 1        | 2        |
| 1        | 3        |
| 2        | 3        |
| 1        | 4        |
| 2        | 4        |
| 1        | 5        |
| 2        | 5        |
| 1        | 7        |
| 3        | 7        |
| 1        | 6        |
| 3        | 6        |
| 2        | 6        |
+----------+----------+
Output: 
+----------+----------+---------------+
| user1_id | user2_id | common_friend |
+----------+----------+---------------+
| 1        | 2        | 4             |
| 1        | 3        | 3             |
+----------+----------+---------------+
Explanation: 
Users 1 and 2 have 4 common friends (3, 4, 5, and 6).
Users 1 and 3 have 3 common friends (2, 6, and 7).
We did not include the friendship of users 2 and 3 because they only have two common friends (1 and 6).
*/

/*** input table

SELECT *
FROM Friendship

***/

/*
+----------+----------+
| user1_id | user2_id |
+----------+----------+
| 1        | 2        |
| 1        | 3        |
| 1        | 4        |
| 1        | 5        |
| 1        | 6        |
| 1        | 7        |
| 2        | 3        |
| 2        | 4        |
| 2        | 5        |
| 2        | 6        |
| 3        | 6        |
| 3        | 7        |
+----------+----------+
*/

WITH all_friend (me, friend) 
AS 
(
    SELECT user1_id, user2_id
    FROM Friendship
    
	UNION

    SELECT user2_id, user1_id
    FROM Friendship

			/*
		+----------+----------+
		| user1_id | user2_id |
		+----------+----------+
		| 1        |  2       |
		| 1        |  3       |
		| 1        |  4       |
		| 1        |  5       |
		| 1        |  6       |
		| 1        |  7       |
		| 2        |  3       |
		| 2        |  4       |
		| 2        |  5       |
		| 2        |  6       |
		| 3        |  6       |
		| 3        |  7	      |

		| 2        |  1       |
		| 3        |  1       |
		| 4        |  1       |
		| 5        |  1       |
		| 6        |  1       |
		| 7        |  1       |
		| 3        |  2       |
		| 4        |  2       |
		| 5        |  2       |
		| 6        |  2       |
		| 6        |  3       |
		| 7        |  3       |
		+----------+----------+
		*/
)
SELECT f.user1_id AS user1_id, f.user2_id AS user2_id, COUNT(*) AS common_friend
FROM Friendship f
	 INNER JOIN all_friend a1 ON f.user1_id = a1.me
	 INNER JOIN all_friend a2 ON f.user2_id = a2.me AND a1.friend = a2.friend
GROUP BY f.user1_id, f.user2_id
HAVING COUNT(*) >= 3