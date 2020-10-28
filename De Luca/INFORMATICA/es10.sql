# Romanzo: Il miglio verde, autore Stephen King
# Autori:  Stephen King, nazionalità Stati Uniti, nato nel 1947, ancora in vita
# Film: Il miglio verde, regista Frank Darabont, produttore “Vuoto”, anno  “Vuoto”
# Personaggi: Paul Edgecombe ruolo protagonista; John Coffey ruolo protagonista, William Wharton ruolo secondario


insert into Autori values ("Stephen King",1947,null,"Stati uniti");
insert into Romanzi values ("9788817881448","Il miglio verde","Stephen King",0);
insert into Personaggi values ("Paul Edgecombe",null,"M","P");
insert into Personaggi values ("John Coffey",null,"M","P");
insert into Personaggi values ("William Wharton",null,"M","S");
insert into Film values ("F0008","Il miglio verde","Frank Darabont","-",0,"9788817881448");

#Eseguire le seguenti modifiche:
#- Film Il miglio verde: Modificare il produttore in Frank Darabont e l'anno in 2000
# Romanzo Il miglio verde modificare l’anno in 1996

UPDATE film
SET produttore = "Frank Darabont", anno = 2000
WHERE codiceF = "F0008";

UPDATE romanzi
SET anno = 1996
WHERE codiceR = "9788817881448";


#Eseguire le seguenti query:
#- Visualizzare tutti i romanzi di cui è stato prodotto un film con titolo diverso da quello del romanzo stesso
#- Visualizzare tutti i romanzi e la quantità di film girati relativi al romanzo stesso
#- Visualizzare il numero di romanzi di ogni autore nato negli Stati Uniti
#- Visualizzare l'elenco degli anni e la quantità di film prodotti nell'anno stesso
#- Visualizzare i nomi dei personaggi che compaiono in più di un romanzo, ed il numero di romanzi nei quali compaiono
#- Visualizzare i romanzi di autori italiani dai quali sono stati tratti due film
#- Elenco completo dei registi e la quantità di film, di autori Italiani, prodotti nel decennio 2000 - 2010

SELECT romanzi.*, film.titolo
FROM romanzi
INNER JOIN film
ON film.codiceR = romanzi.codiceR
WHERE film.titolo <> romanzi.titolo;

SELECT COUNT(*), romanzi.nomeAutore
FROM romanzi
JOIN autori ON romanzi.nomeAutore = autori.nomeAutore
WHERE autori.nazione = "Stati uniti"
GROUP BY (romanzi.nomeAutore);

SELECT personaggi.nomeP, COUNT(*) as totRomanzi
FROM romanzi
INNER JOIN personaggi
ON personaggi.codiceR = romanzi.codiceR
GROUP BY(personaggi.nomeP)
HAVING COUNT(*) > 1;

SELECT romanzi.titolo
FROM romanzi
JOIN autori ON romanzi.nomeAutore = autori.nomeAutore
JOIN film ON film.codiceR = romanzi.codiceR
WHERE nazione = "Italia"
GROUP BY (romanzi.codiceR)
HAVING count(*) = 2;

SELECT film.titolo, count(*)
FROM film
WHERE film.anno BETWEEN 2000 AND 2010
GROUP BY(film.codiceF)
