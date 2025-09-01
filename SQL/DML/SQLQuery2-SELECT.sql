USE PD_411_SQL;
GO

--SELECT
--		direction_id	AS	N'Номер направления',
--		direction_name	AS	N'Название'
--FROM Directions;

--INSERT Groups
--		(group_id, group_name, direction)
--VALUES	(7,N'SU_411',2);

--SELECT 
--		group_name		AS N'Название группы',
--		direction_name		AS N'Направление обучения'
--FROM	Groups,Directions
--WHERE	direction	    =  direction_id
--AND		direction_name	LIKE(N'Сетевые технологии%')
;
-- % - все возможные символы 

SELECT
		last_name + ' ' + first_name + ' ' + middle_name	AS N'Студент',
		group_name		AS N'Группа',
		direction_name	AS N'Направление обучение'
FROM	Students,Groups,Directions
WHERE	[group]		=	group_id
AND		direction	=	direction_id
;