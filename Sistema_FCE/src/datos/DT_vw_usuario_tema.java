package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Vw_usuario_tema;

public class DT_vw_usuario_tema {

	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsUsuarioTema;
	
	// Metodo para visualizar la vista de usuario tema
			public ArrayList<Vw_usuario_tema> listUsuarioTema()
			{
				ArrayList<Vw_usuario_tema> listUsuarioTema = new ArrayList<Vw_usuario_tema>();
				
				try
				{
					PreparedStatement ps = c.prepareStatement("SELECT * FROM public.vw_usuario_tema;", 
							ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
							ResultSet.HOLD_CURSORS_OVER_COMMIT);
					rsUsuarioTema = ps.executeQuery();
					if(rsUsuarioTema.next())
					{
						Vw_usuario_tema  vwUT = new Vw_usuario_tema();
						vwUT.setId_tema(rsUsuarioTema.getInt("id_tema"));
						vwUT.setTema(rsUsuarioTema.getString("tema"));
						vwUT.setTipo(rsUsuarioTema.getString("tipo"));
						vwUT.setAmbito(rsUsuarioTema.getString("ambito"));
						vwUT.setCarrera(rsUsuarioTema.getString("carrera"));
						listUsuarioTema.add(vwUT);
					}
				}
				catch (Exception e)
				{
					System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
					e.printStackTrace();
				}
				
				return listUsuarioTema;
			}
}
