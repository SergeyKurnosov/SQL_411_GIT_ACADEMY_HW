CREATE DATABASE PD_411_SQL
ON		    -- �������� 'ON' ������ �������� ����� ����������� ���� 
(
   NAME			=	PD_411_SQL, -- ���������� ��� �����
   FILENAME		=	'D:\Microsoft SQL Server\MSSQL14.MSSQLSERVER17\MSSQL\Data\PD_411_SQL.mdf', -- ���������� ��� �����
   SIZE			=	8MB,
   MAXSIZE		=	500MB,
   FILEGROWTH	=	5MB
)
LOG ON		--������ �������� �������� ����� ������� ����
(
   NAME			=	PD_411_SQL_Log,
   FILENAME		=	'D:\Microsoft SQL Server\MSSQL14.MSSQLSERVER17\MSSQL\Data\PD_411_SQL_log.ldf', 
   SIZE			=	8MB,
   MAXSIZE		=	500MB,
   FILEGROWTH	=	8MB
);
GO   -- ��������� 