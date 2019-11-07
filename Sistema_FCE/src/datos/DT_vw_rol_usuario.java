package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Vw_usuario_rol;

public class DT_vw_rol_usuario {
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsTutor;
	
	// Metodo para visualizar todos los usuarios activos que son tutores
		public ArrayList<Vw_usuario_rol> listarTutor()
		{
			ArrayList<Vw_usuario_rol> listarTutor = new ArrayList<Vw_usuario_rol>();
			
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT  * FROM public.vw_usuario_rol where id_rol =3;", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				rsTutor = ps.executeQuery();
				
				while(rsTutor.next())
				{
					Vw_usuario_rol  vwur = new Vw_usuario_rol();
					vwur.setId_user(rsTutor.getInt("id_usuario"));
					vwur.setNombre(rsTutor.getString("nombre"));
					
					listarTutor.add(vwur);
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return listarTutor;
		}
		
		
		
		
}
