USE PD_411_SQL
GO

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