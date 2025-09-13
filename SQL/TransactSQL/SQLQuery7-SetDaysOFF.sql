USE PD_321;
GO
SET DATEFIRST 1;
GO

ALTER PROCEDURE sp_SetDaysOff  @year AS  INT

AS
BEGIN
	EXEC sp_SetNewYearHolidays @year, N'Нов%';
	--EXEC sp_Set_23F_8M_Holidays @year;
	--EXEC sp_SetPashaHolidays @year;
	--EXEC sp_MayHolidays @year;
	--EXEC spSUMMERHolidays @year;


	SELECT 
		[Дата] = [date],
		[Праздник] = holiday_name
	FROM DaysOFF 
	JOIN Holidays ON (holiday = holiday_id)


END
--------------------------------------------------------
--CREATE PROCEDURE sp_INSERT_DAYS_OFF(@start_date AS DATE , @duration AS TINYINT , @holiday AS TINYINT)
--AS
--BEGIN
--        DECLARE @date		AS	DATE	=	@start_date;
--		WHILE	@date < DATEADD(DAY,@duration,@start_date)
--	BEGIN
--		INSERT DaysOFF
--		VALUES (@date, @holiday)
--		SET @date = DATEADD(DAY,1,@date);
--	END
--END
----------------------------------------------------------

--ALTER PROCEDURE sp_SetNewYearHolidays  @year AS INT,  @holiday_name   NVARCHAR(150)
--AS
--BEGIN
--	DECLARE @holiday   AS   TINYINT   = (SELECT holiday_id  FROM  Holidays WHERE holiday_name LIKE @holiday_name);
--	DECLARE @duration  AS   TINYINT   = (SELECT duration  FROM  Holidays WHERE holiday_id = @holiday);
--	DECLARE @start_date AS DATE       = DATEFROMPARTS(@year,1,1);
--	SET     @start_date = DATEADD(DAY, 1-DATEPART(WEEKDAY, @start_date),@start_date);

--	EXEC sp_INSERT_DAYS_OFF @start_date , @duration , @holiday;
--END

-------------------------------------------------------------------------------

--ALTER PROCEDURE sp_Set_23F_8M_Holidays  @year AS INT
--AS
--BEGIN
--	DECLARE @holiday   AS   TINYINT   = (SELECT holiday_id  FROM  Holidays WHERE holiday_name LIKE N'23%');
--	DECLARE @duration  AS   TINYINT   = (SELECT duration  FROM  Holidays WHERE holiday_id = @holiday);
--	DECLARE @start_date AS DATE       = DATEFROMPARTS(@year,2,23);

--	EXEC sp_INSERT_DAYS_OFF @start_date , @duration , @holiday;

--	SET	@holiday = (SELECT holiday_id  FROM  Holidays WHERE holiday_name LIKE N'8%');
--	SET @duration = (SELECT duration  FROM  Holidays WHERE holiday_id = @holiday);
--	SET @start_date = DATEFROMPARTS(@year,3,8);

--	EXEC sp_INSERT_DAYS_OFF @start_date , @duration , @holiday;
--END

-------------------------------------------------------------------------------

--CREATE PROCEDURE sp_SetPashaHolidays(@Year INT)
--AS
--BEGIN
--    DECLARE @holiday   AS   TINYINT   = (SELECT holiday_id  FROM  Holidays WHERE holiday_name LIKE N'Пасха');
--	DECLARE @duration  AS   TINYINT   = (SELECT duration  FROM  Holidays WHERE holiday_id = @holiday);

--    DECLARE @a INT, @b INT, @c INT, @day INT, @e INT, @f INT, @g INT, @h INT, @i INT, @k INT, @l INT, @month INT;
--    SET @a = @Year % 4;
--    SET @b = @Year % 7;
--    SET @c = @Year % 19;
--    SET @day = (19 * @c + 15) % 30;
--    SET @e = (2 * @a + 4 * @b - @day + 34) % 7;
--    SET @f = ( @day + @e + 114 );

--    SET @month = @f / 31;
--    SET @day = (@f % 31) + 1;

--    DECLARE @PaschaDate DATE = DATEADD(DAY, @day - 1, DATEFROMPARTS(@Year, @month, 1));
--    DECLARE @Offset INT = 13;
--    DECLARE @start_date AS DATE = DATEADD(DAY, @Offset, @PaschaDate);

--	EXEC sp_INSERT_DAYS_OFF @start_date , @duration , @holiday;

--END

-----------------------------------------------------------------------------------------------

--CREATE PROCEDURE sp_MayHolidays  (@year AS INT)
--AS
--BEGIN
--	DECLARE @holiday   AS   TINYINT   = (SELECT holiday_id  FROM  Holidays WHERE holiday_name LIKE N'Майские%');
--	DECLARE @duration  AS   TINYINT   = (SELECT duration  FROM  Holidays WHERE holiday_id = @holiday);
--	DECLARE @start_date AS DATE       = DATEFROMPARTS(@year,5,1);

--	EXEC sp_INSERT_DAYS_OFF @start_date , @duration , @holiday;
--END

------------------------------------------------------------------------------------------------

--CREATE PROCEDURE spSUMMERHolidays  (@year AS INT)
--AS
--BEGIN
--	DECLARE @holiday   AS   TINYINT   = (SELECT holiday_id  FROM  Holidays WHERE holiday_name LIKE N'Летние%');
--	DECLARE @duration  AS   TINYINT   = (SELECT duration  FROM  Holidays WHERE holiday_id = @holiday);
--	DECLARE @start_date AS DATE       = DATEFROMPARTS(@year,7,31);
--	SET @start_date = DATEADD(DAY, 1-DATEPART(WEEKDAY, @start_date),@start_date);

--	EXEC sp_INSERT_DAYS_OFF @start_date , @duration , @holiday;
--END

-------------------------------------------------------------------------------------------------