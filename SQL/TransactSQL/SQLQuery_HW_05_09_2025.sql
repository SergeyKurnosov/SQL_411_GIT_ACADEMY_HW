SET DATEFIRST	1;
USE PD_321
GO

ALTER PROCEDURE sp_AddSchedule_HW
		@group_name			AS	NCHAR(10),
		@discipline_name	AS	NVARCHAR(150),
		@teacher_last_name	AS	NVARCHAR(50),
		@start_date			AS	DATE			=	NULL,
		@start_time			AS	TIME,
		-----------------------------
		@days_of_study NVARCHAR(MAX)
AS
BEGIN
	DECLARE @RowCount INT;
	SELECT @RowCount = COUNT(*) FROM Schedule;
	IF @start_date	IS NULL AND @RowCount = 0
		SET @start_date = CAST(GETDATE() AS DATE);

	IF @RowCount >=2
		BEGIN
		DECLARE @st_date	AS	DATE	=	(SELECT MIN(date) FROM Schedule);

		END

	DECLARE	@group			AS	INT		=	(SELECT group_id			FROM Groups			WHERE group_name = @group_name);
	DECLARE	@discipline		AS	SMALLINT=	(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	DECLARE	@lessons_count	AS	TINYINT	=	(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_id = @discipline);
	DECLARE	@lesson_number	AS	TINYINT	=	1;
	DECLARE	@teacher		AS	INT		=	(SELECT teacher_id			FROM Teachers		WHERE last_name LIKE @teacher_last_name);
	DECLARE	@date			AS	DATE	=	@start_date;
	--------------------------------
	DECLARE @Table_days_of_study TABLE (Value INT);

    INSERT INTO @Table_days_of_study (Value)
    SELECT value FROM STRING_SPLIT(@days_of_study, ',');

	WHILE @lesson_number <= @lessons_count
	BEGIN

		DECLARE @Value INT;
		DECLARE cursor_example CURSOR FOR SELECT Value FROM @Table_days_of_study;

		OPEN cursor_example;
		FETCH NEXT FROM cursor_example INTO @Value;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT @Value;

			IF NOT EXISTS	(SELECT lesson_id FROM Schedule WHERE [group] = @group AND discipline = @discipline AND [date] = @date AND @Value = DATEPART(WEEKDAY, @date))
			BEGIN

				INSERT	Schedule
						([group], discipline, teacher, [date], [time], spent)
				VALUES
						(@group, @discipline, @teacher, @date, @start_time, IIF(@date < GETDATE(),1,0)),
						(@group, @discipline, @teacher, @date, DATEADD(MINUTE,95,@start_time), IIF(@date < GETDATE(),1,0));
				
			END
			SET @lesson_number	= @lesson_number+2;
			

			FETCH NEXT FROM cursor_example INTO @Value;
			SET @date			= DATEADD(DAY,@Value - DATEPART(WEEKDAY, @date), @date);
		END
		    SET @date			= DATEADD(DAY,8 - DATEPART(WEEKDAY, @date), @date);


		CLOSE cursor_example;
		DEALLOCATE cursor_example;


	END
END;

ALTER PROCEDURE sp_Select_days_of_study
AS
BEGIN
	WITH FirstOccur AS
	(
	  -- ƒл€ каждого Val находим минимальный ID (пор€док первой встречи)
	  SELECT
		DATEPART(WEEKDAY, [date]),
		MIN(lesson_id) AS FirstID
	  FROM Schedule
	  GROUP BY DATEPART(WEEKDAY, [date])
	)
	SELECT
	  STRING_AGG(CAST(DATEPART(WEEKDAY, [date]) AS VARCHAR(10)), ', ') 
		WITHIN GROUP (ORDER BY FirstID) AS Result
	FROM FirstOccur;
	--DECLARE @Value DATE;

	--DECLARE cursor_example CURSOR FOR
	--SELECT [date] FROM Schedule;

	--OPEN cursor_example;

	--FETCH NEXT FROM cursor_example INTO @Value;

	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	--	PRINT DATEPART(WEEKDAY, @Value);

	--	FETCH NEXT FROM cursor_example INTO @Value;
	--END

	--CLOSE cursor_example;
	--DEALLOCATE cursor_example;
END





-----------------------------------------------------------------------------------------------------------------------------




--ALTER PROCEDURE MyProcedure
--    @ParamList NVARCHAR(MAX)
--AS
--BEGIN
--    -- ѕример: @ParamList = '1,2,3,4,5'
--    -- –азбиваем строку на таблицу
--    DECLARE @Params TABLE (Value INT);
  
--    INSERT INTO @Params 
--		(Value)
--    SELECT value FROM STRING_SPLIT(@ParamList, ',');

--    -- “еперь можно использовать @Params как таблицу с параметрами

--	DECLARE @Value INT; -- или другой тип данных вашей колонки

--	DECLARE cursor_example CURSOR FOR
--	SELECT Value FROM @Params;

--	OPEN cursor_example;

--	FETCH NEXT FROM cursor_example INTO @Value;

--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		-- «десь можно делать что угодно с @Value
--		PRINT @Value; -- например, вывод

--		FETCH NEXT FROM cursor_example INTO @Value;
--	END

--	CLOSE cursor_example;
--	DEALLOCATE cursor_example;
--   -- SELECT * FROM @Params;
--  --  DROP TABLE @Params;
--END