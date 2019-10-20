package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Tbl_usuario;

public class DT_usuario 
{
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsUsuario;
	
	// Metodo para visualizar todos los usuarios activos
	public ArrayList<Tbl_usuario> listUser()
	{
		ArrayList<Tbl_usuario> listaUsuario = new ArrayList<Tbl_usuario>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_usuario where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
			while(rsUsuario.next())
			{
				Tbl_usuario tus  = new Tbl_usuario();
				tus.setId(rsUsuario.getInt("id"));
				tus.setNombres(rsUsuario.getString("nombres"));
				tus.setApellidos(rsUsuario.getString("apellidos"));
				tus.setCarne(rsUsuario.getString("carne"));
				tus.setContrasena(rsUsuario.getString("contrasena"));
				tus.setCorreo(rsUsuario.getString("correo"));
				tus.setEstado(rsUsuario.getInt("estado"));
				listaUsuario.add(tus);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaUsuario;
	}
	
	// Metodo para obtenero un usuario
	public Tbl_usuario obtenerUser(int idUser)
	{
		Tbl_usuario tus  = new Tbl_usuario();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_user where id_user = ? and estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idUser);
			rsUsuario = ps.executeQuery();
			if(rsUsuario.next())
			{
				tus.setId(rsUsuario.getInt("id"));
				tus.setNombres(rsUsuario.getString("nombres"));
				tus.setApellidos(rsUsuario.getString("apellidos"));
				tus.setCarne(rsUsuario.getString("carne"));
				tus.setContrasena(rsUsuario.getString("contrasena"));
				tus.setCorreo(rsUsuario.getString("correo"));
				tus.setEstado(rsUsuario.getInt("estado"));
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tus;
	}
	
	
	//Metodo para validar el Login
	public boolean validarUsuario(String carne, String contrasena)
	{
		
		
		Tbl_usuario tus  = new Tbl_usuario();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT carne, contrasena from tbl_usuario where carne = ? and estado <>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, carne);
			rsUsuario = ps.executeQuery();
			if(rsUsuario.next())
			{
				tus.setCarne(rsUsuario.getString("carne"));
				tus.setContrasena(rsUsuario.getString("contrasena"));
			}
			
			if(tus.getCarne().equals(carne) && tus.getContrasena() == contrasena) {
				return true;
			}
			else {
				return false;
			}
			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerUser() "+ e.getMessage());
			e.printStackTrace();
			return false;
		}
		
	}
	
	public boolean guardarUser(Tbl_usuario tus)
	{
		boolean guardado = false;
		
		try
		{
			this.listUser();
			rsUsuario.moveToInsertRow();
			
			rsUsuario.updateString("carne", tus.getCarne());
			rsUsuario.updateString("nombres", tus.getNombres());
			rsUsuario.updateString("apellidos", tus.getApellidos());
			rsUsuario.updateString("contrasena", tus.getContrasena());
			rsUsuario.updateString("correo", tus.getCorreo());
			rsUsuario.updateInt("estado", 1);
			rsUsuario.insertRow();
			rsUsuario.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUser(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	public boolean modificarUser(Tbl_usuario tus)
	{
		boolean modificado=false;	
		try
		{
			this.listUser();
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tus.getId())
				{
					rsUsuario.updateString("nombre1", tus.getNombres());
					rsUsuario.updateString("apellidos", tus.getApellidos());
					rsUsuario.updateString("password", tus.getContrasena());
					rsUsuario.updateString("email", tus.getCorreo());
					rsUsuario.updateInt("estado", 2);
					rsUsuario.updateRow();
					modificado=true;
					break;
				}
			}
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificarUser() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	public boolean eliminarUser(Tbl_usuario tus)
	{
		boolean eliminado=false;	
		try
		{
			this.listUser();
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tus.getId())
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
			System.err.println("ERROR eliminarUser() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	

}