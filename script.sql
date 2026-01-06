create database BankaEGjakut

use BankaEGjakut

-- Table: Spitali
create table Spitali(
Spitali_Id int primary key,
Emri varchar(50) not null,
Reparti varchar(100) not null,
Qyteti varchar(50) not null,
Rruga varchar(100) not null
)

-- Table: Qendra_Grumbulluese
create table Qendra_Grumbulluese(
Qendra_Id int primary key,
Emri varchar(50) unique not null,
Qyteti varchar(50) not null,
Rruga varchar(100) not null
)

-- Table: Spitali_QendraGrumbulluese
create table Spitali_QendraGrumbulluese(
Spitali_Id int,
Qendra_Id int,
primary key(Spitali_Id, Qendra_Id),
constraint FK_Spitali foreign key(Spitali_Id)
references Spitali(Spitali_Id),
constraint FK_Qendra foreign key(Qendra_Id)
references Qendra_Grumbulluese(Qendra_Id)
)
alter table Spitali_QendraGrumbulluese
add Pacienti_Id int
alter table Spitali_QendraGrumbulluese
add foreign key (Pacienti_Id) references Pacienti(Pacienti_Id)


-- Table: Stafi
create table Stafi(
Stafi_Id int primary key,
Emri varchar(50) not null,
Mbiemri varchar(50) not null,
DateLindja date,
Paga money,
Qendra int,
constraint FK_Qendra_Stafi foreign key (Qendra)
references Qendra_Grumbulluese(Qendra_Id) ON DELETE CASCADE
)
-- Table: Stafi_Mjekesor
create table Stafi_Mjekesor(
Stafi_Mjekesor int identity(1,1) primary key,
Grada_Shkencore varchar(10) not null,
Pervoja_e_punes int not null,
foreign key (Stafi_Mjekesor) references Stafi
)
alter table Stafi_Mjekesor
add Recepsionisti int



-- Table: Telefoni_Stafit
create table Telefoni_Stafit(
Stafi int not null,
Nr_Tel varchar(30) not null,
primary key(Stafi, Nr_Tel),
constraint FK_Telefoni_Stafit foreign key (Stafi) references Stafi(Stafi_Id)
)

-- Table: Recepsionisti
create table Recepsionisti(
Recepsionisti int identity(1,1) primary key,
Grada_Shkencore varchar(10) not null,
Pervoja_e_punes int not null,
foreign key (Recepsionisti) references Stafi
)

-- Table: Vullnetar
create table Vullnetar(
Vullnetari_Id int identity(1,1) primary key,
Profesioni varchar(20)
foreign key (Vullnetari_Id) references Stafi
)

-- Table: Pacienti
create table Pacienti(
Pacienti_Id int identity(1,1) primary key,
Emri varchar(50) not null,
Mbiemri varchar(80) not null,
DateLindja date,
Gjinia varchar(10),
check(Gjinia in('Femer','Mashkull')),
Qyteti varchar(50) not null,
Rruga varchar(100),
Recepsionisti_Id int,
constraint FK_Recepsionisti foreign key (Recepsionisti_Id) references Recepsionisti(Recepsionisti) ON DELETE CASCADE
)

-- Table: Telefoni_Pacientit
create table Telefoni_Pacientit(
Pacienti int not null,
Nr_Tel varchar(30) not null,
primary key(Pacienti, Nr_Tel),
constraint FK_Telefoni_Pacienti foreign key (Pacienti) references Pacienti(Pacienti_Id)
)

-- Table: Pacient_i_QKUK
create table Pacient_i_QKUK(
Pacienti_QKUK int primary key,
Reparti varchar(50) not null,
Raporti varchar(200) not null,
foreign key (Pacienti_QKUK) references Pacienti
)

-- Table: Pacient_Privat
create table Pacient_Privat(
Pacienti_Privat int primary key,
foreign key (Pacienti_Privat) references Pacienti
)

-- Table: Testimi_Standart
create table Testimi_Standart(
Testimi_Id int identity(1,1) primary key,
Hepatiti varchar(10),
HIV varchar(10),
Estradiol varchar(10),
DHEA varchar(10),
)

