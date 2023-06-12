CREATE DATABASE IF NOT EXISTS homework_5;

USE homework_5;

CREATE TABLE IF NOT EXISTS cars (
	id INT NOT NULL PRIMARY KEY,
    carname VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127),
    (3, "Skoda", 9000),
    (4, "Volvo", 29000),
    (5, "Bentley", 35000),
    (6, "Citroen", 21000),
    (7, "Hummer", 41400),
    (8, "Volkswagen", 21600);
    
/* Задание 1. Создать представление, в которое попадут автомобили стоимостью до 25 000 долларов. */

CREATE VIEW cars_view AS
SELECT 
	* 
FROM cars
WHERE cost < 25000;

/* Задание 2. Изменить в существующем представлении порог для стоимости: 
пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW). */

ALTER VIEW cars_view AS
SELECT 
	* 
FROM cars
WHERE cost < 30000;

/* Задание 3. Создать представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично). */

CREATE VIEW cars_view_as AS
SELECT 
	* 
FROM cars
WHERE carname IN ("Audi", "Skoda");

/* Задание 4. Добавить новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, нужно вычесть время станций для пар смежных станций. 
Можно вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD. 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее. */

SELECT
	train_id,
	station,
	station_time
	SUBTIME(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY station_time), station_time
	) AS time_to_next_station
FROM trains;