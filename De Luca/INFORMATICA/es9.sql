use quintaa_esercizio8;

/*
	ROMANZI (CodiceR, Titolo, NomeAut*, Anno)
	PERSONAGGI (NomeP, CodiceR*, sesso, ruolo)
	AUTORI (NomeAut, AnnoN, AnnoM, Nazione)
	FILM (CodiceF, Titolo, Regista, Produttore, Anno, CodiceR*)
*/

/* Totale di film prodotti nel 2019 di romanzi del 17° secolo. */
SELECT COUNT(Film.Anno) as TotaleFilm2019
FROM Film 
INNER JOIN Romanzi
ON Film.CodiceR = Romanzi.CodiceR
WHERE Film.Anno = "2019" AND Romanzi.Anno LIKE "16%";

/*Elenco di tutti i romanzi con la relativa quantità di personaggi presenti nel romanzo.*/

SELECT Romanzi.Titolo, COUNT(Personaggi.NomeP) as nPersonaggi
FROM Romanzi 
INNER JOIN Personaggi
ON Romanzi.CodiceR = Personaggi.CodiceR
GROUP BY Romanzi.CodiceR;

/* Elenco di tutti i romanzi con la relativa quantità di personaggi presenti nel romanzo.*/
SELECT Autori.NomeAutore, COUNT(Romanzi.CodiceR)
FROM Autori 
INNER JOIN Romanzi
ON Autori.NomeAutore = Romanzi.NomeAutore
WHERE Autori.Nazione = "Italia"
GROUP BY Autori.NomeAutore;


# Elenco di Autori di cui è stato prodotto un film di un loro romanzo, mentre gli stessi erano ancora in vita.

SELECT Autori.NomeAutore
FROM Autori 
INNER JOIN Romanzi
ON Autori.NomeAutore = Romanzi.NomeAutore
INNER JOIN Film   
ON Romanzi.CodiceR = Film.CodiceR
WHERE Autori.AnnoM > Film.Anno OR Autori.AnnoM IS NULL;

/* Elenco di tuti i romanzi di cui è stato girato un film solo dopo la morte dell’autore.*/
SELECT Romanzi.Titolo
FROM Autori 
INNER JOIN Romanzi
ON Autori.NomeAutore = Romanzi.NomeAutore
INNER JOIN Film
ON Romanzi.CodiceR = Film.CodiceR
WHERE Film.Anno > Autori.AnnoM;