-- Table: Dhuruesi
create table Dhuruesi(
Dhuruesi_Id int identity(1,1) primary key,
Emri varchar(20) not null,
Mbiemri varchar(30) not null,
DiteLindja date,
Gjinia varchar(10),
check(Gjinia in('Femer','Mashkull')),
Qyteti varchar(50) not null,
Rruga varchar(80) not null,
Data_E_Regjistrimit date,
Recepsionisti int,
constraint FKK_Recepsionisti foreign key (Recepsionisti)
references Recepsionisti(Recepsionisti) ON DELETE CASCADE
)



-- Table: TelefoniDhuruesit
create table TelefoniDhuruesit(
Dhuruesi int not null,
Nr_Tel varchar(30) not null,
primary key(Dhuruesi,Nr_Tel),
constraint Telefoni_Dhuruesit_FK foreign key(Dhuruesi) references Dhuruesi(Dhuruesi_Id)
)

-- Table: Gjaku
create table Gjaku(
Gjaku_Id int identity(1,1) primary key,
Tipi_i_Gjakut varchar(5) not null,
Sasia int not null,
Kosto money not null,
Data date,
Dhuruesi int,
constraint FK_Dhuruesi_Gjaku foreign key (Dhuruesi) references Dhuruesi(Dhuruesi_Id) ON DELETE CASCADE,
Pacienti int,
constraint FK_Pacienti_Gjaku foreign key(Pacienti) references Pacienti(Pacienti_Id),
Qendra int,
constraint FK_Qendra_Gjaku foreign key (Qendra) references Qendra_Grumbulluese(Qendra_Id)
)

-- Table: Testimi_i_Gjakut
create table Testimi_i_Gjakut(
Testimi_Id int,
Gjaku_Id int,
primary key(Testimi_Id, Gjaku_Id),
constraint Testimi_Gj_FK foreign key(Testimi_Id) references Testimi_Standart(Testimi_Id),
constraint Gjaku_FK foreign key (Gjaku_Id) references Gjaku(Gjaku_Id)
)

-- Table: Fatura
create table Fatura(
Fatura_Id int identity(1,1) primary key,
Cmimi money not null,
Data date not null,
Pacienti_Privat int foreign key references Pacient_Privat(Pacienti_Privat) unique
)

--Insertimi i te dhenave

insert into Spitali values(2,'Spitali i Pergjithshem i Gjilanit','Reparti i Gjinekologjise','Gjilan','Rruga Pajazit Ahmeti')
insert into Spitali values(3,'Spitali i Pergjithshem i Ferizajit','Reparti i Emergjencës me reanimacion','Ferizaj','Rr.Ramadan Rexhepi')
insert into Spitali values(4,'Spitali i Pergjithshem i Prizrenit','Reparti i Kirurgjise se Pergjithshme','Prizren','Rr.Shkronjat')
insert into Spitali values(5,'Spitali i Pergjithshem i Vushtrrise','Reparti i Neonatologjise','Vushtrri','B')
insert into Spitali values (6,'Qendra Klinike Uniersitare e Kosoves','Reparti i Infektives','Prishtine','Lagjja e Spitalit')
insert into Spitali values (7,'Spitali i Pergjithshem i Mitrovices','Reparti i Oftalmologjise','Mitrovice','Rr.Lagjja e Spitalit')
insert into Spitali values(8,'Spitali Amerikan','Reparti i Gjinekologjise/Obsestrike','Prishtine','Rr.Shkupi')
insert into Spitali values(9,'Spitali Aloka','Reparti i Kirurgjise','Prishtine','Veternik')
insert into spitali values (10,'Spitali Lindja','Reparti i Gjinekologjise','Prishtine','Veternik')
insert into Spitali values(11,'Spitali Special Bahceci','Reparti i Gjinekologjise','Prishtine','Magjistralja Prishtine-Shkup')


