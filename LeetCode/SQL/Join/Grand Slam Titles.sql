/*
1783. Grand Slam Titles
Medium

Table: Players

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| player_id      | int     |
| player_name    | varchar |
+----------------+---------+
player_id is the primary key for this table.
Each row in this table contains the name and the ID of a tennis player.
 

Table: Championships

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| year          | int     |
| Wimbledon     | int     |
| Fr_open       | int     |
| US_open       | int     |
| Au_open       | int     |
+---------------+---------+
year is the primary key for this table.
Each row of this table contains the IDs of the players who won one each tennis tournament of the grand slam.
 

Write an SQL query to report the number of grand slam tournaments won by each player. 
Do not include the players who did not win any tournament.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Players table:
+-----------+-------------+
| player_id | player_name |
+-----------+-------------+
| 1         | Nadal       |
| 2         | Federer     |
| 3         | Novak       |
+-----------+-------------+
Championships table:
+------+-----------+---------+---------+---------+
| year | Wimbledon | Fr_open | US_open | Au_open |
+------+-----------+---------+---------+---------+
| 2018 | 1         | 1       | 1       | 1       |
| 2019 | 1         | 1       | 2       | 2       |
| 2020 | 2         | 1       | 2       | 2       |
+------+-----------+---------+---------+---------+
Output: 
+-----------+-------------+-------------------+
| player_id | player_name | grand_slams_count |
+-----------+-------------+-------------------+
| 2         | Federer     | 5                 |
| 1         | Nadal       | 7                 |
+-----------+-------------+-------------------+
Explanation: 
Player 1 (Nadal) won 7 titles: Wimbledon (2018, 2019), Fr_open (2018, 2019, 2020), US_open (2018), and Au_open (2018).
Player 2 (Federer) won 5 titles: Wimbledon (2020), US_open (2019, 2020), and Au_open (2019, 2020).
Player 3 (Novak) did not win anything, we did not include them in the result table.
*/

WITH CTE
AS
(
	SELECT [year], titles, wins, COUNT(wins) OVER (PARTITION BY wins ORDER BY wins) AS [grand_slams_count]
	FROM   
		( 
		 SELECT [year], wimbledon, fr_open, us_open, au_open
		 FROM championships
		)AS c  
	UNPIVOT  
		( 
		 wins FOR titles IN (wimbledon, fr_open, us_open, au_open)
		) as unpvt

		/*
		+------+-----------+------+-------------------+
		| year | titles    | wins | grand_slams_count |
		+------+-----------+------+-------------------+
		| 2018 | wimbledon | 1    | 7                 |
		| 2018 | fr_open   | 1    | 7                 |
		| 2018 | us_open   | 1    | 7                 |
		| 2018 | au_open   | 1    | 7                 |
		| 2019 | wimbledon | 1    | 7                 |
		| 2019 | fr_open   | 1    | 7                 |
		| 2020 | fr_open   | 1    | 7                 |
		| 2020 | us_open   | 2    | 5                 |
		| 2020 | au_open   | 2    | 5                 |
		| 2019 | us_open   | 2    | 5                 |
		| 2019 | au_open   | 2    | 5                 |
		| 2020 | wimbledon | 2    | 5                 |
		+------+-----------+------+-------------------+
		*/
)

SELECT DISTINCT cte.wins AS [player_id], p.player_name, cte.grand_slams_count
FROM CTE cte
INNER JOIN Players p
ON cte.wins = p.player_id
ORDER BY cte.grand_slams_count