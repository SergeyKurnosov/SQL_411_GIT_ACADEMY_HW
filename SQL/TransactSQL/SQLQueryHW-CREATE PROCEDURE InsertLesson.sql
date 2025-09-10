SET DATEFIRST	1;
USE PD_321
GO


ALTER PROCEDURE sp_InsertLesson
		@group_name			AS	NCHAR(10),
		@discipline_name	AS	NVARCHAR(150),
		@teacher_last_name	AS	NVARCHAR(50),
		@start_date			AS	DATE	=	'1900-01-01',
		@start_time			AS	TIME	=	'00:00'
AS
BEGIN
	DECLARE	@group			AS	INT		=	(SELECT group_id			FROM Groups			WHERE group_name = @group_name);
	DECLARE @learning_days	AS	TINYINT =	(SELECT learning_days		FROM Groups			WHERE group_id = @group);
	DECLARE	@discipline		AS	SMALLINT=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	DECLARE	@lessons_count	AS	TINYINT	=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id = @discipline);
	DECLARE	@lesson_number	AS	TINYINT	=	1;
	DECLARE	@teacher		AS	INT		=	(SELECT teacher_id			FROM Teachers		WHERE last_name LIKE @teacher_last_name);
	DECLARE	@date			AS	DATE	=	IIF(@start_date != '1900-01-01', @start_date, dbo.GetNextLearningDay(@group_name, DEFAULT));
	SET @start_time		=	IIF(@start_time != '00:00', @start_time, (SELECT @start_time FROM Groups WHERE group_id = @group));

	IF(dbo.CheckDisciplineForAddSchedule(@group, @discipline) = 0)
	BEGIN
		PRINT(FORMATMESSAGE(N'Дисциплина "%s" уже выставлена для группы "%s"', @discipline_name, @group_name));
		RETURN;
	END

	WHILE @lesson_number <= @lessons_count
	BEGIN
			IF(dbo.CheckDateForAddSchedule(@group, @date, @start_time) != 0 AND dbo.CheckDateHolydays(@date) != 0)
			BEGIN
			    PRINT(@date);
				DECLARE @ResultCode	INT;
				EXEC @ResultCode = sp_InsertToSchedule @group, @discipline, @teacher, @date, @start_time; 
					IF(@ResultCode = 0)
						SET @lesson_number = @lesson_number + 2;			
			END
			ELSE
			BEGIN
				PRINT(FORMATMESSAGE(N'%s %s у группы %s уже занято / не учебный день (каникулы)', CAST(@date AS NCHAR(10)) , CAST(@start_time AS NCHAR(8) ), @group_name));
			END
			PRINT(FORMATMESSAGE(N'1--___%s___---', CAST(@date AS NCHAR(10))));
			SET @date			= dbo.GetNextLearningDay(@group_name, @date);
			PRINT(FORMATMESSAGE(N'2--___%s___---', CAST(@date AS NCHAR(10))));
	END
END

ALTER PROCEDURE sp_InsertToSchedule
		@group				AS	INT,
		@discipline			AS	SMALLINT,
	    @teacher		    AS	INT,
		@date				AS	DATE,
		@start_time			AS	TIME
AS
BEGIN TRY
		INSERT	Schedule
				([group], discipline, teacher, [date], [time], spent)
		VALUES
				(@group, @discipline, @teacher, @date, @start_time, IIF(@date < GETDATE(),1,0)),
				(@group, @discipline, @teacher, @date, DATEADD(MINUTE,95,@start_time), IIF(@date < GETDATE(),1,0));
		RETURN 0;
END TRY
BEGIN CATCH
		RETURN 1;
END CATCH


ALTER FUNCTION CheckDisciplineForAddSchedule
(
		@group				AS	INT,
		@discipline			AS	SMALLINT
)
RETURNS BIT
AS
BEGIN
	IF EXISTS	(SELECT lesson_id FROM Schedule WHERE [group] = @group AND discipline = @discipline)
	BEGIN
		RETURN 0;
	END
RETURN 1;	
END

ALTER FUNCTION CheckDateForAddSchedule
(
		@group				AS	INT,
		@date				AS	DATE	=	'1900-01-01',
		@time				AS	TIME	=	'00:00'
)
RETURNS BIT
AS
BEGIN
	IF EXISTS	(SELECT lesson_id FROM Schedule WHERE [group] = @group AND [date] = @date AND [time] = @time)
	BEGIN
		RETURN 0;
	END
RETURN 1;	
END

CREATE FUNCTION CheckDateHolydays
(
		@date				AS	DATE	=	'1900-01-01'
)
RETURNS BIT
AS
BEGIN

	DECLARE @numHoliday		AS INT = 1;
	DECLARE @CountHolidays	AS INT = (SELECT COUNT(*) FROM Holidays);
	DECLARE @StartHoliday	AS DATE;
	DECLARE @EndHoliday		AS DATE;

	WHILE @numHoliday <= @CountHolidays
	BEGIN
		SET @StartHoliday	= (SELECT [start_date] FROM Holidays WHERE ID = @numHoliday);
		SET @EndHoliday		= (SELECT [end_date] FROM Holidays WHERE ID = @numHoliday);
		IF(@date >= @StartHoliday AND @date <= @EndHoliday)
			RETURN 0;

		SET @numHoliday = @numHoliday + 1;
	END

RETURN 1;	
END



