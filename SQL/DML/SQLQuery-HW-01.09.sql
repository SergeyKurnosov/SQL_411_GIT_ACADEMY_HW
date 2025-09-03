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
--		(N'�������',N'������',N'����������', '2006-09-18' ,11),
--		(N'��������',N'�����',N'������������','1987-09-16' ,11),
--		(N'�������',N'��������',N'������������','1987-09-06' ,11),
--		(N'�������',N'������',N'��������','1988-05-01' ,11),
--		(N'��������',N'������',N'���������','2000-04-11' ,11),
--		(N'���������',N'�������',N'�������������','2000-11-14' ,11),
--		(N'�������',N'�����',N'���������','2003-04-11' ,11),
--		(N'������',N'���������',N'���������','2001-01-14' ,11),
--		(N'�������',N'����������',N'����������','1993-06-21' ,11),
--		(N'���������',N'��������',N'������������','2006-02-23' ,11)
--		;
----------------------------------------------------

--SELECT 
--    group_name		AS N'������',
--	COUNT (*) AS N'���������� ���������'
--FROM Students, Groups
-- WHERE [group] = group_id
-- GROUP BY group_name
--;
----------------------------------------------------
--SELECT 
--    direction_name		AS N'�����������',
--	COUNT (*) AS N'���������� ���������'
--FROM Students, Groups, Directions
-- WHERE [group] = group_id AND direction = direction_id
-- GROUP BY direction_name
--;
----------------------------------------------------
SELECT
		last_name + ' ' + first_name + ' ' + middle_name	AS N'�������',
		group_name		AS N'������',
		direction_name	AS N'����������� ��������'
FROM	Students,Groups,Directions
WHERE	[group]		=	group_id
AND		direction	=	direction_id
;