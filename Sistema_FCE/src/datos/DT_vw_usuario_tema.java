package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Vw_usuario_tema;

public class DT_vw_usuario_tema {

	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsUsuarioTema;
	
	// Metodo para visualizar la vista de usuario tema
	public ArrayList<Vw_usuario_tema> listUsuarioTema()
	{
		ArrayList<Vw_usuario_tema> listarUsuarioTema = new ArrayList<Vw_usuario_tema>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * FROM public.vw_usuario_tema;", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuarioTema = ps.executeQuery();
			while(rsUsuarioTema.next())
			{
				Vw_usuario_tema  vwUT = new Vw_usuario_tema();
				vwUT.setId_tema(rsUsuarioTema.getInt("id_tema"));
				vwUT.setTema(rsUsuarioTema.getString("tema"));
				vwUT.setTipo(rsUsuarioTema.getString("tipo"));
				vwUT.setAmbito(rsUsuarioTema.getString("ambito"));
				vwUT.setCarrera(rsUsuarioTema.getString("carrera"));
				listarUsuarioTema.add(vwUT);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listarUsuarioTema;
	}
	
	
	// Metodo para obtenero un usuario
	public Vw_usuario_tema obtenerTema(int idTema)
	{
		Vw_usuario_tema tema  = new Vw_usuario_tema();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from Vw_usuario_tema where id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idTema);
			rsUsuarioTema = ps.executeQuery();
			if(rsUsuarioTema.next())
			{	
				Vw_usuario_tema  vwT = new Vw_usuario_tema();
				vwT.setId_tema(rsUsuarioTema.getInt("id_tema"));
				vwT.setTema(rsUsuarioTema.getString("tema"));
				vwT.setTipo(rsUsuarioTema.getString("tipo"));
				vwT.setAmbito(rsUsuarioTema.getString("ambito"));
				vwT.setCarrera(rsUsuarioTema.getString("carrera"));
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerTema() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tema;
	}
}
