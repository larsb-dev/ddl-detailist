CREATE DATABASE Detailist;

USE Detailist;

CREATE TABLE MWStSatz (
    mwst_art INT AUTO_INCREMENT,
    mwst_satz DECIMAL(3, 2) NOT NULL,
    PRIMARY KEY (mwst_art)
);

CREATE TABLE Kunde (
    kunden_nr INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    adresse VARCHAR(500) NOT NULL,
    telefon VARCHAR(20),
    email VARCHAR(100),
    PRIMARY KEY (kunden_nr)
);

CREATE TABLE Artikel (
    artikel_nr INT AUTO_INCREMENT,
    art_mwst INT NOT NULL,
    bezeichnung VARCHAR(500) NOT NULL,
    listenpreis DECIMAL(10, 2) NOT NULL,
    bestand INT NOT NULL,
    mindestbestand INT NOT NULL,
    PRIMARY KEY (artikel_nr),
    FOREIGN KEY (art_mwst) REFERENCES MWStSatz(mwst_art)
);

CREATE TABLE Bestellung (
    bestell_nr INT AUTO_INCREMENT,
    kunden_nr INT NOT NULL,
    bestell_datum DATE NOT NULL,
    liefer_datum DATE,
    PRIMARY KEY (bestell_nr),
    FOREIGN KEY (kunden_nr) REFERENCES Kunde(kunden_nr)
);

CREATE TABLE Bestellposition (
    bestellpos_nr INT AUTO_INCREMENT,
    bestell_nr INT NOT NULL,
    artikel_nr INT NOT NULL,
    menge INT NOT NULL,
    PRIMARY KEY (bestellpos_nr),
    FOREIGN KEY (bestell_nr) REFERENCES Bestellung(bestell_nr),
    FOREIGN KEY (artikel_nr) REFERENCES Artikel(artikel_nr)
);

CREATE TABLE Girokonto (
    giro_nr INT AUTO_INCREMENT,
    kunden_nr INT NOT NULL,
    iban VARCHAR(34) NOT NULL,
    bic VARCHAR(11) NOT NULL,
    PRIMARY KEY (giro_nr),
    FOREIGN KEY (kunden_nr) REFERENCES Kunde(kunden_nr)
);

INSERT INTO MWStSatz (mwst_satz) VALUES (3.80), (8.10);

INSERT INTO Kunde (name, adresse, telefon, email) VALUES
    ('Alice Example', '123 Main St, City', '0123456789', 'alice@example.com'),
    ('Bob Sample', '456 Side St, Town', '0987654321', 'bob@sample.com'),
    ('Charlie Test', '789 Market Ave, Village', '0172837465', 'charlie@test.com');

INSERT INTO Artikel (art_mwst, bezeichnung, listenpreis, bestand, mindestbestand) VALUES
    (1, 'Laptop', 999.99, 10, 2),
    ( 2, 'Book', 19.99, 8, 10),
    (1, 'Smartphone', 499.99, 20, 5),
    (2, 'Notebook', 5.99, 100, 20),
    (1, 'Monitor', 199.99, 15, 3);

INSERT INTO Bestellung (kunden_nr, bestell_datum, liefer_datum) VALUES
    (1, '2024-06-01', '2024-06-05'),
    (2, '2024-06-02', NULL),
    (1, '2024-06-03', '2024-06-10');

INSERT INTO Bestellposition (bestell_nr, artikel_nr, menge) VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 2, 3),
    (3, 2, 5);

INSERT INTO Girokonto (kunden_nr, iban, bic) VALUES
    (1, 'DE89370400440532013000', 'COBADEFFXXX'),
    (2, 'DE75512108001245126199', 'BHBLDEHHXXX');