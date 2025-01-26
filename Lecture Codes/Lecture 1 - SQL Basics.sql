--select FirstName as fname, LastName as lname from Employee;
--select *, (UnitPrice * Quantity) as cost from InvoiceLine;
--select Name from Artist;
--select CONCAT(FirstName, ' ',  LastName) as FullName, Address, City, State, PostalCode, Country from Employee;
--select InvoiceId, UnitPrice, Quantity from InvoiceLine;
--select BillingCountry from Invoice where total > 10;
--select * from Track where Name like '%Rock%';
--select FirstName, LastName from Employee where ReportsTo is not NULL and City = 'Calgary';
--select BillingCity as 'german_city', concat('$', total) as 'total' from Invoice where BillingCountry is 'Germany' and total > 1;
--select * from Employee order by LastName, FirstName, BirthDate  DESC;
--select * from Invoice where BillingCountry is "USA" and total > 10 order by total desc, BillingState, BillingCity;
--select distinct BillingState from Invoice where BillingCountry is "USA" order by BillingState; // DISTINCT removes duplicates.
-- select city as 'city' from Customer where country is "Canada"
-- union all
-- select city as 'city' from Employee where Country is "Canada";

-- select city as 'city' from Customer where country is "Canada"
-- union 
-- select city as 'city' from Employee where Country is "Canada";

-- select city as 'city' from Customer where country is "Canada"
-- INTERSECT 
-- select city as 'city' from Employee where Country is "Canada";

-- select city as 'city' from Customer where country is "Canada"
-- EXCEPT
-- select city as 'city' from Employee where Country is "Canada";

--select * from Genre join MediaType;

-- select * 
-- from Track
-- join MediaType USING (MediaTypeId)
-- join Genre USING (GenreId)
-- where genre.Name= 'Jazz' AND Composer LIKE '%Miles Davis%'

-- select *
-- from Artist
-- join Album USING (ArtistId)
-- where Artist.Name LIKE 'Black%'
-- order by Artist.Name, Album.Title;

-- select *
-- from Artist
-- left join Album USING (ArtistId)
-- where Artist.Name LIKE 'Black%'
-- order by Artist.Name, Album.Title;

select Track.TrackId, Track.Name as tName, Track.Composer, Track.UnitPrice, Album.Title, MediaType.Name as mName, Genre.Name as gName
from Track
join Album USING (AlbumId)
join MediaType USING (MediaTypeId)
join Genre USING (GenreId)
where Track.Name is 'Give Me Novacaine';