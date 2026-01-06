--ALGJERBRA RELACIONARE  
-- 1 Dhuruesit qe kane HIV por nuk kane HEPATIT
create view [Dhuruesit_sipas_semundjes] as
select ts.Testimi_Id from Testimi_Standart ts inner join Testimi_i_Gjakut tgj
on ts.Testimi_Id=tgj.Testimi_Id
and ts.Hepatiti=0
except
select ts.Testimi_Id from Testimi_Standart ts inner join Testimi_i_Gjakut tgj
on ts.Testimi_Id=tgj.Testimi_Id
and ts.HIV=1

select   (d.Emri + ' ' + d.Mbiemri) [Emri Dhuruesit]
from Dhuruesit_sipas_semundjes dh inner join Gjaku gj
on dh.Testimi_Id=gj.Gjaku_Id 
inner join Dhuruesi d on d.Dhuruesi_Id=dh.Testimi_Id

-- 2 Te shfaqen pacientet dhe dhuruesit qe jane nga Prishtina
select 'Pacient' , p.Pacienti_Id ,p.Emri, p.Qyteti from  Pacienti p
where p.Qyteti like 'Prishtine'
union
select 'Dhurues', dh.Dhuruesi_Id,dh.Emri, dh.Qyteti from Dhuruesi dh
where dh.Qyteti like 'Prishtine'
order by Qyteti

-- 3 Dhuruesit qe nuk kane ESTRADIOL e as DHEA
create view [Dhuruesit_sipas_semundjes3] as
select ts.Testimi_Id from Testimi_Standart ts inner join Testimi_i_Gjakut tgj
on ts.Testimi_Id=tgj.Testimi_Id
and ts.ESTRADIOL=0
intersect
select ts.Testimi_Id from Testimi_Standart ts inner join Testimi_i_Gjakut tgj
on ts.Testimi_Id=tgj.Testimi_Id
and ts.DHEA=0

select   (d.Emri + ' ' + d.Mbiemri) [Emri Dhuruesit]
from Dhuruesit_sipas_semundjes3 dh inner join Gjaku gj
on dh.Testimi_Id=gj.Gjaku_Id 
inner join Dhuruesi d on d.Dhuruesi_Id=dh.Testimi_Id

--4 Dhuruesit me ESTRADIOL dhe DHEA
create view [Dhuruesit_sipas_semundjes4] as
select ts.Testimi_Id from Testimi_Standart ts inner join Testimi_i_Gjakut tgj
on ts.Testimi_Id=tgj.Testimi_Id
and ts.ESTRADIOL=1
union
select ts.Testimi_Id from Testimi_Standart ts inner join Testimi_i_Gjakut tgj
on ts.Testimi_Id=tgj.Testimi_Id
and ts.DHEA=1

select   (d.Emri + ' ' + d.Mbiemri) [Emri Dhuruesit]
from Dhuruesit_sipas_semundjes4 dh inner join Gjaku gj
on dh.Testimi_Id=gj.Gjaku_Id 
inner join Dhuruesi d on d.Dhuruesi_Id=dh.Testimi_Id

