USE UNIVER;
GO
SELECT * FROM TEACHER WHERE TEACHER.PULPIT LIKE '%ИСиТ%'
						FOR XML PATH('TEACHER'), ROOT('LIST_TEACHERS'), ELEMENTS;
SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM_CAPACITY
				FROM AUDITORIUM JOIN AUDITORIUM_TYPE
				ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
				WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE '%ЛК%'
				FOR XML AUTO, ROOT('AUDITORIUM_LIST'), ELEMENTS;
GO
DECLARE @h INT = 0;
DECLARE @xm VARCHAR(2000) = N'<?xml version= "1.0" encoding = "windows-1251" ?>
							<ROOT>
								<subj SUBJECT="DB" SUBJECT_NAME="DATABASE" PULPIT="ISIT" />
								<subj SUBJECT="DB2" SUBJECT_NAME="DATABASE2" PULPIT="ISIT" />
								<subj SUBJECT="DB3" SUBJECT_NAME="DATABASE3" PULPIT="ISIT" />
							</ROOT>';
exec sp_xml_preparedocument @h output, @xm;
SELECT [SUBJECT],[SUBJECT_NAME],[PULPIT] FROM OPENXML(@h, '/ROOT/subj', 0)
	WITH ([SUBJECT] NVARCHAR(10), [SUBJECT_NAME] NVARCHAR(100), [PULPIT] NVARCHAR(20))
EXEC SP_XML_REMOVEDOCUMENT @h;
GO
CREATE TABLE #PASSPORT 
(
NAME VARCHAR(100),
SERIYA CHAR(2),
NUMBERP VARCHAR(10) PRIMARY KEY,
ADDRESSP XML
)
/*INSERT INTO #PASSPORT(NAME, SERIYA, NUMBERP, ADDRESSP)
VALUES ('N1', 'BD', '2323232', '<ADDRESSP><COUNTRY>BEL</COUNTRY><CITY>Z</CITY></ADDRESSP>')*/
UPDATE #PASSPORT
SET NUMBERP = '222222' WHERE NUMBERP = '2323232';
SELECT SERIYA, 
NUMBERP,
ADDRESSP.value('(/ADDRESSP/COUNTRY)[1]', 'VARCHAR(10)')[COUNTRY],
ADDRESSP.query('/ADDRESSP')[ADDRESS]
FROM #PASSPORT;
GO
drop xml schema collection STUDENT;

CREATE XML SCHEMA COLLECTION STUDENT1 AS
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault = "unqualified"
elementFormDefault="qualified"
xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="Контактная_информация">
<xs:complexType>
<xs:sequence>
<xs:element name="Паспортные_данные" maxOccurs="1" minOccurs="1">
<xs:complexType>
<xs:sequence>
<xs:element name="Серия" type="xs:string"/>
<xs:element name="Номер_паспорта" type="xs:integer"/>
<xs:element name="Дата_выдачи" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
<xs:element name="Адрес">
<xs:complexType>
<xs:sequence>
<xs:element name="Страна" type="xs:string"/>
<xs:element name="Город" type="xs:string"/>
<xs:element name="Улица" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:schema>';

alter table STUDENT ALTER COLUMN INFO xml(STUDENT1)

insert STUDENT(IDGROUP, NAME, BDAY, INFO)
values(51, N'Пекарев Ефросий Евгеньевич', cast('30-08-2002' as date), 
N'<Контактная_информация>
<Паспортные_данные>
<Серия>МР</Серия>
<Номер_паспорта>8974521</Номер_паспорта>
<Дата_выдачи>2018.04.04
</Дата_выдачи>
</Паспортные_данные>
<Адрес>
<Страна>Россия</Страна>
<Город>Урюпинск</Город>
<Улица>Ленина</Улица>
</Адрес>
</Контактная_информация>')

select * from STUDENT

insert STUDENT(IDGROUP, NAME, BDAY, INFO)
values(51, N'Беков Магомед Иванович', cast('06-07-1999' as date), 
N'<Контактная_информация>
<Паспортные_данные>
<Серия>МР</Серия>
<Номер_паспорта>6712817</Номер_паспорта>
<Дата_выдачи>2015.09.09
</Дата_выдачи>
</Паспортные_данные>
<Паспортные_данные>
<Серия>МР</Серия>
</Паспортные_данные>
<Адрес>
<Страна>Россия</Страна>
<Город>Уфа</Город>
<Улица>Валеева</Улица>
</Адрес>
</Контактная_информация>')