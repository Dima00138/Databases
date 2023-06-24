use tempdb;
/*EXEC sp_helpindex 'AUDITORIUM'
EXEC sp_helpindex 'AUDITORIUM_TYPE'
EXEC sp_helpindex 'FACULTY'
EXEC sp_helpindex 'GROUPS'
EXEC sp_helpindex 'PROFESSION'
EXEC sp_helpindex 'PROGRESS'
EXEC sp_helpindex 'PULPIT'
EXEC sp_helpindex 'STUDENT'
EXEC sp_helpindex 'SUBJECT'
EXEC sp_helpindex 'TEACHER'*/

/*CREATE TABLE #TIMETABLE
(
	TIND INT,
)*/

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш
--CREATE clustered index #TIMETABLE_CL on #TIMETABLE(TIND asc)

SET NOCOUNT ON;
DECLARE @i int = 0;
/*WHILE @i < 1000
BEGIN
	INSERT #TIMETABLE(TIND)
		VALUES (FLOOR(20000*RAND()));
	IF @i % 100 = 0 print @i;
	SET @i = @i + 1;
END;*/

/*CREATE TABLE #EX
(
	TKEY INT,
	CC INT IDENTITY(1, 1)
)

CREATE INDEX #EX_NONCLU ON #EX(TKEY, CC);
CREATE INDEX #EX_TKEY_X ON #EX(TKEY) INCLUDE(CC);
CREATE INDEX #EX_WHERE ON #EX(TKEY) WHERE (TKEY > 15000 AND TKEY < 20000)*/
--CREATE INDEX #EX_TKEY ON #EX(TKEY);

SET NOCOUNT ON;
SET @i = 0;
/*WHILE @i < 10000
BEGIN
	INSERT #EX(TKEY)
		VALUES(FLOOR(20000*RAND()));
		SET @i = @i + 1;
END;
SELECT * FROM #EX WHERE TKEY > 1000 AND CC < 4000
SELECT * FROM #EX WHERE TKEY = 14251 AND CC > 3
SELECT CC FROM #EX WHERE TKEY > 15000

SELECT TKEY from  #EX where TKEY between 5000 and 19999; 
SELECT TKEY from  #EX where TKEY>15000 and  TKEY < 20000  
SELECT TKEY from  #EX where TKEY=17000*/
/*WHILE @i < 100000
BEGIN
	INSERT #EX(TKEY)
		VALUES(FLOOR(20000*RAND()));
		SET @i = @i + 1;
END;*/

ALTER INDEX #EX_TKEY ON #EX REORGANIZE;
ALTER INDEX #EX_NONCLU ON #EX REBUILD WITH(ONLINE = OFF)
/*CREATE INDEX #EX_TKEY ON #EX(TKEY)
WITH (FILLFACTOR = 60);*/
SELECT TKEY, CC FROM #EX;

SELECT name [Индекс], avg_fragmentation_in_percent[Фрагментация в процентах]
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
	OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss
	JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
														WHERE name is not null;