--QUERIES TE AVANCUARA
--1 te shfaqen te dhenat personale te dhuruesve te cilet vijne na Vitia dhe te cilet kane hepatit por nuk kane hiv
select dh.Emri, dh.Mbiemri,gj.Tipi_i_Gjakut, dh.Qyteti, ts.HIV, ts.Hepatiti from Gjakuu gj
inner join Testimi_i_Gjakut tg on gj.Gjaku_Id=tg.Gjaku_Id
inner join Dhuruesii dh on gj.Dhuruesi=dh.Dhuruesi_Id
inner join Testimi_Standart ts on ts.Testimi_Id=tg.Testimi_Id
where ts.Hepatiti=1 and ts.HIV=0
and dh.Qyteti like 'Viti'


/*
  2
Te selektohen pacientet nga Vushtrria qe jane furnizuar me gjak te tipit B-.
Selektimi te behet sipas Emrit, Mbiemit, qytetit te pacientit dhe qendres grumbulluese
*/
select (p.Emri + ' ' + p.Mbiemri) [Emri Pacientit], p.Qyteti, gj.Tipi_i_Gjakut, q.Emri [Qendra Furnizuese] 
from Gjakuu gj inner join Pacienti p
on gj.Pacienti=p.Pacienti_Id 
inner join Qendra_Grumbulluese q on q.Qendra_Id=gj.Qendra
where Tipi_i_Gjakut='B-'
and p.Qyteti like 'Vushtrri'


/*
3 Te listohen te gjitha pacientet te cilat jane shtruar ne repartin e gjinekologjise ne spitalin e Gjilanit
por jane furnizuar me gjak nga QKUK-ja.Selektimi te behet ne baze te emrit, qytetit te pacientit emrit, repartit te spitalit dhe qendres furnizuese
*/
select (p.Emri + ' ' + p.Mbiemri) [Emri Pacientit], p.Qyteti, s.Emri, s.Reparti,
qg.Emri [Qendra furnizuese] from Pacienti p
inner join Spitali_QendraGrumbulluese sq on p.Pacienti_Id=sq.Pacienti_Id
inner join Spitali s on s.Spitali_Id=sq.Spitali_Id
inner join Qendra_Grumbulluese qg on sq.Qendra_Id=qg.Qendra_Id
where s.Reparti like 'Reparti i Gjinekologjise'
and qg.Qyteti like 'Prishtine'

/*
4 Te listohen dhuruesit te cilet kane dhuruar gjak te tipit A+ ne qytetin e Prishtines
gjate periudhes qershor-nentor.Listimi te behet ne baze te emrit, mbiemrit, qytetit te 
dhururesit, qendres grumbulluese dhe informatave te gjakut
*/
select (dh.Emri + ' ' + dh.Mbiemri) [Emri Dhuruesit],gj.Tipi_i_Gjakut,
qg.Qyteti, qg.Emri
from Gjakuu gj inner join Qendra_Grumbulluese qg
on gj.Qendra=qg.Qendra_Id inner join Dhuruesii dh on gj.Dhuruesi=dh.Dhuruesi_Id
where gj.Tipi_i_Gjakut like 'A+'
and qg.Qyteti like 'Prishtine'
and gj.Data between '2022-06-01' and '2022-11-01'


--5 Query i avancuar me dy relacione: Selektimi i pacienteve qe nuk kane marr ndonjeher gjak
Select p.Emri, p.Mbiemri
from Gjaku g right join Pacienti p on g.Pacienti = p.Pacienti_Id
where g.Pacienti is null

--6 Query i avancuar me dy relacione: Paraqit Pacientet te cilet kane marr gjak A+, B- ose 0+ dhe prej cilit Dhurues eshte marr ajo doze e gjakut.
--Selektimi te behet ne baze te emrit e mbiemrit te pacientit, grupit te gjakut dhe emrit e mbiemrit te dhuruesit.

select (p.Emri + ' ' + p.Mbiemri) [Emri i Pacientit], g.Tipi_i_Gjakut, (d.Emri + ' ' + d.Mbiemri) [Emri i Dhuruesit]
from Dhuruesi d inner join Gjaku g on d.Dhuruesi_Id=g.Dhuruesi
inner join Pacienti p on p.Pacienti_Id=g.Pacienti
where g.Tipi_i_Gjakut in ('A+','B-','O+')

--7 Query i avancuar me dy relacione: Selektoni Spitalet te ciat nuk jane qendra Grumbulluese dhe qe ndodhen ne adresen Veternik. Selektimi te behet ne baze te emrit te Spitalit, Qytetit dhe Rruges.

select s.Emri, s.Qyteti, s. Rruga
from Spitali s left join Spitali_QendraGrumbulluese sq on s.Spitali_Id=sq.Spitali_Id
where sq.Spitali_Id is null and Rruga='Veternik'

--8 Query i avancuar me dy relacione: Selektoni te gjithe Pacientet qe jane furnizuar me shume se dy here me gjak. Selektimi te behet ne baze te emrit, mbiemrit dhe dates se lindjes se Pacientit.

select p.Emri, p.Mbiemri, p.DateLindja, count (*) Furnizimi_me_Gjak
from Pacienti p inner join Gjaku g on g.Pacienti=p.Pacienti_Id
where g.Pacienti is not null
Group by p.Emri, p.Mbiemri, p.DateLindja
having count(*)>2

