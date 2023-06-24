USE master;
CREATE database T_MyBase
ON PRIMARY
(name=N'T_MyBase_mdf', filename=N'D:\������-7\��\laba-3\T_MyBase_mdf.mdf',
	size=10240Kb, maxsize=unlimited, filegrowth=1024Kb),
(name=N'T_MyBase_ndf', filename=N'D:\������-7\��\laba-3\T_MyBase_ndf.ndf',
	size=10240Kb, maxsize=1Gb, filegrowth=5%),
filegroup FG1
(name=N'T_MyBase_fg1_1', filename=N'D:\������-7\��\laba-3\T_MyBase_fg1_1.ndf',
	size=10240Kb, maxsize=1Gb, filegrowth=5%),
(name=N'T_MyBase_fg1_2', filename=N'D:\������-7\��\laba-3\T_MyBase_fg1_2.ndf',
	size=10240Kb, maxsize=1Gb, filegrowth=5%)
log on 
(name=N'T_MyBase_log', filename=N'D:\������-7\��\laba-3\T_MyBase_log.ldf',
	size=10240Kb, maxsize=1Gb, filegrowth=10%)
go
use T_MyBase;
CREATE TABLE ��������
(
	�������_��������� nvarchar (50) NOT NULL primary key,
	���_��������� nvarchar(50) NULL,
	��������_��������� nvarchar(50) NULL,
	�������_��������� nvarchar(20) NULL,
	����� nvarchar(50) NULL,
	���� real NULL
	)on FG1;
	CREATE TABLE ������(
	�����_������ int NOT NULL primary key,
	����������_������� int NULL,
	�������_��������� int NULL
	)on FG1;
CREATE TABLE ��������(
	������������_�������� nvarchar(50) NOT NULL primary key,
	�����_������ int NOT NULL foreign key references ������(�����_������)
	) on FG1;
CREATE TABLE ����_�����������_������ (
	�����_�������� int NOT NULL primary key,
	������������_�������� nvarchar(50) NULL foreign key references ��������(������������_��������),
	�������_��������� nvarchar(50) NULL foreign key references ��������(�������_���������),
	���� date NULL,
	)on FG1;
	go
ALTER TABLE ����_�����������_������ ADD ������� nvarchar(20) default'��' NULL;
INSERT INTO �������� (�������_���������, ���_���������, ��������_���������, �������_���������, �����, ����)
	VALUES ('r1', 'n1', 'o1', 1, 'sjnd', 2),
			('r2', 'n1', 'o1', 2, 'dff', 4),
			('r3', 'n2', 'o3', 3, 'dfdfsdd', 1);
INSERT INTO ������ (�����_������, ����������_�������, �������_���������)
	VALUES (1, 12, 4),
			(2, 13, 6);
INSERT INTO �������� (������������_��������, �����_������)
	VALUES ('op1', 1),
			('op2', 2);
INSERT INTO ����_�����������_������ (�����_��������, ������������_��������, �������_���������, ����)
	VALUES (1, 'op1', 'r1', '2022-11-11'),
			(2, 'op2', 'r2', '2022-12-11');
go

SELECT �������_���������, ���� FROM �������� GROUP BY �������_���������, ����;
SELECT count(*)[���-�� �������] FROM ��������;
SELECT Distinct Top(3) ���_���������, ��������_��������� FROM �������� ORDER BY ���_��������� DESC;
UPDATE ������ set �������_���������=�������_���������+2;
SELECT * FROM ������ WHERE �����_������=1 OR �����_������=2 AND ����������_�������=13;
