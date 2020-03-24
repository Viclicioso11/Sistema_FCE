package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_estudiante_candidato;


public class DT_estudiante_candidato {

    // Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsEstudianteCandidato;


	public void getResulset(Connection con) {
		try
		{

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_estudiantes_candidatos where estado<>3",
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
					ResultSet.HOLD_CURSORS_OVER_COMMIT);

			rsEstudianteCandidato = ps.executeQuery();			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerEstudiantesCantidatos() "+ e.getMessage());
			e.printStackTrace();
		}
	}


	public boolean guardarEstudianteCandidato(Tbl_estudiante_candidato tuc) {
		boolean guardado = false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getResulset(con);
			rsEstudianteCandidato.moveToInsertRow();

			rsEstudianteCandidato.updateString("correo", tuc.getCorreo());
			rsEstudianteCandidato.updateInt("estado", 1);	
			rsEstudianteCandidato.insertRow();
			rsEstudianteCandidato.moveToCurrentRow();
			guardado = true;
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
			
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
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_estudiantes_candidatos where estado<>3",
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsEstudianteCandidato = ps.executeQuery();
			while(rsEstudianteCandidato.next())
			{
				Tbl_estudiante_candidato tuc  = new Tbl_estudiante_candidato();
				tuc.setId(rsEstudianteCandidato.getInt("id"));
				tuc.setCorreo(rsEstudianteCandidato.getString("correo"));
				tuc.setNotificado(rsEstudianteCandidato.getInt("notificado"));


				listaEstudianteCandidato.add(tuc);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}

		return listaEstudianteCandidato;
	}

	
	public ArrayList<Tbl_estudiante_candidato> getEstudiante(){
		ArrayList<Tbl_estudiante_candidato> listaEstudianteCandidato = new ArrayList<Tbl_estudiante_candidato>();

		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			String consulta = "select id, fecha, correo from public.tbl_estudiantes_candidatos where estado !=3 order by fecha desc;";
			PreparedStatement ps = con.prepareStatement(consulta,
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsEstudianteCandidato = ps.executeQuery();
			
			while(rsEstudianteCandidato.next())
			{
				Tbl_estudiante_candidato tuc  = new Tbl_estudiante_candidato();
				tuc.setId(rsEstudianteCandidato.getInt("id"));
				tuc.setCorreo(rsEstudianteCandidato.getString("correo"));
				tuc.setFecha(rsEstudianteCandidato.getDate("fecha"));

				listaEstudianteCandidato.add(tuc);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}

		return listaEstudianteCandidato;
	}
	
	//validamos si ese correo ya est� ingresado en el sistema y si aun no se ha usado
	public boolean validarEstudianteCandidato(String correo) {
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_estudiantes_candidatos where correo= ? AND estado = 1",
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
					ResultSet.HOLD_CURSORS_OVER_COMMIT);

			ps.setString(1, correo);
			rsEstudianteCandidato = ps.executeQuery();

			
			
			if(rsEstudianteCandidato.next()) {
				connectionP.closeConnection(con);
				return true;
				
			}
			else {
				connectionP.closeConnection(con);
				return false;
			}
			
			
		}
		catch (Exception e)
		{
			System.err.println("ERROR ValidarEstudianteCandidato(): "+e.getMessage());
			e.printStackTrace();
			return false;
		}
	}

	//al momento de guardar un usuario, ponemos  el estado e n 3
	public boolean EliminarEstudiante(int id) {
		boolean modificado = false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getResulset(con);
			rsEstudianteCandidato.beforeFirst();

			while(rsEstudianteCandidato.next()) {
				
				if(rsEstudianteCandidato.getInt("id") == id ) {
					rsEstudianteCandidato.updateInt("estado", 3);
					rsEstudianteCandidato.updateRow();
					modificado = true;
					break;
				}

			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR cambiarEstadoEstudianteCandidato: "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
	}

	//al momento de guardar un usuario, ponemos  el estado e n 3
	public boolean CambiarEstadoEstudianteCandidato(String correo) {
		boolean modificado = false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getResulset(con);

			rsEstudianteCandidato.beforeFirst();

			while(rsEstudianteCandidato.next()) {
				if(rsEstudianteCandidato.getString("correo").equals(correo)) {
					rsEstudianteCandidato.updateInt("estado", 3);
					rsEstudianteCandidato.updateRow();
					modificado = true;
					break;
				}

			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			

		}
		catch (Exception e)
		{
			System.err.println("ERROR cambiarEstadoEstudianteCandidato: "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
	}


}
