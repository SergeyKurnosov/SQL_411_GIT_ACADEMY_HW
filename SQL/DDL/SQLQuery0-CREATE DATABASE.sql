CREATE DATABASE PD_411_SQL
ON		    -- параметр 'ON' задает свойства файла создаваемой базы 
(
   NAME			=	PD_411_SQL, -- Логическое имя файла
   FILENAME		=	'D:\Microsoft SQL Server\MSSQL14.MSSQLSERVER17\MSSQL\Data\PD_411_SQL.mdf', -- физическое имя файла
   SIZE			=	8MB,
   MAXSIZE		=	500MB,
   FILEGROWTH	=	5MB
)
LOG ON		--ЗАДАЕТ ПАРАМЕТР СВОЙСТВА файла журнала базы
(
   NAME			=	PD_411_SQL_Log,
   FILENAME		=	'D:\Microsoft SQL Server\MSSQL14.MSSQLSERVER17\MSSQL\Data\PD_411_SQL_log.ldf', 
   SIZE			=	8MB,
   MAXSIZE		=	500MB,
   FILEGROWTH	=	8MB
);
GO   -- Применить 