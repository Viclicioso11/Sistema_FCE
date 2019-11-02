package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_tipo_fce;

public class DT_tipo_fce {

	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsTipoFce;
	
	//Este metodo solo lista las carreras con el nombre y el id
	public ArrayList<Tbl_tipo_fce> listarTipoFce(){
		
		ArrayList<Tbl_tipo_fce> listaTipoFce = new ArrayList<Tbl_tipo_fce>();
		
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tipo_fce where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsTipoFce = ps.executeQuery();
			
			while(rsTipoFce.next())
			{
				Tbl_tipo_fce tipoFce = new Tbl_tipo_fce();
				tipoFce.setId(rsTipoFce.getInt("id"));
				tipoFce.setTipo(rsTipoFce.getString("tipo"));
				listaTipoFce.add(tipoFce);
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarTipoFce() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaTipoFce;
		
	}
	
	
}
