package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_opcion;
import entidades.Tbl_rol_opcion;

import entidades.Vw_rol_opcion;

public class DT_rol_opcion {

	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsRolOpcion;
	
	// Metodo para visualizar todas las opciones  y roles asignados

	public ArrayList<Vw_rol_opcion> listarRolOpcion(int id_rol)

	{
		ArrayList<Vw_rol_opcion> listaRolOpcion = new ArrayList<Vw_rol_opcion>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();


			PreparedStatement ps = con.prepareStatement("SELECT * from vw_rol_opcion WHERE rol_id= ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_rol);

			rsRolOpcion = ps.executeQuery();
			while(rsRolOpcion.next())
			{
				Vw_rol_opcion vrop  = new Vw_rol_opcion();
				vrop.setRol(rsRolOpcion.getString("rol"));
				vrop.setOpcion(rsRolOpcion.getString("opcion"));

				vrop.setDescripcion(rsRolOpcion.getString("descripcion"));


				vrop.setRol_id(Integer.parseInt(rsRolOpcion.getString("rol_id")));
				vrop.setOpcion_id(Integer.parseInt(rsRolOpcion.getString("opcion_id")));
				listaRolOpcion.add(vrop);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listRolOpcion() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaRolOpcion;
	}
	


	// Metodo para listar todas las opciones que puede tener un rol
	public ArrayList<Tbl_opcion> listarOpcionesDisponibles(int rol)
	{
		ArrayList<Tbl_opcion> listaOpcion = new ArrayList<Tbl_opcion>();
		//ya filtrado
		ArrayList<Tbl_opcion> opcionesDisponibles = new ArrayList<Tbl_opcion>();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			//para listar todas las opciones posibles
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_opcion where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRolOpcion = ps.executeQuery();
			while(rsRolOpcion.next())
			{
				Tbl_opcion top = new Tbl_opcion();
				top.setId(rsRolOpcion.getInt("id"));
				top.setOpcion(rsRolOpcion.getString("opcion"));
				top.setDescripcion(rsRolOpcion.getString("descripcion"));
				listaOpcion.add(top);
			}
		
			// para listar las opciones que tiene un rol
		ArrayList<Tbl_rol_opcion> opcionesOcupadas = new ArrayList<Tbl_rol_opcion>();
			
		ps = con.prepareStatement("SELECT id_opcion from tbl_rol_opcion WHERE id_rol = ?", 
				ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
				ResultSet.HOLD_CURSORS_OVER_COMMIT);
		ps.setInt(1, rol);
		rsRolOpcion = ps.executeQuery();
		while(rsRolOpcion.next())
		{
			Tbl_rol_opcion trop  = new Tbl_rol_opcion();
			trop.setId_opcion(rsRolOpcion.getInt("id_opcion"));
			
			opcionesOcupadas.add(trop);
		}
		
		
		//vamos a comparar los id de los dos arraylist para ver cuales opciones podemos cargar
		boolean existe = false;
		
		for(Tbl_opcion top : listaOpcion ) {
			
			
			for(Tbl_rol_opcion trop : opcionesOcupadas) {
				//si encuentra el id de una opcion asignada 
				if(top.getId() == trop.getId_opcion()) {
					existe = true;
					break;
				}
				
			}

			if(existe == false) {
				
				opcionesDisponibles.add(top);
			}
			existe = false;
		}
		
	
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarOpcionesDisponibles() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return opcionesDisponibles;
	}

	//-----------------------------------------------------------
	
	
	public boolean asignarOpcionesARol(int id_rol, String StrId_opciones)
	{
		boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_opcion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			//se separa la cadena que viene separada en cadenas de numeros
			String[] array_ids_opciones = StrId_opciones.split(",");
			
			ArrayList<Integer> ids_opciones= new ArrayList<Integer>();
			
			//creamos un arraylist para guardar los id parseados
			for(int i = 0; i < array_ids_opciones.length; i++) {
				
				ids_opciones.add(Integer.parseInt(array_ids_opciones[i]));
				
			}
			
			rsRolOpcion = ps.executeQuery();
			for(int id_opcion : ids_opciones) {
				
				rsRolOpcion.moveToInsertRow();
				rsRolOpcion.updateInt("id_rol", id_rol);
				rsRolOpcion.updateInt("id_opcion", id_opcion);
				rsRolOpcion.insertRow();
				rsRolOpcion.moveToCurrentRow();
			}

			guardado = true;
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR asignarOpcionesARol(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
//------------------------------------
	

	public boolean guardarRolOpcion(int id_rol, int id_opcion)
	{
		boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_opcion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsRolOpcion = ps.executeQuery();
			
			rsRolOpcion.moveToInsertRow();
			rsRolOpcion.updateInt("id_rol", id_rol);
			rsRolOpcion.updateInt("id_opcion", id_opcion);
			rsRolOpcion.insertRow();
			
			rsRolOpcion.moveToCurrentRow();
			guardado = true;
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarRolOpcion(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}

	public boolean existeRolOpcion(int id_opcion, int id_rol)
	{
		boolean existe=false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_opcion WHERE id_opcion = ? AND id_rol = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_opcion);
			ps.setInt(2, id_rol);
			
			rsRolOpcion = ps.executeQuery();
			
			rsRolOpcion.beforeFirst();
			if (rsRolOpcion.next())
			{
				existe = true;
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR existeRolOpcion() "+e.getMessage());
			e.printStackTrace();
		}
		return existe;
	}
	
	
	public boolean eliminarRolOpcion(int id_opcion, int id_rol)
	{
		boolean eliminado=false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_opcion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRolOpcion = ps.executeQuery();
			
			
			rsRolOpcion.beforeFirst();
			while (rsRolOpcion.next())
			{
				if(rsRolOpcion.getInt("id_rol") == id_rol)
				{
					if(rsRolOpcion.getInt("id_opcion") == id_opcion) {
						rsRolOpcion.deleteRow();
						eliminado=true;
						break;
					}
					
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarRolOpcion() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	@SuppressWarnings("unchecked")
	public ArrayList<Vw_rol_opcion> getOpciones(Object opcs){
		ArrayList<Vw_rol_opcion> opciones = new  ArrayList<Vw_rol_opcion>();
		
		try {
			
			if (opcs != null) {
				opciones = (ArrayList<Vw_rol_opcion>) opcs;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return opciones;
	}
	
	
	public boolean isInOption(ArrayList<Vw_rol_opcion> opciones, String[] valores) {
		boolean existe = false;
		
		for(Vw_rol_opcion opcion: opciones ) {
			for(String valor: valores) {
				if (valor.equals(opcion.getOpcion())) {
					existe = true;
					break;
				}
			}
			
			if(existe)
				break;
		}
		
		return existe;
	}
	
	public boolean isInOption(ArrayList<Vw_rol_opcion> opciones, String valor) {
		boolean existe = false;
		for(Vw_rol_opcion opcion: opciones ) {
			if (valor.equals(opcion.getOpcion())) {
				existe = true;
				break;
			}
		}
		
		return existe;
	}
	
}
