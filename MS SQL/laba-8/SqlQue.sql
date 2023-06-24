USE UNIVER;
GO
DECLARE @c char = 'c',
		@v varchar(4) = 'vcha',
		@dt datetime,
		@t time,
		@i int,
		@s smallint,
		@ti tinyint,
		@n numeric(12, 5);
SET @dt = GETDATE();
SET @t = GETDATE();
SELECT @i = (SELECT COUNT(*) FROM AUDITORIUM)
SELECT @s = (SELECT COUNT(*) FROM STUDENT)
SELECT @ti = (SELECT COUNT(*) FROM PROFESSION)
SELECT @c c, @v v, @dt dt, @t t
PRINT'i = ' + CAST(@i AS nvarchar(12));
PRINT's = ' + CAST(@s AS nvarchar(12));
PRINT'ti = ' + CAST(@ti AS nvarchar(12));
PRINT'n = ' + CAST(@n AS nvarchar(12));
GO
DECLARE @capacity int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM),
		@count int,
		@avg numeric(8,4),
		@count_less int,
		@per numeric(4,2);
IF @capacity >= 200
	BEGIN
		SET @count = (SELECT COUNT(*) FROM AUDITORIUM)
		SET @avg = (SELECT AVG(AUDITORIUM_CAPACITY) FROM AUDITORIUM)
		SET @count_less = (SELECT COUNT(*) FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY < @avg)
		SET @per = (CAST(@count_less as numeric(4,2)) / CAST(@count as numeric(4,2))) * 100
		SELECT @count 'Количество аудиторий', @avg 'Средняя вместимость', @count_less 'Количество аудиторий, меньших средней',
				@per 'Процент аудиторий, меньших средней';
	END
ELSE
	SELECT @capacity 'Общая вместимость';

--3 глобальные переменные
print 'Число обработанных строк:';
print @@ROWCOUNT;
print 'Версия SQL Server:';
print @@VERSION;
print 'Системный идентификатор процесса:';
print @@SPID;
print 'Код последней ошибки:';
print @@ERROR;
print 'Имя сервера:';
print @@SERVERNAME;
print 'Уровень вложенности транзакции:';
print @@TRANCOUNT;
print 'Проверка результата считывания строк результирующего набора:';
print @@FETCH_STATUS;
print 'Уровень вложенности текущей процедуры:';
print @@NESTLEVEL;

--уравнение 
declare @z float, @t float = 3.58, @x float = 5.23;

if (@t > @x) set @z = POWER(sin(@t),2);
if (@t < @x) set @z = (4 * (@t + @x));
if (@t = @x) set @z = (1 - exp(@x - 2));

print 'z = ' + cast(@z as varchar(10));

-- ФИО 
declare @fio varchar(70) = 'Тимошенко Дмитрий Валерьевич';
declare @short_fio varchar(30) = substring(@fio, 1, charindex(' ', @fio))
		+ substring(@fio, charindex(' ', @fio) + 1, 1) + '.'
		+ substring(@fio, charindex(' ', @fio, charindex(' ', @fio) + 1) + 1, 1) + '.';

print 'Полное имя: ' + @fio;
print 'Сокращенное имя: ' + @short_fio;


--поиск по др в следующем месяце
select STUDENT.NAME as 'Имя студента', STUDENT.BDAY as 'Дата рождения', (datediff(year, STUDENT.BDAY, getdate())) as 'Возраст'
from STUDENT
where month(STUDENT.BDAY) = (month(getdate()) + 1)

--5 конструкция IF… ELSE 
if ((select count(*) from AUDITORIUM) > 10)
	print 'Имеется больше 10 аудиторий';
else 
	print 'Имеется меньше аудиторий';

--6 с помощью CASE анализируются оценки, полученные студентами некоторого факультета при сдаче экзаменов.
select case
	when PROGRESS.NOTE between 8 and 10 then 'высокая'
	when PROGRESS.NOTE between 5 and 7 then 'средняя'
	when PROGRESS.NOTE = 4 then 'низкая'
	else 'не удовлетворительная'
	end Оценка, count(*) 'Количество'
from PROGRESS, STUDENT, GROUPS
where PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	and STUDENT.IDGROUP = GROUPS.IDGROUP
	and GROUPS.FACULTY = 'ТОВ'
group by case
	when PROGRESS.NOTE between 8 and 10 then 'высокая'
	when PROGRESS.NOTE between 5 and 7 then 'средняя'
	when PROGRESS.NOTE = 4 then 'низкая'
	else 'не удовлетворительная'
	end

--7 временная лок таблица
drop table #EXPLRE
create table #EXPLRE
(	id int not null,
	name varchar(10) not null,
	year int not null
);

set nocount on;
declare @i int = 0;
while @i < 10
	begin 
insert #EXPLRE (id, name, year)
	values (@i, ('student' + cast(@i as varchar(2))), cast(((2021 * @i)-500)as int));
set @i = @i + 1;
end;

select * from #EXPLRE;

--8 оператор return
declare @xx int = 0;
while @xx < 10
	begin
	print 'x = ' + cast(@xx as varchar(5));
	if (@xx = 5) return;
	set @xx = @xx + 1;
	end;
go

--9 ошибки
begin try
	insert into #EXPLRE values (null, null, null);
	end try
begin catch
	print 'ERROR_NUMBER: ' + CONVERT(varchar, ERROR_NUMBER());
	print 'ERROR_MESSAGE: ' + ERROR_MESSAGE();
	print 'ERROR_LINE: ' + CONVERT(varchar, ERROR_LINE());
	print 'ERROR_PROCEDURE: ' + CONVERT(varchar, ERROR_PROCEDURE());
	print 'ERROR_SEVERITY: ' + CONVERT(varchar, ERROR_SEVERITY());
	print 'ERROR_STATE: ' + CONVERT(varchar, ERROR_STATE());
end catch