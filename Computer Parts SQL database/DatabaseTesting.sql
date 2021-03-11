create or alter procedure spExecuteTest @TestID int 
as
	-- begin a new test
	insert into TestRuns values ('First Test', getdate(), getdate())
	declare @TestRunID int = (
		select Max(TestRunID)
		from TestRuns
	);
	
	-- get the IDs
	declare @TableID int
	
	declare table_cursor cursor for
	select TableID
	from TestTables
	where TestID = @TestID
	order by Position asc

	open table_cursor
		fetch next from table_cursor into @TableID
		--print @TableID
		while @@FETCH_STATUS = 0
			begin
		
				-- save the rows 
				declare @TableName nvarchar(50) = (
					select Name
					from Tables
					where TableID = @TableID
				)

				--print @TableName

				-- get the numbe of rows that we work with
				declare @NumberOfRows int = (
					select NoOfRows
					from TestTables
					where TestTables.TestID = @TestID and  TableID = @TableID 
				)

				declare @copy nvarchar(100) = @TableName + '_copy'
				declare @save_rows_sql nvarchar(1000) = '
					select *
					into  ' + @copy + '
					from ' + @TableName + '

					delete from ' + @TableName +'
				'
					--select top ((select count(*) from ' + @copy + ') - ' + convert(nvarchar(10),@NumberOfRows) + ') * from ' + @copy + '

					--insert into ' + @TableName + '
					--select top (( select count (*) from ' + @copy + ') - 100) *
					--from ' + @copy + ''

				print @save_rows_sql

				--select *
				--into ' + @copy + '
				--from ' + @TableName + '
				--except (
				--	select top ((select count(*) from ' + @TableName + ') - ' + convert(nvarchar(10),@NumberOfRows) + ') *
				--	from ' + @TableName + '
				--)'
				--declare @delete_rows nvarchar(1000) = '
				--delete from ' + @TableName + '
				--except (
				--	select top ((select count(*) from ' + @TableName + ') - ' + convert(nvarchar(10),@NumberOfRows) + ') *
				--	from ' + @TableName + 
				--')'
				--print @delete_rows

				execute sp_executesql @save_rows_sql

				fetch next from table_cursor into @TableID
				--print @TableID
			end
	close table_cursor

	deallocate table_cursor

	declare table_insert cursor for
	select TableID
	from TestTables
	where TestID = @TableID
	order by Position desc

	open table_insert
		fetch next from table_insert into @TableID
		while @@FETCH_STATUS = 0
			begin
		
				set @TableName = (
					select Name
					from Tables
					where TableID = @TableID
				)
				set @NumberOfRows = (
					select NoOfRows
					from TestTables
					where TestTables.TestID = @TestID and  TableID = @TableID 
				)

				set @copy = @TableName + '_copy'
				
				declare @insert_sql_old nvarchar (1000) = '
					insert into ' + @TableName + '
					select top ((select count(*) from ' + @copy + ') - ' + convert(nvarchar(10),@NumberOfRows) + ') * from ' + @copy + '
				'
				--	insert into ' + @TableName + '
				--	select top ((select count(*) from ' + @copy + ') - ' + convert(nvarchar(10),@NumberOfRows) + ') *
				--	from ' + @copy + '
				--'
				execute sp_executesql @insert_sql_old

				--print @insert_sql_old


				-- begin a new insert test
				insert into TestRunTables values (@TestRunID, @TableID, getdate(), getdate())
				declare @insert_sql nvarchar (1000) = '
				insert into ' + @TableName + '
				select *
				from ' + @copy + '
				except (
					select top ((select count(*) from ' + @copy + ') - ' + convert(nvarchar(10),@NumberOfRows) + ') *
					from ' + @copy + '
				)'

				print @insert_sql
				
				execute sp_executesql @insert_sql
				declare @drop nvarchar(1000) = 'drop table ' + @copy
				execute sp_executesql @drop

				update TestRunTables
				set EndAt = sysdatetime()
				where TestRunID = @TestRunID and TableID = @TableID



				fetch next from table_insert into @TableID
			end



	close table_insert

	deallocate table_insert

	declare @ViewID int
	declare views_test cursor for
	select ViewID
	from TestViews

	open views_test
	fetch next from views_test into @ViewID
	while @@FETCH_STATUS = 0
	begin
		
		insert into TestRunViews values (@TestRunID, @ViewID, SYSDATETIME(),SYSDATETIME())

		declare @ViewName nvarchar(100) = (
			select Name
			from Views
			where ViewID = @ViewID
		)

		declare @view_sql nvarchar(500) = ' 
		select *
		from ' + @ViewName + '
		'
		execute sp_executesql @view_sql;

		update TestRunViews
		set EndAt = SYSDATETIME()
		where TestRunID = @TestRunID and ViewID = @ViewID

		fetch next from views_test into @ViewID
	end
	close views_test
	deallocate views_test

	-- prepare the tables
	-- delete from the tables
	--delete from CPU_Socket
	--where socket_type not in (
	--	select TOP ( (select Count(*) from CPU_Socket) - @NumberOfRows) socket_type
	--	from CPU_Socket
	--)


	-- finished table test
	update TestRuns
	set EndAt = sysdatetime()
	where TestRunID = @TestRunID 

	--begin views tests


go

exec spExecuteTest @TestID = 1

select * from Tests
select * from Tables
select * from TestTables
select * from Views
select * from TestViews

select * from TestRuns
select * from TestRunTables
select * from TestRunViews
go


--drop table Motherboard_And_CPU_Kits_copy
--drop table Motherboard_copy
--drop table Processor_copy
--drop table CPU_Socket_copy