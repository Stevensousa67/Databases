SELECT *
FROM (
	SELECT Track.Name as track_name, Album.Title as album_title, Artist.Name as artist_name, Genre.Name as genre_name
	FROM Track
	JOIN Album USING (AlbumId)
	JOIN Artist USING (ArtistId)
	JOIN Genre USING (GenreId)
	JOIN PlaylistTrack USING (TrackId)
	JOIN Playlist USING (PlaylistId)
	WHERE Playlist.Name IN ('Grunge', '90''s Music') AND Track.Composer IS NULL
);