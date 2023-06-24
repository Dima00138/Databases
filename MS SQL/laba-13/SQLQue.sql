USE UNIVER;
GO
CREATE FUNCTION COUNT_STUDENTS(@faculty VARCHAR(20)) RETURNS INT
AS BEGIN DECLARE @rc INT = 0;
	SET @rc = (SELECT COUNT(STUDENT.IDSTUDENT)
				FROM STUDENT JOIN GROUPS
				ON STUDENT.IDGROUP = GROUPS.IDGROUP
				JOIN FACULTY
				ON GROUPS.FACULTY = FACULTY.FACULTY WHERE FACULTY.FACULTY = @faculty);
			RETURN @rc;
	END;
GO
DECLARE @f INT = dbo.COUNT_STUDENTS('ИТ');
PRINT CAST(@f AS VARCHAR(4));
GO
CREATE FUNCTION FSUBJECTS(@p VARCHAR(20)) RETURNS VARCHAR(300)
AS BEGIN
	DECLARE @tv CHAR(20), @t VARCHAR(300) = 'ДИСЦИПЛИНЫ: ';
	DECLARE ZKSUBJECTS CURSOR LOCAL
	FOR SELECT PULPIT FROM PULPIT WHERE PULPIT.FACULTY = @p;
	OPEN ZKSUBJECTS
		FETCH ZKSUBJECTS INTO @tv;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @t = @t + ', ' + rtrim(@tv);         
			FETCH  ZKSUBJECTS into @tv;
		END;
		CLOSE ZKSUBJECTS;
	RETURN @t;
END;
GO
SELECT PULPIT, dbo.FSUBJECTS(FACULTY) FROM PULPIT;
GO
CREATE FUNCTION FFACPUL(@f VARCHAR(10), @p VARCHAR(20)) RETURNS TABLE
AS RETURN
SELECT FACULTY.FACULTY, PULPIT.PULPIT FROM FACULTY LEFT OUTER JOIN PULPIT
								ON FACULTY.FACULTY = PULPIT.FACULTY
								WHERE FACULTY.FACULTY = ISNULL(@f, FACULTY.FACULTY)
								AND
									PULPIT.FACULTY = ISNULL(@p, PULPIT.FACULTY);
GO
SELECT * FROM dbo.FFACPUL('ИТ', NULL);
GO
CREATE FUNCTION FCTEACHER(@p VARCHAR(20)) RETURNS INT
AS BEGIN
	DECLARE @rc INT = (SELECT COUNT(*) FROM TEACHER
						WHERE	TEACHER.PULPIT = ISNULL(@p, TEACHER.PULPIT));
	RETURN @rc;
END;
GO
SELECT PULPIT, dbo.FCTEACHER(PULPIT) FROM PULPIT;
GO
CREATE FUNCTION COUNT_PULPIT(@f VARCHAR(20)) RETURNS INT
AS BEGIN DECLARE @rc INT = 0;
	SET @rc = (select count(PULPIT) from PULPIT where FACULTY = @f);
			RETURN @rc;
	END;
GO
CREATE FUNCTION COUNT_GROUP(@f VARCHAR(20)) RETURNS INT
AS BEGIN DECLARE @rc INT = 0;
	SET @rc = (select count(IDGROUP) from GROUPS where FACULTY = @f);
			RETURN @rc;
	END;
GO
CREATE FUNCTION COUNT_PROF(@f VARCHAR(20)) RETURNS INT
AS BEGIN DECLARE @rc INT = 0;
	SET @rc = (select count(PROFESSION) from PROFESSION where FACULTY = @f);
			RETURN @rc;
	END;
GO
create function FACULTY_REPORT(@c int) returns @fr table
	                        ( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
	                                                                 [Количество студентов] int, [Количество специальностей] int )
	as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                                                    where dbo.COUNT_STUDENTS(FACULTY) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  DBO.COUNT_PULPIT(@f),
	            DBO.COUNT_GROUP(@f),   dbo.COUNT_STUDENTS(@f),
	               DBO.COUNT_PROF(@f)); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;
