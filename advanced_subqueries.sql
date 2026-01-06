-- SUBQUERIES TE AVANCUARA
-- 1Të shfaqen pacientet të cilat kanë sasi  më të lartë se mesatarja e sasise të gjakut sipas grupit te gjakut.
SELECT gj.Gjaku_Id, gj.Kosto
FROM  Gjakuu gj
WHERE gj.Kosto >ANY (SELECT AVG(gj.Kosto)
FROM Gjakuu gj, Pacienti p
WHERE gj.Pacienti=p.Pacienti_Id
group by Tipi_i_Gjakut)



/* 2
te shfaqen te gjithe pacientet qe kane porosi te njejten sasi gjaku si klienti id=7
*/
select p.Pacienti_Id,(p.Emri + ' ' + p.Mbiemri) [Emri Pacientit], gj.Tipi_i_Gjakut, gj.Data
from Pacienti p inner join  Gjakuu gj
on p.Pacienti_Id=gj.Pacienti
where gj.Tipi_i_Gjakut=(
select gj.Tipi_i_Gjakut from Gjaku gj
where gj.Pacienti=7)

/* 3
Te shfaqen Pacientet te cile kane bere porosi me sasi me te larte se 500mL
*/
Select (p.Emri + ' ' + p.Mbiemri) [Emri Pacientit], p.Sasia_e_gjakut
From Pacienti p
where exists (Select p.Emri,p.Mbiemri, p.Sasia_e_gjakut
from Gjaku gj
where p.Pacienti_Id=gj.Pacienti and p.Sasia_e_gjakut > 500)


/* 4
Te shfaqen pacientet te cilet nuk kane pranuar sasine gjakut pra kane vlere null.
*/

Select p.Pacienti_Id,(p.Emri + ' ' + p.Mbiemri) [Emri Pacientit], p.Qyteti
From Pacienti p
Where not exists (Select p.Pacienti_Id, p.Emri, p.Mbiemri, gj.Gjaku_Id
from Gjaku gj
where p.Pacienti_Id=gj.Pacienti)


















