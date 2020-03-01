package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Vw_tema;

public class DT_vw_tema {

	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsWvTema;
	
	// Metodo para obtenero un tema
	public Vw_tema obtenerTema(int idTema)
	{
		Vw_tema tema  = new Vw_tema();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from Vw_tema where id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idTema);
			rsWvTema = ps.executeQuery();
			
			if(rsWvTema.next())
			{	
				Vw_tema  vwT = new Vw_tema();
				vwT.setId_tema(rsWvTema.getInt("id_tema"));
				vwT.setTema(rsWvTema.getString("tema"));
				vwT.setAmbito(rsWvTema.getString("ambito"));
				vwT.setCarrera(rsWvTema.getString("carrera"));
				vwT.setTutor(rsWvTema.getInt("tutor"));
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
	

	/**
	 * este nos servira para filtar todos los temas que no tienen tutyores 
	 */
	public ArrayList<Vw_tema> filtrarSintutor(ArrayList<Vw_tema> data){
		
		ArrayList<Vw_tema> sinT = new ArrayList<Vw_tema>(); 
		
		for (int i=0; i < data.size() ; i ++) {
			if(data.get(i).getTutor() == 0) {
				sinT.add(data.get(i));
			}
		}
			
		return sinT;
	}
	
	public void getResulset(Connection con) {
		try	{
			
			PreparedStatement ps = con.prepareStatement("SELECT * from Vw_tema", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsWvTema = ps.executeQuery();
			
		}catch (Exception e){
			System.out.println("DATOS: ERROR en obtenerTema() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	public ArrayList<Vw_tema> listarTemas(){
		
		ArrayList<Vw_tema> temas = new ArrayList<Vw_tema>();
		
		try {
			
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			getResulset(con);
			
			while(rsWvTema.next()) {
				
				Vw_tema  vwT = new Vw_tema();
				
				vwT.setId_tema(rsWvTema.getInt("id_tema"));
				vwT.setTema(rsWvTema.getString("tema"));
				vwT.setTutor(rsWvTema.getInt("tutor"));
				vwT.setFecha(rsWvTema.getString("fecha"));
				vwT.setPalabras_claves(rsWvTema.getString("palabras_claves"));
				vwT.setCarrera(rsWvTema.getString("carrera"));
				vwT.setAmbito(rsWvTema.getString("ambito"));
				vwT.setTipo_fce(rsWvTema.getString("tipo_fce"));
				
				System.out.println(vwT.getTutor());
				
				temas.add(vwT);
			}
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return temas;
	}
	
	public ArrayList<Vw_tema> listarTemasTutor(){
		
		
		ArrayList<Vw_tema> temas = new ArrayList<Vw_tema>();
		
		try {
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM public.vw_tema_tutor", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsWvTema = ps.executeQuery();
			
			while(rsWvTema.next()) {
				
				Vw_tema  vwT = new Vw_tema();
				
				vwT.setId_tema(rsWvTema.getInt("id_tema"));
				vwT.setTema(rsWvTema.getString("tema"));
				vwT.setFecha(rsWvTema.getString("fecha"));
				vwT.setPalabras_claves(rsWvTema.getString("palabras_claves"));
				vwT.setTutor(rsWvTema.getInt("id_tutor"));
				vwT.setNombre_tutor(rsWvTema.getString("nombre_tutor"));
				vwT.setCarrera(rsWvTema.getString("carrera"));
				vwT.setAmbito(rsWvTema.getString("ambito"));
				vwT.setTipo_fce(rsWvTema.getString("tipo_fce"));
				System.out.println(vwT.getTutor());
				temas.add(vwT);
			}
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);			
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return temas;
		
		
	}

}