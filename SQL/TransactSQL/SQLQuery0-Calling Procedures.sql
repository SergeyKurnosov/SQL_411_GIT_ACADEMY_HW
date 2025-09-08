
SET DATEFIRST 1;
USE PD_321
GO


--DELETE FROM Schedule
EXEC sp_AddSchedule N'PD_411', N'%MS SQL Server%', N'Ковтун', '2025-08-18', '13:30';
EXEC sp_SelectSchedule;
PRINT(dbo.GetNextLearningDay(N'PD_411', NULL));
PRINT(N'----------------------------------')
PRINT(dbo.IsLearningDay(N'PD_411', '2025-09-08'));
PRINT(dbo.GetNextLearningDay(N'PD_411', '2025-09-05'));


PRINT(dbo.IsLearningDay(N'PV_211', '2025-09-15'));

SELECT dbo.DecimalToBinary(21) AS BinaryValue;


SELECT * FROM Groups
SELECT
	group_id,
	group_name,
	direction_name,
	dbo.DecimalToBinary(learning_days) AS days_learning
FROM Groups , Directions
WHERE direction = direction_id;