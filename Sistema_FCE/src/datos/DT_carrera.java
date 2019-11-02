package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_carrera;
import entidades.Tbl_usuario;

public class DT_carrera {
	
	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsCarrera;
	
	//Este metodo solo lista las carreras con el nombre y el id
	public ArrayList<Tbl_carrera> listarCarreras(){
		
		ArrayList<Tbl_carrera> listaCarrera = new ArrayList<Tbl_carrera>();
		
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_carrera where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsCarrera = ps.executeQuery();
			
			while(rsCarrera.next())
			{
				Tbl_carrera carrera = new Tbl_carrera();
				carrera.setId(rsCarrera.getInt("id"));
				carrera.setNombre(rsCarrera.getString("nombre"));
				listaCarrera.add(carrera);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarCarrera() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaCarrera;
		
	}
	
	

}
