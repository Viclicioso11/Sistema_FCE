package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entidades.Tbl_usuario;

public class DT_usuario_tema {


	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsUsuarioTema;
	
	public boolean validarUsuarioTema(int id_usuario)
	{
		boolean validar = false;
		
		Tbl_usuario tus  = new Tbl_usuario();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_usuario_tema where id_usuario = ? ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_usuario);
			rsUsuarioTema = ps.executeQuery();
			
			if(rsUsuarioTema.next())
			{
				validar = true;
				return validar;
			}
			
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en Validar UsuarioTema "+ e.getMessage());
			e.printStackTrace();
		}
		
		return validar;
		
	}
}
