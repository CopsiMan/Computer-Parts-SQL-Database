use ComputerPartsWharehouseManagement
go

drop table Tc
drop table Tb
drop table Ta

create table Ta (
	aid int primary key,
	a2 int unique
)

create table Tb (
	bid int primary key,
	b2 int
)

create table Tc (
	cid int primary key,
	aid int foreign key references Ta(aid),
	bid int foreign key references Tb(bid)
)

delete from Ta
delete from Tb
delete from Tc

declare @count int = 1000;
declare @i int = 0;
while @count > @i
begin
	insert into Ta values (@i, @i * 2,null,null)
	insert into Tb values (@i, rand() * @count)
	insert into Tc values (@i, rand() * @i, rand() * @i)
	set @i = @i + 1
end

alter table Ta
add name nvarchar(100)
alter table Ta
add a3 int
go

update Ta
set a3 = rand(Ta.a2) * 1000
update Ta
set name = concat('test', rand() * 1000 * Ta.aid) 


-- clustered index seek
select * from Ta where aid < 5

-- clustered index scan
select * from Ta where a3 = 716

create index Ta_name_index on Ta(name) include (a2) 
drop index Ta_name_index on Ta

-- nonclustered index scan
select name from Ta where a2 >= 5

-- nonclustered index seek
select name from Ta where name like 'test5%'

-- key lookup
select a2 from Ta where name like 'test1%' and a2 = 40

drop index Tb_b2_index on Tb
select * from Tb where b2 = 5

create index Tb_b2_index on Tb(b2)
select * from Tb where b2 = 5

drop index Tc_bid_index on Tc
create index Tc_bid_index on Tc(bid)

create or alter view Tb_Tc_View as
select Tc.bid
from Tc inner join Tb on Tb.bid = Tc.bid

select * from Tb_Tc_View
