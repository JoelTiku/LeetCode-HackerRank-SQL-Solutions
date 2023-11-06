/*
1112. Highest Grade For Each Student
Medium

Table: Enrollments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key of this table.
 

Write a SQL query to find the highest grade with its corresponding course for each student. 
In case of a tie, you should find the course with the smallest course_id.

Return the result table ordered by student_id in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+
Output: 
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+
*/

SELECT t.student_id, t.course_id, t.grade
FROM
(
	SELECT *, RANK() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id) AS [rank]
	FROM Enrollments

	/*
	+------------+-----------+-------+------+
	| student_id | course_id | grade | rank |
	+------------+-----------+-------+------+
	| 1          | 2         | 99    | 1    |
	| 1          | 1         | 90    | 2    |
	| 2          | 2         | 95    | 1    |
	| 2          | 3         | 95    | 2    |
	| 3          | 3         | 82    | 1    |
	| 3          | 1         | 80    | 2    |
	| 3          | 2         | 75    | 3    |
	+------------+-----------+-------+------+
	*/
)t
WHERE t.[rank] = 1