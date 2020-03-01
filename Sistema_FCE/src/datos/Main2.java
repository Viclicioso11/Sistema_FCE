package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Main2 {
	
	public static void main(String[] args) {
		// Getting ConnectionPolling instance
		ConnectionPooling connectionP = ConnectionPooling.getInstance();
		
		// first query
		try {
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			ResultSet rs = null;
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getInt("id"));
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// second query
		try {
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			ResultSet rs = null;
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getInt("id"));
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
	
}
