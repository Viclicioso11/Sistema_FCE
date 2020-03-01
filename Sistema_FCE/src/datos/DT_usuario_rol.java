package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Vw_usuario_rol;

public class DT_usuario_rol 
{
	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsUsuarioRol;
	
	// Metodo para visualizar todos los usuarios y roles octivos
	public ArrayList<Vw_usuario_rol> listUserRol()
	{
		ArrayList<Vw_usuario_rol> listaUsuarioRol = new ArrayList<Vw_usuario_rol>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * from vw_usuario_rol", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuarioRol = ps.executeQuery();
			while(rsUsuarioRol.next())
			{
				Vw_usuario_rol vur  = new Vw_usuario_rol();
				vur.setNombre(rsUsuarioRol.getString("nombre"));
				vur.setId_rol(Integer.parseInt(rsUsuarioRol.getString("id_rol")));
				vur.setId_user(Integer.parseInt(rsUsuarioRol.getString("id_usuario")));
				vur.setApellido(rsUsuarioRol.getString("apellido"));
				vur.setCarne(rsUsuarioRol.getString("carne"));
				vur.setRol(rsUsuarioRol.getString("rol"));
				vur.setCorreo(rsUsuarioRol.getString("correo"));
				listaUsuarioRol.add(vur);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUsuarioRol() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaUsuarioRol;
	}
	
	
	// Metodo para obtenero un usuario
	public Vw_usuario_rol obtenerUserRol(int idURol)
	{
		Vw_usuario_rol vur  = new Vw_usuario_rol();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * from Vw_usuario_rol where id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idURol);
			rsUsuarioRol = ps.executeQuery();
			if(rsUsuarioRol.next())
			{	
				vur.setId_user(rsUsuarioRol.getInt("id_user"));
				vur.setNombre(rsUsuarioRol.getString("nombre"));
				vur.setApellido(rsUsuarioRol.getString("apellido"));
				vur.setId_rol(rsUsuarioRol.getInt("id_rol"));
				vur.setCarne(rsUsuarioRol.getString("carne"));
				vur.setRol(rsUsuarioRol.getString("rol"));
				vur.setId_rol(rsUsuarioRol.getInt("id"));
				vur.setCorreo(rsUsuarioRol.getString("correo"));
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerURol() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return vur;
	}

	public boolean guardarUsuariorRol(int id_rol, int id_usuario)
	{
		boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_usuario", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuarioRol = ps.executeQuery();
			
			rsUsuarioRol.moveToInsertRow();
			rsUsuarioRol.updateInt("id_usuario", id_usuario);
			rsUsuarioRol.updateInt("id_rol", id_rol);
			rsUsuarioRol.insertRow();
			rsUsuarioRol.moveToCurrentRow();
			guardado = true;
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUsuarioRol(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}

	public boolean existeUsuarioRol(int id_usuario, int id_rol)
	{
		boolean existe=false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_usuario WHERE id_usuario = ? AND id_rol = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_usuario);
			ps.setInt(2, id_rol);
			rsUsuarioRol = ps.executeQuery();
			
			rsUsuarioRol.beforeFirst();
			if (rsUsuarioRol.next())
			{
				existe = true;
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR ExisteUsuarioRol() "+e.getMessage());
			e.printStackTrace();
		}
		return existe;
	}
	
	
	public boolean eliminarUsuarioRol(int id_usuario, int id_rol)
	{
		boolean eliminado=false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_usuario", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuarioRol = ps.executeQuery();
			
			
			rsUsuarioRol.beforeFirst();
			while (rsUsuarioRol.next())
			{
				if(rsUsuarioRol.getInt("id_rol") == id_rol)
				{
					if(rsUsuarioRol.getInt("id_usuario") == id_usuario) {
						rsUsuarioRol.deleteRow();
						eliminado=true;
						break;
					}
					
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarUsuarioRol() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
}