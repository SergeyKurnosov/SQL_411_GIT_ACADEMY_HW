USE PD_321
GO

SET DATEFIRST	1;

DECLARE		@start_date			AS		DATE	=	'2025-08-18'
DECLARE     @date				AS		DATE	=	@start_date
DECLARE     @start_time			AS		TIME	=	'13:30'
DECLARE		@discipline			AS		SMALLINT=	(SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%MS SQL Server')
DECLARE		@lessons_count		AS		TINYINT	=	(SELECT	number_of_lessons	FROM Disciplines	WHERE discipline_name LIKE N'%MS SQL Server%');
DECLARE		@group				AS		INT		=	(SELECT group_id			FROM Groups			WHERE group_name=N'PD_411');
DECLARE		@teacher			AS		INT		=	(SELECT teacher_id			FROM Teachers		WHERE first_name=N'Олег');
DECLARE		@lesson_number		AS		INT		=	1;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Объектно-ориентированное программирование на языке C++%');
SET @date		= '2025-01-28'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Объектно-ориентированное программирование на языке C++%');

WHILE(@lesson_number <= @lessons_count)
BEGIN
        SET @lesson_number = @lesson_number + 1;
        SET @lesson_number = @lesson_number + 1;
IF(@date != '2025-02-22' AND @date != '2025-03-08')
		INSERT Schedule
		([group], discipline, teacher, [date], [time])
		VALUES
		(@group, @discipline, @teacher, @date, @start_time),
		(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 90, @start_time));
SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 6,3,2), @date);
END

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @lesson_number =	1;
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%UML и паттерны проектирования%');
SET @date		= '2025-04-07'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%UML и паттерны проектирования%');

WHILE(@lesson_number <= @lessons_count)
BEGIN
        SET @lesson_number = @lesson_number + 1;
        SET @lesson_number = @lesson_number + 1;
		INSERT Schedule
		([group], discipline, teacher, [date], [time])
		VALUES
		(@group, @discipline, @teacher, @date, @start_time),
		(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 90, @start_time));
SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 5,3,2), @date);
END
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @lesson_number =	1;
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Язык программирования C#%');
SET @date		= '2025-04-28'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Язык программирования C#%');

WHILE(@lesson_number <= @lessons_count)
BEGIN

IF(@date = '2025-05-02')
  SET @date = '2025-05-12'


INSERT Schedule
([group], discipline, teacher, [date], [time])
VALUES
(@group, @discipline, @teacher, @date, @start_time),
(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 95, @start_time));
SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 5,3,2), @date);
SET @lesson_number = @lesson_number + 2;
END

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @lesson_number =	1;
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Разработка Windows-приложений на языке C++%');
SET @date		= '2025-06-16'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Разработка Windows-приложений на языке C++%');

WHILE(@lesson_number <= @lessons_count)
BEGIN
INSERT Schedule
([group], discipline, teacher, [date], [time])
VALUES
(@group, @discipline, @teacher, @date, @start_time),
(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 95, @start_time));
SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 5,3,2), @date);
SET @lesson_number = @lesson_number + 2;
END

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @lesson_number =	1;
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Разработка Windows-приложений на языке C#%');
SET @date		= '2025-07-14'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Разработка Windows-приложений на языке C#%');

WHILE(@lesson_number <= @lessons_count)
BEGIN
INSERT Schedule
([group], discipline, teacher, [date], [time])
VALUES
(@group, @discipline, @teacher, @date, @start_time),
(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 95, @start_time));
SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 5,3,2), @date);
SET @lesson_number = @lesson_number + 2;
END


--DELETE FROM Schedule
SELECT  *
FROM Schedule
ORDER BY date