select * from Qendra_Grumbulluese
insert into Qendra_Grumbulluese values(1,'Spitali i Pergjithshem i Prizrenit','Prizren','Shadervani')
insert into Qendra_Grumbulluese values(2,'Qendra Klinike Universitare e Kosoves','Prishtine','Lagjja e Spitalit')
insert into Qendra_Grumbulluese values(3,'Spitali i Pergjitshem i Gjilanit','Gjilan','Rr.Pajazit Ahmeti')
insert into Qendra_Grumbulluese values(4,'Spitali i Pergjithshem i Ferizajit','Ferizaj','Rr.Ramadan Rexhepi')
insert into Qendra_Grumbulluese values(5,'Spitali i Pergjitshem i Pejes','Peje','Rr.Nene Tereza')
insert into Qendra_Grumbulluese values(6,'Spitali i Pergjithshem i Mitrovices','Mitrovice','Rr.Lagjja e Spitalit')
insert into Qendra_Grumbulluese values (7,'Spitali i Pergjithshem i Gjakoves','Gjakove','Rr.Zid Sadik Aga')
insert into Qendra_Grumbulluese values (8,'Spitali i Pergjithshem i Vushtrrise','Vushtrri','Rr.Sheikh Zayed')


insert into Stafi values(1,'Gazmend','Rama','12-12-1987',CAST(1500.00 AS Decimal(7, 2)),3)
insert into Stafi values(2,'Magbule',' Agaj','03-01-1990',CAST(1500.00 AS Decimal(7, 2)),1)
insert into Stafi values(3,'Shefqet','Ismajli','01-06-1998',CAST(2000.00 AS Decimal(7, 2)),7)
insert into Stafi values(4,'Azem','Hoxha','06-01-1978',CAST(1500.00 AS Decimal(7, 2)),8)
insert into Stafi values(5,'Elmedina','Haxhiu','08-07-1970',CAST(1500.00 AS Decimal(7, 2)),6)
insert into Stafi values(6,'Blerina','Maliqi','03-02-1989',CAST(900.00 AS Decimal(7, 2)),5)
insert into Stafi values(7,'Shqiprim','Agaj','05-09-1963',CAST(2000.00 AS Decimal(7, 2)),4)
insert into Stafi values(8,'Gezim','Arifi','06-06-1960',CAST(900.00 AS Decimal(7, 2)),2)
insert into Stafi values(9,'Rrezarta','Bekteshi','11-11-1978',CAST(1500.00 AS Decimal(7, 2)),1)
insert into Stafi values(10,'Besart','Rama','10-08-1990',CAST(900.00 AS Decimal(7, 2)),5)
insert into Stafi values(11,'Tixhe','Neziri','02-06-2001',null,2)
insert into Stafi values(12,'Alban','Gashi','12-12-1987',CAST(1500.00 AS Decimal(7, 2)),3)
insert into Stafi values(13,'Anida','Gerbeshi','12-12-1989',CAST(500.00 AS Decimal(7, 2)),2)
insert into Stafi values(14,'Besiana','Ademi','12-11-1997',CAST(500.00 AS Decimal(7, 2)),1)
insert into Stafi values(15,'Vigan','Nuhiu','1-10-2000',CAST(500.00 AS Decimal(7, 2)),3)
insert into Stafi values(16,'Anduena','Beqiri','2-2-2002',CAST(500.00 AS Decimal(7, 2)),4)

set identity_insert Vullnetar on;
go
insert into Vullnetar(Vullnetari_Id, Profesioni) values(12, 'sociolog')
insert into Vullnetar(Vullnetari_Id, Profesioni) values(13, 'psikolog')
insert into Vullnetar(Vullnetari_Id, Profesioni) values(14, 'punetor social')
insert into Vullnetar(Vullnetari_Id, Profesioni) values(15, 'administrator publik')
insert into Vullnetar(Vullnetari_Id, Profesioni) values(16, 'ekonomist')
select * from Vullnetar
set identity_insert Vullnetar off;
go

