SELECT Album.Title AS album_title, Artist.Name AS artist_name, Track.Name AS track_name, MediaType.Name AS media_type, '$' || Track.UnitPrice AS unit_price
FROM Album
JOIN Artist USING (ArtistId)
JOIN Track USING (AlbumId)
JOIN MediaType USING (MediaTypeId)
WHERE Album.AlbumId IN (
    SELECT Album.AlbumId
    FROM Track
    JOIN Album USING (AlbumId)
    JOIN Artist USING (ArtistId)
    JOIN MediaType USING (MediaTypeId)
    WHERE (MediaType.Name LIKE '%video%' AND Track.UnitPrice <> 1.99) OR (MediaType.Name LIKE '%audio%' AND Track.UnitPrice <> 0.99)
)
ORDER BY Track.TrackId