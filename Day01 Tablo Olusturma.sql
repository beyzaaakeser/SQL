CREATE TABLE ogrenciler1
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, -- ondalikli sayilar icin kullanilir (double gibi)
kayit_tarihi date
);


---- VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA ----


CREATE TABLE ogrenci_notlari
AS -- Benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin 
--normal tablo olustururkenki parantezler yerine AS kullanip SELECT komutuyla almak istedigimiz verileri aliriz
SELECT 
isim,soyisim,not_ort FROM ogrenciler1;



-- DML - DATA MANIPULATION LANGUAGE 
-- INSERT (Database'e veri ekleme)

INSERT INTO ogrenciler1 VALUES ('1234567','Said','Ilhan',85.5,now());
INSERT INTO ogrenciler1 VALUES ('1234567','Said','Ilhan',85.5,'2020-12-11');


--  BIR TABLOYA PARCALI VERI EKLEMEK ISTERSEK --
INSERT INTO ogrenciler1 (isim,soyisim) VALUES ('Erol','Evren');

-- DQL - DATA QUERY LANGUAGE --
-- SELECT 
select * FROM ogrenciler1 -- ogrenciler1 tablosundan her seyi sec dedik