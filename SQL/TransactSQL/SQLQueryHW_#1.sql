USE PD_321
GO

SET DATEFIRST	1;

DECLARE		@start_date			AS		DATE	=	'2025-08-18'
DECLARE     @date				AS		DATE	=	@start_date
DECLARE     @start_time			AS		TIME	=	'13:30'
DECLARE		@discipline			AS		SMALLINT=	(SELECT	discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%MS SQL Server')
DECLARE		@lessons_count		AS		TINYINT	=	(SELECT	number_of_lessons	FROM Disciplines	WHERE discipline_name LIKE N'%MS SQL Server%');
DECLARE		@group				AS		INT		=	(SELECT group_id			FROM Groups			WHERE group_name=N'PD_411');
DECLARE		@teacher			AS		INT		=	(SELECT teacher_id			FROM Teachers		WHERE first_name=N'Юыху');
DECLARE		@lesson_number		AS		INT		=	1;

WHILE(@lesson_number <= @lessons_count)
BEGIN
        SET @lesson_number = @lesson_number + 1;
        SET @lesson_number = @lesson_number + 1;
		
INSERT Schedule
		([group], discipline, teacher, [date], [time])
VALUES
		(@group, @discipline, @teacher, @date, @start_time),
		(@group, @discipline, @teacher, @date, DATEADD(MINUTE, 95, @start_time));

SET @date	=	DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 5,3,2), @date)

END

--DELETE FROM Schedule
SELECT  *
FROM Schedule
ORDER BY date