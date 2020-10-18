/*SEZIONE DDL*/

CREATE SCHEMA `es5`;

CREATE TABLE `es5`.`turista` (
  `id_Turista` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `dataNascita` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Turista`),
  UNIQUE INDEX `idturista_UNIQUE` (`id_Turista` ASC) VISIBLE);


CREATE TABLE `es5`.`viaggio` (
  `id_Viaggio` INT NOT NULL AUTO_INCREMENT,
  `nomeLocalita` VARCHAR(45) NOT NULL,
  `durata` INT NULL,
  `costo` DOUBLE NULL,
  `dataPartenza` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Viaggio`),
  UNIQUE INDEX `idviaggio_UNIQUE` (`id_Viaggio` ASC) VISIBLE);
  
  CREATE TABLE `es5`.`prenotazione` (
  `id_Prenotazione` INT NOT NULL AUTO_INCREMENT,
  `id_Turista` INT NOT NULL,
  `id_Viaggio` INT NOT NULL,
  `dataPrenotazione` VARCHAR(45) NULL,
  `tipoPagamento` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Prenotazione`, `id_Turista`, `id_Viaggio`),
  UNIQUE INDEX `id_Prenotazione_UNIQUE` (`id_Prenotazione` ASC) VISIBLE,
  INDEX `id_Turista_idx` (`id_Turista` ASC) VISIBLE,
  INDEX `id_Viaggio_idx` (`id_Viaggio` ASC) VISIBLE,
  CONSTRAINT `id_Turista`
    FOREIGN KEY (`id_Turista`)
    REFERENCES `es5`.`turista` (`id_Turista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Viaggio`
    FOREIGN KEY (`id_Viaggio`)
    REFERENCES `es5`.`viaggio` (`id_Viaggio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/*SEZIONE DML*/
USE es5;

INSERT INTO turista (nome, cognome, dataNascita, telefono)
VALUES 
("Riccardo","De Luca","01/01/2002","121983322"),
("Gianni","Feri","03/05/2002","121213322"),
("Piero","Croci","01/04/2002","323242343"),
("Mauro","Lotti","09/02/2002","323231333"),
("Pietro","Lazza","31/08/2002","323231444");

INSERT INTO viaggio (nomeLocalita, durata, costo, dataPartenza)
VALUES 
("Roma","3","1000","01/12/2022"),
("Firenze","1","2000","09/01/2021"),
("Siena","2","500","10/07/2021"),
("Parigi","10","29000","11/09/2021");

INSERT INTO prenotazione (id_Turista, id_Viaggio, dataPrenotazione, tipoPagamento)
VALUES
("1","4","10/10/2020","Denaro contante"),
("2","2","31/01/2020","Carta di credito"),
("2","1","11/11/2020","Assegno bancario"),
("5","3","01/10/2020","Assegno circolare");

/*SEZIONE DQL*/

/*
1- Trovare le informazioni dei viaggi di durata inferiore ai 15 giorni
2- Trovare le diverse località dei viaggi di durata tra i 7 e i 10 giorni e di costo inferiore a 500 €
3- Trovare le informazioni anagrafiche dei clienti il cui cognome inizia con “Ro” ordinate in ordine
alfabetico
4- Trovare le località dei viaggi prenotate dal cliente Mario Rossi
5- Trovare i tipi di pagamento effettuati dalla cliente Francesca Verdi
6- Trovare le località e le durate dei viaggi prenotati nel dicembre del 2018
7- Trovare per ogni cliente il costo totale dei viaggi prenotati
8- Trovare la media del costo dei viaggi prenotati
*/

SELECT *
FROM viaggio
WHERE durata < 15;

SELECT nomeLocalita
FROM viaggio
WHERE (durata BETWEEN 7 AND 10) AND (costo < 500);

SELECT *
FROM turista
WHERE cognome LIKE "Ro%"
ORDER BY cognome, nome;

SELECT nomeLocalita
FROM prenotazione
INNER JOIN turista
ON prenotazione.id_turista = turista.id_turista
INNER JOIN Viaggio
ON viaggio.id_viaggio = prenotazione.id_viaggio
WHERE nome = "Mario" AND cognome = "Rossi";

SELECT cognome, nome, tipoPagamento
FROM prenotazione
INNER JOIN turista
ON prenotazione.id_turista = turista.id_turista
WHERE nome = "Francesca" AND cognome = "verdi";

SELECT nomeLocalita, durata
FROM viaggio
WHERE dataPartenza LIKE "__/12/2018";

SELECT cognome, nome, SUM(v.costo)
FROM prenotazione as p
INNER JOIN turista as t
ON p.id_turista = t.id_turista
INNER JOIN viaggio as v
ON v.id_viaggio = p.id_viaggio
GROUP BY p.id_turista;

SELECT AVG(costo) as mediaCostoViaggi
FROM viaggio
INNER JOIN Prenotazione
ON viaggio.id_viaggio = prenotazione.id_viaggio

