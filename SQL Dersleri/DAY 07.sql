-- DAY 07 --

-- 									DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.
-- DISTINCT genelde tek bir sutun gormek istenildiginde kullanilir, 
-- group by ise daha komplike aggregate methodlar falan varsa kullanilir

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);


INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun

-- Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyiniz
SELECT DISTINCT urun_isim 
FROM musteri_urun;

select urun_isim from musteri_urun
group by urun_isim; -- group by ile cozumu 

SELECT DISTINCT musteri_isim 
FROM musteri_urun;


-- Tabloda kac farkli meyve vardir ?
SELECT COUNT(DISTINCT urun_isim) AS urun_cesit_sayisi 
FROM musteri_urun;

SELECT COUNT(DISTINCT urun_isim) FROM musteri_urun
group by urun_isim; -- group by ile cozumu 

SELECT urun_isim, count (urun_isim) FROM musteri_urun
group by urun_isim;

-- FETCH NEXT (SAYI) ROW ONLY- OFFSET - LIMIT  

-- 1) Tabloyu urun_id ye gore siralayiniz

-- Musteri urun tablosundan ilk 3 kaydi listeleyiniz.
Select *  from musteri_urun order by urun_id 
FETCH NEXT 3 row only -- fetch ile cozumu 

select * from musteri_urun order by urun_id 
limit 3; -- limit ile cozumu


-- Musteri urun tablosundan ilk kaydi listeleyiniz.
select * from musteri_urun order by urun_id 
limit 1;

Select *  from musteri_urun order by urun_id 
FETCH NEXT 1 row only;


-- Musteri urun tablosundan son 3 kaydi listeleyiniz.
Select *  from musteri_urun order by urun_id desc
FETCH NEXT 3 row only;

select * from musteri_urun order by urun_id desc
limit 3;


-- 2) Sirali tablodan ilk 3 kaydi listeleyin
SELECT *
FROM musteri_urun 
ORDER BY urun_id
FETCH NEXT 3 ROW ONLY;

-- 3) Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin
SELECT *
FROM musteri_urun
ORDER BY urun_id
OFFSET 3 ROW
FETCH NEXT 4 ROW ONLY


CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

select * from maas order by maas

-- en yuksek maasi alan musteriyi listeleyiniz
select * from maas order by maas desc
select * from maas order by maas desc limit 1

-- Maas tablosundan en yuksek ikinci maasi listeleyiniz
select * from maas order by maas desc limit 1 offset 1
select * from maas order by maas desc offset 1 limit 1

-- satir atlamak istedigimizde offset komutunu kullaniriz.
select * from maas order by maas desc 
offset 1
fetch next 1 row only 

-- Maas tablosundan en dusuk 4. maasi listeleyiniz.
select * from maas order by maas offset 3 limit 2



 /*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns 
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */

-- DDL -- ALTER TABLE 

CREATE TABLE personel3  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel3 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel3 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel3 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel3 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel3 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel3 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel3 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel3

-- 1) ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel3
ADD ulke_isim varchar(20) DEFAULT 'Turkiye'; -- default yazarsak olusturdugumuz sutuna belirttigimiz veriyi tum satirlara girer

ALTER TABLE personel3
ADD zipcode varchar(30) -- default yazmazsak bos gelir

-- 2) Tabloya birden fazla field ekleme

ALTER TABLE personel3
ADD cinsiyet varchar(20) , ADD yas int;

-- 3) DROP tablodan sutun silme

ALTER TABLE personel3 
DROP COLUMN yas

-- 4) RENAME COLUMN sutun adi degistirme

ALTER TABLE personel3
RENAME COLUMN ulke_isim TO ulke_adi;

-- 5) RENAME tablonun ismini degistirme
ALTER TABLE personel3 
RENAME TO isciler

-- 6) TYPE/SET (modify) sutunlarin ozelliklerini degistirme

ALTER TABLE isciler
ALTER COLUMN ulke_adi TYPE varchar(30), 
ALTER COLUMN ulke_adi SET NOT NULL;

--Not: String data türünü numerik bir data türüne 
--dönüştürmek istersek;

ALTER COLUMN fieldname
TYPE int USING(fieldname::int) şeklinde yaparız.



 /*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu 
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
	
	Transaction baslatmak icin begin komutu kullanmamiz gerekir ve Transaction'i sonlandirkak icin commit komutunu calistirmaliyiz
	ama oracle'da beginle baslatmadan SAVEPOINT - ROLLBACK ile de baslatilabiliyor.
 */ 

CREATE TABLE ogrenciler2
(
id serial, -- serial data turu otomatik olarak 1'den baslayarak sirali olarak sayi atamasi yapar.
			-- insert into ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine default yazariz.
	
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x; -- begini baslatmadan savepoint baslatirsak hata verir
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

select * from ogrenciler2;
delete from ogrenciler2
 /*

	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz 
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.

	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden 
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu 
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki 
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka 
	"COMMIT" komutu kullanılır. 
 */