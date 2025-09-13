
USE PD_321
GO

--DROP TABLE DaysOFF;
--DROP TABLE Holidays;


--CREATE TABLE Holidays
--(
--	holiday_id		TINYINT			PRIMARY KEY,
--	holiday_name	NVARCHAR(150)	NOT NULL,
--	duration		TINYINT			NOT NULL,
--	start_day		TINYINT,
--	start_month		TINYINT			
--);



--CREATE TABLE DaysOFF
--(
--	dayoff_id		SMALLINT		PRIMARY KEY IDENTITY(1,1),
--	[date]			DATE			NOT NULL UNIQUE,
--	holiday			TINYINT			NOT NULL
--	CONSTRAINT FK_DaysOFF_to_Holidays	FOREIGN KEY REFERENCES Holidays(holiday_id)
--);


CREATE TABLE CompleteDisciplines
(
	complete_id		INT	        	PRIMARY KEY IDENTITY(1,1),
	[group]			INT				NOT NULL	
	CONSTRAINT FK_CompleteDiscipline_Groups			FOREIGN KEY REFERENCES  Groups(group_id),
	discipline		SMALLINT		NOT NULL
	CONSTRAINT FK_CompleteDiscipline_Disciplines	FOREIGN KEY REFERENCES Disciplines(discipline_id),
	[date]			DATE			NOT NULL UNIQUE
);

