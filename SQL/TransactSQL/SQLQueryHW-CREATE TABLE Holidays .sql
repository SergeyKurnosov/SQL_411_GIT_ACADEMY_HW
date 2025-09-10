USE PD_321
GO

CREATE TABLE Holidays
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name_holiday NVARCHAR(100) NOT NULL,
    [start_date] DATE NOT NULL,
    end_date DATE NOT NULL
);


ALTER PROCEDURE sp_InsertToHolidays
AS
BEGIN
SET DATEFIRST 1;


DECLARE @CurrentYear    INT    =    YEAR(GETDATE());
DECLARE @DayHoliday  DATE   =    DATEFROMPARTS(@CurrentYear,12,31);
DECLARE @LastDayOfWeek  INT    =    DATEPART(WEEKDAY, @DayHoliday);
DECLARE @DaysToMonday INT = (@LastDayOfWeek + 7 - 1) % 7;

DECLARE @StartHoliday DATE = DATEADD(DAY, -@DaysToMonday, @DayHoliday);
DECLARE @EndHoliday DATE = DATEADD(DAY, 13, @StartHoliday);

EXEC    sp_InsertToHolidaysDATA N'Новогодние каникулы', @StartHoliday , @EndHoliday;

SET     @DayHoliday = DATEFROMPARTS(@CurrentYear,02,23);
EXEC    sp_InsertToHolidaysDATA N'23 февраля', @DayHoliday , @DayHoliday;

SET     @DayHoliday = DATEFROMPARTS(@CurrentYear,03,08);
EXEC    sp_InsertToHolidaysDATA N'8 марта', @DayHoliday , @DayHoliday;

SET     @DayHoliday = dbo.CalculateOrthodoxEaster(@CurrentYear);
SET     @EndHoliday = DATEADD(DAY, 2, @DayHoliday)
EXEC    sp_InsertToHolidaysDATA N'Пасха', @DayHoliday , @EndHoliday;

SET     @DayHoliday = DATEFROMPARTS(@CurrentYear,05,01);
SET     @EndHoliday = DATEADD(DAY, 9, @DayHoliday)
EXEC    sp_InsertToHolidaysDATA N'Майские каникулы', @DayHoliday , @EndHoliday;

SET     @DayHoliday     =    DATEFROMPARTS(@CurrentYear,07,31);
SET     @LastDayOfWeek  =    DATEPART(WEEKDAY, @DayHoliday);
SET     @DaysToMonday   =    (@LastDayOfWeek + 7 - 1) % 7;
SET     @StartHoliday   =    DATEADD(DAY, -@DaysToMonday, @DayHoliday);
SET     @EndHoliday     =    DATEADD(DAY, 20, @StartHoliday);
EXEC    sp_InsertToHolidaysDATA N'Летние каникулы', @StartHoliday , @EndHoliday;


END;


EXEC sp_InsertToHolidays;
-- DROP TABLE Holidays;
SELECT * FROM Holidays;


ALTER PROCEDURE sp_InsertToHolidaysDATA
        @Name_holiday  AS  NVARCHAR(100),
        @start_date    AS  DATE,
        @end_date      AS  DATE
AS
BEGIN
        INSERT Holidays
              (Name_holiday , [start_date] , end_date)
        VALUES
              (@Name_holiday, @start_date, @end_date);
END


ALTER FUNCTION dbo.CalculateOrthodoxEaster(@Year INT)
RETURNS DATE
AS
BEGIN
    DECLARE @a INT, @b INT, @c INT, @day INT, @e INT, @f INT, @g INT, @h INT, @i INT, @k INT, @l INT, @month INT;
    SET @a = @Year % 4;
    SET @b = @Year % 7;
    SET @c = @Year % 19;
    SET @day = (19 * @c + 15) % 30;
    SET @e = (2 * @a + 4 * @b - @day + 34) % 7;
    SET @f = ( @day + @e + 114 );

    SET @month = @f / 31;
    SET @day = (@f % 31) + 1;

    DECLARE @PaschaDate DATE = DATEADD(DAY, @day - 1, DATEFROMPARTS(@Year, @month, 1));
    DECLARE @Offset INT = 13;
    RETURN DATEADD(DAY, @Offset, @PaschaDate);
END


