package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Tbl_usuario;
import entidades.Vw_usuario_rol;

/**
 * @author Jonathan
 *
 */
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
	
	
	//Metodo para validar si existe el usuario del Login
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
			
			if(tus.getCarne().equals(carne) && tus.getContrasena().equals(contrasena)) {
				return true;
			}
			else {
				return false;
			}
			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en Validar usuario "+ e.getMessage());
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
			rsUsuario.updateString("nombres", tus.getNombres());
			rsUsuario.updateString("apellidos", tus.getApellidos());
			rsUsuario.updateString("carne", tus.getCarne());
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
					rsUsuario.updateString("nombres", tus.getNombres());
					rsUsuario.updateString("apellidos", tus.getApellidos());
					rsUsuario.updateString("contrasena", tus.getContrasena());
					rsUsuario.updateString("correo", tus.getCorreo());
					rsUsuario.updateInt("estado",2);
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
	
	//Metodo para retornar el un objeto creado de la sesion
	public Vw_usuario_rol UsuarioConfirmado(String carne)
	{
		Vw_usuario_rol vsus  = new Vw_usuario_rol();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT nombre, apellido, carne, id, correo from vw_usuario_rol where carne = ? ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, carne);
			rsUsuario = ps.executeQuery();
			if(rsUsuario.next())
			{
				vsus.setNombre(rsUsuario.getString("nombre"));
				vsus.setApellido(rsUsuario.getString("apellido"));
				vsus.setCarne(rsUsuario.getString("carne"));
				vsus.setId_rol(rsUsuario.getInt("id"));
				vsus.setCorreo(rsUsuario.getString("correo"));
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerUsuarioConfirmado() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return vsus;
	}

	
	// Metodo para obtenero un usuario
		public int obtenerIDUser(String carne)
		{
			int id_user = 0;
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT id from tbl_usuario where carne = ? and estado<>3", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setString(1, carne);
				rsUsuario = ps.executeQuery();
				if(rsUsuario.next())
				{
					id_user = rsUsuario.getInt("id");
					
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en obtenerIDUser() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return id_user;
		}
		
		public boolean dtverificarLogin(String carne, String contrasena, int id_rol)
		{
			boolean existe=false;
			
			String SQL = ("SELECT * FROM public.vw_usuario_rol where carne=? and contrasena=? and id_rol=?");
			try
			{
				PreparedStatement ps = c.prepareStatement(SQL);
				ps.setString(1, carne);
				ps.setString(2, contrasena);
				ps.setInt(3, id_rol);
				ResultSet rs = null;
				rs = ps.executeQuery();
			
				if(rs.next())
				{
					existe=true;
				}
			
			
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR dtverificarLogin() "+ e.getMessage());
				e.printStackTrace();
			}
		
			return existe;
		}
		
		
		
		// Metodo para obtenero un usuario
		public Tbl_usuario obtenerNombreEstudiante(String carne_correo)
		{
			Tbl_usuario usuario = new Tbl_usuario();
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT * from tbl_usuario where carne = ? OR correo = ? and estado<>3", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setString(1, carne_correo);
				ps.setString(2, carne_correo);
				
				rsUsuario = ps.executeQuery();
				
				if(rsUsuario.next())
				{
					usuario.setNombres(rsUsuario.getString("nombres"));;
					usuario.setApellidos(rsUsuario.getString("apellidos"));
					usuario.setId(rsUsuario.getInt("id"));
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en obtenerNombreEstudiante() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return usuario;
		}
		
		public Tbl_usuario obtenerUser(int id)
		{
			Tbl_usuario tus  = new Tbl_usuario();
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT * from tbl_usuario where id = ? and estado<>3", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setInt(1, id);
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
				System.out.println("DATOS: ERROR en obtenerIDUser() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return tus;
		}

	
}
