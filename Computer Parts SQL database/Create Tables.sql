create database ComputerPartsWharehouseManagement

use ComputerPartsWharehouseManagement

create table Producer (
	producer_name varchar(30) primary key,
	creation_date date,
	primary_location varchar(100)
)

create table CPU_Socket (
	socket_type varchar(10) primary key,
	release_date date,
	length_mm int,
	width_mm int
	)

create table Processor (
	cpu_id int primary key,
	release_date date,
	socket_type varchar(10) foreign key references CPU_Socket(socket_type),
	base_clock decimal(2,1),
	boost_clock decimal(2,1),
	producer varchar(30) foreign key references Producer(producer_name)
	)

create table Graphics_Card (
	gpu_id int primary key,
	release_date date,
	model varchar(20),
	memory_clock int,
	core_clock int,
	producer varchar(30) foreign key references Producer(producer_name)
	)

create table Motherboard (
	m_id int primary key,
	release_date date,
	model varchar(10),
	PCIE_slots int,
	socket_type varchar(10) foreign key references CPU_Socket(socket_type),
	)


create table RAM_Memory (
	ram_id int primary key,
	release_date date,
	producer varchar(30) foreign key references Producer(producer_name),
	speed int,
	latency char(4),
	size_GB int
)

create table HDD (
	hdd_id int primary key,
	release_date date,
	capacity_GB int,
	max_read int,
	max_write int,
	spin_rpm int
)

create table SSD (
	ssd_id int primary key,
	release_date date,
	capacity_GB int,
	max_read int,
	max_write int,
	connection_type varchar(20)
)

create table Storage_Bundle (
	ram_id int foreign key references RAM_Memory(ram_id),
	hdd_id int foreign key references HDD(hdd_id),
	ssd_id int foreign key references SSD(ssd_id),
	constraint storage_bundle_id primary key (ram_id, hdd_id, ssd_id)
)


create table Motherboard_And_CPU_Kits (
	m_id int foreign key references Motherboard(m_id),
	cpu_id int foreign key references Processor(cpu_id),
	discount int,
	constraint kit_id primary key (m_id, cpu_id)
)

create table Monitor (
	monitor_id int primary key,
	release_date date,
	model varchar(30),
	panel_type varchar(10),
	refresh_rate int,
	producer varchar(30) foreign key references Producer(producer_name)
)

create table Keyboard (
	keyboard_id int primary key,
	release_date date,
	key_type varchar(30),
	rgb varchar(3),
	producer varchar(30) foreign key references Producer(producer_name)
)

create table Mouse (
	mouse_id int primary key,
	release_date date,
	extra_buttons int,
	rgb varchar(3),
	producer varchar(30) foreign key references Producer(producer_name)
)

create table Peripherals_Bundle (
	monitor_id int foreign key references Monitor(monitor_id),
	keyboard_id int foreign key references Keyboard(keyboard_id),
	mouse_id int foreign key references Mouse(mouse_id),
	constraint peripherals_bundle_id primary key (monitor_id, keyboard_id, mouse_id)
)