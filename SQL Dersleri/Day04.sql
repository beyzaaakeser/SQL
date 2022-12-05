-- ODEV : 
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
select * from markalar;
select * from calisanlar2;

Select marka_id, calisan_sayisi FROM markalar 
WHERE marka_isim IN (Select isyeri from calisanlar2 where sehir = 'Ankara');


--									ALIASES
-- Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir.

CREATE TABLE calisanlar3 
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50) );

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar3;

-- Eger iki sutunun verilerini birlestirmek istersek concat sembolunu || kullaniriz. 
Select calisan_id As id, calisan_isim||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar3;

-- 2.YOL : 
Select calisan_id As id, concat(calisan_isim,calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar3;

-- iki sutun verisi arasina bosluk koymak :
Select calisan_id As id, calisan_isim||' ' ||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar3;

--										IS NULL CONDITION
-- Arama yapilan field’da NULL degeri almis kayitlari getirir

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50), 
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar;

-- Name sutununda null olan degerleri listeleyelim.
SELECT isim from insanlar where isim is null; 

-- Insanlar tablosunda sadece null olmayan degerleri listeleyiniz
SELECT isim from insanlar where isim is not null; 

-- Insanlar tablosunda null deger almis verileri no name olarak degistiriniz.
Update insanlar
set isim='No Name' where isim is null;


-- 								ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
*/

/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar (ASC ayni zamanda Natural siralama)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/

drop table if exists insanlar;

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50), adres
varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara'); 
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara'); 
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara'); 
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul'); 

select * from insanlar;

--Insanlar tablosundaki datalari adres’e gore siralayin
Select * from  insanlar order by adres;
Select * from  insanlar order by soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
SELECT * FROM insanlar where isim='Mine' order by ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir

-- Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin

Select * from insanlar where soyisim='Bulut' order by 4; -- field sirasina gore siraaladi. 4te adres var adrese gore siraliyor yani


-- 							ORDER BY field_name DESC CLAUSE

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin

SELECT *
FROM insanlar
ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin

SELECT *
FROM insanlar
ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eger sutun uzunluguna gore siralamak istersek length komutu kullaniriz 
Ve yine uzunlugu buyukten kucuge siralamak istersek sonuna DESC komutunu ekleriz.
*/

SELECT isim, soyisim
FROM insanlar
ORDER BY LENGTH (soyisim);

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT CONCAT (isim, ‘ ’ , soyisim) AS isim_soyisim
FROM insanlar
ORDER BY LENGTH(isim)+LENGTH(soyisim); -- concat ile cozumu

Select isim|| ' '||soyisim AS isim_soyisim from insanlar ORDER BY LENGTH (isim||soyisim); -- || ile cozumu 

SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH(isim||soyisim)
SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim)+LENGTH (soyisim)
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim)+LENGTH (soyisim)
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH (concat(isim,soyisim))


-- 									GROUP BY CLAUSE

-- Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT 
-- komutuyla birlikte kullanılır

CREATE TABLE manav
(
isim varchar(50), 
Urun_adi varchar(50), 
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav

-- Isme gore alinan toplam urunleri listeleyiniz
Select isim,sum(urun_miktar) AS alinan_toplam_urun from manav 
group by (isim);


-- Isme gore alinan toplam urunleri bulun ve urunleri buyukten kucuge listeleyiniz
Select isim,sum(urun_miktar) AS alinan_toplam_urun from manav 
group by (isim)
order by alinan_toplam_urun DESC

-- Urun ismine gore urunu alan toplam kisi sayisi
Select urun_adi,count (isim) from manav 
group by urun_adi;

Select isim, count(urun_adi) from manav
group by isim;

-- Alinan kilo miktarina gore musteri sayisi


