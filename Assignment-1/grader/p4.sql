SELECT DISTINCT Artist.Name as artist_name
from Playlist
JOIN PlaylistTrack USING (PlaylistID)
JOIN Track USING (TrackID)
JOIN Album USING (AlbumID)
JOIN Artist USING (ArtistID)
WHERE Playlist.Name is 'Heavy Metal Classic'
ORDER BY Artist.Name