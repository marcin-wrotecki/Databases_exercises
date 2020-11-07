CREATE EXTENSION postgis; 
--1--
CREATE TABLE obiekty(id SERIAL PRIMARY KEY,name text,geom GEOMETRY);
--a--
INSERT INTO obiekty(name, geom) VALUES ('obiekt1',ST_COLLECT( Array['LINESTRING(0 1, 1 1)', 'CIRCULARSTRING(1 1, 2 0, 3 1)' , 'CIRCULARSTRING(3 1, 4 2, 5 1)' , 'LINESTRING(5 1, 6 1)']));
--b--
INSERT INTO obiekty(name, geom) VALUES ('obiekt2', ST_BuildArea(ST_Collect( Array['LINESTRING(10 6, 14 6)', 'CIRCULARSTRING(14 6, 16 4, 14 2)' , 'CIRCULARSTRING(14 2, 12 0, 10 2)','LINESTRING(10 2, 10 6)', 'CIRCULARSTRING(11 2, 13 2, 11 2)'])));
--c--
INSERT INTO obiekty(name, geom) VALUES ('obiekt3',ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))',0));
--d--
INSERT INTO obiekty(name, geom) VALUES ('obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)',0));
--e--
INSERT INTO obiekty(name, geom) VALUES ('obiekt5', ST_GeomFromText('MULTIPOINT((30 30 59),(38 32 234))',0));
--f--
INSERT INTO obiekty(name, geom) VALUES ('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION( LINESTRING(1 1, 3 2) , POINT(4 2))',0));
--2--
SELECT ST_AREA(ST_BUFFER(ST_SHORTESTLINE(o1.geom,o2.geom),5)) FROM obiekty AS o1, obiekty AS o2 WHERE o1.name LIKE 'obiekt3' and o2.name LIKE 'obiekt4';
--3--
--Aby zmienić obiekt 4 w poligon musi on mieć przestrzeń zamkniętą - musimy załatać dziurę -- 
UPDATE obiekty SET geom =(SELECT ST_BUILDAREA(ST_COLLECT(o1.geom,ST_GEOMFROMTEXT('LINESTRING(20 20, 20.5 19.5)'))) FROM obiekty o1 WHERE o1.name LIKE 'obiekt4') WHERE name LIKE 'obiekt4';
--4--
INSERT INTO obiekty(name, geom) VALUES ('obiekt7', (SELECT ST_COLLECT(o1.geom, o2.geom) FROM obiekty o1, obiekty o2 WHERE o1.name LIKE 'obiekt3' AND o2.name LIKE 'obiekt4'));
--5--
SELECT name, ST_AREA(ST_BUFFER(geom,5)) FROM obiekty WHERE NOT ST_HASARC(geom);