set identity_insert Pacienti on;
go
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(1,'Albin','Gashi','03-04-1996','Mashkull','Prishtine','Rr.Muharrem Fejza')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(2,'Hana','Neziri','02-02-2001','Femer','Gjilan','Dheu i Bardhe')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(3,'Violeta','Neziri','05-05-1975','Femer','Gjilan','Rr.Agim Ramadani')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(4,'Arsim','Rexhepi','06-23-1987','Mashkull','Gjakove','Rr.Qarshia e Vjeter')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(5,'Burim','Gashi','09-28-1990','Mashkull','Vushtrri',null)
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga)values(6,'Albulena','Hamiti','12-12-1987','Femer','Prishtine','Rr.B')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(7,'Ron','Krasniqi','01-11-2001','Mashkull','Prishtine','Rr.Muharrem Fejza')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(8,'Diellza','Ahmeti','11-11-1990','Femer','Prizren','Rr.Shadervani')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga)values(9,'Enver','Berisha','09-08-1968','Mashkull','Prizren','Rr.Tranziti')
insert into Pacienti(Pacienti_Id,Emri,Mbiemri,DateLindja,Gjinia,Qyteti,Rruga) values(10,'Valdet','Kollari','12-25-1980','Mashkull','Peje','Rr.Nene Tereza')
set identity_insert Pacienti off;
go

insert into Pacient_i_QKUK values(2,'Reparti i Gjinekologjise')
insert into Pacient_i_QKUK values(1,'Reparti i Gjinekologjise')
insert into Pacient_i_QKUK values(3,'Reparti i Kirurgjise')
insert into Pacient_i_QKUK values(4,'Reparti i Infektives')
insert into Pacient_i_QKUK values(5,'Reparti i Oftalmologjise')
insert into Pacient_i_QKUK values(10,'Reparti i Infektives')
insert into Pacient_i_QKUK values(9,'Reparti i Kirurgjise')
insert into Pacient_i_QKUK values(8,'Reparti i Neonatologjise')
insert into Pacient_i_QKUK values(7,'Reparti i Kirurgjise')
insert into Pacient_i_QKUK values(6,'Reparti i Gjinekologjise')

insert into Pacient_Privat values(1)
insert into Pacient_Privat values(2)
insert into Pacient_Privat values(3)
insert into Pacient_Privat values(4)
insert into Pacient_Privat values(5)
insert into Pacient_Privat values(6)
insert into Pacient_Privat values(7)
insert into Pacient_Privat values(8)
insert into Pacient_Privat values(9)
insert into Pacient_Privat values(10)

set identity_insert Fatura on;
go
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(1,CAST(2000.00 AS Decimal(7, 2)),'02-02-2022',1)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(2,CAST(2000.00 AS Decimal(7, 2)),'02-05-2022',9)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(3,CAST(1500.00 AS Decimal(7, 2)),'02-22-2022',2)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(4,CAST(900.00 AS Decimal(7, 2)),'08-23-2022',8)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(5,CAST(1230.00 AS Decimal(7, 2)),'02-01-2023',3)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(6,CAST(3000.00 AS Decimal(7, 2)),'02-02-2022',7)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(7,CAST(900.00 AS Decimal(7, 2)),'12-12-2022',4)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(8,CAST(900.00 AS Decimal(7, 2)),'03-30-2022',6)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(9,CAST(590.00 AS Decimal(7, 2)),'12-27-2022',5)
insert into Fatura(Fatura_Id,Cmimi,Data,Pacienti_Privat) values(10,CAST(200.00 AS Decimal(7, 2)),'11-23-2022',10)
set identity_insert Fatura off;
go

select * from Spitali_QendraGrumbulluese
insert into Spitali_QendraGrumbulluese values(2,4,8)
insert into Spitali_QendraGrumbulluese values(3,4,9)
insert into Spitali_QendraGrumbulluese values(4,4,10)
insert into Spitali_QendraGrumbulluese values(5,4,7)
insert into Spitali_QendraGrumbulluese values(6,4,6)
insert into Spitali_QendraGrumbulluese values(7,4,5)
insert into Spitali_QendraGrumbulluese values(8,4,4)
insert into Spitali_QendraGrumbulluese values(9,4,3)
insert into Spitali_QendraGrumbulluese values(10,9,2)
insert into Spitali_QendraGrumbulluese values(9,8,1)
insert into Spitali_QendraGrumbulluese values(8,7,9)
insert into Spitali_QendraGrumbulluese values(7,7,8)
insert into Spitali_QendraGrumbulluese values(6,5,7)
insert into Spitali_QendraGrumbulluese values(5,3,6)
insert into Spitali_QendraGrumbulluese values(4,3,5)
insert into Spitali_QendraGrumbulluese values(3,2,4)
insert into Spitali_QendraGrumbulluese values(2,1,3)
insert into Spitali_QendraGrumbulluese values(1,4,2)
insert into Spitali_QendraGrumbulluese values(2,5,8)
insert into Spitali_QendraGrumbulluese values(4,5,10)
insert into Spitali_QendraGrumbulluese values(1,2,9)
insert into Spitali_QendraGrumbulluese values(2,2,8)
insert into Spitali_QendraGrumbulluese values(3,6,7)
insert into Spitali_QendraGrumbulluese values(8,8,6)
insert into Spitali_QendraGrumbulluese values(6,3,1)

