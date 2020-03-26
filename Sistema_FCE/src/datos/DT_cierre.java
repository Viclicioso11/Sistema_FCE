package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entidades.Tbl_cierre;

public class DT_cierre {

	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rs;
	
	public void getRs(Connection con) throws SQLException {
		PreparedStatement ps = con.prepareStatement("SELECT * from tbl_cierre", 
				ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
				ResultSet.HOLD_CURSORS_OVER_COMMIT);
		rs = ps.executeQuery();
	}
	
	public boolean cerrarFCE(Tbl_cierre cierre) {
		boolean cerrado = false;
		
		try {
			Connection con = connectionP.getConnection();
			
			this.getRs(con);
			
			this.rs.moveToInsertRow();
			this.rs.updateInt("idtema", cierre.getIdTema());
			this.rs.updateString("doc", cierre.getDoc());
			this.rs.insertRow();
			this.rs.moveToCurrentRow();
			
			this.connectionP.closeConnection(con);
			cerrado = true;
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return cerrado;
		
	}
	
	public ArrayList<Tbl_cierre> getAll() {
		ArrayList<Tbl_cierre> cierres =  new ArrayList<Tbl_cierre>();
		
		try {
			Connection con = this.connectionP.getConnection();
			
			this.getRs(con);
			
			while(this.rs.next()) {
				Tbl_cierre cierre = new Tbl_cierre();
				cierre.setId(this.rs.getInt("id"));
				cierre.setIdTema(this.rs.getInt("idtema"));
				cierre.setFecha(this.rs.getDate("fecha"));
				cierre.setDoc(this.rs.getString("doc"));
				cierres.add(cierre);
			}
			
			this.connectionP.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return cierres;
	}
	
	public Tbl_cierre getCierreId(int id) {
		Tbl_cierre cierre =  new Tbl_cierre();
		
		try {
			Connection con = this.connectionP.getConnection();
			this.getRs(con);
			
			while(this.rs.next()) {
				if (this.rs.getInt("id") == id) {
					cierre.setId(this.rs.getInt("id"));
					cierre.setIdTema(this.rs.getInt("idtema"));
					cierre.setFecha(this.rs.getDate("fecha"));
					cierre.setDoc(this.rs.getString("doc"));
				}
			}
			
			this.connectionP.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return cierre;
	}
	
	public boolean tieneCierre(int idtema) {
		boolean cerrado = false;
		
		try {
			Connection con = this.connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_cierre where idtema = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			ps.setInt(1, idtema);
			
			this.rs = null;
			this.rs = ps.executeQuery();
			
			if(this.rs.next()) {
				cerrado = true;
			}
			
			this.connectionP.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return cerrado;
	}
}
