package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_carrera;
import entidades.Tbl_facultad;
import entidades.Vw_carrera_facultad;

public class DT_carrera {
	
    // Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
		
	private ResultSet rsCarrera;
	
	//Este metodo solo lista las carreras con el nombre y el id
	public ArrayList<Tbl_carrera> listarCarreras(){
		
		ArrayList<Tbl_carrera> listaCarrera = new ArrayList<Tbl_carrera>();
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_carrera where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCarrera = ps.executeQuery();
			
			while(rsCarrera.next())
			{
				Tbl_carrera carrera = new Tbl_carrera();
				carrera.setId(rsCarrera.getInt("id"));
				carrera.setNombre(rsCarrera.getString("nombre"));
				listaCarrera.add(carrera);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);

		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarCarrera() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaCarrera;
		
	}
	
	//Este metodo solo lista las facultades con el nombre y el id
	public ArrayList<Tbl_facultad> listarFacultad(){
		
		ArrayList<Tbl_facultad> listarFacultad = new ArrayList<Tbl_facultad>();
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_facultad where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCarrera = ps.executeQuery();
			
			while(rsCarrera.next())
			{
				Tbl_facultad facultad = new Tbl_facultad();
				facultad.setId(rsCarrera.getInt("id"));
				facultad.setNombre(rsCarrera.getString("nombre"));
				listarFacultad.add(facultad);
			}
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarFacultad() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listarFacultad;
		
	}
		
	//Metodo para listar la facultad con su carrera
	
	public ArrayList<Vw_carrera_facultad> listCarreraFacul()
	{
		ArrayList<Vw_carrera_facultad> listarCarreraFacul = new ArrayList<Vw_carrera_facultad>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from vw_carrera_facultad where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCarrera = ps.executeQuery();
			while(rsCarrera.next())
			{
				Vw_carrera_facultad vur  = new Vw_carrera_facultad();
				
				vur.setNombre_carrera(rsCarrera.getString("nombre_carrera"));
				vur.setId_carrera(Integer.parseInt(rsCarrera.getString("id_carrera")));
				vur.setId_facultad(Integer.parseInt(rsCarrera.getString("id_facultad")));
				vur.setNombre_facultad(rsCarrera.getString("nombre_facultad"));
				
				listarCarreraFacul.add(vur);
			}
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUsuarioRol() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listarCarreraFacul;
	}

	
	public void getRS(Connection con)
	{
		try {
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_carrera where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCarrera = ps.executeQuery();
		} catch (Exception e) {
			System.out.println("DATOS: ERROR en listUsuarioRol() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	
	
	//Función para guardar carrera
	public boolean guardarCarrera(Tbl_carrera tcarr ) {
			
		boolean guardado = false;
			
			try
			{
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();

				this.getRS(con);
				rsCarrera.moveToInsertRow();
				rsCarrera.updateInt("id_facultad", tcarr.getId_facultad());
				rsCarrera.updateString("nombre", tcarr.getNombre());
				rsCarrera.updateInt("estado",1);
				
				rsCarrera.insertRow();
				rsCarrera.moveToCurrentRow();
				
				guardado = true;
				connectionP.closeConnection(con);
			}
			catch (Exception e) 
			{
				System.err.println("ERROR en guardarCarrera(): "+e.getMessage());
				e.printStackTrace();
			}
			
			return guardado;
	}
	
	//Funcion para mofificar una carrera
	public boolean modificarCarrera(Tbl_carrera tcarr)
	{
		boolean modificado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsCarrera.beforeFirst();
			while (rsCarrera.next())
			{
				if(rsCarrera.getInt(1)==tcarr.getId())
				{
					rsCarrera.updateString("nombre", tcarr.getNombre());
					rsCarrera.updateInt("estado", 2);
					rsCarrera.updateRow();
					modificado=true;
					break;
				}
			}
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificarCarrera() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	
	//función para eliminar una carrera
	public boolean eliminarCarrera(int id)
	{
		boolean eliminado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsCarrera.beforeFirst();
			while (rsCarrera.next())
			{
				if(rsCarrera.getInt(1)==id)
				{
					rsCarrera.updateInt("estado",3);
					rsCarrera.updateRow();
					eliminado=true;
					break;
				}
			}
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarCarrera() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	public Tbl_carrera obtenerCarrera(int idCarrera)
	{
		Tbl_carrera tCarrera  = new Tbl_carrera();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_carrera where id = ? and estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idCarrera);
			
			rsCarrera = ps.executeQuery();
			if(rsCarrera.next())
			{
				tCarrera.setId(rsCarrera.getInt("id"));
				tCarrera.setId_facultad(rsCarrera.getInt("id_facultad"));
				tCarrera.setNombre(rsCarrera.getString("nombre"));
				tCarrera.setEstado(rsCarrera.getInt("estado"));
			}
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en ObtenerOpcion() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tCarrera;
	}
		
	
	

}
