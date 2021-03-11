if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO


-- t1 CPU_Socket
-- t2 Processor
-- t3 Motherboard_And_CPU_Kits
-- v1 View CPU_Socket
-- v2 View Motherboard and Processor
-- v3 Producer and Processor


insert into Tests (Name)
values ('First Test')

insert into Tables (name) values
	('CPU_Socket'),
	('Processor'),
	('Motherboard_And_CPU_Kits'),
	('Motherboard')

	
insert into TestTables (TestID, TableID, NoOfRows, Position) values 
	(1,1,1000,4),
	(1,2,1000,2),
	(1,3,1000,1),
	(1,4,1000,3)

insert into Views values
 ('view_socket'),
 ('view_motherboard_processor'),
 ('view_processor_producer')

insert into TestViews values
	(1,1),
	(1,2),
	(1,3)

delete from Motherboard_And_CPU_Kits
--where cpu_id > 9
delete from Processor
--where cpu_id > 9
delete from Motherboard
--where m_id > 9
delete from CPU_Socket
--where socket_type like 'test%'

--print(concat('test',convert(varchar(5), @count)))
--print(rand(900))


insert into CPU_Socket
values ('lga1155','20001030',3,4),
('lga1150','20011030',4,4),
('lga1160','20101030',5,4),
('socket 1','20021030',3,7),
('socket 2','20031030',6,4)

insert into Processor
values (1,'20121030', 'lga1155', 2.4, 3.3, 'Intel'),
(2,'20071030', 'lga1150', 1.4, 2.5, 'Intel'),
(3,'20081030', 'lga1155', 3.4, 4.3, 'Intel'),
(4,'20061030', 'socket 2', 2.4, 4.3, 'AMD'),
(5,'20081030', 'socket 1', 3.4, 4.3, 'AMD')

insert into Motherboard
values (1,'20121030', 'B450',2, 'lga1150'),
(2,'20071030', 'B455', 1, 'lga1160'),
(3,'20081030', 'B350', 3,'lga1155'),
(4,'20061030', 'B400', 4,'socket 1'),
(5,'20081030', 'B650', 4, 'socket 2')

insert into Motherboard_And_CPU_Kits
values (1,2,10),
(3,1,20),
(3,3,12),
(4,5,13),
(5,4,213)


declare @count int = 1000;
while @count > 0
begin
	insert into CPU_Socket values (concat('test',convert(varchar(5), @count)), '20201030', floor(rand(@count*10000)*1000 + 1000),floor(rand(@count*10000)*1000))
	insert into Processor values (@count + 10, '20201030', concat('test',convert(varchar(5), @count)),rand(@count*1000),rand(@count*1000), 'AMD')
	insert into Motherboard values (@count + 10, '20201030', 'B550',floor(rand(@count*1000)*10),concat('test',convert(varchar(5), @count)))
	insert into Motherboard_And_CPU_Kits values (@count + 10, @count + 10, floor(rand(@count*10000)*1000))
	set @count = @count - 1;
end

select * from CPU_Socket
select * from Processor
select * from Motherboard
select * from Motherboard_And_CPU_Kits
go

--print convert(int,convert(time,sysdatetime()))


--insert into ' + @TableName + '
--select *
--from ' + @copy + '
--except (
--	select top ((select count(*) from ' + @copy + ') - 10) *
--	from ' + @copy + '
--)

create or alter view view_socket as
select * , length_mm * width_mm as surface_area
from CPU_Socket
go

create or alter view view_motherboard_processor as
select Motherboard.*, Processor.producer
from Motherboard
join Processor on 
Motherboard.socket_type = Processor.socket_type
go

create or alter view view_processor_producer as
select Processor.release_date, count(Processor.release_date) as 'Count'
from Producer
join Processor on Producer.producer_name = Processor.producer
group by release_date
go

select * from view_socket
select * from view_motherboard_processor
select * from view_processor_producer

--drop table cop

--select *
--into cop
--from Motherboard_And_CPU_Kits

--delete from Motherboard_And_CPU_Kits

--insert into Motherboard_And_CPU_Kits
--select top 5 * 
--from cop

select top (( select count (*) from Motherboard_And_CPU_Kits) - 100) * from Motherboard_And_CPU_Kits

--select * from Motherboard


--select *
--from CPU_Socket
--except (
--	select top ((select count(*) from CPU_Socket) - 100) *
--	from CPU_Socket
--)

--select *
--from Processor
--except (
--	select top ((select count(*) from Processor) - 100) *
--	from Processor
--)

--select *
--from Motherboard_And_CPU_Kits
--except (
--	select top ((select count(*) from Motherboard_And_CPU_Kits) - 100) *
--	from Motherboard_And_CPU_Kits
--)


--select *
--				into Motherboard_And_CPU_Kits_copy
--				from Motherboard_And_CPU_Kits
--				except (
--					select top ((select count(*) from Motherboard_And_CPU_Kits) - 100) *
--					from Motherboard_And_CPU_Kits
--				)

--				delete from Motherboard_And_CPU_Kits
--				where exists (
--					select top ((select count(*) from Motherboard_And_CPU_Kits) - 100) *
--					from Motherboard_And_CPU_Kits
--				)