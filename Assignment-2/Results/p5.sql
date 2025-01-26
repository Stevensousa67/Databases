SELECT Employee.EmployeeId AS e_id, 
       Employee.FirstName AS e_first_name, 
       Employee.LastName AS e_last_name, 
       Employee.Title AS e_title,
       CASE 
           WHEN SUM(Invoice.Total) IS NULL THEN '$0.00' 
           ELSE '$' || printf('%.2f', ROUND(SUM(Invoice.Total), 2)) 
       END AS total_invoices
FROM Invoice
RIGHT JOIN Customer USING (CustomerId)
RIGHT JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
GROUP BY Employee.EmployeeId, Employee.FirstName, Employee.LastName, Employee.Title
ORDER BY total_invoices DESC, e_last_name, e_first_name;