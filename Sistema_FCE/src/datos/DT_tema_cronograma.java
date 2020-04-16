package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Vw_tema_cronograma;

/**
 * @author Jonathan
 *
 */
public class DT_tema_cronograma 
{
	 // Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsTemaCronograma;
	
	// Metodo para listar los temas de un tutor disponibles
	public ArrayList<Vw_tema_cronograma> listar_temas_cronograma(int id_tutor)
	{
		
		DT_cronograma dtcrono = new DT_cronograma();
		
		// es el id del cronograma actual
		int id_cronograma = dtcrono.obtenerIdCronogramaFechas();
		
		ArrayList<Vw_tema_cronograma> listaTemaCronograma = new ArrayList<Vw_tema_cronograma>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from vw_tema_cronograma where id_tutor = ? AND estado_tema = 1  AND id_cronograma = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
					ps.setInt(1, id_tutor);
					ps.setInt(2, id_cronograma);
					
			rsTemaCronograma = ps.executeQuery();
			while(rsTemaCronograma.next())
			{
				Vw_tema_cronograma vwTC  = new Vw_tema_cronograma();
				vwTC.setId(rsTemaCronograma.getInt("id"));
				vwTC.setId_cronograma(rsTemaCronograma.getInt("id_cronograma"));
				vwTC.setId_tema(rsTemaCronograma.getInt("id_tema"));
				vwTC.setTema(rsTemaCronograma.getString("tema"));
				vwTC.setDescripcion_cronograma(rsTemaCronograma.getString("descripcion_cronograma"));
				listaTemaCronograma.add(vwTC);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listTemaCronograma() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaTemaCronograma;
	}
	
	// Metodo para listar los temas de un cronograma
	public ArrayList<Vw_tema_cronograma> listar_temas_administrador()
	{
		
		DT_cronograma dtcrono = new DT_cronograma();
		
		// es el id del cronograma actual
		int id_cronograma = dtcrono.obtenerIdCronogramaFechas();
		
		ArrayList<Vw_tema_cronograma> listaTemaCronograma = new ArrayList<Vw_tema_cronograma>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from vw_tema_cronograma where estado_tema = 1  AND id_cronograma = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
					ps.setInt(1, id_cronograma);
					
			rsTemaCronograma = ps.executeQuery();
			while(rsTemaCronograma.next())
			{
				Vw_tema_cronograma vwTC  = new Vw_tema_cronograma();
				vwTC.setId(rsTemaCronograma.getInt("id"));
				vwTC.setId_cronograma(rsTemaCronograma.getInt("id_cronograma"));
				vwTC.setId_tema(rsTemaCronograma.getInt("id_tema"));
				vwTC.setTema(rsTemaCronograma.getString("tema"));
				vwTC.setDescripcion_cronograma(rsTemaCronograma.getString("descripcion_cronograma"));
				listaTemaCronograma.add(vwTC);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listTemaCronograma() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaTemaCronograma;
	}
	
}
