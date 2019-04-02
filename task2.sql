-- SQL для создания таблиц в БД.

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees (
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(50)  NOT NULL,
	salary INT(11) UNSIGNED NOT NULL,
	manager_id INT(11) DEFAULT NULL,
	PRIMARY KEY (id)
);


-- SQL для записи данных в БД.

INSERT INTO employees(name, salary, manager_id)
VALUES
	('Joe', 70000, 3),
	('Henry', 80000, 4),
	('Sam', 60000, NULL),
	('Max', 90000, NULL);


-- SQL - решение задачи.

SELECT emp1.name
FROM employees as emp1
INNER JOIN employees AS emp2 ON emp1.manager_id = emp2.id
WHERE emp1.salary > emp2.salary;