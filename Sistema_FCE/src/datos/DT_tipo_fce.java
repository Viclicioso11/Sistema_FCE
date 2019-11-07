package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_opcion;
import entidades.Tbl_tipo_fce;

public class DT_tipo_fce {

	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsTipoFce;
	
	//Este metodo solo lista las carreras con el nombre y el id
	public ArrayList<Tbl_tipo_fce> listarTipoFce(){
		
		ArrayList<Tbl_tipo_fce> listaTipoFce = new ArrayList<Tbl_tipo_fce>();
		
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tipo_fce where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsTipoFce = ps.executeQuery();
			
			while(rsTipoFce.next())
			{
				Tbl_tipo_fce tipoFce = new Tbl_tipo_fce();
				tipoFce.setId(rsTipoFce.getInt("id"));
				tipoFce.setTipo(rsTipoFce.getString("tipo"));
				listaTipoFce.add(tipoFce);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarTipoFce() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaTipoFce;
		
	}
	
	public boolean guardarTipoFce(Tbl_tipo_fce tfe) {
		boolean guardado = false;
		try
		{
			this.getResulset();
			rsTipoFce.moveToInsertRow();
			rsTipoFce.updateString("tipo", tfe.getTipo());
			rsTipoFce.updateString("descripcion", tfe.getDescripcion());
			rsTipoFce.updateInt("estado", 1);
			rsTipoFce.insertRow();
			rsTipoFce.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUser(): "+e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarTipoFce(int id) {
		boolean eliminado = false;
		
		try {
			this.getResulset();
			rsTipoFce.beforeFirst();
			while(rsTipoFce.next()) {
				
				if(rsTipoFce.getInt("id") == id) {
					
					rsTipoFce.updateInt("estado", 3);
					
					rsTipoFce.updateRow();
					
					System.out.println(rsTipoFce.getInt("estado"));
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
	public boolean editarTipoFce(Tbl_tipo_fce tfe) {
		boolean editado = false;
		
		try {
			this.getResulset();
			rsTipoFce.beforeFirst();
			while(rsTipoFce.next()) {
				
				if(rsTipoFce.getInt("id") == tfe.getId()) {
					
					rsTipoFce.updateString("opcion", tfe.getTipo() );
					rsTipoFce.updateString("descripcion", tfe.getDescripcion());
					rsTipoFce.updateInt("estado", 2);
					
					rsTipoFce.updateRow();
					editado = true;
					break;
					
				}
			}
			
		} catch (Exception e) {
			System.err.println("ERROR Modificar TipoFce: "+e.getMessage());
			e.printStackTrace();
		}
		
		return editado;
	}
	
	
	public void getResulset() {
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tipo_fce where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsTipoFce = ps.executeQuery();
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerTipoFce() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	
	public ArrayList<Tbl_tipo_fce> obtenerTipoFce(){
		ArrayList<Tbl_tipo_fce> listaTipoFce = new ArrayList<Tbl_tipo_fce>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tipo_fce where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsTipoFce = ps.executeQuery();
			
			while(rsTipoFce.next())
			{
				Tbl_tipo_fce tfe = new Tbl_tipo_fce();
				
				tfe.setId(rsTipoFce.getInt("id"));
				tfe.setTipo(rsTipoFce.getString("tipofce"));
				tfe.setDescripcion(rsTipoFce.getString("descripcion"));
				tfe.setEstado(rsTipoFce.getInt("estado"));
				
				listaTipoFce.add(tfe);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerTipoFce() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaTipoFce;
	}
	
	public Tbl_tipo_fce obtenerTipoFce(int idTipoFce)
	{
		Tbl_tipo_fce tTipoFce  = new Tbl_tipo_fce();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tipo_fce where id = ? and estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idTipoFce);
			
			rsTipoFce = ps.executeQuery();
			if(rsTipoFce.next())
			{
				tTipoFce.setId(rsTipoFce.getInt("id"));
				tTipoFce.setTipo(rsTipoFce.getString("TipoFce"));
				tTipoFce.setDescripcion(rsTipoFce.getString("descripcion"));
				tTipoFce.setEstado(rsTipoFce.getInt("estado"));
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en ObtenerTipoFce() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tTipoFce;
	}
	
	
}
