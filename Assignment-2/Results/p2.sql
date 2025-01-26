SELECT Artist.Name as artist_name, COUNT(Track.Name) as num_tracks
FROM Artist
JOIN Album USING (ArtistId)
JOIN Track USING (AlbumId)
GROUP BY Artist.Name
HAVING num_tracks > 50 AND artist_name NOT IN ('Various Artists', 'The Office', 'Lost')
ORDER BY num_tracks DESC, artist_name
