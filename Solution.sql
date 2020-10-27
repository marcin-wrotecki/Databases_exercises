--Wczytanie plikow .shp -- 
--wszedlem do folderu qgis_sample_data\qgis_sample_data\shapefiles i po kolei wczytywałem kolejne pliki
shp2pgsql -I -s 2263 airports.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 alaska.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 builtups.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 grassland.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 lakes.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 landice.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 majrivers.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 pipelines.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 popp.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 railroads.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 regions.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 rivers.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 storagep.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 swamp.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 trails.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 trees.shp |psql -U postgres -d Exercise_4
shp2pgsql -I -s 2263 tundra.shp |psql -U postgres -d Exercise_4
--Zmiana bazy danych z poziomu konsoli : \connect database_name  - \connect Exercise_4
--4--

SELECT DISTINCT p.* INTO tableB  FROM popp p, majrivers m WHERE p.f_codedesc LIKE 'Building' AND ST_DISTANCE(p.geom,m.geom)<100000;

--5--
CREATE TABLE airportsNew( id SERIAL PRIMARY KEY, name TEXT, geom GEOMETRY, elev NUMERIC);
INSERT INTO airportsNew(name, geom, elev) SELECT name, geom, elev FROM airports;

--a--
SELECT * FROM airportsNew ORDER BY ST_Y(ST_CENTROID(geom)) LIMIT 1;
SELECT * FROM airportsNew ORDER BY ST_Y(ST_CENTROID(geom)) DESC LIMIT 1;

--b--
INSERT INTO airportsNew(name,geom,elev) VALUES ('airportB',(SELECT ST_LINEINTERPOLATEPOINT(ST_SHORTESTLINE((SELECT geom FROM airportsNew ORDER BY ST_Y(ST_CENTROID(geom)) LIMIT 1),(SELECT geom FROM airportsNew ORDER BY ST_Y(ST_CENTROID(geom)) DESC LIMIT 1
)),0.5)),1000)

--6--
SELECT ST_Area(ST_BUFFER(ST_SHORTESTLINE(a.geom,l.geom),1000)) FROM airports a, lakes l WHERE a.name LIKE 'AMBLER' AND l.names LIKE 'Iliamna Lake';

--7--
SELECT vegdesc, SUM(area_km2) AS area FROM (SELECT vegdesc, t.area_km2 FROM trees t JOIN tundra tu ON t.geom = tu.geom) AS trees_area GROUP BY vegdesc;
SELECT vegdesc, SUM(area_km2) AS area FROM (SELECT vegdesc, t.area_km2 FROM trees t JOIN swamp s ON t.geom = s.geom) AS trees_area GROUP BY vegdesc;
