-- Notlar TechproEducation Data Science egitiminden alinmistir.

------------------------------------------------------------------------------------------------

-- GreenPages Database

------------------------------------------------------------------------------------------------

-- DERS: 11.12.24

------------------------------------------------------------------------------------------------

-- create table customers

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY, -- NOT NULL ve UNIQUE birlesimi
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  country     VARCHAR(50),
  score       INTEGER
                       ); -- Noktali virgülü DBeaver'da kullanmak zorunda degiliz.

------------------------------------------------------------------------------------------------

-- Insert customers data

INSERT INTO customers (customer_id, first_name, last_name, country, score) VALUES
(1, 'Maria', 'Cramer', 'Germany', 350),
(2, 'John', 'Steel', 'USA', 900),
(3, 'Georg', 'Pipps', 'UK', 750),
(4, 'Martin', 'Müller', 'Germany', 500),
(5, 'Peter', 'Franken', 'USA', NULL);

------------------------------------------------------------------------------------------------

-- create table orders

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id    SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  DATE,
  quantity    INTEGER
                    );

------------------------------------------------------------------------------------------------

-- create table employees

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id      SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  emp_country VARCHAR(50),
  salary      INTEGER
                       );

------------------------------------------------------------------------------------------------

-- DERS: 12.12.24

------------------------------------------------------------------------------------------------
/*
Komutlarin Sirasi     Komutlarin Arka Planda Calisma Sirasi

SELECT                FROM 
FROM                  WHERE
WHERE                 GROUP BY
GROUP BY              HAVING
HAVING                SELECT
ORDER BY              ORDER BY
LIMIT                 LIMIT */

------------------------------------------------------------------------------------------------

-- SORU: Customer tablosundaki  bütün fieldlari getirin.
-- Select'te * isaretiyle tablodan tüm fieldlari secip getirdik.

SELECT *
FROM customers

------------------------------------------------------------------------------------------------

-- SORU: Customer tablosundan sadece first_name ve country fieldlarini getirin.
-- Sütunlari yazarken araya virgül koymak gerekli

SELECT
	first_name,
	country
FROM customers c

------------------------------------------------------------------------------------------------

-- DERS: 13.12.24

------------------------------------------------------------------------------------------------

-- SELECT DISTINCT:
-- Sorgu sonucunda tekrar eden verileri cikarip yalnizca essiz (unique) verilerin görüntülenmesini saglar.
-- SORU: Country degerlerini tekrar eden degerler olmadan getiriniz.

SELECT DISTINCT
	country 
FROM customers c 

------------------------------------------------------------------------------------------------

-- DERS: 16.12.24

------------------------------------------------------------------------------------------------

-- create table orders

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id    SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  DATE,
  quantity    INTEGER
                    );
                   
INSERT INTO orders (order_id, customer_id, order_date, quantity) VALUES
(1001,1, '2021-01-11', 250),
(1002,2, '2021-04-05', 1150),
(1003,3, '2021-06-18', 500),
(1004,6, '2021-08-31', 750);

SELECT *
FROM orders o 

------------------------------------------------------------------------------------------------

-- create table employees

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id      SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  emp_country VARCHAR(50),
  salary      INTEGER
                       );

-- Insert employees data
                      
INSERT INTO employees (emp_id, first_name, last_name, emp_country, salary) VALUES
(1,'John', 'Steel', 'USA', 55000),
(2,'Ann', 'Labrune', 'France', 75000),
(3,'Marie', 'Bertrand', 'Brazil', 75000),
(4,'Georg', 'Afonso', 'UK', 75000),
(5,'Marie', 'Steel', 'UK', 75000);

SELECT *
FROM employees e 

------------------------------------------------------------------------------------------------























