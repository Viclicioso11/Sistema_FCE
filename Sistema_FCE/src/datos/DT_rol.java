package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_rol;
import entidades.Tbl_usuario;


public class DT_rol {

	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsRol;
	
	
	//FUnci�n para devolver un arreglo con todos los roles que hay en la bd
	public ArrayList<Tbl_rol> listRol()
	{
		ArrayList<Tbl_rol> listaRol = new ArrayList<Tbl_rol>();
		
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_rol where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRol = ps.executeQuery();
			while(rsRol.next())
			{
				Tbl_rol trol = new Tbl_rol();
				trol.setId(rsRol.getInt("id"));
				trol.setRol(rsRol.getString("rol"));
				trol.setDescripcion(rsRol.getString("descripcion"));
				trol.setEstado(rsRol.getInt("estado"));
				listaRol.add(trol);	
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listRol() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaRol;
	}
	
	
	
	
	//Funci�n para guardar un rol
	public boolean guardarRol(Tbl_rol trol) {
			
		boolean guardado = false;
			
			try
			{
				this.listRol();
				rsRol.moveToInsertRow();
				rsRol.updateString("rol", trol.getRol());
				rsRol.updateString("descripcion", trol.getDescripcion());
				rsRol.updateInt("estado",1);
				
				rsRol.insertRow();
				rsRol.moveToCurrentRow();
				
				guardado = true;
			}
			catch (Exception e) 
			{
				System.err.println("ERROR en guardarRol(): "+e.getMessage());
				e.printStackTrace();
			}
			
			return guardado;
	}
	
	//Funcion para mofificar un rol
	public boolean modificarRol(Tbl_rol trol)
	{
		boolean modificado=false;	
		
		try
		{
			this.listRol();
			rsRol.beforeFirst();
			while (rsRol.next())
			{
				if(rsRol.getInt(1)==trol.getId())
				{
					rsRol.updateString("rol", trol.getRol());
					rsRol.updateString("descripcion", trol.getDescripcion());
					rsRol.updateInt("estado", 2);
					rsRol.updateRow();
					modificado=true;
					break;
				}
			}
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificarRol() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	//funci�n para eliminar un rol
	public boolean eliminarRol(Tbl_rol trol)
	{
		boolean eliminado=false;	
		
		try
		{
			this.listRol();
			rsRol.beforeFirst();
			while (rsRol.next())
			{
				if(rsRol.getInt(1)==trol.getId())
				{
					rsRol.updateInt("estado",3);
					rsRol.updateRow();
					eliminado=true;
					break;
				}
			}
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarRol() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	// Metodo para obtenero un rol
		public Tbl_rol obtenerRol(int idRol)
		{
			Tbl_rol trol  = new Tbl_rol();
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT * from tbl_rol where id = ? and estado<>3", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setInt(1, idRol);
				
				rsRol = ps.executeQuery();
				if(rsRol.next())
				{
					trol.setId(rsRol.getInt("id"));
					trol.setRol(rsRol.getString("rol"));
					trol.setDescripcion(rsRol.getString("descripcion"));
					trol.setEstado(rsRol.getInt("estado"));
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en ObtenerRol() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return trol;
		}
	
}
