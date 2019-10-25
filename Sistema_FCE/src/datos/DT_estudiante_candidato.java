package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_estudiante_candidato;
import entidades.Tbl_opcion;

public class DT_estudiante_candidato {
	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsEstudianteCandidato;
	
	
	public void getResulset() {
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_estudiantes_candidatos where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsEstudianteCandidato = ps.executeQuery();
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerOpciones() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	public boolean guardarEstudianteCandidato(Tbl_estudiante_candidato tuc) {
		boolean guardado = false;
		try
		{
			this.getResulset();
			rsEstudianteCandidato.moveToInsertRow();
			
			rsEstudianteCandidato.updateString("correo", tuc.getCorreo());
			rsEstudianteCandidato.updateInt("estado", 1);	
			rsEstudianteCandidato.insertRow();
			rsEstudianteCandidato.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUser(): "+e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	// Metodo para obtener los etudiantes candidatos
		public ArrayList<Tbl_estudiante_candidato> listEtudianteCandidato()
		{
			ArrayList<Tbl_estudiante_candidato> listaEstudianteCandidato = new ArrayList<Tbl_estudiante_candidato>();
			
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT * from tbl_estudiantes_candidatos where estado<>3", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				rsEstudianteCandidato = ps.executeQuery();
				while(rsEstudianteCandidato.next())
				{
					Tbl_estudiante_candidato tuc  = new Tbl_estudiante_candidato();
					tuc.setId(rsEstudianteCandidato.getInt("id"));
					tuc.setCorreo(rsEstudianteCandidato.getString("correo"));
					tuc.setNotificado(rsEstudianteCandidato.getInt("notificado"));
					
				;
				
					listaEstudianteCandidato.add(tuc);
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return listaEstudianteCandidato;
		}
	

}
