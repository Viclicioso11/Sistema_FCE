package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_opcion;
import entidades.Tbl_usuario;

public class DT_opcion {
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsOpcion;
	
	
	public boolean guardarOpcion(Tbl_opcion topc) {
		boolean guardado = false;
		try
		{
			this.getResulset();
			rsOpcion.moveToInsertRow();
			rsOpcion.updateString("opcion", topc.getOpcion() );
			rsOpcion.updateString("descripcion", topc.getDescripcion());
			rsOpcion.updateInt("estado", 1);
			rsOpcion.insertRow();
			rsOpcion.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUser(): "+e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarOpcion(int id) {
		boolean eliminado = false;
		
		try {
			this.getResulset();
			rsOpcion.beforeFirst();
			while(rsOpcion.next()) {
				
				if(rsOpcion.getInt("id") == id) {
					
					rsOpcion.updateInt("estado", 3);
					
					rsOpcion.updateRow();
					
					System.out.println(rsOpcion.getInt("estado"));
					eliminado = true;
					break;
					
				}
			}
			
		} catch (Exception e) {
			System.err.println("ERROR Modificar opcion: "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
		
	}
	public boolean editarOpcion(Tbl_opcion topc) {
		boolean editado = false;
		
		try {
			this.getResulset();
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
			
		} catch (Exception e) {
			System.err.println("ERROR Modificar opcion: "+e.getMessage());
			e.printStackTrace();
		}
		
		return editado;
	}
	
	
	public void getResulset() {
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_opcion where estado<>3", 
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
	
	
	
	public ArrayList<Tbl_opcion> obtenerOpciones(){
		ArrayList<Tbl_opcion> listaOpcion = new ArrayList<Tbl_opcion>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_opcion where estado<>3", 
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
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerOpciones() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaOpcion;
	}
	
	public Tbl_opcion obtenerOpcion(int idOpcion)
	{
		Tbl_opcion tOpcion  = new Tbl_opcion();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_opcion where id = ? and estado<>3", 
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
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en ObtenerOpcion() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tOpcion;
	}
}
