USE PD_411_SQL;
GO

DROP TABLE Grades, 
Schedule, 
RequiredDisciplines, DependentDisciplines, DisciplinesDirectionsRelation, TeachersDisciplinesRelation, Disciplines,
Teachers, 
Students, Groups, Directions;

USE master 
GO

ALTER DATABASE [PD_411_SQL] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE PD_411_SQL;