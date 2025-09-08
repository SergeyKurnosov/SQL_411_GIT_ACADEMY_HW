USE PD_321
GO


DECLARE @start AS DATE = '2025-09-08';
WHILE @start != '2025-09-15'
    BEGIN
        PRINT(dbo.IsLearningDay(N'PV_211', @start));
        SET @start = DATEADD(DAY , 1  , @start)
    END



SELECT
	group_id,
	group_name,
	direction_name,
	dbo.DecimalToBinary(learning_days) AS days_learning
FROM Groups , Directions
WHERE direction = direction_id;

---------------------------------------------------------------------------------------------------



ALTER FUNCTION dbo.DecimalToBinary(@num INT)
RETURNS VARCHAR(32)
AS
BEGIN
    DECLARE @result VARCHAR(32) = ''
    DECLARE @day TINYINT = 1;
    DECLARE @degree INT = 1;

    WHILE @day <= 7
    BEGIN
        IF (@num & @degree) != 0
            SET @result = @result + dbo.NameDayForNumber(@day)
        SET @day = @day + 1
        SET @degree = @degree * 2;
    END

    RETURN @result
END


ALTER FUNCTION dbo.NameDayForNumber(@num TINYINT)
RETURNS VARCHAR(32)
AS
BEGIN
DECLARE @dayName VARCHAR(32);
SET @dayName = CASE 
                    WHEN @num = 1 THEN '��_'
                    WHEN @num = 2 THEN '��_'
                    WHEN @num = 3 THEN '��_'
                    WHEN @num = 4 THEN '��_'
                    WHEN @num = 5 THEN '��_'
                    WHEN @num = 6 THEN '��_'
                    WHEN @num = 7 THEN '��'
                    ELSE 'error'
                    END;

RETURN @dayName
END