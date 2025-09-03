USE PD_321
GO

SELECT
			[Дисциплина]					= discipline_name,
			[Количество преподователей]		= COUNT(teacher_id)
--FROM	Teachers, Disciplines, TeachersDisciplinesRelation
--WHERE		teacher		=	teacher_id
--AND			discipline	=	discipline_id
FROM		Disciplines 
LEFT JOIN	TeachersDisciplinesRelation	ON	(discipline = discipline_id)
LEFT JOIN	Teachers					ON	(teacher = teacher_id)
GROUP BY	discipline_name
HAVING COUNT(teacher_id) = 0
;

SELECT * FROM Disciplines;


