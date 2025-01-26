import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class SQLiteDemo {
	Connection connection;
	String sql;
	String DB_PATH = SQLiteDemo.class.getResource("Chinook_Sqlite_AutoIncrementPKs.sqlite").getFile();

	public SQLiteDemo() throws ClassNotFoundException, SQLException {
		// load the sqlite-JDBC driver using the current class loader
		Class.forName( "org.sqlite.JDBC" );

		// protocol (jdbc): subprotocol (sqlite):databaseName (Chinook_Sqlite_AutoIncrementPKs.sqlite)
		connection = DriverManager.getConnection("jdbc:sqlite:" + DB_PATH);
	}

	public void run() throws SQLException {
		Scanner input = new Scanner(System.in);
		// get input(s)
		System.out.print( "Enter an artist (type n/a for none): " );
		String param = input.next();

		// generate parameterized sql
		if ( param.equalsIgnoreCase("n/a") ) {

			sql = "SELECT art.Name AS art_name, alb.Title AS alb_title" +
					" FROM album alb INNER JOIN artist art USING (ArtistId)" +
					" ORDER BY art_name, alb_title";

		} else {

			sql = "SELECT art.Name AS art_name, alb.Title AS alb_title" +
					" FROM artist art INNER JOIN album alb USING (ArtistId)" +
					" WHERE art.Name LIKE ?" +
					" ORDER BY art_name, alb_title";


		}
		System.out.println("\nSQL: " + sql + "\n");

		// prepare statement (never use string concatenation to build the query)
		// to avoid SQL injection
		// never do "Where art.Name LIKE " + param + "ORDER BY... "
		PreparedStatement stmt = connection.prepareStatement( sql );

		// bind parameter(s)
		// In SQLite "?" is a placeholder (act like variable)
		// 1 is the first placeholder, 2 is the second placeholder, etc
		if ( !param.equalsIgnoreCase("n/a") ) {
			stmt.setString( 1, param );
		}

		// get results
		ResultSet res = stmt.executeQuery();
		while ( res.next() ) {
			System.out.println( "<" + res.getString( "art_name" ) + "> " + res.getString( "alb_title" ) );
		}
	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException {

		SQLiteDemo demo = new SQLiteDemo();
		demo.run();
	}
}