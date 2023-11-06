/*** SUM All previous salaries including the current salary ***/
SELECT e1.id, e1.name, e1.salary, e2.salary
FROM Employee e1
INNER JOIN Employee e2
ON e1.id >= e2.id
ORDER BY e1.id
/*
+----+-------+--------+--------+
| id | name  | salary | salary |
+----+-------+--------+--------+
| 1  | Joe   | 70000  | 70000  |
| 2  | Jim   | 80000  | 70000  |
| 2  | Jim   | 80000  | 80000  |
| 3  | Henry | 90000  | 70000  |
| 3  | Henry | 90000  | 80000  |
| 3  | Henry | 90000  | 90000  |
+----+-------+--------+--------+
*/


SELECT DISTINCT e1.id, e1.[name], SUM(e2.salary) OVER(PARTITION BY e1.id ORDER BY e1.id) [Adding Salaries]
FROM Employee e1
INNER JOIN Employee e2
ON e1.id >= e2.id
ORDER BY e1.id

/*
+----+-------+-----------------+
| id | name  | Adding Salaries |
+----+-------+-----------------+
| 1  | Joe   | 70000           |
| 2  | Jim   | 150000          |
| 3  | Henry | 240000          |
+----+-------+-----------------+
*/