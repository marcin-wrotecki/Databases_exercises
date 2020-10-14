-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-10-14 13:06:13.763

-- foreign keys
ALTER TABLE produkty
    DROP CONSTRAINT produkty_producenci;

ALTER TABLE zamowienia
    DROP CONSTRAINT zamowienia_produkty;

-- tables
DROP TABLE producenci;

DROP TABLE produkty;

DROP TABLE zamowienia;

-- sequences
DROP SEQUENCE IF EXISTS producenci_seq;

DROP SEQUENCE IF EXISTS produkty_seq;

DROP SEQUENCE IF EXISTS zamowienia_seq;

-- End of file.

