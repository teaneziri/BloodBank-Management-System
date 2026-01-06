--SUBQUERIES TE THJESHTA
/*
1 Te shfaqen Pacientet te cilet kane paguar me shume se mesatarja e kostos se gjakut
*/
select * from Dhuruesii dh
where dh.Kostoo > (
select avg(gj.Kosto) from Gjakuu gj
)
select * from Dhuruesii

/*2Te shfaqen te gjithe pacientet te cilet kane marre gjak.
Selektimi te behet ne baze te emrit, mbiemrit, qytetit te pacientit*/
select p.Emri, p.Mbiemri, p.Qyteti from  Pacienti p
where p.Pacienti_Id in(select Pacienti_Id from Gjakuu gj
where p.Pacienti_Id=gj.Pacienti)

/*
3te shfaqen Qendrat ne te te cilat nuk eshte dhuruar gjak
Selektimi te behet ne baze te emrit dhe qytetit te qendres
*/
select q.Emri, q.Qyteti from  Qendra_Grumbulluese q
where q.Qendra_Id not in(select Qendra from Gjakuu gj
where q.Qendra_Id=gj.Qendra)

/*
4 Te listohen pacientet te cilet kane marre gjak me shume se mesatarja e gjakut te dhuruar.
Selektimi te behet ne baze te emrit, mbiemrit, sasise se gjakut te pacientit
*/
select p.Emri, p.Mbiemri, p.Sasia_e_gjakut from Pacienti p
where p.Sasia_e_gjakut < (
select avg(gj.Sasia_e_gjakut) from Gjakuu gj)

--5 Te selektohet pacienti i cili ka bere pagesen me te voglen per nje doze gjaku. Selektimi te behet ne baze te Emrit, Mbiemrit dhe Cmimit te fatures

select p.Emri, p.Mbiemri, f.Cmimi
from Pacienti p, Pacient_Privat pp, Fatura f
where p.Pacienti_Id=pp.Pacienti_Privat and pp.Pacienti_Privat=f.Pacienti_Privat and f.Cmimi = (Select min(f.Cmimi)
                                                                                               from Fatura f )

--6 Listoni dhuruesit qe vijne nga Peja dhe qe kane grupin e gjakut AB+

select d.Emri, d.Mbiemri, g.Tipi_i_Gjakut, g.Sasia
from Dhuruesi d inner join Gjaku g on g.Dhuruesi=d.Dhuruesi_Id
where d.Qyteti like 'Peje' and
g.Tipi_i_Gjakut in (select g.Tipi_i_Gjakut
                 from Gjaku g  
                 where g.Tipi_i_Gjakut like 'AB+')

--7 Selektimi i Stafit qe pagen e kane me te madhe se mesatarja e pages se te gjithe stafit, duke i renditur ata sipas Qendres se Grumbullimit ku punojn.

select s.Emri, s.Mbiemri, s.Paga, q.emri as Emri_i_Qendres_Grumbulluese
from Stafi s inner join Qendra_Grumbulluese q on s.Qendra = q.Qendra_Id
where s.Paga > (select avg(s.Paga)
                from Stafi s)
order by q.Emri desc

--8 Listoni te gjithe dhuruesit te cilet kan dhuruar me kosot me te ulet gjaku se sa shuma e gjakut te dhuruar nga Dhurues te Mitrovices.

select d.Emri, d.Mbiemri, d.Qyteti, sum(g.Kosto) 'Kosto'
From Dhuruesi d, Gjaku g, Pacienti p
where d.Dhuruesi_Id = g.Dhuruesi and p.Pacienti_Id=g.Pacienti
group by d.Emri, d.Mbiemri, d.Qyteti
having sum(g.Kosto) <= all (select sum(g.Kosto)
                            from Dhuruesi d, Gjaku g, Pacienti p
                            where d.Dhuruesi_Id = g.Dhuruesi and p.Pacienti_Id=g.Pacienti and d.Qyteti='Mitrovice'
                            group by d.Emri)
















































