--STORED PROCEDURES
/* 1
Nje stored procedure e cila permes output-it tregon perqindjen e dhuruesve te gjakut brenda dy datave te caktuara
(te dhena si inpute)
*/
alter procedure dhuruesitSipasDates1
(@startDate date,
@endDate date)
as
begin
declare @Dhuruesit int =(select count(*) from Dhuruesii)
declare @DhuruesitSipasDates int=(select count(*) from Dhuruesii dh
where dh.Data_E_Regjistrimit between @startDate and @endDate)


Print 'Dhuruesit qe jane regjistruar mes dates ' + convert(varchar, @startDate, 2) + ' dhe ' + 
convert(varchar, @endDate, 2) + ' jane ' + CAST((100*  @DhuruesitSipasDates/@Dhuruesit) as varchar(255)) + '  %'
end

dhuruesitSipasDates1 '2022-03-09','2022-08-09'

/* 2
Nje stored procedure e cila permes output-it tregon mesataren e dhuruesve te gjakut sipas qytetit
(te dhene si input)
*/
alter procedure pacientet
(@Qyteti varchar(255)
)
as
begin

declare @PacientetSipasGjakut int=(select avg(p.Sasia_e_gjakut) from Pacienti p
where p.Qyteti=@Qyteti)

Print 'Mesatarja e gjakut te dhuruar ne qytetin e ' +  @Qyteti + ' eshte ' + CAST((@PacientetSipasGjakut) as varchar(255))
end

pacientet 'Gjilan'

/*
3
Nje stored procedure e cila ne baze te inputeve te perdoruesit tregon nese sasia e dhuruar eshte me e madhe apo me e vogel se mesatarja e sasise se gjakut.
*/
alter procedure dhuruesitSipasSasiseSeGjakut
(@id varchar(255) ,
@emri varchar(255) out,
@mbiemri varchar(255) out,
@mesatarja float out,
@sasia int out
)
as
begin
select @emri = dh.Emri,@mbiemri= dh.Mbiemri,@mesatarja = avg(gj.Sasia_e_gjakut)
from Dhuruesi dh, Gjaku gj
where dh.Dhuruesi_Id=gj.Dhuruesi
group by dh.Emri, dh.Mbiemri

if(@sasia < @mesatarja)
Print 'Dhuruesi ' + ' ' + @emri + ' ' + @mbiemri + ' ka dhuruar gjak me shume se mesatarja e gjakut te grumbulluar.'

else
Print 'Dhuruesi ' + ' ' + @emri + ' ' + @mbiemri + ' ka dhuruar gjak me pak se mesatarja e gjakut te grumbulluar.'
end

declare @emri varchar(255), @mbiemri
varchar(255), @mesatarja float, @sasia int
exec dhuruesitSipasSasiseSeGjakut '5',1750,
@emri out, @mbiemri out, @mesatarja out


/*
4
Nje stored procedure e cila ne baze te inputeve te perdoruesit tregon nese pacienti eshte furnizuar me gjak ose jo.
*/
alter PROCEDURE pacientetSipasSasiseSeGjakut
@id varchar (50),
@sasia int
AS
BEGIN
SELECT p.Emri,p.Mbiemri, Sasia_e_gjakut=( CASE
WHEN @sasia between 0 and 499 THEN 'Pacienti ka pranuar me pak se 500mL'
WHEN @sasia between 500 and 1000 THEN 'Pacienti ka pranuar me shume se 500mL'
else NULL
END )
FROM Pacienti p
WHERE p.Pacienti_Id=@id
END

execute pacientetSipasSasiseSeGjakut '1', '300'


--5 Krijimi i procedures qe tregon nese Pacienti i Spitaleve Private ka marr vetem nje here gjak apo me shume se nje here
create proc PacientiSipasFatures
@IdInput int
as
Begin
declare @faturat int;
select @faturat = (select count(*) [faturat]
from Pacient_Privat pp inner join Fatura f on f.Pacienti_Privat=pp.Pacienti_Privat
where pp.Pacienti_Privat=@IdInput)

If @faturat>1
Begin
Print 'Pacienti ka marr me shume se nje here gjak'
End

Else
Begin
Print 'Pacienti ka marr vetem nje her gjak'
End
end

PacientiSipasFatures 1



--6 Krijimi i storage procedure qe shfaq dhuruesit ne baze te input Qyteti

create procedure DhuruesitSipasQytetit
@qyteti varchar(255)
as
Begin
select *
from Dhuruesi
where Qyteti like @qyteti

end

DhuruesitSipasQytetit 'Prishtine'

--7 Krijimi i procedures qe paraqet perqindjen ne baze te Tipit te Gjakut

create procedure PerqindjaSipasTipitTeGjakut
@tipi varchar (255)

as
Begin

declare @Gjaku int =(select count (*) from Gjaku)
declare @GjakuSipasTipit int =(select count(*) from Gjaku where Tipi_i_Gjakut=@tipi)

print 'Tipi i Gjakut ' +@tipi + ' eshte' + CAST ((100* @GjakuSipasTipit/@Gjaku) as varchar(255)) + ' %'
END

PerqindjaSipasTipitTeGjakut 'A+'

--8 Procedura qe tregon tipin e gjkut te Dhuruesit duke futur si input Id-ne e tij
create proc DhuruesiSipasTipitTeGjakut
@IdInput int

as
Begin
select Tipi_i_Gjakut = (select Case  
When Tipi_i_Gjakut= 'A+' Then
'Dhuruesi ka tipin e gjakut A pozitiv'

When Tipi_i_Gjakut= 'A-'Then
'Dhuruesi ka tipin e gjakut A negativ'

When Tipi_i_Gjakut= 'AB-'Then
'Dhuruesi ka tipin e gjakut AB negativ'

When Tipi_i_Gjakut= 'AB+'Then
'Dhuruesi ka tipin e gjakut AB pozitiv'

When Tipi_i_Gjakut= 'O+'Then
'Dhuruesi ka tipin e gjakut O pozitiv'

End )
from Gjaku g inner join Dhuruesi d on d.Dhuruesi_Id=g.Dhuruesi
where d.Dhuruesi_Id=@IdInput




end

DhuruesiSipasTipitTeGjakut 9




