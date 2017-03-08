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
/* 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37. */
/* 11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: [GROUP BY](http://www.sqlite.org/lang_select.html#resultset) */
/* 12. Provide a query that includes the track name with each invoice line item. */
/* 13. Provide a query that includes the purchased track name AND artist name with each invoice line item. */
/* 14. Provide a query that shows the # of invoices per country. HINT: [GROUP BY](http://www.sqlite.org/lang_select.html#resultset) */
/* 15. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table. */
/* 16. Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre. */
/* 17. Provide a query that shows all Invoices but includes the # of invoice line items. */
/* 18. Provide a query that shows total sales made by each sales agent. */
/* 19. Which sales agent made the most in sales in 2009? */
/* 20. Which sales agent made the most in sales in 2010? */
/* 21. Which sales agent made the most in sales over all? */
/* 22. Provide a query that shows the # of customers assigned to each sales agent. */
/* 23. Provide a query that shows the total sales per country. Which country's customers spent the most? */
/* 24. Provide a query that shows the most purchased track of 2013. */
/* 25. Provide a query that shows the top 5 most purchased tracks over all. */
/* 26. Provide a query that shows the top 3 best selling artists. */
/* 27. Provide a query that shows the most purchased Media Type. */
