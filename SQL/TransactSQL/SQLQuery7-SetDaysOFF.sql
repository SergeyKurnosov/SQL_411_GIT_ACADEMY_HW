USE PD_321;
GO
SET DATEFIRST 1;

ALTER PROCEDURE sp_SetDaysOff  @year AS  INT
AS
BEGIN
	EXEC sp_SetNewYearHolidays @year, N'���%';

	SELECT 
		[����] = [date],
		[��������] = holiday_name
	FROM DaysOFF 
	JOIN Holidays ON (holiday = holiday_id)
END