package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Vw_tema;
import entidades.Vw_tema_estudiante;
import entidades.Vw_usuario_rol;
import entidades.Vw_usuario_tema;


public class DT_vw_tema_estudiante {
	
	// Getting ConnectionPolling instance
		ConnectionPooling connectionP = ConnectionPooling.getInstance();
		private ResultSet rsWvTema;
		
	
	public ArrayList<Vw_tema_estudiante> listarTemas_estudiante(int idtema){
		
		
		ArrayList<Vw_tema_estudiante> tema_estudiante = new ArrayList<Vw_tema_estudiante>();
		
		try {
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM public.vw_tema_estudiante where id_tema= ? ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idtema);
			
			rsWvTema = ps.executeQuery();
			
			while(rsWvTema.next()) {
				
				Vw_tema_estudiante  vwT = new Vw_tema_estudiante();
				
				vwT.setId_usuario(rsWvTema.getInt("id_usuario"));
				vwT.setId_tema(rsWvTema.getInt("id_tema"));
				vwT.setTema(rsWvTema.getString("tema"));
				vwT.setCarne(rsWvTema.getString("carne"));
				vwT.setNombres(rsWvTema.getString("nombres"));
				vwT.setApellidos(rsWvTema.getString("apellidos"));
				tema_estudiante.add(vwT);
			}
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);			
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return tema_estudiante;
		
	}
	

	
	
	

}
