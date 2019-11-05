package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Vw_rol_opcion;

public class DT_rol_opcion {

	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsRolOpcion;
	
	// Metodo para visualizar todas las opciones  y roles asignados
	public ArrayList<Vw_rol_opcion> listarRolOpcion()
	{
		ArrayList<Vw_rol_opcion> listaRolOpcion = new ArrayList<Vw_rol_opcion>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from vw_rol_opcion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRolOpcion = ps.executeQuery();
			while(rsRolOpcion.next())
			{
				Vw_rol_opcion vrop  = new Vw_rol_opcion();
				vrop.setRol(rsRolOpcion.getString("rol"));
				vrop.setOpcion(rsRolOpcion.getString("opcion"));
				vrop.setRol_id(Integer.parseInt(rsRolOpcion.getString("rol_id")));
				vrop.setOpcion_id(Integer.parseInt(rsRolOpcion.getString("opcion_id")));
				listaRolOpcion.add(vrop);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listRolOpcion() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaRolOpcion;
	}
	
	

	public boolean guardarRolOpcion(int id_rol, int id_opcion)
	{
		boolean guardado = false;
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_rol_opcion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsRolOpcion = ps.executeQuery();
			
			rsRolOpcion.moveToInsertRow();
			rsRolOpcion.updateInt("id_rol", id_rol);
			rsRolOpcion.updateInt("id_opcion", id_opcion);
			rsRolOpcion.insertRow();
			
			rsRolOpcion.moveToCurrentRow();
			guardado = true;
			
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
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_rol_opcion WHERE id_opcion = ? AND id_rol = ?", 
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
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_rol_opcion", 
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
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarRolOpcion() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	
	
}