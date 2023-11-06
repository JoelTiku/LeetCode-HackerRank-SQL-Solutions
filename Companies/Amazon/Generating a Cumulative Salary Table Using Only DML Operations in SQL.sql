/*

In SQL, assuming we are working with an in-memory database and the SQL flavor supports 
DML statements (INSERT, UPDATE, DELETE) for such in-memory tables, 
how can you generate a table named "EmployeeSalary", 
that has three columns ("ID", "Salary", and "Cumulative"), and 
that contains the following data:

ID: An integer sequence starting from 1
Salary: Starts from 1000 and increases by 100 with each row
Cumulative: The cumulative sum of the "Salary" column up to the current row
Keep in mind that no pre-existing tables or data are available and that the solution should only involve DML operations (Data Manipulation Language: SELECT, INSERT, UPDATE, DELETE). What SQL script would you write to accomplish this?

Output:
+-------+-----------+---------------+
|  ID   |  Salary   |  Cumulative   |
+-------+-----------+---------------+
|	1	|	1000    |	 1000		|
|	2	|	1100    |	 2100		|
|	3	|	1200    |	 3300		|
|	4	|	1300    |	 4600		|
|	5	|	1400    |	 6000		|
+-------+-----------+---------------+

*/


;WITH EmployeeSalary
AS
(
	SELECT 1 AS ID, 1000 AS Salary

	UNION ALL

	SELECT ID + 1 AS ID, Salary + 100 AS Salary
	FROM EmployeeSalary
	WHERE ID <= 4
)

SELECT cte.*, SUM(cte.Salary) OVER(ORDER BY cte.ID) AS Cumulative
FROM EmployeeSalary cte
