SELECT DISTINCT Album.Title as album_title
FROM Album
JOIN Track USING (AlbumID)
JOIN Genre USING (GenreID)
WHERE Genre.Name is 'Bossa Nova'