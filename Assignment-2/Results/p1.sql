SELECT Name as lazy_artist
FROM Artist
WHERE ArtistId NOT IN(
				SELECT ArtistId
				FROM Album
)
ORDER BY lazy_artist