select * from Pacient_i_QKUK
alter table Pacient_i_QKUK
drop column Raporti

select * from Recepsionisti
alter table Recepsionisti
drop column Grada_Shkencore

set identity_insert Recepsionisti on;
go
insert into Recepsionisti(Recepsionisti,Pervoja_e_punes) values(7,5)
insert into Recepsionisti(Recepsionisti,Pervoja_e_punes) values(8,2)
insert into Recepsionisti(Recepsionisti,Pervoja_e_punes) values(10,8)
set identity_insert Recepsionisti off;
go


select * from Telefoni_Pacientit
insert into Telefoni_Pacientit values(1,'044-123-546')
insert into Telefoni_Pacientit values(1,'044-124-546')
insert into Telefoni_Pacientit values(3,'049-705-950')
insert into Telefoni_Pacientit values(4,'043-555-546')
insert into Telefoni_Pacientit values(5,'049-243-546')
insert into Telefoni_Pacientit values(6,'045-123-666')
insert into Telefoni_Pacientit values(7,'049-542-546')
insert into Telefoni_Pacientit values(7,'044-895-184')
insert into Telefoni_Pacientit values(10,'049-729-910')
insert into Telefoni_Pacientit values(4,'045-163-506')

select * from Telefoni_Stafit
insert into Telefoni_Stafit values(1,'044-243-524')
insert into Telefoni_Stafit values(2,'044-354-635')
insert into Telefoni_Stafit values(2,'045-354-635')
insert into Telefoni_Stafit values(3,'049-000-635')
insert into Telefoni_Stafit values(4,'043-366-655')
insert into Telefoni_Stafit values(5,'044-265-968')
insert into Telefoni_Stafit values(5,'043-354-635')
insert into Telefoni_Stafit values(6,'049-659-324')
insert into Telefoni_Stafit values(7,'049-356-625')
insert into Telefoni_Stafit values(7,'049-354-635')

select * from Stafi_Mjekesor
set identity_insert Stafi_Mjekesor on;
go
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(1,'Dr.','10',7)
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(2,'MsC.','4',7)
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(3,'PhD.','25',10)
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(4,'PhD.','30',8)
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(5,'MsC.','8',8)
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(6,'MsC.','11',8)
insert into Stafi_Mjekesor(Stafi_Mjekesor,Grada_Shkencore,Pervoja_e_punes,Recepsionisti) values(9,'Dr.','19',10)
set identity_insert Stafi_Mjekesor off;
go

