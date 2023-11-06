/*
1951. All the Pairs With the Maximum Number of Common Followers
Medium

Table: Relations

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key for this table.
Each row of this table indicates that the user with ID follower_id is following the user with ID user_id.
 

Write an SQL query to find all the pairs of users with the maximum number of common followers. In other words, if the maximum number of common followers between any two users is maxCommon, then you have to return all pairs of users that have maxCommon common followers.

The result table should contain the pairs user1_id and user2_id where user1_id < user2_id.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Relations table:
+---------+-------------+
| user_id | follower_id |
+---------+-------------+
| 1       | 3           |
| 2       | 3           |
| 7       | 3           |
| 1       | 4           |
| 2       | 4           |
| 7       | 4           |
| 1       | 5           |
| 2       | 6           |
| 7       | 5           |
+---------+-------------+
Output: 
+----------+----------+
| user1_id | user2_id |
+----------+----------+
| 1        | 7        |
+----------+----------+
Explanation: 
Users 1 and 2 have two common followers (3 and 4).
Users 1 and 7 have three common followers (3, 4, and 5).
Users 2 and 7 have two common followers (3 and 4).
Since the maximum number of common followers between any two users is 3, 
we return all pairs of users with three common followers, which is only the pair (1, 7). 
We return the pair as (1, 7), not as (7, 1).
Note that we do not have any information about the users that follow users 3, 4, and 5, so 
we consider them to have 0 followers.
*/


--SELECT DISTINCT t.user1_id, t.user2_id
--FROM
WITH CTE_Count
AS
(
	SELECT r1.[user_id] AS user1_id, r1.[follower_id] AS follower1_id,
		   r2.[user_id] AS user2_id, r2.[follower_id] AS follower2_id,
		   COUNT(*) OVER(PARTITION BY r1.[user_id], r2.[user_id] ORDER BY r1.[user_id]) AS [Count]
	FROM Relations r1 
	INNER JOIN Relations r2
	ON r1.follower_id = r2.follower_id AND r1.[user_id] < r2.[user_id]

	/*
	+----------+--------------+----------+--------------+-------+
	| user1_id | follower1_id | user2_id | follower2_id | Count |
	+----------+--------------+----------+--------------+-------+
	| 1        | 4            | 2        | 4            | 2     |
	| 1        | 3            | 2        | 3            | 2     |
	| 1        | 3            | 7        | 3            | 3     |
	| 1        | 4            | 7        | 4            | 3     |
	| 1        | 5            | 7        | 5            | 3     |
	| 2        | 3            | 7        | 3            | 2     |
	| 2        | 4            | 7        | 4            | 2     |
	+----------+--------------+----------+--------------+-------+
	*/
)

SELECT DISTINCT user1_id, user2_id
FROM CTE_Count cte
WHERE cte.[Count] = (SELECT MAX([Count]) FROM CTE_Count)






/*Alternative Answer*/

SELECT TOP 1 WITH TIES r1.[user_id] AS user1_id ,r2.[user_id] AS user2_id 
FROM Relations r1 
INNER JOIN Relations r2
ON r1.follower_id = r2.follower_id AND r1.[user_id] < r2.[user_id]
GROUP BY r1.[user_id], r2.[user_id]
ORDER BY COUNT(*) DESC				-- ORDER BY COUNT(1) DESC	BECAUSE COUNT(1) == COUNT(*) 





