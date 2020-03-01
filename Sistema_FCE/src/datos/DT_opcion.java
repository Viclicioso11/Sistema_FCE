package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_opcion;

public class DT_opcion {
	 
	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsOpcion;
	
	
	public ArrayList<Tbl_opcion> obtenerOpciones(){
		ArrayList<Tbl_opcion> listaOpcion = new ArrayList<Tbl_opcion>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_opcion where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsOpcion = ps.executeQuery();
			
			while(rsOpcion.next())
			{
				Tbl_opcion topc  = new Tbl_opcion();
				
				topc.setId(rsOpcion.getInt("id"));
				topc.setOpcion(rsOpcion.getString("opcion"));
				topc.setDescripcion(rsOpcion.getString("descripcion"));
				topc.setEstado(rsOpcion.getInt("estado"));
				
				listaOpcion.add(topc);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerOpciones() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaOpcion;
	}
	
	public void getRS(Connection con) {
		try
		{
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_opcion where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsOpcion = ps.executeQuery();
			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerOpciones() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	public boolean guardarOpcion(Tbl_opcion topc) {
		boolean guardado = false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsOpcion.moveToInsertRow();
			rsOpcion.updateString("opcion", topc.getOpcion() );
			rsOpcion.updateString("descripcion", topc.getDescripcion());
			rsOpcion.updateInt("estado", 1);
			rsOpcion.insertRow();
			rsOpcion.moveToCurrentRow();
			guardado = true;
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarOpcion(): "+e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarOpcion(int id) {
		boolean eliminado = false;
		
		try {
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsOpcion.beforeFirst();
			
			while(rsOpcion.next()) {
				if(rsOpcion.getInt("id") == id) {
					rsOpcion.updateInt("estado", 3);					
					rsOpcion.updateRow();					
					eliminado = true;
					break;
					
				}
				
			}
			connectionP.closeConnection(con);
		} catch (Exception e) {
			System.err.println("ERROR Modificar opcion: "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
		
	}
	
	public boolean editarOpcion(Tbl_opcion topc) {
		boolean editado = false;
		
		try {
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsOpcion.beforeFirst();
			while(rsOpcion.next()) {
				
				if(rsOpcion.getInt("id") == topc.getId()) {
					
					rsOpcion.updateString("opcion", topc.getOpcion() );
					rsOpcion.updateString("descripcion", topc.getDescripcion());
					rsOpcion.updateInt("estado", 2);
					
					rsOpcion.updateRow();
					editado = true;
					break;
					
				}
			}
			connectionP.closeConnection(con);
			
		} catch (Exception e) {
			System.err.println("ERROR Modificar opcion: "+e.getMessage());
			e.printStackTrace();
		}
		
		return editado;
	}
	

	public Tbl_opcion obtenerOpcion(int idOpcion)
	{
		Tbl_opcion tOpcion  = new Tbl_opcion();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_opcion where id = ? and estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idOpcion);
			
			rsOpcion = ps.executeQuery();
			if(rsOpcion.next())
			{
				tOpcion.setId(rsOpcion.getInt("id"));
				tOpcion.setOpcion(rsOpcion.getString("Opcion"));
				tOpcion.setDescripcion(rsOpcion.getString("descripcion"));
				tOpcion.setEstado(rsOpcion.getInt("estado"));
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en ObtenerOpcion() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tOpcion;
	}
}
