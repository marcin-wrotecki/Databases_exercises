--Wczytanie danych --
CREATE DATABASE exercise_5;
\c exercise_5
CREATE EXTENSION postgis;
shp2pgsql -I -s 2263 airports.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 alaska.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 builtups.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 grassland.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 lakes.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 landice.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 majrivers.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 pipelines.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 popp.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 railroads.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 regions.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 rivers.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 storagep.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 swamp.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 trails.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 trees.shp |psql -U postgres -d exercise_5
shp2pgsql -I -s 2263 tundra.shp |psql -U postgres -d exercise_5


/*Następnie wczytano dane w aplikacji QGIS poprzez połączneie z bazą postgresa--
/*1*/
/*Aby zmienić kolor należy kliknąć prawym przyciskiem myszki na tabelę trees, dodać warstwę do projektu, następnie  kliknąć PPM na warstwę trees, wybrać właściwości, styl, wybrać wartość unikalną, wybrać wartość vegdesc, sklasyfikować i wybrać odpowiednie kolory.
/*Aby obliczyć polę powierzchni należy posłużyć się wtyczką Group Stats (należy ją zainstalować), następnie ją uruchomić, wybrać warstwę trees i przesunąć z Fields do Rows -> vegdesc a do Value -> sum, area_km^2, a następnie wcisnąć calculate
 Otrzymane wartości
Deciduous - 165378
Evergreen 164579
Mixed Trees -> 189273
*/
/*2*/
/* Należy wcisnąć na pasku Wektor ->Narzędzia zarządzania danymi -> Podziel warstwę wektorową ->wybrać jako warstwę wejściową trees, jako pole z unikalnym ID -> vegdesca i katalog docelowy i uruchom (należy wcześniej wejść w ustawienia -> opcje -> processing- > ogólne i w opcji filtrowanie nieprawidłowych obiektów zaznaczyć pomiń (ignoruj) obiekty z nieprawidłowymi geometrami
/*3*/
/*Dodaje warstwy regions oraz railroads, klikam PPM na regions, otwórz tabelę atrybutów - znajduje Matanuska-Susistna i kopiuję go. Następnie wchodzę w zakładkę edycja->wklej obiekty jako -> nowa warstwa wektorowa - powstaje nowy plik i warstwa
Następnie wchodzę w zakładkę Wektor -> narzędzia geoprocesingu -> przytnij i wybieram railroads oraz nową warstwę - Matanuska-Susistna i zapisuję  w nowym /pliku. Aby policzyć długość należy kliknąć nowopowstałą warstwę, otwórz tabelę atrybutów, wybrać kalkulator pół oraz w polu wyrażenie wpisać sum($length) -> wynik 262604 m
/*4*/
/*Dodaję warstwę airports, wchodzę we wtyczkę group stats. Klikam Filter i wpisuję "use" LIKE 'Military', potem w ROWS umieszczam wartość use, a w values elev oraz average
Rezultat:
Military 593,25 [m n.p.m]
Aby obliczyć ilość należy zamienić average na count
Military 8
Aby policzyć ilość lotnisk militarnych, które są położone powyżej 1400 m n.p.m. należy w filter napisać warunek
"use" LIKE 'Military' and "elev" >= 1400
Jest tylko jedno takie lotnisko
Military 1
Aby je usunąć, należy kliknać w zakładkę Feature -> show selected on map , włączyć tryb edycji i kliknąć na przycisk (poniżej zakładek) "Usuń zaznaczone"
/*5*/
/*Klikam PPM na regions, otwórz tabelę atrybutów - znajduje Bristol Bay i kopiuję go. Następnie wchodzę w zakładkę edycja->wklej obiekty jako -> nowa warstwa wektorowa - powstaje nowy plik i warstwa

Dodaje warstwę pop -> potem wektor (jeśli znikły opcję to włączyć wtyczkę processing) -> narzędzie geoprocessingu->przytnij -> wybieram warstwy popp i Bristol Bay, uruchom i otrzymuję nową warstwę.
Liczba obiektów - 11 (PPM na nowej warstwie i wyświetl liczbę obiektów - drugi sposób na policzenie liczby obiketów)

Aby policzyć liczbę obiektówów, położonynych nie dalej niż 100 km od rzeki, należy dodać warstwę rivers  i stworzyć buffor (wektor->narzędzia geopocessingu-> buffor, wybrać warstwę, odległość 100 km). Następnie zrobić analogicznie przycięcie - > nadal wyszło 11
/*6*/
/*Należy dodać warstwę majrivers, następnie wektor -> narzędzia analizy-> przycięcia linii i wybrać railroads i majrivers, stworzyć nową warstwę i na niej PPM i wyświetl liczbę obiektów (8)
/*7*/
/*Wektor -> narzędzia geometrii -> wydobądź wierzchołki, wybrać warstwę railroads, uruchom, wyświetl liczbę obiektów (662)
/*8*/
/*Należy stworzyć buffor dla warstwy airports (wektor->narzędzia geopocessingu-> buffor, 100km) i railroads (wektor->narzędzia geopocessingu-> buffor, 50km)
Następnie Wektor-> Narzędzia geoprocesingu -> różnica -> wybrać utworzone buffory airports i railroads i otrzymana warstwa to rozwiązanie zadania (nie mogłem znaleźć warstwy z siecią dróg)
/*9*/
/*
Należy dodać warstwę swamp, obliczyć wierzchołki [7469] (Wektor -> narzędzia geometrii -> wydobądź wierzchołki) i policzyć powierzchnię [24719,8 km2] (wtyczka GroupStats i do value areakm2 i sum)
Aby uprościć klikamy wektor-> narzędzia geometrii -> uprość geometrię, wybieramy warstwę swamps i tolerację 100m. Analogicznie liczę polę i liczbę wierzchołków
- powierzchnia  - 24719.8 - bez zmian
- wierzchołki -6175 - roznica 1294
*/ 