set identity_insert Dhuruesi on;
go
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(1,'Blerton','Gashi',CAST(N'2000-01-09' AS Date),'Mashkull','Viti','Rr.Agim Ramadani', CAST(N'2000-01-09' AS Date),8)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(2,'Dardan','Krasniqi',CAST(N'1987-02-10' AS Date),'Mashkull','Prishtine','Rr.Vellezerit Gervalla',CAST(N'2022-03-09' AS Date),10)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(3,'Adelina','Sefa',CAST(N'1975-12-12' AS Date),'Femer','Prishtine','Rr.Vellezerit Gervalla',CAST(N'2023-01-01' AS Date),10)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(4,'Jon','Hoxha',CAST(N'1998-11-11' AS Date),'Mashkull','Peje','Rr.Nene Tereza',CAST(N'2022-09-03' AS Date),10)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(5,'Marigona','Kryeziu',CAST(N'2000-06-02' AS Date),'Femer','Prizren','Rr.Tranziti',CAST(N'2022-08-09' AS Date),10)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(6,'Lorik','Gashi',CAST(N'1980-10-08' AS Date),'Mashkull','Gjakove','Rr.Qarshia e Vjeter',CAST(N'2023-01-01' AS Date),10)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(7,'Erzen','Mehmeti',CAST(N'1980-10-02' AS Date),'Mashkull','Prishtine','Rr.B',CAST(N'2022-03-09' AS Date),10)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(8,'Flutura','Krasniqi',CAST(N'2002-12-11' AS Date),'Femer','Gjilan','Rr.Spitalit',CAST(N'2022-03-09' AS Date),7)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(9,'Jetlira','Hoxha',CAST(N'1990-02-10' AS Date),'Femer','Prishtine','Rr.Muharrem Fejza',CAST(N'2022-10-09' AS Date),8)
insert into Dhuruesi(Dhuruesi_Id,Emri,Mbiemri,DiteLindja,Gjinia,Qyteti,Rruga,Data_E_Regjistrimit,Recepsionisti)
values(10,'Fjolla','Ahmeti',CAST(N'2003-12-10' AS Date),'Femer','Prishtine','Rr.Vellezerit Gervalla',CAST(N'2022-11-09' AS Date),10)
set identity_insert Dhuruesi off;
go


insert into TelefoniDhuruesit values(1,'049-253-564')
insert into TelefoniDhuruesit values(2,'045-233-554')
insert into TelefoniDhuruesit values(3,'044-243-524')
insert into TelefoniDhuruesit values(4,'049-370-720')
insert into TelefoniDhuruesit values(5,'045-263-664')
insert into TelefoniDhuruesit values(6,'043-224-893')
insert into TelefoniDhuruesit values(7,'049-300-522')
insert into TelefoniDhuruesit values(8,'043-336-876')
insert into TelefoniDhuruesit values(9,'049-610-834')
insert into TelefoniDhuruesit values(9,'044-610-835')

alter table Gjaku
alter column Sasia varchar(20)



set identity_insert Gjaku on;
go
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (1,'A+','500mL',CAST(500.00 AS Decimal(7, 2)),CAST(N'2022-11-09' AS Date),1,10,1)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (2,'A-','1000mL',CAST(1000.00 AS Decimal(7, 2)),CAST(N'2022-12-10' AS Date),2,9,5)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (3,'A+','1500mL',CAST(1500.00 AS Decimal(7, 2)),CAST(N'2022-06-08' AS Date),3,8,6)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (4,'A-','500mL',CAST(500.00 AS Decimal(7, 2)),CAST(N'2022-11-09' AS Date),4,7,5)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (5,'B_','3000mL',CAST(3000.00 AS Decimal(7, 2)),CAST(N'2022-02-07' AS Date),5,8,4)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (6,'B-','2500mL',CAST(2500.00 AS Decimal(7, 2)),CAST(N'2022-12-12' AS Date),6,9,3)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (7,'B-','500mL',CAST(500.00 AS Decimal(7, 2)),CAST(N'2022-06-02' AS Date),5,10,2)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (8,'AB+','1200mL',CAST(1200.00 AS Decimal(7, 2)),CAST(N'2023-01-01' AS Date),4,9,1)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (9,'O+','2000mL',CAST(2000.00 AS Decimal(7, 2)),CAST(N'2022-12-12' AS Date),3,8,7)
insert into Gjaku(Gjaku_Id,Tipi_i_Gjakut,Sasia,Kosto,Data,Dhuruesi,Pacienti,Qendra)
values (10,'AB-','500mL',CAST(500.00 AS Decimal(7, 2)),CAST(N'2022-06-08' AS Date),2,10,6)
set identity_insert Gjaku off;
go







set identity_insert Testimi_Standart on;
go
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(1,1,0,0,0)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(2,1,1,0,0)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(3,1,1,1,0)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(4,0,1,0,0)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(5,0,1,1,0)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(6,0,1,1,1)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(7,0,0,1,0)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(8,0,0,1,1)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(9,0,0,0,1)
insert into Testimi_Standart(Testimi_Id,Hepatiti,HIV,Estradiol,DHEA) values(10,1,1,1,1)
set identity_insert Testimi_Standart off;
go

