CREATE TABLE ogrenciler10
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
iNSERT INTO ogrenciler10 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler10 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler10 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler10 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler10 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler10 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler10;


-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
delete from ogrenciler10 where isim= 'Mustafa Bak' or isim ='Nesibe Yilmaz';

select * from ogrenciler10;

-- Veli ismi Hasan olan datayi silelim
delete from ogrenciler10 where veli_isim = 'Hasan';

--truncate komutu kullanirsak tablodaki verilerin tamamini siler. icindeki verileri secmeli silme yapilmaz.

									-- TRUNCATE --
-- Bir tablodaki tum verileri geri alamayacagimiz sekilde siler. sartli silme yapmaz. 

Truncate table ogrenciler10




								-- ON DELETE CASCADE -- 
-- her defasinda once child table verilerini silmek yerine on delete cascade silme ozelligini aktif edebiliriz.
-- bunun icin foreign key olan satirin en sonuna on delete cascade komutunu yazmak yeterlidir. 
 
CREATE TABLE talebeler1
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler1(id)
on delete cascade
);

INSERT INTO talebeler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler1 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler1 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler1 VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler1 VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar1 VALUES ('123','kimya',75);
INSERT INTO notlar1 VALUES ('124', 'fizik',65);
INSERT INTO notlar1 VALUES ('125', 'tarih',90);
INSERT INTO notlar1 VALUES ('126', 'Matematik',90);

select * from talebeler1;
select * from notlar1;

-- notlar1 tablosundan id'si 123 olan datayi silelim.

DELETE FROM notlar1 where talebe_id = '123';
DELETE FROM talebeler1 where id = '126'; -- parent table'dan data silince child table'dan da direkt sildi cunku on delete cascade yazdik.
										 -- on delete cascade olmasaydi child table'dan silinmezdi.
/*
	1. tablolardan veri silmek icin.. normalde oncelikle  childdaki datayi silmemiz gerekir.
	2. child da on delete cascade kullanirsak... parent'dan datayi silebiliriz.
	3. bu durumda data hem parenttan hemde childdan silinir.
*/

/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
	parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
	data child tablo dan da silinir
*/


									-- IN CONDITION --
/*
BIRDEN FAZLA MANTIKSAL ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme imkani verir.
AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir.
OR (veya): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir.

select FROM musteriler WHERE urun_isim ='Orange' OR urun_isim ='Apple' OR urun_isim ='Apricot';
yerine 

SELECT * FROM musteriler WHERE urun_isim IN ('Orange', 'Apple', 'Apricot')
boyle yapmak yani 
*/
										 
