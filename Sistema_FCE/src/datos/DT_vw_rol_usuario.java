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
		public ArrayList<Vw_usuario_rol> listTutor()
		{
			ArrayList<Vw_usuario_rol> listaTutor = new ArrayList<Vw_usuario_rol>();
			
			try
			{
				PreparedStatement ps = c.prepareStatement("SELECT * FROM public.vw_usuario_rol where rol ='Tutor' or rol='tutor';", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				rsTutor = ps.executeQuery();
				
				while(rsTutor.next())
				{
					Vw_usuario_rol  vwUR = new Vw_usuario_rol();
					vwUR.setId_user(rsTutor.getInt("id_usuario"));
					vwUR.setNombre(rsTutor.getString("nombre"));
					
					listaTutor.add(vwUR);
				}
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return listaTutor;
		}
}
