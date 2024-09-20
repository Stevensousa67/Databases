SELECT Album.Title as album_title, Track.TrackID as track_id, Track.Name as track_name, Track.Milliseconds / 60000 AS minutes, CAST((Track.Milliseconds % 60000) / 1000.0 + 0.5 AS INT) AS seconds
from Album
LEFT JOIN Track USING (AlbumID)
LEFT JOIN Artist USING (ArtistID)
WHERE Artist.Name is 'The Black Crowes'
ORDER BY Album.Title, Track.TrackID;
