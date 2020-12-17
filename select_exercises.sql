/* Create a new file called select_exercises.sql. Do your work for this exercise in that file.

Use the albums_db database. */
USE albums_db;
SHOW TABLES;

##  Explore the structure of the albums table.
DESCRIBE albums;
# Write queries to find the following information.

## The name of all albums by Pink Floyd
SELECT * FROM albums 
	WHERE artist = "pink floyd";
	
## The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date, name FROM albums
	WHERE name LIKE "Sgt%";
	
## The genre for the album Nevermind
SELECT genre FROM albums
	WHERE name = 'nevermind';
	
## Which albums were released in the 1990s
SELECT name, release_date FROM albums
	WHERE release_date LIKE '199%';
	
## Which albums had less than 20 million certified sales
SELECT name, sales FROM albums
	WHERE sales < 20;
	
## All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT name, genre FROM albums
	WHERE genre ='rock';
	# they are only looking for genres that match rock, in order to get different types of rock it would be the following query because this will look for any type of rock in the genre list
		SELECT name, genre FROM albums
		WHERE genre LIKE '%rock%';