--5--
CREATE DATABASE Exercise_2;
CREATE SCHEMA sklep;
SET search_path TO sklep;
--komendy z sklep_create.sql (plik wygenerowany przez vertabelo)
--6--
INSERT INTO producenci VALUES (1,'Milka','milka@kontakt.pl','111111111'),(2,'Alpen Gold','alpenGold@kontakt.pl','222222222'),(3,'Dell','dell@kontakt.pl','333333333'),(4,'Lech','lech@kontakt.pl','444444444'),(5,'Samsung','samsung@kontakt.pl','555555555'),(6,'Lays','lays@kontakt.pl','666666666'),(7,'Pepsi','pepsi@kontakt.pl','777777777'),(8,'Caprio','caprio@kontakt.pl','888888888'),(9,'Razer','razer@kontakt.pl','999999999'),(10,'Reserved','reserved@kontakt.pl','101010101');

INSERT INTO produkty VALUES(1,'ciastka',4.00,1),(2,'czekolada',3.00,2),(3,'komputer',1500.00,3),(4,'piwo',2.50,4),(5,'smartfon',2500,5),(6,'chipsy',5.00,6),(7,'cola',3.50,7),(8,'sok',1.50,8),(9,'myszki komputerowe',250.00,9),(10,'Ubrania',50.00,10);

INSERT INTO zamowienia VALUES (1,500,'2020-02-10',1), (2,600,'2020-02-15',2),(3,270,'2020-02-12',3),(4,250,'2020-02-11',4),(5,350,'2020-02-18',5),(6,420,'2020-02-25',6),(7,130,'2020-02-2',7),(8,750,'2020-02-5',8),(9,240,'2020-02-7',9),(10,1000,'2020-03-1',10);


--7--
--PPM na nazwie bazy danych, kliknięcie opcji BACK-UP, wybranie sciezki, gdzie zapisac plik do backupu, create
--8--
----PPM na nazwie bazy danych, kliknięcie opcji Belete/Drop
--9--
--stworzenie nowej bazy danych
CREATE DATABASE backup_exercise_2;
--PPM na nazwie bazy danych, kliknięcie restore, wybranie pliku (w prawym dolnym rogu okienka -> zmienić rozszerzenie na .sql), select

--10--
--Dobrze, ale trzeba i tak wykonac polecenie  
SET search_path TO sklep;
--ALTER DATABASE "backup_exercise_2" RENAME TO "Exercise_2" ; --
--Ja zmieniłem nazwę w pgadmin

--11--
--Dodałem trochę danych
--INSERT INTO zamowienia VALUES (11,900,'2020-02-14',7),(12,100,'2020-02-10',5),(13,400,'2020-02-17',10),(14,150,'2020-02-10',1),(15,100,'2020-02-18',5),(16,700,'2020-02-14',9),(17,900,'2020-02-15',1),(18,450,'2020-01-10',2),(19,150,'2020-02-10',8),(20,200,'2020-02-10',1),(21,700,'2020-02-10',10),(22,350,'2020-02-10',7),(23,300,'2020-02-10',6),(24,600,'2020-02-22',8),(25,450,'2020-02-24',3),(26,500,'2020-01-26',8),(27,200,'2020-02-28',4);--
--a--
SELECT 'Producent: ' || nazwa_producenta || ' liczba_zamowien: ' || COUNT(z.id_produktu) || ', wartosc_zamowienia: ' || liczba_sztuk * cena FROM producenci AS p JOIN produkty AS pr ON p.id_producenta = pr.id_producenta JOIN zamowienia AS z ON pr.id_produktu = z.id_produktu GROUP BY p.id_producenta,z.liczba_sztuk,pr.cena;

--b--
SELECT 'Produkt: ' || nazwa_produktu || ' liczba_zamowien: ' || COUNT(z.id_produktu) FROM produkty AS pr JOIN zamowienia AS z ON pr.id_produktu = z.id_produktu GROUP BY pr.id_produktu;

--c--
SELECT * FROM produkty NATURAL JOIN zamowienia;
--d--
--DODAŁEM--
--e--
SELECT * FROM zamowienia WHERE EXTRACT(MONTH FROM data) = 1;
--f--
--SELECT EXTRACT(isodow FROM data)  FROM zamowienia;--
--select to_char(data, 'Day')FROM zamowienia;--
SELECT to_char(data, 'Day'),COUNT( to_char(data, 'Day')) as liczba FROM zamowienia GROUP BY to_char(data, 'Day') ORDER BY liczba DESC;

--g--
SELECT  nazwa_produktu , COUNT(z.id_produktu) AS liczba_zamowien FROM produkty AS pr JOIN zamowienia AS z ON pr.id_produktu = z.id_produktu  GROUP BY pr.id_produktu ORDER BY liczba_zamowien DESC;

