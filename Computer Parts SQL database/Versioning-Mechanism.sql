
create procedure Update1 
as
	alter table Keyboard
	alter column key_type nvarchar(50)
go

create procedure Downgrade1
as
	alter table Keyboard
	alter column key_type varchar(30)
go

create procedure Update2
as
	alter table SSD
	add Producer varchar(30)
go

-- drop procedure Update2

create procedure Downgrade2
as
	alter table SSD
	drop column Producer
go

create or alter procedure Update3
as
	alter table SSD
	add constraint default_producer
	default 'Unknown' for Producer
	update SSD
	set SSD.Producer = 'Unknown' 
	where SSD.Producer is NULL
go

insert into SSD (ssd_id,release_date,capacity_GB,max_read,max_write,connection_type) 
values (6,'19901030',8,128,64,'Sata')
go

create procedure Downgrade3
as
	alter table SSD
	drop constraint default_producer
go

--sp_rename 'HDD.PK__HDD__55E1E51AC37AC60F', 'PK_HDD_ID';
--go

create procedure Update4
as
	alter table Storage_Bundle
	drop constraint storage_bundle_id
go

create procedure Downgrade4
as
	alter table Storage_Bundle
	add constraint storage_bundle_id
	primary key (ram_id, hdd_id, ssd_id)
go

--drop procedure Update4
--drop procedure Downgrade4
--go

create procedure Update5
as
	alter table Keyboard
	add Serial_Number nvarchar(50)
go

create procedure Downgrade5
as
	alter table Keyboard
	drop column Serial_Number
go

create or alter procedure Update6
as
	alter table SSD
	add constraint FK_ssd_producer
	foreign key (Producer) references Producer (producer_name)
go

create procedure Downgrade6
as
	alter table SSD
	drop constraint FK_ssd_producer
go

create or alter procedure Update7
as
	create table Mouse_Pad(
		pad_id int primary key identity(1,1),
		length_cm decimal (5,2),
		width_cm decimal (5,2),
		color nvarchar(20),
		rbg bit default 0
	)
	insert into Mouse_Pad (length_cm,width_cm,color,rbg)
	values (12.3,54.45,'black',1),
			(14.3,21.32,'red',0)
go

create or alter procedure Downgrade7
as
	drop table Mouse_Pad
go

exec Update1
exec Update2
exec Update3
exec Update4
exec Update5
exec Update6
exec Update7

select * 
from Keyboard

select * 
from SSD


select* 
from Producer

select * 
from Mouse_Pad

--insert into Producer (producer_name, creation_date, primary_location)
--values ('Unknown','19000101','Nowhere')

select *
from Storage_Bundle

exec Downgrade7
exec Downgrade6
exec Downgrade5
exec Downgrade4
exec Downgrade3
exec Downgrade2
exec Downgrade1

go
--drop table Version_Status

create table Version_Status (
	version_number int
)

insert Version_Status values (0)

select * from Version_Status
go

create or alter procedure change_version @version int
as
	declare @current_version int;
	select  @current_version = version_number
	from Version_Status

	--print @current_version

	declare @sql_update nvarchar(256);
	declare @sql_string nvarchar(256);
	declare @sql_downgrade nvarchar(256);
	set @sql_update = N'exec Update';
	set @sql_downgrade = N'exec Downgrade';


	while @current_version < @version
		begin
			set @current_version = @current_version + 1
			set @sql_string = CONCAT(@sql_update,@current_version);
			print @sql_string

			
			execute sp_executesql @sql_string;

		end

	while @current_version > @version
		begin
			set @sql_string = CONCAT(@sql_downgrade,@current_version);
			print @sql_string

			execute sp_executesql @sql_string;
			
			set @current_version = @current_version - 1

		end

	
	update Version_Status
	set version_number = @version
go

exec change_version @version = 1;
select * from Version_Status

