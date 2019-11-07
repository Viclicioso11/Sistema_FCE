package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_ambito;
import entidades.Tbl_opcion;
import entidades.Tbl_usuario;

public class DT_ambito {
	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsAmbito;
	
	//Este metodo solo lista los ambitos con el nombre y el id
	public ArrayList<Tbl_ambito> listarAmbitos(){
		
		ArrayList<Tbl_ambito> listaAmbito = new ArrayList<Tbl_ambito>();
		
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_ambito where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsAmbito = ps.executeQuery();
			
			while(rsAmbito.next())
			{
				Tbl_ambito ambito = new Tbl_ambito();
				ambito.setId(rsAmbito.getInt("id"));
				ambito.setAmbito(rsAmbito.getString("ambito"));
				listaAmbito.add(ambito);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarAmbito() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaAmbito;
		
	}
	
	public boolean guardarAmbito(Tbl_ambito ta) {
		boolean guardado = false;
		try
		{
			this.getResulset();
			rsAmbito.moveToInsertRow();
			rsAmbito.updateString("ambito", ta.getAmbito() );
			rsAmbito.updateString("descripcion", ta.getDescripcion());
			rsAmbito.updateInt("estado", 1);
			rsAmbito.insertRow();
			rsAmbito.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarAmbito(): "+e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarAmbito(int id) {
		boolean eliminado = false;
		
		try {
			this.getResulset();
			rsAmbito.beforeFirst();
			while(rsAmbito.next()) {
				
				if(rsAmbito.getInt("id") == id) {
					
					rsAmbito.updateInt("estado", 3);
					
					rsAmbito.updateRow();
					
					System.out.println(rsAmbito.getInt("estado"));
					eliminado = true;
					break;
					
				}
			}
			
		} catch (Exception e) {
			System.err.println("ERROR Modificar ambito: "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
		
	}
	public boolean editarAmbito(Tbl_ambito topc) {
		boolean editado = false;
		
		try {
			this.getResulset();
			rsAmbito.beforeFirst();
			while(rsAmbito.next()) {
				
				if(rsAmbito.getInt("id") == topc.getId()) {
					
					rsAmbito.updateString("ambito", topc.getAmbito() );
					rsAmbito.updateString("descripcion", topc.getDescripcion());
					rsAmbito.updateInt("estado", 2);
					
					rsAmbito.updateRow();
					editado = true;
					break;
					
				}
			}
			
		} catch (Exception e) {
			System.err.println("ERROR Modificar ambito: "+e.getMessage());
			e.printStackTrace();
		}
		
		return editado;
	}
	
	
	public void getResulset() {
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_ambito where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsAmbito = ps.executeQuery();
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerAmbitos() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	
	public ArrayList<Tbl_ambito> obtenerAmbitos(){
		ArrayList<Tbl_ambito> listaAmbito = new ArrayList<Tbl_ambito>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_ambito where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsAmbito = ps.executeQuery();
			
			while(rsAmbito.next())
			{
				Tbl_ambito ta  = new Tbl_ambito();
				
				ta.setId(rsAmbito.getInt("id"));
				ta.setAmbito(rsAmbito.getString("ambito"));
				ta.setDescripcion(rsAmbito.getString("descripcion"));
				ta.setEstado(rsAmbito.getInt("estado"));
				
				listaAmbito.add(ta);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerAmbitos() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaAmbito;
	}
	
	public Tbl_ambito obtenerAmbito(int idAmbito)
	{
		Tbl_ambito tAmbito  = new Tbl_ambito();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_ambito where id = ? and estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idAmbito);
			
			rsAmbito = ps.executeQuery();
			if(rsAmbito.next())
			{
				tAmbito.setId(rsAmbito.getInt("id"));
				tAmbito.setAmbito(rsAmbito.getString("Ambito"));
				tAmbito.setDescripcion(rsAmbito.getString("descripcion"));
				tAmbito.setEstado(rsAmbito.getInt("estado"));
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en ObtenerAmbito() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tAmbito;
	}
	
}
