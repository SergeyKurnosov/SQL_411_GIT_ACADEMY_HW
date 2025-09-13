USE PD_321;
GO

ALTER PROCEDURE sp_Complete_Disciplines
AS
BEGIN

	INSERT INTO CompleteDisciplines 
			([group], discipline, [date])
    SELECT   [group], discipline,MAX([date])
    FROM Schedule , Disciplines
    WHERE spent = 1
    GROUP BY discipline , [group];

END