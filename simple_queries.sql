--QUERIES TE THJESHTE ME NJE RELACION
--1 Selektimi i stafit qe kane rroge mbi 1000
select Emri, Mbiemri, Paga
from Stafi
where Paga>1000

--2 Mosha mesatare e dhureusve
select avg(Datediff(year, DiteLindja, getDate())) as Mosha_Mesatare
from Dhuruesi

--3 Listimi i stafit me emrin Vigan ose Rrezarta qe kane rroge me te vogel se 700
select * from Stafi
where Emri in('Rrezarta','Vigan') and Paga<700
order by Emri asc

--4 Listimi i te gjitha grupeve te gjaut dhe numri i sasise per to
select distinct Tipi_i_Gjakut, sum(Kosto) as SasiaTotale
from Gjaku
where Tipi_i_Gjakut is not null
group by Tipi_i_Gjakut


--5  Te listohen dhuruesit e regjistruar ne muajt tetor-nentor 2022
select * from Dhuruesi
where Data_E_Regjistrimit between '2022-10-09'and '2022-11-01'

--6 Paraqit koston me te larte te gjakut te dhuruar
select max(Kosto) [Kosto_e_larte] 
from  Gjaku

--7 Te listohen te gjithe pacientet qe vijne nga komuna e Gjilanit dhe jane te gjinise femerore
select * from Pacienti
where Gjinia like 'Femer'
and Qyteti like 'Gjilan'

--8 Te listohen 3 mjeket me me se shumti pervoje pune
select top 3  Pervoja_e_punes from Stafi_Mjekesor
order by Pervoja_e_punes desc





--QUERIES TE THJESHTA ME DY  E ME SHUME RELACIONE
--1 Numeroni te gjithe punonjesit e QKUK-se dhe qe rrogen e kane mbi 500 euro
select count (*) as Punonjes
from Stafi s, Qendra_Grumbulluese q
where s.Qendra=q.Qendra_Id and q.Emri='Qendra Klinike Universitare e Kosoves'  and Paga>500

--2Sa punonjes ka per secilen Qender Grumbulluese duke i renditur ato sipas numrit me te vogel te punonjesve per ato Qendra qe kane me shume se nje punonjes
select q.Emri, q.Qyteti, count(*) as Punonjes
from Stafi s, Qendra_Grumbulluese q
where q.Qendra_Id=s.Qendra
Group by q.Emri, q.Qyteti
having count(*) > 1
order by Punonjes asc

--3: Listimi i dhurimit te gjakut ne daten 11 shtator deri 12 tetor dhe qendra ku jane grumbullu

select g.Tipi_i_Gjakut, g.Data, q.Emri
from Gjaku g, Qendra_Grumbulluese q
where g.Gjaku_Id=q.Qendra_Id and
g.Data between '2022-11-09'  and '2022-12-10'

--4: Kosto mesatare per secilin pacient qe ka blere gjak.

select p.Emri, p.Mbiemri, p.Pacienti_Id, avg(g.Kosto) as Mesatarja
from Pacienti p, Gjaku g
where p.Pacienti_Id=g.Pacienti
Group by p.Pacienti_Id, p.Emri, p.Mbiemri


--5 Te listohen te dhenat e stafit dhe qendrat ne te cilat punojne
select s.Emri, s.Mbiemri, q.Emri,
q.Qyteti,q.Rruga
from Stafi s, Qendra_Grumbulluese q
where q.Qendra_Id=s.Qendra

--6 Te listohen dhuruesit te cilet jane regjistruar te recepsionisti me id-10(te shfaqen te dhenat e dy paleve)
select (dh.Emri + ' ' + dh.Mbiemri) [Emri Dhuruesit], dh.DiteLindja, (dh.Rruga + ' -  ' + dh.Qyteti) [Adresa],
(s.Emri + ' ' + s.Mbiemri) [Emri Recepsionistit]
from Dhuruesi dh, Recepsionisti r, Stafi s
where  dh.Recepsionisti=r.Recepsionisti and s.Stafi_Id=r.Recepsionisti
and r.Recepsionisti=10

--7 te shfaqet tipi i gjakut dhe te dhenat personale te dhuruesit te cilet nga testimi standart kane rezultuar se kane HIV dhe HEPATIT
select (dh.Emri + ' ' + dh.Mbiemri) [Emri Dhuruesit],gj.Tipi_i_Gjakut,t.Hepatiti, t.HIV 
from  Gjaku gj, Dhuruesii dh,Testimi_Standart t,Testimi_i_Gjakut tgj
where gj.Gjaku_Id=tgj.Gjaku_Id
and t.Testimi_Id=tgj.Testimi_Id and  gj.Dhuruesi=dh.Dhuruesi_Id 
and t.Hepatiti=1 and t.HIV=1 

--8 te shfaqen te dhenat e  pacienteve te cilet kane paguar fature me shume se 1500
select (p.Emri + ' ' + p.Mbiemri) [Emri Pacientit],p.Qyteti, f.Cmimi,f.Data
from Pacienti p,Pacient_Privat pp, Fatura f
where pp.Pacienti_Privat=p.Pacienti_Id and pp.Pacienti_Privat=f.Pacienti_Privat
and Cmimi>1500
