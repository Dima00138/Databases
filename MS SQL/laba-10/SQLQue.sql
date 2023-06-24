USE UNIVER;

DECLARE @tv char(40);
DECLARE DISCISIT CURSOR
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT
								WHERE PULPIT LIKE '%����%'
OPEN DISCISIT;
FETCH DISCISIT INTO @tv;
PRINT '���������� �� ����';
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @tv;
		FETCH DISCISIT INTO @tv;
	END;
CLOSE DISCISIT;
go
DECLARE @tv char(40);
DECLARE DISCIS CURSOR LOCAL
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT
								WHERE PULPIT LIKE '%����%'
OPEN DISCIS;
FETCH DISCIS INTO @tv;
PRINT 'LOCAL CURSOR DISCIPL';
PRINT '1. ' + @tv;
GO
DECLARE @tv char(40);
FETCH DISCIS INTO @tv;
PRINT '2. ' + @tv;
GO
DECLARE @tv char(40);
DECLARE DISCIS CURSOR GLOBAL
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT
								WHERE PULPIT LIKE '%����%'
OPEN DISCIS;
FETCH DISCIS INTO @tv;
PRINT 'GLOBAL CURSOR DISCIPL';
PRINT '1. ' + @tv;
GO
DECLARE @tv char(40);
FETCH DISCIS INTO @tv;
PRINT '2. ' + @tv;
CLOSE DISCIS;
DEALLOCATE DISCIS;
GO
DECLARE @tv char(40);
FETCH DISCIS INTO @tv;
PRINT '2. ' + @tv;
GO
DECLARE @tv char(40);
DECLARE DISCIS CURSOR LOCAL STATIC
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT
								WHERE PULPIT LIKE '%����%'
OPEN DISCIS;
UPDATE SUBJECT SET SUBJECT_NAME = '���� ������' WHERE SUBJECT_NAME LIKE '%���� ������12%';
FETCH DISCIS INTO @tv;
PRINT 'LOCAL STATIC CURSOR DISCIPL';
PRINT '1. ' + @tv;
FETCH DISCIS INTO @tv;
PRINT '2. ' + @tv;
CLOSE DISCIS;
GO
DECLARE @tv char(40);
DECLARE DISCIS CURSOR LOCAL DYNAMIC
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT
								WHERE PULPIT LIKE '%����%'
OPEN DISCIS;
UPDATE SUBJECT SET SUBJECT_NAME = '���� ������12' WHERE SUBJECT_NAME LIKE '%���� ������%';
FETCH DISCIS INTO @tv;
PRINT 'LOCAL DYNAMIC CURSOR DISCIPL';
PRINT '1. ' + @tv;
FETCH DISCIS INTO @tv;
PRINT '2. ' + @tv;
CLOSE DISCIS;
GO
DECLARE @tv char(40);
DECLARE DISCIS CURSOR LOCAL SCROLL
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT
								WHERE PULPIT LIKE '%����%'
OPEN DISCIS;
FETCH DISCIS INTO @tv;
PRINT 'LOCAL CURSOR DISCIPL WITH NAVIGATION';
PRINT '1. ' + @tv;
FETCH LAST FROM DISCIS INTO @tv;
PRINT 'LAST. ' + @tv;
GO
GO
DECLARE @tv char(40);
DECLARE DISCIS CURSOR LOCAL DYNAMIC
					FOR SELECT SUBJECT.SUBJECT_NAME FROM SUBJECT FOR UPDATE;
OPEN DISCIS;
FETCH DISCIS INTO @tv;
PRINT 'LOCAL CURSOR DISCIPL WITH UPDATE';
PRINT '1. ' + @tv;
FETCH DISCIS INTO @tv;
UPDATE SUBJECT SET SUBJECT_NAME = '������ ��������� ����+1' WHERE CURRENT OF DISCIS;
PRINT '2. ' + @tv;
GO
DECLARE @nt char(40), @is char(40);
DECLARE OTCHI CURSOR LOCAL DYNAMIC
					FOR SELECT PROGRESS.NOTE, STUDENT.IDSTUDENT  FROM PROGRESS
					JOIN STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT FOR UPDATE;
OPEN OTCHI;
FETCH OTCHI INTO @nt, @is;
PRINT 'SIX QUEST';
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @nt <= 4
			BEGIN
			PRINT @nt + '  ' + @is;
				DELETE PROGRESS WHERE IDSTUDENT = @is AND PROGRESS.NOTE = @nt;
				DELETE STUDENT WHERE STUDENT.IDSTUDENT = @is;
			END;
		FETCH OTCHI INTO @nt, @is;
	END;
