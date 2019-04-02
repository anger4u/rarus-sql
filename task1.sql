-- SQL для создания таблиц в БД.

DROP TABLE IF EXISTS departments;
CREATE TABLE IF NOT EXISTS departments (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  salary INT(11) UNSIGNED NOT NULL,
  department_id INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (department_id) REFERENCES departments (id)
);


-- SQL для записи данных в БД.

INSERT INTO departments(name)
VALUES
  ('IT'),
  ('Sales');

INSERT INTO employees(name, salary, department_id)
VALUES
  ('Joe', 70000, 1),
  ('Henry', 80000, 2),
  ('Sam', 60000, 2),
  ('Max', 90000, 1);


-- SQL - решение задачи.

SELECT departments.name, MAX(salary) 
FROM employees 
INNER JOIN departments ON employees.department_id = departments.id 
GROUP BY employees.department_id;