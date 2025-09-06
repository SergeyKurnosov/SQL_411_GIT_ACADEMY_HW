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