-- Data Insertion --

insert into Producer
values ('Dell','19901030', 'Berlin'),
('HyperX', '20001023', 'Las Vegas'),
('Intel', '19901212', 'Paris'),
('Corsair', '19801212', 'Berlin'),
('AMD', '200108102', 'Madrid'),
('Nvidia', '20001222', 'London'),
('Logitech', '20101113', 'Bucharest')

insert into CPU_Socket
values ('lga1155','20001030',3,4),
('lga1150','20011030',4,4),
('lga1160','20101030',5,4),
('socket 1','20021030',3,7),
('socket 2','20031030',6,4)

insert into Processor
values (7,'20121030', 'lga1155', 2.4, 2.5, 'Intel'),
(6,'20121030', 'lga1155', 2.4, 3.3, 'Intel'),
(1,'20121030', 'lga1155', 2.4, 3.3, 'Intel'),
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

insert into Graphics_Card
values (1,'20021030','GT220', 600, 400, 'Nvidia'),
(2,'20031030','GT320', 800, 600, 'Nvidia'),
(3,'20051030','GTX650', 1200, 900, 'Nvidia'),
(4,'20061030','RX450', 1000, 900, 'AMD'),
(5,'20081030','RX750', 2000, 1000, 'AMD')

insert into RAM_Memory
values  (6,'20201030','Corsair', 1600, 'CL13', 8),
(1,'20001030','Corsair', 1600, 'CL13', 1),
(2,'20021030','Corsair', 2600, 'CL15', 1),
(3,'20031030','HyperX', 3600, 'CL17', 2),
(4,'20041030','Corsair', 3200, 'CL10', 8),
(5,'20051030','HyperX', 4600, 'CL9', 2)

insert into SSD
values (1,'20010103',64,500,400,'Sata'),
(2,'20101003',256,550,600,'Sata'),
(3,'20041003',512,2500,4400,'M.2'),
(4,'20030203',512,2500,1500,'M.2'),
(5,'20020103',1024,550,450,'Sata')

insert into HDD
values (6,'20030203',512,400,300,20000),
(7,'20020103',1024,550,450,10000),
(1,'20010103',64,500,400,7500),
(2,'20101003',256,550,600,7500),
(3,'20041003',512,300,200,4500),
(4,'20030203',512,400,300,4500),
(5,'20020103',1024,550,450,5500)

insert into Storage_Bundle
values (1,2,3),
(2,3,4),
(3,4,2),
(5,3,2),
(2,4,3)


insert into Keyboard
values 
(6,'20051030', 'mechanical', 0, 'Dell'),
(7,'20051030', 'mechanical', 0, 'Dell'),
(8,'20051030', 'mechanical', 0, 'Dell'),
(1,'20011030', 'membrane', 0, 'Logitech'),
(2,'20021030', 'membrane', 1, 'Logitech'),
(3,'20031030', 'mechanical', 1, 'Corsair'),
(4,'20051030', 'mechanical', 0, 'Corsair'),
(5,'20071030', 'mechanical', 1, 'Corsair')

insert into Monitor
values (1,'20001030', 'PG123', 'TN', 60, 'Dell'),
(2,'20011030', 'PG1sdf', 'TN', 60, 'Dell'),
(3,'20201030', 'PG235', 'TN', 144, 'Dell'),
(4,'20151030', 'PG2343', 'VA', 240, 'Corsair'),
(5,'20021030', 'PG12343', 'IPS', 75, 'Dell')

insert into Mouse
values (1,'20001030', 0, 0, 'Logitech'),
(2,'20021030', 2, 1, 'Logitech'),
(3,'20051030', 4, 0, 'Corsair'),
(4,'20031030', 4, 1, 'Corsair'),
(5,'20081030', 3, 0, 'Logitech')

insert into Peripherals_Bundle
values (1,3,2),
(2,3,1),
(4,3,5),
(3,4,1),
(4,2,5)


-- This Query is bad --
insert into Keyboard
values (5,'20011030', 'membrane', 0, 'Mamut')


-- Update Data --
update Monitor
set release_date = '20201030'
where monitor_id = 3 or monitor_id = 1

update Keyboard
set rgb = 1
where producer in ('Corsair', 'Dell')

update Producer
set creation_date = '19991030'
where producer_name like 'Int%'

-- Delete Data -- 
delete  from HDD where spin_rpm between 9000 and 1000000

delete from Keyboard where producer like 'De%'

-- Union -- 

select producer
from Keyboard
where rgb = 1 or key_type like 'mec%'
union all
select producer
from RAM_Memory

