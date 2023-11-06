/*
177. Nth Highest Salary
Medium

1285

700

Add to List

Share
SQL Schema
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
*/

CREATE FUNCTION getNthHighestSalary(@N INT) 
RETURNS INT 
AS
BEGIN
	DECLARE @salary INT
	SET @salary = 
	    (SELECT t.salary
         FROM
		(
			SELECT ROW_NUMBER() OVER (ORDER BY salary DESC) AS num, salary 
            FROM Employee
			GROUP BY salary

			/*
			+-----+--------+				
			| num | salary |				
			+-----+--------+				
			| 1   | 300    |				
			| 2   | 200    |				
			| 3   | 100    |                
			+-----+--------+
			*/
		 )t
         WHERE t.num = @N ) 
    RETURN @salary
END

--SELECT dbo.getNthHighestSalary(1) -- The first highest salary  // return 300
--SELECT dbo.getNthHighestSalary(2) -- The second highest salary // return 200
--SELECT dbo.getNthHighestSalary(3) -- The third highest salary  // return 100
--SELECT dbo.getNthHighestSalary(4) -- The fourth highest salary // return NULL

/*
+-----+--------+
| id  | salary |
+-----+--------+
| 1   |	100    |
| 2   | 100    |
+-----+--------+
--SELECT dbo.getNthHighestSalary(2) -- The second highest salary // return NULL
*/