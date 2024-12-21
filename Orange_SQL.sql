-- Notlar TechproEducation Data Science egitiminden alinmistir.

------------------------------------------------------------------------------------------------

-- OrangePages Database

------------------------------------------------------------------------------------------------

-- DERS: 12.12.24

------------------------------------------------------------------------------------------------

-- Tekli yorum satiri icin "--" kullanilir.
/*
 coklu
 yorum
 satiri icin /*...*/ arasina yazabiliriz. */

------------------------------------------------------------------------------------------------
/*
SORU: students isimli bir table olusturun. Bu table'da student_id, first_name,
      last_name, birth_date ve department olsun. (Data tiplerini uygun sekilde seciniz.)
      student_id field'i Primary Key olsun. */
 
DROP TABLE IF EXISTS students;
CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	birth_date DATE,
	department VARCHAR(50)
                      );

SELECT *
FROM students

------------------------------------------------------------------------------------------------

-- SORU: 5 Mayis 2000 dogumlu John Doe isimli ve Computer Science departmaninda calisan kisiyi ekleyelim.

INSERT INTO students (first_name, last_name, birth_date, department) VALUES
('John', 'Doe', '2000-05-15', 'Computer Science');

------------------------------------------------------------------------------------------------
/*
SORU: Alttaki girisleri students tablosuna yapiniz:

      Jane Smith, '1999-07-22', Mathematics,

      Emily' Johnson, 2001-03-18, Physics,

      Michael Brown, 1998-12-01, Biology */

INSERT INTO students (first_name, last_name, birth_date, department) VALUES 
('Jane', 'Smith', '1999-07-22', 'Mathematics'),
('Emily', 'Johnson', '2001-03-18', 'Physics'),
('Michael', 'Brown', '1998-12-01', 'Biology');

SELECT *
FROM students s

------------------------------------------------------------------------------------------------

-- Sadece belli fieldlara bilgi girisi yapalim.
-- first name: Alice, depart: Chemistry

INSERT INTO students (first_name, department) VALUES
('Alice', 'Chemistry')

------------------------------------------------------------------------------------------------

-- Tablo olusturma

CREATE TABLE ogrenciler(
	ogrenci_no char(7), -- Mutlaka 7 karakter yer kaplayacak
	isim varchar(20),
	soyisim varchar(30),
	not_ort real, -- Ondalikli sayilari belirtmek icin
	kayit_tarihi date
                       );

SELECT *
FROM ogrenciler o

------------------------------------------------------------------------------------------------

