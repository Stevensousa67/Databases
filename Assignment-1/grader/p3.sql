SELECT InvoiceLine.InvoiceLineID as invoice_line_id, Track.TrackId as track_id, Album.Title as album_title, Artist.Name as artist_name, Track.Name as track_name, MediaType.Name as media_type, ('$' || Track.UnitPrice) AS unit_price, InvoiceLine.Quantity as qty
from Invoice
JOIN InvoiceLine USING (InvoiceID)
JOIN Track USING (TrackID)
JOIN Album USING (AlbumID)
JOIN Artist USING (ArtistID)
JOIN MediaType USING (MediaTypeID)
WHERE Invoice.Total > 25
ORDER BY Album.Title, Artist.Name, Track.Name