USE PD_321
GO

----------------------------------------------------
--INSERT Groups 
--		(group_id, group_name, direction)
--VALUES 
--		(11,N'PD_411', 1)
--		;
----------------------------------------------------
--INSERT Students
--		(last_name, first_name, middle_name, birth_date, [group])
--VALUES
--		(N'Джумаев',N'Илькин',N'Байрамович', '2006-09-18' ,11),
--		(N'Андреева',N'Алина',N'Владимировна','1987-09-16' ,11),
--		(N'Иванова',N'Вероника',N'Владимировна','1987-09-06' ,11),
--		(N'Ильиных',N'Никита',N'Евгеньич','1988-05-01' ,11),
--		(N'Курносов',N'Сергей',N'Сергеевич','2000-04-11' ,11),
--		(N'Мещеряков',N'Евгений',N'Александрович','2000-11-14' ,11),
--		(N'Стафеев',N'Данил',N'Вадимович','2003-04-11' ,11),
--		(N'Севрюк',N'Елизавета',N'Андреевна','2001-01-14' ,11),
--		(N'Зангиев',N'Константин',N'Робертович','1993-06-21' ,11),
--		(N'Леонтьева',N'Шарлотта',N'Владимировна','2006-02-23' ,11)
--		;
----------------------------------------------------

--SELECT 
--    group_name		AS N'Группа',
--	COUNT (*) AS N'Количество студентов'
--FROM Students, Groups
-- WHERE [group] = group_id
-- GROUP BY group_name
--;
----------------------------------------------------
--SELECT 
--    direction_name		AS N'Направление',
--	COUNT (*) AS N'Количество студентов'
--FROM Students, Groups, Directions
-- WHERE [group] = group_id AND direction = direction_id
-- GROUP BY direction_name
--;
----------------------------------------------------
SELECT
		last_name + ' ' + first_name + ' ' + middle_name	AS N'Студент',
		group_name		AS N'Группа',
		direction_name	AS N'Направление обучение'
FROM	Students,Groups,Directions
WHERE	[group]		=	group_id
AND		direction	=	direction_id
;