CREATE DATABASE PD_411_SQL
ON		    
(
   NAME			=	PD_411_SQL,
   FILENAME		=	'D:\Microsoft SQL Server\MSSQL14.MSSQLSERVER17\MSSQL\Data\PD_411_SQL.mdf',
   SIZE			=	8MB,
   MAXSIZE		=	500MB,
   FILEGROWTH	=	5MB
)
LOG ON
(
   NAME			=	PD_411_SQL_Log,
   FILENAME		=	'D:\Microsoft SQL Server\MSSQL14.MSSQLSERVER17\MSSQL\Data\PD_411_SQL_log.ldf', 
   SIZE			=	8MB,
   MAXSIZE		=	500MB,
   FILEGROWTH	=	8MB
);
GO  
-------------------------------------------------------------------
USE PD_411_SQL
GO

CREATE TABLE Directions
(
	direction_id	TINYINT			PRIMARY KEY,
	direction_name	NVARCHAR(256)	NOT NULL
);

CREATE TABLE Groups
(
	group_id		INT				PRIMARY KEY,
	group_name		NVARCHAR(16)	NOT NULL,
	direction		TINYINT			NOT NULL
	CONSTRAINT FK_Groups_Directions   FOREIGN KEY REFERENCES  Directions(direction_id)
);

CREATE TABLE Students
(
	student_id		INT				PRIMARY KEY,
	last_name		NVARCHAR(150)	NOT NULL,
	first_name		NVARCHAR(150)	NOT NULL,
	middle_name		NVARCHAR(150),
	birth_date		DATE			NOT NULL,
	[group]			INT				NOT NULL	
	CONSTRAINT FK_Students_Groups   FOREIGN KEY REFERENCES  Groups(group_id)
);
-------------------------------------------------------------------
CREATE TABLE Teachers
(
	teacher_id		INT				PRIMARY KEY,
	last_name		NVARCHAR(150)	NOT NULL,
	first_name		NVARCHAR(150)	NOT NULL,
	middle_name		NVARCHAR(150),
	birth_date		DATE			NOT NULL,
	work_since		DATE			NOT NULL,
);
-------------------------------------------------------------------
CREATE TABLE Disciplines
(
	discipline_id		INT				PRIMARY KEY,
	discipline_name		NVARCHAR(256)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
);

CREATE TABLE TeachersDisciplinesRelation
(
	teacher		INT,
	discipline	INT,
	PRIMARY KEY (teacher,discipline),
	CONSTRAINT FK_TDR_Teachers			FOREIGN KEY (teacher)		REFERENCES Teachers(teacher_id),
	CONSTRAINT FK_TDR_Disciplines		FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id)
);

CREATE TABLE DisciplinesDirectionsRelation
(
	discipline		INT,
	direction		TINYINT,
	PRIMARY KEY (discipline, direction),
	CONSTRAINT FK_DDR_Disciplines		FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DDR_Directions		FOREIGN KEY (direction)		REFERENCES Directions(direction_id)
);

CREATE TABLE DependentDisciplines
(
	discipline				INT,
	dependent_discipline	INT,
	PRIMARY KEY (discipline, dependent_discipline),
	CONSTRAINT FK_DD_Discipline_2_Disciplines_Relation		FOREIGN KEY (discipline)			REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DD_Dependent_2_Discipline_Relation		FOREIGN KEY (dependent_discipline)	REFERENCES Disciplines(discipline_id)
);

CREATE TABLE RequiredDisciplines
(
	discipline				INT,
	required_discipline	INT,
	PRIMARY KEY (discipline, required_discipline),
	CONSTRAINT FK_RD_Discipline_2_Disciplines_Relation		FOREIGN KEY (discipline)			REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_RD_Required_2_Discipline_Relation			FOREIGN KEY (required_discipline)	REFERENCES Disciplines(discipline_id)
);
-------------------------------------------------------------------
CREATE TABLE Schedule
(
	lesson_id		INT		PRIMARY KEY,
	date			DATE	NOT NULL,
	time			TIME	NOT NULL,
	[group]			INT		NOT NULL,
	discipline		INT		NOT NULL,
	teacher			INT		NOT NULL,
	CONSTRAINT FK_Schedule_Groups			FOREIGN KEY ([group])		REFERENCES Groups(group_id),
	CONSTRAINT FK_Schedule_Disciplines		FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_Schedule_Teachers			FOREIGN KEY (teacher)		REFERENCES Teachers(teacher_id)
);
-------------------------------------------------------------------
CREATE TABLE Grades
(
	student		INT,
	lesson		INT,
	grade_1		INT,
	grade_2		INT,
	PRIMARY KEY (student , lesson),
	CONSTRAINT FK_Grades_Students		FOREIGN KEY(student)	REFERENCES Students(student_id),
	CONSTRAINT FK_Grades_Schedule		FOREIGN KEY(lesson)		REFERENCES Schedule(lesson_id)
);