select * from Testimi_i_Gjakut
insert into Testimi_i_Gjakut values(1,1)
insert into Testimi_i_Gjakut values(1,2)
insert into Testimi_i_Gjakut values(1,3)
insert into Testimi_i_Gjakut values(1,4)
insert into Testimi_i_Gjakut values(1,5)
insert into Testimi_i_Gjakut values(1,6)
insert into Testimi_i_Gjakut values(1,7)
insert into Testimi_i_Gjakut values(1,8)
insert into Testimi_i_Gjakut values(1,9)
insert into Testimi_i_Gjakut values(1,10)
insert into Testimi_i_Gjakut values(2,1)
insert into Testimi_i_Gjakut values(2,2)
insert into Testimi_i_Gjakut values(2,3)
insert into Testimi_i_Gjakut values(2,4)
insert into Testimi_i_Gjakut values(2,5)
insert into Testimi_i_Gjakut values(2,6)
insert into Testimi_i_Gjakut values(2,7)
insert into Testimi_i_Gjakut values(2,8)
insert into Testimi_i_Gjakut values(3,9)
insert into Testimi_i_Gjakut values(3,7)
insert into Testimi_i_Gjakut values(4,5)
insert into Testimi_i_Gjakut values(5,3)
insert into Testimi_i_Gjakut values(6,1)
insert into Testimi_i_Gjakut values(7,4)
insert into Testimi_i_Gjakut values(8,6)


update Pacienti
set Rruga='Rr.B'
where Pacienti_Id=1

update Pacienti
set Qyteti='Gjilan'
where Pacienti_Id=3

update Dhuruesi
set Emri='Fjolle'
where Dhuruesi_Id=10

update Stafi_Mjekesor
set Grada_Shkencore='PhD.'
where Stafi_Mjekesor=9

update Stafi_Mjekesor
set Pervoja_e_punes=20
where Stafi_Mjekesor=9

update Stafi_Mjekesor
set Pervoja_e_punes=40
where Stafi_Mjekesor=3

update Pacienti
set rruga='Iliria'
where Pacienti_Id=3

update Pacienti
set DateLindja='12-26-1980'
where Pacienti_Id=10

update Pacienti
set Emri='Rron'
where Pacienti_Id=7

update Qendra_Grumbulluese
set Emri='Spitali i Pergjithshem - Prizren'
where Qendra_Id=1

update Qendra_Grumbulluese
set Emri='Spitali i Pergjithshem-Peje'
where Qendra_Id=5

update Qendra_Grumbulluese
set Emri='Spitali i Pergjithshem-Vushtrri'
where Qendra_Id=8

update Qendra_Grumbulluese
set Emri='Spitali i Pergjithshem-Gjakove'
where Qendra_Id=7

update Qendra_Grumbulluese
set Emri='Spitali i Pergjithshem-Gjilan'
where Qendra_Id=3

update Fatura
set Data='02-02-2022'
where Fatura_Id=4

update Fatura
set Cmimi=CAST(1400.00 AS Decimal(7, 2))
where Fatura_Id=5


update Dhuruesi
set Qyteti='Mitrovice'
where Dhuruesi_Id=3

update Dhuruesi
set Emri='Erza'
where Dhuruesi_Id=7

update Dhuruesi
set Gjinia='Femer'
where Dhuruesi_Id=7

update Gjaku
set Tipi_i_Gjakut='B-'
where Gjaku_Id=5

delete from Testimi_i_Gjakut
where Gjaku_Id=5

delete from TelefoniDhuruesit
where Dhuruesi=7

delete from Stafi_Mjekesor
where Stafi_Mjekesor=3

delete from Telefoni_Pacientit
where Pacienti=3

delete from Telefoni_Stafit
where Stafi=3

delete from Dhuruesi
where Dhuruesi_Id=1

delete from Pacienti
where Emri='Hana'

delete from Pacienti
where Pacienti_Id=8

delete from Stafi
where Stafi_Id=7

delete from Gjaku
where Gjaku_Id=8








