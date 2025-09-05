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

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Основы Информационных технологий%');
SET @date		= '2024-08-27'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Основы Информационных технологий%');

WHILE(@lesson_number <= @lessons_count)
BEGIN

INSERT Schedule
([group], discipline, teacher, [date], [time])
VALUES
(@group, @discipline, @teacher, @date, @start_time),
(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 90, @start_time));

IF(DATEPART(iso_week, @date)%2 = 0)
BEGIN
    IF(DATEPART(WEEKDAY, @date) = 2)
    SET @date =	DATEADD(DAY, 7, @date);
END

ELSE IF(DATEPART(iso_week, @date)%2 != 0)
    SET @date =	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 2,2,5), @date);

SET @lesson_number = @lesson_number + 2;
END
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @lesson_number = 1
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Администрирование Windows');
SET @date		= '2024-10-22'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Администрирование Windows');

WHILE(@lesson_number <= @lessons_count)
BEGIN

INSERT Schedule
([group], discipline, teacher, [date], [time])
VALUES
(@group, @discipline, @teacher, @date, @start_time),
(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 90, @start_time));



IF(DATEPART(iso_week, @date)%2 = 0)
BEGIN
    IF(DATEPART(WEEKDAY, @date) = 2)
    SET @date =	DATEADD(DAY, 7, @date);
END

ELSE IF(DATEPART(iso_week, @date)%2 != 0)
    SET @date =	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 2,2,5), @date);

IF(@date = '2024-12-31')
    SET @date = '2025-01-09'

SET @lesson_number = @lesson_number + 2;
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @lesson_number = 1
SET @discipline = (SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%Процедурное программирование на языке C++');
SET @date		= '2024-08-31'
SET @lessons_count =  (SELECT	number_of_lessons		FROM Disciplines	WHERE discipline_name LIKE N'%Процедурное программирование на языке C++');

WHILE(@lesson_number <= @lessons_count)
BEGIN

INSERT Schedule
([group], discipline, teacher, [date], [time])
VALUES
(@group, @discipline, @teacher, @date, @start_time),
(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 90, @start_time));
IF(@date >= '2025-01-11')
    SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 6,3,2), @date)

IF(@date <= '2024-12-28')
BEGIN
IF(DATEPART(iso_week, @date)%2 = 0)
    SET @date =	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 4,2,7), @date);
ELSE IF(DATEPART(iso_week, @date)%2 != 0)
    IF(DATEPART(WEEKDAY, @date) = 6)
    SET @date =	DATEADD(DAY, 5, @date); 
END

IF(@date = '2025-01-04')
    SET @date = '2025-01-11'
SET @lesson_number = @lesson_number + 2;
END

--DELETE FROM Schedule
SELECT  *
FROM Schedule
ORDER BY date
