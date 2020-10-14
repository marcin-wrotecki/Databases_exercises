-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-10-14 13:06:13.763

-- tables
-- Table: producenci
CREATE TABLE producenci (
    id_producenta int  NOT NULL,
    nazwa_producenta Text  NOT NULL,
    mail Text  NOT NULL,
    telefon Text  NOT NULL,
    CONSTRAINT producenci_pk PRIMARY KEY (id_producenta)
);

-- Table: produkty
CREATE TABLE produkty (
    id_produktu int  NOT NULL,
    nazwa_produktu Text  NOT NULL,
    cena Float  NOT NULL,
    id_producenta int  NOT NULL,
    CONSTRAINT produkty_pk PRIMARY KEY (id_produktu)
);

-- Table: zamowienia
CREATE TABLE zamowienia (
    id_zamowienia int  NOT NULL,
    liczba_sztuk int  NOT NULL,
    data date  NOT NULL,
    id_produktu int  NOT NULL,
    CONSTRAINT zamowienia_pk PRIMARY KEY (id_zamowienia)
);

-- foreign keys
-- Reference: produkty_producenci (table: produkty)
ALTER TABLE produkty ADD CONSTRAINT produkty_producenci
    FOREIGN KEY (id_producenta)
    REFERENCES producenci (id_producenta)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: zamowienia_produkty (table: zamowienia)
ALTER TABLE zamowienia ADD CONSTRAINT zamowienia_produkty
    FOREIGN KEY (id_produktu)
    REFERENCES produkty (id_produktu)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- sequences
-- Sequence: producenci_seq
CREATE SEQUENCE producenci_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- Sequence: produkty_seq
CREATE SEQUENCE produkty_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- Sequence: zamowienia_seq
CREATE SEQUENCE zamowienia_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- End of file.

