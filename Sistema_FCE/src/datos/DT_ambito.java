package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_ambito;

public class DT_ambito {
	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsAmbito;
	
	//Este metodo solo lista los ambitos con el nombre y el id
	public ArrayList<Tbl_ambito> listarAmbitos(){
		
		ArrayList<Tbl_ambito> listaAmbito = new ArrayList<Tbl_ambito>();
		
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_ambito where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsAmbito = ps.executeQuery();
			
			while(rsAmbito.next())
			{
				Tbl_ambito ambito = new Tbl_ambito();
				ambito.setId(rsAmbito.getInt("id"));
				ambito.setAmbito(rsAmbito.getString("ambito"));
				listaAmbito.add(ambito);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarAmbito() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaAmbito;
		
	}
	
}
