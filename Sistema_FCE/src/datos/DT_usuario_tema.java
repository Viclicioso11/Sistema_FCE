package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import entidades.Tbl_usuario_tema;

public class DT_usuario_tema {


	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsUsuarioTema;
	
	public boolean validarUsuarioTema(int id_usuario)
	{
		boolean validar = false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario_tema where id_usuario = ? ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_usuario);
			rsUsuarioTema = ps.executeQuery();
			
			if(rsUsuarioTema.next())
			{
				validar = true;
				return validar;
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en Validar UsuarioTema "+ e.getMessage());
			e.printStackTrace();
		}
		
		return validar;
		
	}
	
	// Metodo para visualizar todos los usuarios_temas activos
	public ArrayList<Tbl_usuario_tema> listUsaurioTema()
	{
		ArrayList<Tbl_usuario_tema> listaUsuarioTema = new ArrayList<Tbl_usuario_tema>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario_tema", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuarioTema = ps.executeQuery();
			while(rsUsuarioTema.next())
			{
				Tbl_usuario_tema tut  = new Tbl_usuario_tema();
				tut.setId(rsUsuarioTema.getInt("id"));
				tut.setId_usuario(rsUsuarioTema.getInt("id_usuario"));
				tut.setId_tema(rsUsuarioTema.getInt("id_tema"));
				
				listaUsuarioTema.add(tut);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		} catch (Exception e)	{
			System.out.println("DATOS: ERROR en listtema() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaUsuarioTema;
	}
			
	public void getRS(Connection con) {
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("SELECT * from tbl_usuario_tema", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsUsuarioTema = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	//Metodo para guardar Usuariotema
	public boolean guardarUsuarioTema(Tbl_usuario_tema tut)
	{
		boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			this.getRS(con);
			rsUsuarioTema.moveToInsertRow();
			rsUsuarioTema.updateInt("id_usuario", tut.getId_usuario());
			rsUsuarioTema.updateInt("id_tema", tut.getId_tema());
			rsUsuarioTema.insertRow();
			rsUsuarioTema.moveToCurrentRow();
			guardado = true;
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUser(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	//Metodo para modficar Usuariotema
	public boolean modificarUsuariotema(Tbl_usuario_tema tut)
	{
		boolean modificado=false;	
		try
		{

			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			this.getRS(con);
			rsUsuarioTema.beforeFirst();
			while (rsUsuarioTema.next())
			{
				if(rsUsuarioTema.getInt(1)==tut.getId())
				{
					rsUsuarioTema.updateInt("id_usuario",tut.getId_usuario());
					rsUsuarioTema.updateInt("id_tema", tut.getId_tema());
					rsUsuarioTema.updateRow();
					modificado=true;
					break;
					
				}
			}
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		}	catch (Exception e)		{
			System.err.println("ERROR modificarUsuarioTema() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	

	public boolean eliminarUsuarioTema(int id_usuario, int id_tema)
	{
		boolean eliminado=false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			this.getRS(con);
			rsUsuarioTema.beforeFirst();
			
			while (rsUsuarioTema.next())
			{
				if(rsUsuarioTema.getInt("id_usuario") == id_usuario)
				{
					if(rsUsuarioTema.getInt("id_tema") == id_tema) {
						rsUsuarioTema.deleteRow();
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
			System.err.println("ERROR eliminaUsuarioTEma() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	//para obtener el id del tema dependiendo del id del usuario
	public int ibtenerIdTema(int id_usuario)
	{
		int id_tema = 0;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT id_tema from vw_tema_estudiante where id_usuario = ? ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_usuario);
			
			rsUsuarioTema = ps.executeQuery();
			
			if(rsUsuarioTema.next())
			{
				id_tema = rsUsuarioTema.getInt("id_tema");
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en Validar ibtenerIdTema "+ e.getMessage());
			e.printStackTrace();
		}
		
		return id_tema;
		
	}

}