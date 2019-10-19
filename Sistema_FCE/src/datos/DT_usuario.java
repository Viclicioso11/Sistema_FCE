package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Tbl_user;

public class DT_usuario 
{
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsUsuario;
	
	// Metodo para visualizar todos los usuarios activos
	public ArrayList<Tbl_user> listUser()
	{
		ArrayList<Tbl_user> listaUsuario = new ArrayList<Tbl_user>();
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_user where estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
			while(rsUsuario.next())
			{
				Tbl_user tus  = new Tbl_user();
				tus.setId_user(rsUsuario.getInt("id_user"));
				tus.setNombre1(rsUsuario.getString("nombre1"));
				tus.setNombre2(rsUsuario.getString("nombre2"));
				tus.setApellido1(rsUsuario.getString("apellido1"));
				tus.setApellido2(rsUsuario.getString("apellido2"));
				tus.setUsername(rsUsuario.getString("username"));
				tus.setPassword(rsUsuario.getString("password"));
				tus.setEmail(rsUsuario.getString("email"));
				tus.setPwd_tmp(rsUsuario.getString("pwd_tmp"));
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
	public Tbl_user obtenerUser(int idUser)
	{
		Tbl_user tus  = new Tbl_user();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_user where id_user = ? and estado<>3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idUser);
			rsUsuario = ps.executeQuery();
			if(rsUsuario.next())
			{
				tus.setId_user(rsUsuario.getInt("id_user"));
				tus.setNombre1(rsUsuario.getString("nombre1"));
				tus.setNombre2(rsUsuario.getString("nombre2"));
				tus.setApellido1(rsUsuario.getString("apellido1"));
				tus.setApellido2(rsUsuario.getString("apellido2"));
				tus.setUsername(rsUsuario.getString("username"));
				tus.setPassword(rsUsuario.getString("password"));
				tus.setEmail(rsUsuario.getString("email"));
				tus.setPwd_tmp(rsUsuario.getString("pwd_tmp"));
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
	
	public boolean guardarUser(Tbl_user tus)
	{
		boolean guardado = false;
		
		try
		{
			this.listUser();
			rsUsuario.moveToInsertRow();
			
			rsUsuario.updateString("username", tus.getUsername());
			rsUsuario.updateString("nombre1", tus.getNombre1());
			rsUsuario.updateString("nombre2", tus.getNombre2());
			rsUsuario.updateString("apellido1", tus.getApellido1());
			rsUsuario.updateString("apellido2", tus.getApellido2());
			rsUsuario.updateString("password", tus.getPassword());
			rsUsuario.updateString("email", tus.getEmail());
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
	
	public boolean modificarUser(Tbl_user tus)
	{
		boolean modificado=false;	
		try
		{
			this.listUser();
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tus.getId_user())
				{
					rsUsuario.updateString("nombre1", tus.getNombre1());
					rsUsuario.updateString("nombre2", tus.getNombre2());
					rsUsuario.updateString("apellido1", tus.getApellido1());
					rsUsuario.updateString("apellido2", tus.getApellido2());
					rsUsuario.updateString("password", tus.getPassword());
					rsUsuario.updateString("email", tus.getEmail());
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
	
	public boolean eliminarUser(Tbl_user tus)
	{
		boolean eliminado=false;	
		try
		{
			this.listUser();
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tus.getId_user())
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
