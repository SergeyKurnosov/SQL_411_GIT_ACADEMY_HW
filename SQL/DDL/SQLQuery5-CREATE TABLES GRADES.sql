USE PD_411_SQL
GO

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