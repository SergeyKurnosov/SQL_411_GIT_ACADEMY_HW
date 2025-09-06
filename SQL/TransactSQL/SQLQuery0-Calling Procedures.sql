
SET DATEFIRST 1;
USE PD_321
GO


--DELETE FROM Schedule
EXEC sp_AddSchedule N'PD_411', N'%MS SQL Server%', N'Ковтун', '2025-08-18', '13:30';
EXEC sp_SelectSchedule;
PRINT(dbo.GetNextLearningDay(N'PD_411', NULL));
PRINT(N'----------------------------------')
PRINT(dbo.IsLearningDay(N'PD_411', '2025-09-12'));
PRINT(dbo.GetNextLearningDay(N'PD_411', '2025-09-05'));