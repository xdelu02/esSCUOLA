# 1- Il titolo dei romanzi del 19° secolo
SELECT titolo
FROM romanzi
WHERE anno LIKE "18%";

# 2- Il titolo, l’autore e l’anno di pubblicazione dei romanzi di autori russi, 
# ordinati per autore e, per lo stesso autore, ordinati per anno di pubblicazione
SELECT romanzi.titolo, romanzi.nomeAutore, romanzi.anno
FROM romanzi
INNER JOIN autori
ON autori.nomeAutore = romanzi.nomeAutore
WHERE autori.nazione = "Russia"
ORDER BY autori.nomeAutore, romanzi.anno;

# 3- I personaggi principali (ruolo =”P”) dei romanzi di autori viventi.
SELECT personaggi.*
FROM personaggi
INNER JOIN romanzi
ON romanzi.codiceR = personaggi.codiceR
INNER JOIN autori
ON autori.nomeAutore = romanzi.nomeAutore
WHERE personaggi.ruolo = 'P' AND autori.annoM IS NULL;

#4. I romanzi dai quali è stato tratto un film con lo stesso titolo del romanzo
SELECT romanzi.*, film.titolo
FROM romanzi
INNER JOIN film
ON film.codiceR = romanzi.codiceR
WHERE film.titolo = romanzi.titolo;

#5- Il titolo, il regista e l’anno dei film tratti dal romanzo “Robin Hood”
SELECT film.titolo, film.regista, film.anno
FROM romanzi
INNER JOIN film
ON film.codiceR = romanzi.codiceR
WHERE romanzi.titolo = "Robin hood";

#6- Per ogni autore italiano, l’anno del primo e dell’ultimo romanzo.
SELECT romanzi.nomeAutore, MIN(romanzi.anno) as primoRomanzo, MAX(romanzi.anno) as ultimoRomanzo
FROM romanzi
INNER JOIN autori
ON autori.nomeAutore = romanzi.nomeAutore
WHERE autori.nazione = "Stati uniti"
GROUP BY (autori.nazione);

#7- I nomi dei personaggi che compaiono in più di un romanzo, ed il numero dei romanzi nei quali compaiono
SELECT personaggi.nomeP, COUNT(*) as totRomanzi
FROM romanzi
INNER JOIN personaggi
ON personaggi.codiceR = romanzi.codiceR
GROUP BY(personaggi.nomeP)
HAVING COUNT(*) > 1;

#8- I romanzi di autori italiani dai quali è stato tratto più di un film
SELECT romanzi.titolo
FROM romanzi
INNER JOIN autori
ON autori.nomeAutore = romanzi.nomeAutore
INNER JOIN film
ON film.codiceR = romanzi.codiceR
WHERE autori.nazione = "Italia"
GROUP BY (film.codiceR)
HAVING COUNT(film.codiceR) > 1;







