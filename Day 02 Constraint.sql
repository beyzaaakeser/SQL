CREATE TABLE ogrenciler5
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, -- ondalikli sayilar icin kullanilir (double gibi)
kayit_tarihi date
);

--VAR OLAN BIR TABLODAN YENI BIR TABLO OLUSTURMAK 


CREATE TABLE NOTLAR 
AS
SELECT isim,not_ort FROM ogrenciler5;

select * from ogrenciler5;

-- INSERT TABLO ICINE VERI EKLEME 

INSERT INTO notlar VALUES('Sevim',93.5);
INSERT INTO notlar VALUES('Busra',91.5);
INSERT INTO notlar VALUES('Berna',98.5);
INSERT INTO notlar VALUES('Ayse',92.5);
INSERT INTO notlar VALUES('Fatma',95.5);

select * from notlar;

Create table talebeler
(
	isim varchar(20),
	notlar real
);

INSERT INTO talebeler VALUES('Sevim',93.5);
INSERT INTO talebeler VALUES('Busra',91.5);
INSERT INTO talebeler VALUES('Berna',98.5);
INSERT INTO talebeler VALUES('Ayse',92.5);
INSERT INTO talebeler VALUES('Fatma',95.5);

select * from talebeler

-- bir field'in tekrarsiz deger alabvilmesi icin data typeinden sonra UNIQUE yazmak gerekir
-- ornek : id char(4) UNIQUE, isim varchar(20) ==> burada id unique bir deger ama isim unique degil.

CREATE TABLE ogrenciler7
(
ogrenci_no char(7) UNIQUE, -- constrait olarak table'lar kisminda veriyor
isim varchar(20) NOT NULL, -- isim sutunu bos gecilmesin dedik. not null ayri yazilir 
soyisim varchar(25),
not_ort real, -- ondalikli sayilar icin kullanilir (double gibi)
kayit_tarihi date
);

select * from ogrenciler7;

insert into ogrenciler7 VALUES ('1234567','Beyza','Keser',75.5,now());
insert into ogrenciler7 VALUES ('1234568','Ali','Veli',75.5,now());
insert into ogrenciler7 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5); -- not null kisitlamasi oldugu icin bu veri eklenemez

-- primary key atamasi

CREATE TABLE ogrenciler8
(
ogrenci_no char(7) primary key, -- primary key constraint'dir.
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarihi date
);

-- primary key atamasi 2. yol 

CREATE TABLE ogrenciler9
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarihi date,
	constraint ogr Primary key (ogrenci_no) -- primary'i key'e kendimiz isim vererek olusturduk.
);
-- primary key olan table'a parent table denir.
-- foreign key olan table'a ise child table denir.
-- eger parent child kurduysak once child tablosunu sonra parent tablosunu silmek gerekiyor. mecburi


-- FOREIGN KEY 
/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

Create table tedarikciler3 (
	tedarikci_id char(5) primary key, 
	tedarikci_ismi varchar(20),
	iletisim_isim varchar(20)
);

Create table urunler (
tedarikci_id char(5), 
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id) 
	-- foreign key bu sekilde olusturuluyor. 
	-- urunler tablosundaki tedarikci id'yi foreign yap, referans olarak tedarikciler 3'teki tedarikci id ile iliskilendir dedik		
);

select * from tedarikciler3;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. 
“id” yi Primary Key yapin,
“isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.
Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun.
“adres_id” field‘i ile Foreign Key oluşturun.
*/

Create table calisanlar(
	id char(15) primary key,
	isim varchar(30) unique,
	maas int not null,
	ise_baslama date
	
);

Create table adresler(
	adres_id char(30),
	sokak varchar(30),
	cadde varchar(30),
	sehir varchar(30),
	foreign key (adres_id)REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --unique cons. oldugu icin kabul etmedi, isimden var dedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maasi not null olamaz dedik buraada null oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- unique olmali iki tane can olmaz
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- syntax hatasi. integer dedigin maas yerine hiclik yani string girmeye calisiyorsun dedi
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- ikinci hicligi kabul etmedi, primary key
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- ayni primary key 10002 den dolayi kabul etmedi
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key null kabul etmez o yuzden hata verdi

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
-INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep'); -- Parent tabloda olmayan id ile child a ekleme yapamayiz 

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar;
select * from adresler;

-- CHECK CONSTRAINT
CREATE TABLE calisanlar1
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000) not null,
ise_baslama date
);

Insert into calisanlar1 Values ('10002','Mehmet Yilmaz',19000, '2018-04-14');

-- DQL --- WHERE KULLANIMI

SELECT * FROM calisanlar;
select isim from calisanlar;

-- Calisanlar tablosundan maasi 5000'den buyuk olan isimleri listeleyiniz

SELECT isim, maas from calisanlar WHERE maas>5000;

-- calisanlar tablosundan ismi veli han olan tum verileri listeleyiniz.
Select * from calisanlar where isim = 'Veli Han';

-- calisanlar tablosundan maasi 5000 olan tum verileri listeleyiniz.
select * from calisanlar where maas = 5000;


-- DML --- DELETE KOMUTU 
delete from calisanlar; -- eger parent tablo baska bir child tablo ile iliskili ise once child tablo silinmelidir.
delete from adresler;
select * from adresler; -- artik tablo bos gelecek cunku her seyi sildik deletge ile 

select * from adresler;-- tekrar ekleme yapip yazdirdik tablonun icine geldi

-- Adresler tablosundan sehri antep olan verileri silelim
delete from adresler where sehir = 'Antep';

 
CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);


