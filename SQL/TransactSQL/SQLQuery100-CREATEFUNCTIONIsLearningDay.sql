USE PD_321
GO

CREATE FUNCTION IsLearningDay
(
	@group_name		AS		NCHAR(10),
	@date			AS		DATE
)
RETURNS BIT
AS
BEGIN
	--SET DATEFIRST	1
	DECLARE			@group			AS	INT		=	(SELECT group_id		FROM Groups WHERE group_name = @group_name);
	DECLARE			@learning_days	AS	TINYINT	=	(SELECT learning_days	FROM Groups WHERE group_id = @group);
	DECLARE			@weekday		AS	INT		=	DATEPART(WEEKDAY, @date);
	DECLARE			@exponent		AS	TINYINT	=	@weekday-1;
	--DECLARE		    @learning_day	AS	BIT		=	
	RETURN			@learning_days & POWER(2, @exponent);
	
END


ALTER FUNCTION dbo.DecimalToBinary(@num INT)
RETURNS VARCHAR(32)
AS
BEGIN
    DECLARE @result VARCHAR(32) = ''
    DECLARE @power TINYINT = 0;
    DECLARE @degree INT = 1;

    WHILE @power <= 7
    BEGIN
   --    SET @degree = POWER(@power, 2);
        IF (@num & @degree) != 0
            SET @result = @result + dbo.NameDayForNumber(@power+1)
     --   ELSE
       --     IF (@power != 7)
             --   SET @result = @result + 'âõä_'
        SET @power = @power + 1
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
                    WHEN @num = 1 THEN 'Ïí_'
                    WHEN @num = 2 THEN 'Âò_'
                    WHEN @num = 3 THEN 'Ñð_'
                    WHEN @num = 4 THEN '×ò_'
                    WHEN @num = 5 THEN 'Ïò_'
                    WHEN @num = 6 THEN 'Ñá_'
                    WHEN @num = 7 THEN 'Âñ'
                    ELSE 'error'
                    END;

RETURN @dayName
END