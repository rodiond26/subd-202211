CREATE database otus;
USE otus;

CREATE TABLE IF NOT EXISTS students (name VARCHAR(128), age TINYINT UNSIGNED);

INSERT INTO students (name, age)
VALUES
('Mary', 17),
('John', 22),
('Steve', 44);