select max_read, max_write
from SSD
where connection_type like '%ta' or connection_type = 'Molex'
union
select max_read, max_write
from HDD

-- Intersect --

select Producer, release_date
from Processor
where release_date in ('20061030','20011023','20101023')
intersect
select Producer , release_date
from Graphics_Card

select rgb, release_date, producer
from Mouse
intersect
select rgb, release_date, producer
from Keyboard
where producer in ('Corsair', 'Dell', 'HyperX')

-- Except --

select m_id
from Motherboard
except
select m_id 
from Motherboard_And_CPU_Kits

select top 1 *
from Processor
where cpu_id not in (select cpu_id from Motherboard_And_CPU_Kits)
order by boost_clock desc

-- Joins -- 

select Count(*) as Rgb_Combo
from Keyboard
left join Mouse
on Keyboard.producer = Mouse.producer
where Keyboard.release_date not in ('20021030','20001010')
group by Keyboard.rgb

select distinct producer_name
from Producer
right join RAM_Memory
on Producer.producer_name = RAM_Memory.producer and speed > 3500
order by producer_name desc

select distinct top 3 latency
from RAM_Memory
inner join Storage_Bundle 
on ssd_id = 3
inner join Mouse on Mouse.producer = RAM_Memory.producer

select Count(*)
from  Monitor
full join Peripherals_Bundle on Monitor.monitor_id = Peripherals_Bundle.monitor_id
full join Motherboard_And_CPU_Kits on discount > 5
where Monitor.model not in ('PG123','PGsdf')
group by Monitor.panel_type
having panel_type like 'TN'

-- Subquery --

select Count(*)
from Processor
where Processor.producer in (
select producer
from Graphics_Card
where release_date > '20030101'
)

select Max(release_date)
from Keyboard
where keyboard_id in (
	select keyboard_id
	from Peripherals_Bundle
	where monitor_id in (
		select monitor_id
		from Monitor
		where Monitor.producer = 'Dell'
		)
	)

-- Exists --

select distinct max_read
from SSD
where exists (
	select *
	from Storage_Bundle, HDD
	where HDD.capacity_GB > 10 and SSD.ssd_id = Storage_Bundle.ssd_id
)

select AVG(memory_clock) as [Memory Clock Average] , AVG(core_clock) as [Core Clock Average]
from Graphics_Card
where exists (
	select producer
	from Processor
	where socket_type = 'socket 1'
)
 
-- Subquery in From --

select Count(*), producer
from (
	select * 
	from Mouse
	left join Producer on  Mouse.producer = Producer.producer_name
) Mouse_Producers
group by Producer

select Sum(size_GB) as [Available Size]
from (
	select *
	from RAM_Memory
	where ram_id not in (
		select ram_id
		from Storage_Bundle
		)
	) Ram

-- Group By -- 

select Count(*), max_read
from Storage_Bundle
full join SSD on Storage_Bundle.ssd_id = SSD.ssd_id
where ram_id is null
group by connection_type, max_read
having max_read in (
	select max_read
	from HDD
	where spin_rpm between 6000 and 8000 
)

select COUNT(*), release_date
from Motherboard
where PCIE_slots >= 2
group by release_date
having release_date in (
	select release_date
	from Processor
	where Processor.base_clock > 1.5
)

-- ANY ALL --

select memory_clock - core_clock as  Speed_Difference
from Graphics_Card
where memory_clock > Any (
	select core_clock
	from Graphics_Card
	where producer = 'AMD'
)

select memory_clock - core_clock as  Speed_Difference
from Graphics_Card
where memory_clock > (
	select Min(core_clock)
	from Graphics_Card
	where producer = 'AMD'
)

select  refresh_rate * 2 as OC_Refresh_Rate
from Monitor
where release_date < Any (
	select release_date
	from Mouse
)

select refresh_rate * 2 as OC_Refresh_Rate
from Monitor
where release_date < (
	select Max(release_date)
	from Mouse
)


select *, boost_clock / base_clock as Boost
from Processor
where boost_clock <= all (
	select boost_clock
	from Processor
)

select *, boost_clock / base_clock as Boost
from Processor
where boost_clock in (
	select min(boost_clock)
	from Processor
)

select *
from Keyboard
inner join Producer on Keyboard.producer = Producer.producer_name
where Producer.creation_date >= all (
	select creation_date
	from Producer
)

select *
from Keyboard
inner join Producer on Keyboard.producer = Producer.producer_name
where Producer.creation_date in (
	select max(creation_date)
	from Producer
)










