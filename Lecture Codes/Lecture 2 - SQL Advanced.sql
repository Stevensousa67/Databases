-- select COUNT(*) from Employee
-- select COUNT(ReportsTo) from Employee
-- select COUNT(DISTINCT ReportsTo) from Employee
-- select SUM(UnitPrice), MIN(UnitPrice), MAX(UnitPrice), AVG(UnitPrice) from Track;

-- SELECT (MediaType.Name) as media_type, MIN(UnitPrice) as min_price, MAX(UnitPrice) as max_price, AVG(UnitPrice) as avg_price
-- FROM Track
-- JOIN MediaType USING (MediaTypeID)
-- GROUP BY MediaType.Name
-- ORDER BY avg_price DESC, MediaType.Name
-- 
-- SELECT *
-- FROM Track JOIN MediaType USING (MediaTypeId)
-- ORDER BY MediaType.Name;

-- SELECT InvoiceId, SUM(UnitPrice * Quantity) as total
-- FROM InvoiceLine
-- GROUP BY InvoiceId
-- ORDER BY total DESC, InvoiceId;

-- SELECT Invoice.BillingCity, Invoice.BillingState, ROUND(AVG(Invoice.Total),2) as avg_total, SUM(Invoice.Total) as sum_total, COUNT(*) as ct
-- FROM Invoice
-- WHERE BillingCountry is 'USA'
-- GROUP BY BillingCity, BillingState
-- ORDER BY avg_total DESC;

-- SELECT TrackId, Track.Name, Album.Title, COUNT(*) as num_sold
-- FROM Track 
-- JOIN InvoiceLine USING (TrackId)
-- JOIN Album USING (AlbumId)
-- JOIN Artist USING (ArtistId)
-- WHERE Artist.Name is 'Queen'
-- GROUP BY TrackId
-- ORDER BY num_sold DESC, Track.Name ASC;

-- SELECT TrackId, Track.Name, Album.Title, COUNT(*) as num_sold
-- FROM Track 
-- JOIN InvoiceLine USING (TrackId)
-- JOIN Album USING (AlbumId)
-- JOIN Artist USING (ArtistId)
-- WHERE Artist.Name is 'Queen'
-- GROUP BY TrackId
-- HAVING num_sold >= 2
-- ORDER BY num_sold DESC, Track.Name ASC;

-- SELECT Genre.Name as g_name, COUNT(DISTINCT AlbumId) AS cnt
-- FROM Track
-- JOIN Genre USING (GenreId)
-- GROUP BY Genre.Name
-- HAVING cnt >= 10
-- ORDER BY cnt DESC;

-- SELECT *
-- FROM Track
-- JOIN Album USING (AlbumId)
-- WHERE Album.Title is 'Jagged Little Pill'

-- SELECT *
-- FROM Track
-- WHERE AlbumId = (
-- 	SELECT AlbumId
-- 	FROM Album
-- 	WHERE Title is 'Jagged Little Pill'
-- );

-- SELECT *
-- FROM Track
-- JOIN Album USING (AlbumId)
-- JOIN Artist USING (ArtistId)
-- WHERE Artist.Name is 'Queen'

-- SELECT *
-- FROM Track
-- JOIN Album USING (AlbumId)
-- JOIN Artist USING (ArtistId)
-- WHERE Artist.Name = (
-- 	SELECT Name
-- 	From Artist
-- 	WHERE Name is 'Queen'
-- );

-- SELECT Name as artist_name, COUNT(AlbumId) as album_ct
-- FROM Artist
-- LEFT JOIN Album USING (ArtistId)
-- WHERE Name like '%Santana%'
-- GROUP BY Name

-- SELECT MIN(customer_tracks.total_tracks) as min_q, MAX (customer_tracks.total_tracks) as max_q, AVG(customer_tracks.total_tracks) as avg_q, COUNT (customer_tracks.CustomerId) as num_customers
-- FROM (
-- 				Select Customer.CustomerId, SUM(InvoiceLine.Quantity) as total_tracks
-- 				FROM InvoiceLine
-- 				JOIN Invoice USING (InvoiceId)
-- 				JOIN Customer USING (CustomerId)
-- 				GROUP BY CustomerId
-- ) customer_tracks

-- SELECT FirstName, LastName, SUM(total) as total_spent
-- FROM Customer
-- JOIN Invoice USING (CustomerId)
-- GROUP BY CustomerId
-- HAVING total_spent > 40
-- ORDER BY total_spent DESC, LastName, FirstName

-- SELECT q1.FirstName, q1.LastName, SUM(total) as total_spent
-- FROM(
-- 				SELECT * 
-- 				FROM Customer
-- 				JOIN Invoice USING (CustomerId)
-- ) q1
-- GROUP BY CustomerId
-- HAVING total_spent > 40
-- ORDER BY total_spent DESC, LastName, FirstName

CREATE VIEW q1 as 
SELECT FirstName, LastName, SUM(total) as total_spent
FROM Customer JOIN Invoice USING (CustomerId)
GROUP BY CustomerId;

SELECT *
FROM q1
WHERE total_spent > 40
ORDER BY total_spent DESC, LastName, FirstName

-- drop view q1;