-- Var olan tablodan yeni tablo create etmek (isim, soyisim ve not_ort field'larini kullanarak)

CREATE TABLE ogrenci_notlar
AS
SELECT isim, soyisim, not_ort -- Avantaj: Kriterleri bir öncekinden ceker.
FROM ogrenciler o 

SELECT *
FROM ogrenci_notlar

------------------------------------------------------------------------------------------------

INSERT INTO ogrenciler VALUES
('1234567', 'Tom', 'Cruise', 85.5, '2024-12-12')

INSERT INTO ogrenciler VALUES
('2345678', 'Tom', 'Hanks', 95, now());

SELECT *
FROM ogrenciler o

------------------------------------------------------------------------------------------------

-- DERS: 13.12.24

------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS aktorler (
    id INTEGER,
    name VARCHAR(30),
    email VARCHAR(50)
                                    );

SELECT *
FROM aktorler a 

------------------------------------------------------------------------------------------------

-- Dizayn hatasindan dolayi yanlis girisi kabul eden datalar

INSERT INTO aktorler VALUES (1001, 'Kemal Sunal', 'aktor@gmail.com');
INSERT INTO aktorler VALUES (1002, 'Şener Şen', 'aktor@gmail.com');
/*
Üstteki girislerde unique constraint kriteri olmadigi icin ayni mail girisine yanlislikla izin
vermis olduk. Dizayn hatasi! */

------------------------------------------------------------------------------------------------

-- Tek field icin veri girisi:

INSERT INTO aktorler(name) VALUES ('Türkan Şoray');

------------------------------------------------------------------------------------------------

--CONSTRAINTS / KISITLAMALAR / BELIRLEYICILER
-- UNIQUE ve NOT NULL

CREATE TABLE ogrenciler2 (
	ogrenci_no char (7) UNIQUE, -- UNIQUE sütunda birden fazla NULL olabilir.
	isim varchar(20) NOT NULL,
	soyisim varchar(30) NOT NULL,
	not_ort real,
	kayit_tarihi date
);

INSERT INTO ogrenciler2 VALUES ('1234567', 'Ali', 'Yılmaz', 80, now())

INSERT INTO ogrenciler2 VALUES ('2345678', 'Ali', 'Veli', 90, now())

INSERT INTO ogrenciler2 VALUES ('2345679', ' ', 'Ece',  50, now()) -- Bosluk karakteri NULL degildir.

INSERT INTO ogrenciler2 (isim,soyisim) VALUES ('Bilal', 'Ece')

INSERT INTO ogrenciler2 (isim,soyisim) VALUES ('John', 'Steve')

-- Not: NULLlarin hepsi UNIQUE kabul edilir. 
--Her fieldda birden fazla null olabilir. (Postgre ve MysQL böyle kabul ediyor.)

SELECT *
FROM ogrenciler2 o

------------------------------------------------------------------------------------------------
/*
Primary Key:
            Eger bir field "primary key" olarak deklare edilmisse, 
            field datalari "unique" ve "not null" olmali.
            Bir tabloda sadece 1 tane "primary key" olabilir. */

-- Primary Key atamasi icin 1. yol:

CREATE TABLE ogrenciler3 (
	ogrenci_no char(7) PRIMARY KEY,
	isim varchar(20) NOT NULL,
	soyisim varchar(30) NOT NULL,
	not_ort real,
	kayit_tarihi date
                         );
                        
SELECT *
FROM ogrenciler3 o 

-- Primary Key atamasi icin 2. yol (Cok tercih edilmez.):

CREATE TABLE ogrenciler4( 
ogrenci_no char(7),
isim varchar(20) NOT NULL,
soyisim varchar (30) NOT NULL,
not_ort real,
kayit_tarihi date,
CONSTRAINT ogr_no_pk PRIMARY KEY(ogrenci_no)
                        );
                       
-- NOT: 2. metotta PK icin, istedigimiz özel ismi (custom) verebiliriz. (ogr_no_pk yazdik.)                      

SELECT *
FROM ogrenciler4 o

INSERT INTO ogrenciler4 VALUES ('1234567', 'Ali', 'Yılmaz', 80, now())

INSERT INTO ogrenciler4 (isim, soyisim) VALUES ('John', 'Steve')

-- Hata aliriz. Cünkü Primary Key olan ogrenci_no hücresini bos gecemeyiz.

------------------------------------------------------------------------------------------------

/*
Parent Tablo:
             Birincil anahtari (Primary Key) veya Unique Key iceren ve referans verilen tablodur.
             Diger bir deyisle, parent tablo, child tablonun foreign key tarafindan referans alinan tablodur.
             Child tablo, Foreign Key iceren ve parent tabloya referansla baglanan tablodur.
             Child tablo, parent tablonun primary key veya UNİQUE anahtarini Foreign Key olarak kendi
             icinde barindirir ve bu Foreign Key üzerinden parent tabloyla iliskilendirilir. */
/*
Foreign Key:
			Foreign Key baska bir tablodaki Primary Key ile iliskilendirilmis olmalidir.
			Deger olarak "null" kabul eder.
			Tekrarlanan verileri kabul eder.
			Bir tablo birden cok "Foreign Key" alanina sahip olabilir. */

------------------------------------------------------------------------------------------------

CREATE TABLE sirketler(
sirket_id integer, 
sirket varchar(50) PRIMARY KEY,
personel_sayisi integer
                      );

CREATE TABLE personel(
	id integer,
	isim varchar(50),
	sehir varchar(50),
	maas real,
	sirket varchar(50),
FOREIGN KEY(sirket) REFERENCES sirketler(sirket)
                     );

-- CONSTRAINT per_fk FOREIGN KEY(sirket) REFERENCES sirketler(sirket)); bu yazim seklinde custom foreign key baglanti ismi verilmis olur.
-- Personel tablosundaki sirket fieldi sirketler tablosundaki sirket ile iliskili olacak.
-- Personel tablosundaki her bir satir, sirketler tablosunda gercekten var olan bir sirkete ait olmalidir.
-- Eger sirketler tablosunda olmayan bir sirket adi personel tablosuna eklenmeye calisilirsa, bu islem hata verir.

------------------------------------------------------------------------------------------------

-- CHECK Constraints
-- Age ve salary icin veri giris sarti olusturalim:
-- salary 5000 den büyük olmali, age 0'dan kücük olmamali

CREATE TABLE person(
id INTEGER,
name VARCHAR(50),
salary REAL CHECK(salary>5000), -- 5000 degerinden yüksek giris olmali
age INTEGER CHECK(age>0)  -- negatif deger olmamali
                   );

SELECT * FROM person p 

INSERT INTO person VALUES (11, 'Ali Can', 6000, 35)

INSERT INTO person VALUES (12, 'Ruşen Ece', 5500, -3) -- Hatali giris: Age degeri sarti saglamiyor. (age>0)

INSERT INTO person VALUES (13, 'Ali Can', 4000, 45)  -- Hatali giris: Salary degeri sarti saglamiyor. (>5000)
 
------------------------------------------------------------------------------------------------

-- DERS: 16.12.24