--12--
--a--
SELECT 'Produkt ' || nazwa_produktu || ', ktorego producenten jest ' || nazwa_producenta ||', zamowiono ' || COUNT(pr.id_produktu) || ' razy'   FROM producenci AS p JOIN produkty AS pr ON p.id_producenta = pr.id_producenta JOIN zamowienia AS z ON pr.id_produktu = z.id_produktu GROUP BY nazwa_producenta, nazwa_produktu;
--b--
SELECT *, cena*liczba_sztuk AS wartosc FROM zamowienia NATURAL JOIN produkty ORDER BY cena*liczba_sztuk OFFSET 3 ;
--c--
CREATE TABLE klienci(id_klienta INT PRIMARY KEY, email TEXT, telefon TEXT);
INSERT INTO klienci VALUES (1, 'marcin@kontakt.pl','211111111'), (2, 'ania@kontakt.pl','122222222'),(3, 'kamil@kontakt.pl','233333333'),(4, 'kinga@kontakt.pl','244444444'),(5, 'krzystof@kontakt.pl','255555555'),(6, 'roman@kontakt.pl','266666666'),(7, 'miroslawa@kontakt.pl','277777777'),(8, 'ksenia@kontakt.pl','288888888'),(9, 'wiesia@kontakt.pl','299999999'),(10, 'zbyszek@kontakt.pl','200000000');
--d--
ALTER TABLE zamowienia ADD COLUMN id_klienta INT;
ALTER TABLE zamowienia ADD CONSTRAINT klient FOREIGN KEY(id_klienta) REFERENCES klienci(id_klienta);
UPDATE zamowienia SET id_klienta=1 WHERE id_produktu % 10 =0;
UPDATE zamowienia SET id_klienta=2 WHERE id_produktu % 10 =1;
UPDATE zamowienia SET id_klienta=3 WHERE id_produktu % 10 =2;
UPDATE zamowienia SET id_klienta=4 WHERE id_produktu % 10 =3;
UPDATE zamowienia SET id_klienta=5 WHERE id_produktu % 10 =4;
UPDATE zamowienia SET id_klienta=6 WHERE id_produktu % 10 =5;
UPDATE zamowienia SET id_klienta=7 WHERE id_produktu % 10 =6;
UPDATE zamowienia SET id_klienta=8 WHERE id_produktu % 10 =7;
UPDATE zamowienia SET id_klienta=9 WHERE id_produktu % 10 =8;
UPDATE zamowienia SET id_klienta=10 WHERE id_produktu % 10 =9;
--e--
SELECT id_klienta, nazwa_produktu, liczba_sztuk, liczba_sztuk*cena AS wartosc_zamowienia FROM klienci NATURAL JOIN zamowienia NATURAL JOIN produkty;
--f--
SELECT 'NAJCZĘŚCIEJ ZAMAWIAJĄCY ' || id_klienta AS klient, SUM(liczba_sztuk*cena) AS wartosc_zamowienia FROM klienci NATURAL JOIN zamowienia NATURAL JOIN produkty GROUP BY id_klienta ORDER BY COUNT(id_zamowienia) DESC LIMIT 1;
SELECT 'NAJRZADZIEJ ZAMAWIAJACY ' || id_klienta AS klient, SUM(liczba_sztuk*cena) AS wartosc_zamowienia FROM klienci NATURAL JOIN zamowienia NATURAL JOIN produkty GROUP BY id_klienta ORDER BY COUNT(id_zamowienia) LIMIT 1;
--g--
DELETE FROM produkty  WHERE id_produktu=(SELECT p.id_produktu FROM produkty AS p LEFT OUTER JOIN zamowienia AS z ON z.id_produktu = p.id_produktu WHERE id_zamowienia IS NULL);

--13--
--a--
CREATE TABLE numer (liczba INT);
--b--
CREATE SEQUENCE liczba_seq
AS INT
START WITH 100
INCREMENT BY 5
MINVALUE 0
MAXVALUE 125
CYCLE
--c--
INSERT INTO numer VALUES (nextval('liczba_seq')); --7 razy--
--d--
SELECT setval('liczba_seq',currval('liczba_seq')+6);
--e--
SELECT currval('liczba_seq');
SELECT nextval('liczba_seq');
--f--
DROP SEQUENCE liczba_seq;

--14--
--a--
SELECT usename AS role_name FROM pg_catalog.pg_user ORDER BY role_name desc;
--b--
CREATE USER SuperUser290321 LOGIN SUPERUSER;
CREATE ROLE guest290321;
GRANT SELECT ON ALL TABLES IN SCHEMA sklep TO guest290321;
SELECT usename AS role_name FROM pg_catalog.pg_user ORDER BY role_name desc;
--c--

--15--
--a--
BEGIN;
UPDATE produkty SET cena = cena+10;
COMMIT;
--b--
BEGIN;
	UPDATE produkty SET cena=1.1*cena WHERE id_produktu=3;
	SAVEPOINT S1;
	UPDATE zamowienia SET liczba_sztuk=1.25*liczba_sztuk;
	SAVEPOINT S2;
	DELETE FROM klienci WHERE id_klienta=(SELECT id_klienta AS klient FROM klienci NATURAL JOIN zamowienia NATURAL JOIN produkty GROUP BY id_klienta ORDER BY COUNT(id_zamowienia) DESC LIMIT 1);
    ROLLBACK TO SAVEPOINT S1;
	ROLLBACK TO SAVEPOINT S2;
	ROLLBACK;
COMMIT;

--c--
CREATE OR REPLACE FUNCTION udzial_procentowy(id_producenta INT)
RETURNS TEXT
AS 'SELECT nazwa_producenta || '' - '' || COUNT(id_producenta)*100/(SELECT COUNT(id_zamowienia) FROM zamowienia) || ''% wszystkich zamowien'' FROM producenci AS pr NATURAL JOIN produkty AS p NATURAL JOIN zamowienia AS z GROUP BY(pr.id_producenta);'
LANGUAGE SQL;

SELECT udzial_procentowy(2);
