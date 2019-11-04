package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Tbl_facultad;
import entidades.Tbl_facultad;

/**
 * @author Jonathan
 *
 */
public class DT_facultad 
{
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsUsuario;
	
	// Metodo para visualizar todos los facultads activos
	public ArrayList<Tbl_facultad> listFacultad()
	{
		ArrayList<Tbl_facultad> listaFacultad = new ArrayList<Tbl_facultad>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_facultad where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
			while(rsUsuario.next())
			{
				Tbl_facultad tfa  = new Tbl_facultad();
				tfa.setId(rsUsuario.getInt("id"));
				tfa.setNombre(rsUsuario.getString("nombre"));
				tfa.setEstado(rsUsuario.getInt("estado"));
				listaFacultad.add(tfa);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listFacultad() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaFacultad;
	}
	
	
	public boolean guardarFacultad(Tbl_facultad tfa)
	{
		boolean guardado = false;
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_facultad where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
			rsUsuario.moveToInsertRow();
			rsUsuario.updateString("nombre", tfa.getNombre());
			rsUsuario.updateInt("estado", 1);
			rsUsuario.insertRow();
			rsUsuario.moveToCurrentRow();
			guardado = true;
			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarFacultad(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	public boolean modificarFacultad(Tbl_facultad tfa)
	{
		boolean modificado=false;	
		try
		{

			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_facultad where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tfa.getId())
				{
					rsUsuario.updateString("nombre", tfa.getNombre());
					rsUsuario.updateInt("estado",2);
					rsUsuario.updateRow();
					modificado=true;
					break;
				}
			}
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificarFacultad() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	public boolean eliminarFacultad(Tbl_facultad tfa)
	{
		boolean eliminado=false;	
		try
		{
			this.listFacultad();
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tfa.getId())
				{
					rsUsuario.updateInt("estado",3);
					rsUsuario.updateRow();
					eliminado=true;
					break;
				}
			}
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarFacultad() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	// Metodo para obtenero un facultad
		public Tbl_facultad obtenerFacultad(int idFacultad)
		{
			Tbl_facultad tus  = new Tbl_facultad();
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT * from tbl_facultad where id = ? and estado<>3", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setInt(1, idFacultad);
				rsUsuario = ps.executeQuery();
				if(rsUsuario.next())
				{
					tus.setId(rsUsuario.getInt("id"));
					tus.setNombre(rsUsuario.getString("nombre"));
					tus.setEstado(rsUsuario.getInt("estado"));
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en obtenerFacultad() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return tus;
		}

	
}
