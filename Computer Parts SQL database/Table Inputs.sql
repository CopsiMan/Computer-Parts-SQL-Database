insert into CPU_Socket(
	socket_type,
	release_date,
	length_mm,
	width_mm
	)
values ('lga12','20181012','12','32')

insert into Processor (cpu_id,release_date,socket_type,base_clock,boost_clock)
values ('1', '20191030','lga12','4.3','4.8')
insert into Processor (cpu_id,release_date,socket_type,base_clock,boost_clock)
values ('2', '20191020','lga12','3.2','4.2')

select * from Processor

insert into Producer(producer_name, creation_date, primary_location)
values ('Corsair', '20001020', 'Las Vegas')


insert into RAM_Memory (ram_id, release_date, producer, speed, latency, size_GB)
values ('1','20151221','Corsair','4200','cl18','4')
insert into RAM_Memory (ram_id, release_date, producer, speed, latency, size_GB)
values ('2','20151021','Corsair','3600','cl16','8')

select * from RAM_Memory


insert into Motherboard (m_id, release_date, model, PCIE_slots, socket_type)
values ('1', '20181020','bf300', '2', 'lga12')

select* from Motherboard

insert into Motherboard_And_CPU_Kits(m_id, cpu_id, discount)
values ('1','1','100')
insert into Motherboard_And_CPU_Kits(m_id, cpu_id, discount)
values ('1','2','300')

select * from Motherboard_And_CPU_Kits


select * from CPU_Socket