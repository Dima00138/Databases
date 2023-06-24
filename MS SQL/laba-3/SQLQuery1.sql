USE master;
CREATE database T_MyBase
ON PRIMARY
(name=N'T_MyBase_mdf', filename=N'D:\ПОИБМС-7\БД\laba-3\T_MyBase_mdf.mdf',
	size=10240Kb, maxsize=unlimited, filegrowth=1024Kb),
(name=N'T_MyBase_ndf', filename=N'D:\ПОИБМС-7\БД\laba-3\T_MyBase_ndf.ndf',
	size=10240Kb, maxsize=1Gb, filegrowth=5%),
filegroup FG1
(name=N'T_MyBase_fg1_1', filename=N'D:\ПОИБМС-7\БД\laba-3\T_MyBase_fg1_1.ndf',
	size=10240Kb, maxsize=1Gb, filegrowth=5%),
(name=N'T_MyBase_fg1_2', filename=N'D:\ПОИБМС-7\БД\laba-3\T_MyBase_fg1_2.ndf',
	size=10240Kb, maxsize=1Gb, filegrowth=5%)
log on 
(name=N'T_MyBase_log', filename=N'D:\ПОИБМС-7\БД\laba-3\T_MyBase_log.ldf',
	size=10240Kb, maxsize=1Gb, filegrowth=10%)
go
use T_MyBase;
CREATE TABLE Работник
(
	Фамилия_работника nvarchar (50) NOT NULL primary key,
	Имя_работника nvarchar(50) NULL,
	Отчество_работника nvarchar(50) NULL,
	Телефон_работника nvarchar(20) NULL,
	Адрес nvarchar(50) NULL,
	Стаж real NULL
	)on FG1;
	CREATE TABLE Детали(
	Номер_детали int NOT NULL primary key,
	Количество_деталей int NULL,
	Признак_сложности int NULL
	)on FG1;
CREATE TABLE Операции(
	Наименование_операции nvarchar(50) NOT NULL primary key,
	Номер_детали int NOT NULL foreign key references Детали(Номер_детали)
	) on FG1;
CREATE TABLE Учет_выполненной_работы (
	Номер_операции int NOT NULL primary key,
	Наименование_операции nvarchar(50) NULL foreign key references Операции(Наименование_операции),
	Фамилия_работника nvarchar(50) NULL foreign key references Работник(Фамилия_работника),
	Дата date NULL,
	)on FG1;
	go
ALTER TABLE Учет_выполненной_работы ADD Сделана nvarchar(20) default'да' NULL;
INSERT INTO Работник (Фамилия_работника, Имя_работника, Отчество_работника, Телефон_работника, Адрес, Стаж)
	VALUES ('r1', 'n1', 'o1', 1, 'sjnd', 2),
			('r2', 'n1', 'o1', 2, 'dff', 4),
			('r3', 'n2', 'o3', 3, 'dfdfsdd', 1);
INSERT INTO Детали (Номер_детали, Количество_деталей, Признак_сложности)
	VALUES (1, 12, 4),
			(2, 13, 6);
INSERT INTO Операции (Наименование_операции, Номер_детали)
	VALUES ('op1', 1),
			('op2', 2);
INSERT INTO Учет_выполненной_работы (Номер_операции, Наименование_операции, Фамилия_работника, Дата)
	VALUES (1, 'op1', 'r1', '2022-11-11'),
			(2, 'op2', 'r2', '2022-12-11');
go

SELECT Фамилия_работника, Стаж FROM Работник GROUP BY Фамилия_работника, Стаж;
SELECT count(*)[Кол-во записей] FROM Работник;
SELECT Distinct Top(3) Имя_работника, Отчество_работника FROM Работник ORDER BY Имя_работника DESC;
UPDATE Детали set Признак_сложности=Признак_сложности+2;
SELECT * FROM Детали WHERE Номер_детали=1 OR Номер_детали=2 AND Количество_деталей=13;
