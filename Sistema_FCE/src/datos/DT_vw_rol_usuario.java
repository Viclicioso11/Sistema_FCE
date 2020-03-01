package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Vw_usuario_rol;

public class DT_vw_rol_usuario {
	
	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsTutor;
	
	// Metodo para visualizar todos los usuarios activos que son tutores
	public ArrayList<Vw_usuario_rol> listarTutor()
	{
		ArrayList<Vw_usuario_rol> listarTutor = new ArrayList<Vw_usuario_rol>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT  * FROM public.vw_usuario_rol where id_rol =3;", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsTutor = ps.executeQuery();
			
			while(rsTutor.next())
			{
				Vw_usuario_rol  vwur = new Vw_usuario_rol();
				vwur.setId_user(rsTutor.getInt("id_usuario"));
				vwur.setNombre(rsTutor.getString("nombre"));
				
				listarTutor.add(vwur);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listarTutor;
	}
	
	// Metodo para obtenero un usuario rol
	public Vw_usuario_rol obtenerNombreTutor()
	{
		Vw_usuario_rol  usuario = new Vw_usuario_rol();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT  * FROM public.vw_usuario_rol where id_rol =3;", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);			
			
			rsTutor = ps.executeQuery();
			
			if(rsTutor.next())
			{
				usuario.setNombre(rsTutor.getString("nombres"));
				usuario.setId_user(rsTutor.getInt("id"));
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerNombreEstudiante() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return usuario;
		}
			
	
	
	
}

		

