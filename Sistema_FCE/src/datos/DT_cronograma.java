package datos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import entidades.Tbl_actividad_cronograma;
import entidades.Tbl_cronograma;



public class DT_cronograma {


    // Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsCronograma;
	
	
	//guardamos un cronograma
	public boolean guardarCronograma(Tbl_cronograma tco) {
		boolean guardado = false;

		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_cronograma", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			
			java.sql.Date sqlInicio = new java.sql.Date(tco.getFecha_inicio().getTime());
			java.sql.Date sqlFin = new java.sql.Date(tco.getFecha_fin().getTime());
			rsCronograma.moveToInsertRow();
			rsCronograma.updateString("descripcion", tco.getDescripcion());

			rsCronograma.updateInt("id_tipo_cronograma", tco.getTipo_cronograma());
			rsCronograma.updateDate("fecha_inicio",sqlInicio);
			rsCronograma.updateDate("fecha_fin", sqlFin);
			rsCronograma.updateInt("estado",1);
			
			rsCronograma.insertRow();
			rsCronograma.moveToCurrentRow();
			
			guardado = true;
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
	
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en guardarCronograma() "+ e.getMessage());
			e.printStackTrace();
		}
		return guardado;
		
	}
	
	
	//Funcion para editar los detalles del cronograma
	public boolean editarCronograma(Tbl_cronograma tcro)
	{
		boolean modificado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();


			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_cronograma", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			
			
			rsCronograma.beforeFirst();
			while (rsCronograma.next())
			{
				if(rsCronograma.getInt(1)== tcro.getId())
				{

					rsCronograma.updateInt("id_tipo_cronograma", tcro.getTipo_cronograma());

					rsCronograma.updateString("descripcion", tcro.getDescripcion());	
					rsCronograma.updateRow();
					modificado=true;
					break;
				}
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR editarCronograma() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	//traemos el id del ultimo registro guardado
	public int obtenerIdCronograma(Date fechaInicio, Date fechaFin, String tipo) {
		int id_cronograma = 0;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT id from tbl_cronograma WHERE fecha_inicio = ? AND fecha_fin = ? AND"
					+ " tipo_cronograma = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setDate(1, fechaInicio);
			ps.setDate(2, fechaFin);
			ps.setString(3, tipo);
			
			rsCronograma = ps.executeQuery();
			
			rsCronograma.beforeFirst();
			if(rsCronograma.next())
			{
				id_cronograma = rsCronograma.getInt("id");
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerIDCronograma() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return id_cronograma;
	}
	
	//FUnciï¿½n para devolver los detalles del cronograma enviado a traves del id
	public Tbl_cronograma obtenerDetallesCronograma(int id_cronograma)
	{
		Tbl_cronograma tcro = new Tbl_cronograma();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_cronograma where id = ? AND estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_cronograma);
			rsCronograma = ps.executeQuery();
			
			while(rsCronograma.next())
			{
				
				tcro.setId(rsCronograma.getInt("id"));
				tcro.setDescripcion(rsCronograma.getString("descripcion"));
				tcro.setFecha_inicio(rsCronograma.getDate("fecha_inicio"));
				tcro.setFecha_fin(rsCronograma.getDate("fecha_fin"));

				tcro.setTipo_cronograma(rsCronograma.getInt("id_tipo_cronograma"));

			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarActividadesCronograma "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tcro;
	}

	//validar la existencia del cronograma
	public boolean ExisteCrono(int idPG) {
		boolean existe = false;
		
		try
		{
			Connection c = connectionP.getConnection();
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_cronograma where id=?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idPG);
			rsCronograma = ps.executeQuery();
			
			if(rsCronograma.next()) {
				existe = true;
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en existeCrono() "+ e.getMessage());
			e.printStackTrace();
		}
		return existe;
	}

	
	//METODOS PARA LAS ACTIVIDADES DEL CRONOGRAMA
	
	//Guardamos las actividades que va agregando al cronograma
	public boolean guardarActividadCrono(Tbl_actividad_cronograma taco, int id_cronograma) {
		boolean guardado = false;

		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_cronograma", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			
			rsCronograma.moveToInsertRow();
			
			java.sql.Date sqlInicio = new java.sql.Date(taco.getFecha_inicio().getTime());
			java.sql.Date sqlFin = new java.sql.Date(taco.getFecha_fin().getTime());
			
			
			rsCronograma.updateString("nombre", taco.getNombre());
			rsCronograma.updateString("descripcion", taco.getDescripcion());
			rsCronograma.updateDate("fecha_inicio", sqlInicio);
			rsCronograma.updateDate("fecha_fin",sqlFin);
			rsCronograma.updateInt("estado",1);
			rsCronograma.updateInt("id_cronograma",id_cronograma);
			
			rsCronograma.insertRow();
			rsCronograma.moveToCurrentRow();
			
			guardado = true;
			
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en guardarActividadCrono"+ e.getMessage());
			e.printStackTrace();
		}
		return guardado;
		
	}
	
	//Funcion para editar las actividades del cronograma
	public boolean editarActividadCrono(Tbl_actividad_cronograma tacro)
	{
		boolean modificado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_cronograma", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			
			
			rsCronograma.beforeFirst();
			while (rsCronograma.next())
			{
				if(rsCronograma.getInt(1)== tacro.getId())
				{
					java.sql.Date sqlInicio = new java.sql.Date(tacro.getFecha_inicio().getTime());
					java.sql.Date sqlFin = new java.sql.Date(tacro.getFecha_fin().getTime());
					
					rsCronograma.updateString("nombre", tacro.getNombre());
					rsCronograma.updateString("descripcion", tacro.getDescripcion());
					rsCronograma.updateDate("fecha_inicio",sqlInicio);
					rsCronograma.updateDate("fecha_fin",sqlFin);
					rsCronograma.updateRow();
					modificado=true;
					break;
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR editarActividadCrono() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	//funciï¿½n para editar una actividad de un cronograma
	public boolean eliminarActividadCronograma(int id_cronoAct)
	{
		boolean eliminado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_cronograma", 
			ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
			ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			rsCronograma.beforeFirst();
			while (rsCronograma.next())
			{
				if(rsCronograma.getInt(1) == id_cronoAct)
				{
					rsCronograma.updateInt("estado",3);
					rsCronograma.updateRow();
					eliminado=true;
					break;
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarActividadCronograma() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	
	
	
	//FUnciï¿½n para devolver un arreglo con todos los las actividad que hay en un cronograma
	public ArrayList<Tbl_actividad_cronograma> listarActividadesCronograma(int id_cronograma)
	{
		ArrayList<Tbl_actividad_cronograma> listaCro = new ArrayList<Tbl_actividad_cronograma>();
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_cronograma where id_cronograma = ? AND estado <> 3 "
					+ "ORDER BY fecha_inicio asc",
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			

			 ps = con.prepareStatement("SELECT * from tbl_actividad_cronograma where id_cronograma = ? AND estado <> 3", 

					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_cronograma);
			rsCronograma = ps.executeQuery();
			
			while(rsCronograma.next())
			{
				Tbl_actividad_cronograma acro = new Tbl_actividad_cronograma();
				
				acro.setId(rsCronograma.getInt("id"));
				acro.setNombre(rsCronograma.getString("nombre"));
				acro.setDescripcion(rsCronograma.getString("descripcion"));
				acro.setFecha_inicio(rsCronograma.getDate("fecha_inicio"));
				acro.setFecha_fin(rsCronograma.getDate("fecha_fin"));
				listaCro.add(acro);	
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarActividadesCronograma "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaCro;
	}
	
	
	//esta funcion devuelve el id de la ultima actividad guardada en el cronograma
	// Metodo para obtenero un usuario
	public int obtenerIdActividad()
	{
		int id_actividad = 0;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT id from tbl_actividad_cronograma order by id DESC limit 1", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			if(rsCronograma.next())
			{
				id_actividad = rsCronograma.getInt("id");
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerIdActividad() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return id_actividad;
	}
		

	
	
	//listamos todos los cronogramas
	public ArrayList<Tbl_cronograma> listarCronogramas()
	{
		ArrayList<Tbl_cronograma> listaCro = new ArrayList<Tbl_cronograma>();
		
		
		try
		{
			Connection con = connectionP.getConnection();

			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_cronograma where estado <> 3 "
					+ "ORDER BY fecha_inicio desc", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCronograma = ps.executeQuery();
			
			while(rsCronograma.next())
			{
				Tbl_cronograma acro = new Tbl_cronograma();
				
				acro.setId(rsCronograma.getInt("id"));
				acro.setDescripcion(rsCronograma.getString("descripcion"));

				acro.setTipo_cronograma(rsCronograma.getInt("id_tipo_cronograma"));

				acro.setFecha_inicio(rsCronograma.getDate("fecha_inicio"));
				acro.setFecha_fin(rsCronograma.getDate("fecha_fin"));
				listaCro.add(acro);	
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarCronogramas "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaCro;
	}
	
	//FUnción obtener fecha maxima y fecha minima de un cronograma en funcion de sus actividades
	public String[] limitesFecha (int id_cronograma)
	{
		String[] limites = new String[2];
		try
		{
			Connection c = connectionP.getConnection();
			//fecha inicio primera
			PreparedStatement ps = c.prepareStatement("SELECT fecha_inicio from tbl_actividad_cronograma where id_cronograma = ? AND estado <> 3"
					+ " ORDER BY fecha_inicio ASC LIMIT 1", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_cronograma);
			rsCronograma = ps.executeQuery();
			
			while(rsCronograma.next())
			{
				limites[0] = rsCronograma.getString("fecha_inicio");
				
			}
			//fecha final maxima
			ps = c.prepareStatement("SELECT fecha_fin from tbl_actividad_cronograma where id_cronograma = ? AND estado <> 3"
					+ " ORDER BY fecha_fin DESC LIMIT 1", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_cronograma);
			rsCronograma = ps.executeQuery();
			
			while(rsCronograma.next())
			{
				limites[1] = rsCronograma.getString("fecha_fin");
				
			}
				
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en limitesFecha "+ e.getMessage());
			e.printStackTrace();
		}
		
		return limites;
	}
	
	
}
