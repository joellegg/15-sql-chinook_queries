/* 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US. */
SELECT c.CustomerId, c.FirstName, c.LastName, c.Country
FROM Customer c
WHERE Country <> 'USA'
ORDER BY Country ASC

/* 2. Provide a query only showing the Customers from Brazil. */
SELECT c.CustomerId, c.FirstName, c.LastName, c.Country
FROM Customer c
WHERE Country = 'Brazil'

/* 3. Provide a query showing the Invoices of customers who are from Brazil.
The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country. */
SELECT c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.BillingCountry = 'Brazil'

/* 4. Provide a query showing only the Employees who are Sales Agents. */
SELECT e.LastName, e.Title
FROM Employee e
WHERE e.Title = 'Sales Support Agent'

/* 5. Provide a query showing a unique list of billing countries from the Invoice table. */
SELECT i.BillingCountry
FROM Invoice i
GROUP BY i.BillingCountry

/* 6. Provide a query showing the invoices of customers who are from Brazil. */
SELECT *
FROM Invoice  i
WHERE i.BillingCountry = 'Brazil'

/* 7. Provide a query that shows the invoices associated with each sales agent.
The resultant table should include the Sales Agent's full name. */
SELECT e.FirstName, e.LastName, c.LastName AS 'Customer Last Name', i.*
FROM Employee e
JOIN Invoice i ON i.CustomerId = c.CustomerId
JOIN Customer c ON c.SupportRepId = e.EmployeeId

/* 8. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers. */
SELECT i.Total, c.FirstName AS 'Customer First', c.LastName AS 'Customer Last', c.Country, e.FirstName AS 'Employee First', e.LastName AS 'Employee Last'
FROM Invoice i
JOIN Employee e ON e.EmployeeId = c.SupportRepId
JOIN Customer c ON c.CustomerId = i.CustomerId

/* 9. How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years? */
SELECT strftime('%Y', i.InvoiceDate) AS Year, COUNT(i.InvoiceDate) AS Count, SUM(i.Total) AS Total_Sales
FROM Invoice i
WHERE (i.InvoiceDate LIKE '2011%' OR i.InvoiceDate LIKE '2009%')
GROUP BY strftime('%Y', i.InvoiceDate)

/* 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37. */
SELECT COUNT(il.InvoiceLineId)
FROM InvoiceLine il
WHERE il.InvoiceId = 37

/* 11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
HINT: [GROUP BY](http://www.sqlite.org/lang_select.html#resultset) */
SELECT il.InvoiceId, COUNT(il.InvoiceLineId) As number_of_lines
FROM InvoiceLine il
GROUP BY il.InvoiceId

/* 12. Provide a query that includes the track name with each invoice line item. */
SELECT il.*, t.Name
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId

/* 13. Provide a query that includes the purchased track name AND artist name with each invoice line item. */
SELECT il.*, t.Name, a.Name As Artist
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
JOIN Album al ON al.AlbumId = t.AlbumId
JOIN Artist a ON a.ArtistId = al.ArtistId

/* 14. Provide a query that shows the # of invoices per country.
HINT: [GROUP BY](http://www.sqlite.org/lang_select.html#resultset) */
SELECT i.BillingCountry, COUNT(i.BillingCountry) AS number_of_invoices
FROM Invoice i
GROUP BY i.BillingCountry
ORDER BY number_of_invoices DESC

/* 15. Provide a query that shows the total number of tracks in each playlist.
The Playlist name should be included on the resultant table. */
SELECT pl.Name, COUNT(plt.TrackId) AS number_of_tracks
FROM PlayList pl
JOIN PlayListTrack plt ON plt.PlayListId = pl.PlayListId
GROUP BY pl.Name


/* 16. Provide a query that shows all the Tracks, but displays no IDs.
The resultant table should include the Album name, Media type and Genre. */
SELECT t.Name AS track_name, a.Title AS album_title, mt.Name AS media_type, g.Name AS genre, t.Composer, t.Milliseconds AS length, t.Bytes, t.UnitPrice
FROM Track t
JOIN Album a ON a.AlbumId = t.AlbumId
JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
JOIN Genre g ON g.GenreId = t.GenreId

/* 17. Provide a query that shows all Invoices but includes the # of invoice line items. */
SELECT *, COUNT(il.InvoiceLineId) AS invoice_lines
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId

/* 18. Provide a query that shows total sales made by each sales agent. */
SELECT e.LastName, SUM(i.Total)
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId


/* 19. Which sales agent made the most in sales in 2009? */
SELECT e.LastName, SUM(i.Total) AS sales_total
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE i.InvoiceDate LIKE '2009%'
GROUP BY e.EmployeeId
ORDER BY sales_total DESC
LIMIT 1

/* 20. Which sales agent made the most in sales in 2010? */
SELECT e.LastName, SUM(i.Total) AS sales_total
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE i.InvoiceDate LIKE '2010%'
GROUP BY e.EmployeeId
ORDER BY sales_total DESC
LIMIT 1

/* 21. Which sales agent made the most in sales over all? */
SELECT e.LastName, SUM(i.Total) AS sales_total
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId
ORDER BY sales_total DESC
LIMIT 1

/* 22. Provide a query that shows the # of customers assigned to each sales agent. */
SELECT e.LastName, SUM(c.CustomerId)
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId

/* 23. Provide a query that shows the total sales per country. Which country's customers spent the most? */
SELECT i.BillingCountry, SUM(i.Total) sales_total
FROM Invoice i
GROUP BY i.BillingCountry
ORDER BY sales_total DESC

/* 24. Provide a query that shows the most purchased track of 2013. */
SELECT t.Name, COUNT(t.Name) AS purchased
FROM Track t
JOIN InvoiceLine il ON il.TrackId = t.TrackId
JOIN Invoice i ON i.InvoiceId = il.InvoiceId
WHERE i.InvoiceDate LIKE '2013%'
GROUP BY t.Name
ORDER BY purchased DESC

/* 25. Provide a query that shows the top 5 most purchased tracks over all. */
SELECT t.Name, COUNT(t.Name) AS purchased
FROM Track t
JOIN InvoiceLine il ON il.TrackId = t.TrackId
JOIN Invoice i ON i.InvoiceId = il.InvoiceId
GROUP BY t.Name
ORDER BY purchased DESC
LIMIT 5

/* 26. Provide a query that shows the top 3 best selling artists. */
SELECT a.Name, SUM(i.Total) total_sales
FROM Artist a
JOIN Album al ON al.ArtistId = a.ArtistId
JOIN Track t ON t.AlbumId = al.AlbumId
JOIN InvoiceLine il ON il.TrackId = t.TrackId
JOIN Invoice i ON i.InvoiceId = il.InvoiceId
GROUP BY a.Name
ORDER BY total_sales DESC
LIMIT 5

/* 27. Provide a query that shows the most purchased Media Type. */
SELECT mt.Name AS MediaType, COUNT(il.InvoiceLineId) most_purchased
FROM MediaType mt, Track t, InvoiceLine il
ON t.MediaTypeId = mt.MediaTypeId
AND il.TrackId = t.TrackId
GROUP BY mt.Name
ORDER BY most_purchased DESC
LIMIT 1
