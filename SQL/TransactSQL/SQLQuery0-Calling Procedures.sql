
SET DATEFIRST 1;
USE PD_321
GO


--DELETE FROM Schedule
--EXEC sp_AddSchedule N'PD_411', N'%MS SQL Server%', N'Ковтун', '2025-08-18', '13:30';
EXEC sp_AddSchedule N'PD_411', N'%ADO.NET%', N'Ковтун';
EXEC sp_AddSchedule N'PD_411', N'Системное программирование%', N'Ковтун';
EXEC sp_AddSchedule N'PD_411', N'%Сетевое программирование%', N'Ковтун', '2025-08-18', '13:30';
EXEC sp_AddSchedule N'PD_411', N'HTML/CSS', N'Ковтун', '2025-08-18', '13:30';
EXEC sp_AddSchedule N'PD_411', N'%JavaScript%', N'Ковтун', '2025-08-18', '13:30';
-- Язык программирования C#
-- Объектно-ориентированное программирование на языке C++
EXEC sp_AddSchedule N'PD_411', N'Язык программирования C#', N'Ковтун', '2025-04-07', '13:30';

EXEC sp_Complete_Disciplines ;
SELECT * FROM CompleteDisciplines;
SELECT * FROM Schedule;



EXEC sp_SelectSchedule;
SELECT * FROM Disciplines;
PRINT(dbo.GetNextLearningDay(N'PD_411', NULL));
PRINT(N'----------------------------------')
PRINT(dbo.IsLearningDay(N'PD_411', '2025-09-12'));
PRINT(dbo.GetNextLearningDay(N'PD_411', '2025-09-05'));


