-- GROUP BY DEVAMI :

CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel

-- Isme gore toplam maaslari bulun
select isim,sum(maas) from personel group by isim;

-- Personel tablosundaki isimleri gruplayiniz.
select isim from personel group by isim;

-- Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
SELECT sirket, COUNT (*) AS calisan_sayisi 
FROM personel
WHERE maas>5000
GROUP BY sirket;

-- Her sirket icin Min ve Max maasi bulun
SELECT sirket, MIN (maas) AS en_az_maas, MAX (maas) AS en_fazla_maas 
FROM personel
GROUP BY sirket;


-- 									HAVING CLAUSE
-- HAVING, AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur.

-- 1) Her sirketin MIN maaslarini eger 4000’den buyukse goster
Select sirket,min(maas) AS en_az_maas from personel
group by sirket
having min(maas)>4000;
/*
Having komutu yalnizca group by komutu ile kullanilir.
eger gruplamadan sonra bir sart varsa having komutu kullanilir
Where kullanimi ile ayni mantikla calisir.
*/


-- 2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi 
-- ve toplam maasi gosteren sorgu yaziniz
SELECT isim, SUM (maas) AS toplam_maas 
FROM personel
GROUP BY isim
HAVING SUM (maas) >10000;

-- 3) Eger bir sehirde calisan personel sayisi 1’den coksa 
-- sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir, COUNT (isim) AS toplam_personel_sayisi 
FROM personel
GROUP BY sehir
HAVING COUNT (isim)>1;

-- 4) Eger bir sehirde alinan MAX maas 5000’den dusukse 
-- sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir, MAX (maas) AS max_maas 
FROM personel
GROUP BY sehir
HAVING MAX (maas) <5000;


--						UNION OPERATOR
-- Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i 
-- ayni olmalidir.

-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz
SELECT isim AS isci_ve_sehirler, maas FROM personel WHERE maas > 4000
union
SELECT sehir,maas from personel where maas>5000;


-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
Select isim as isim_ve_sehir , maas from personel where isim = 'Mehmet Ozturk'
union 
select sehir,maas from personel where sehir='Istanbul';

-- 3) Sehirlerden odenen ucret 3000’den fazla olanlari ve personelden ucreti 5000’den az
-- olanlari bir tabloda maas miktarina gore sirali olarak gosteren sorguyu yaziniz



-- 								UNION OPERATOR
-- 						2 Tablodan Data Birlestirme

CREATE TABLE personel1
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
	
CONSTRAINT personel1_pk PRIMARY KEY (id)
	)
INSERT INTO personel1 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel1 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel1 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel1 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel1 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel1 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel1 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel1(id)
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel1
select * from personel_bilgi

-- id’si 12345678 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi 
-- tablosundan da tel ve cocuk sayisini yazdirin
Select sehir as sehir_ve_tel, maas as maas_ve_cocuk_sayisi from personel1 where id =123456789
union
select tel,cocuk_sayisi from personel_bilgi where id =123456789;

/*
								UNION ALL OPERATOR
UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesini alir.
UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.

NOT : UNION ALL ile birlestirmelerde de
1)Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali
2)Alt alta gelecek sutunlarin data type’lari ayni olmali
*/


-- Personel1 tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
Select isim,maas from personel1 where maas<5000
union
Select isim,maas from personel1 where maas<5000
-- union ==> cift, mukerrer, tekrarli veriler varsa onu teke dusurur ve bize o sekilde sonuc verir
-- union all ==> iki sorguyu da alt alta koydu ve calistirdi.Tekrarli verilerle birlikte tum sorgulari getirir 



-- 								INTERSECT OPERATOR

-- Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
select id from personel1  where sehir in('Istanbul','Ankara');
-- Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3);

--Iki sorguyu INTERSECT ile birlestirin
select id from personel1  where sehir in('Istanbul','Ankara')
intersect
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3);


-- 1) Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
select id from personel1 where maas not between 4800 and 5500;
-- 2) Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3);
-- 3) Iki sorguyu INTERSECT ile birlestirin
select id from personel1 where maas not between 4800 and 5500
intersect
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3);

-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select isim from personel1 where sirket='Honda'
intersect
select isim from personel1 where sirket='Ford'
intersect
select isim from personel1 where sirket='Tofas'



--							EXCEPT OPERATOR

/*
iki sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanilir
*/

-- 1) 5000’den az maas alip Honda’da calismayanlari yazdirin
SELECT isim,sirket from personel1 where maas<5000
EXCEPT
SELECT isim,sirket from personel1 where sirket='Honda'

