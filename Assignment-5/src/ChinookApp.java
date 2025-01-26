import java.sql.*;

/**
 * Application for a set of queries on the Chinook database
 * <p>
 * Name: Steven Sousa
 *
 * @author Dr. Jung
 */
public class ChinookApp {
    Connection connection;
    String sql;

    /**
     * ChinookApp constructor
     *
     * @param path
     * @throws ClassNotFoundException cannot find JDBC driver
     * @throws SQLException           SQL gone bad
     */
    public ChinookApp(String path) throws ClassNotFoundException, SQLException {
        // load the sqlite-JDBC driver using the current class loader
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:" + path);
    }

    /**
     * @param country
     * @return
     * @throws SQLException customersInCountry
     *                      1) How many customers live in country [parameter value]?
     */
    public int customers(String country) throws SQLException {
        String SQL_Query = "SELECT COUNT(*) FROM main.Customer WHERE Country = ?";
        PreparedStatement ps = connection.prepareStatement(SQL_Query);
        ps.setString(1, country);
        ResultSet rs = ps.executeQuery();

        rs.next();
        return rs.getInt(1);
    }

    /**
     * @return
     * @throws SQLException 2) List all employees (sort by employee id)
     */
    public String employees() throws SQLException {
        String SQL_Query = "SELECT EmployeeID, FirstName || ' ' || LastName AS FullName, Title FROM Employee ORDER BY EmployeeId ASC";
        PreparedStatement ps = connection.prepareStatement(SQL_Query);
        ResultSet rs = ps.executeQuery();

        StringBuilder result = new StringBuilder();

        while (rs.next()) {
            int employeeID = rs.getInt("EmployeeID");
            String fullName = rs.getString("FullName");
            String title = rs.getString("Title");

            result.append(employeeID).append(". ").append(fullName).append(" (").append(title).append(")\n");
        }
        return result.toString();
    }

    /**
     * @param supportRepId
     * @return
     * @throws SQLException 3) How many customers have been supported by employee id [parameter value]?
     */
    public int supportedCustomers(int supportRepId) throws SQLException {
        String SQL_Query = "SELECT DISTINCT COUNT(*) FROM Customer WHERE supportRepId = ?";
        PreparedStatement ps = connection.prepareStatement(SQL_Query);
        ps.setInt(1, supportRepId);
        ResultSet rs = ps.executeQuery();
        rs.next();
        return rs.getInt(1);
    }

    /**
     * @return
     * @throws SQLException 4) List all customers (sort by customer id)
     */
    public String customerList() throws SQLException {
        String SQL_Query = "SELECT CustomerId, FirstName || ' ' || LastName AS FullName, City, State, Country FROM Customer ORDER BY CustomerId ASC";
        PreparedStatement ps = connection.prepareStatement(SQL_Query);
        ResultSet rs = ps.executeQuery();

        StringBuilder result = new StringBuilder();

        while (rs.next()) {
            int customerID = rs.getInt("CustomerId");
            String fullName = rs.getString("FullName");
            String city = rs.getString("City");
            String state = rs.getString("State");
            String country = rs.getString("Country");

            result.append(customerID).append(". ").append(fullName).append(" (").append(city);

            // Conditionally append state if not null
            if (state != null && !state.isEmpty()) {
                result.append(", ").append(state);
            }

            result.append(", ").append(country).append(")\n");
        }
        return result.toString();
    }

    /**
     * @param customerId
     * @return
     * @throws SQLException 5) List all invoices for customer #[parameter value] (sort by invoice id, each line by invoice line id)
     */
    public String invoices(int customerId) throws SQLException {
        String sqlQuery = "SELECT i.InvoiceId, i.Total, GROUP_CONCAT(' ' || il.InvoiceLineId || ': ''' || t.Name || ''' on ''' || a.Title || ''' by ''' || ar.Name || ''' (' || il.Quantity || ' @ $' || il.UnitPrice || ')', CHAR(10)) AS invoice_lines FROM Invoice AS i JOIN InvoiceLine AS il ON i.InvoiceId = il.InvoiceId JOIN Track AS t ON il.TrackId = t.TrackId JOIN Album AS a ON t.AlbumId = a.AlbumId JOIN Artist AS ar ON a.ArtistId = ar.ArtistId WHERE i.CustomerId = ? GROUP BY i.InvoiceId, i.Total ORDER BY i.InvoiceId";
        PreparedStatement ps = connection.prepareStatement(sqlQuery);
        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();
        StringBuilder result = new StringBuilder();

        while (rs.next()) {
            int invoiceId = rs.getInt("InvoiceId");
            double total = rs.getDouble("Total");
            String invoiceLines = rs.getString("invoice_lines");
            result.append(String.format("Invoice #%d ($%.2f)%n", invoiceId, total));    // Build Invoice Header
            result.append(invoiceLines);    // Append InvoiceLines
            result.append("\n");    // Append character return
        }
        return result.toString();
    }
}
