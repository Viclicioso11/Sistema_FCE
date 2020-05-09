package datos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import entidades.Tbl_actividad_pg;
import entidades.Tbl_tarea;



public class DT_vw_tema_tarea {


    // Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsTarea;
	
	//FUnci�n para devolver un arreglo con todos los las actividad que hay en un cronograma
	public ArrayList<Tbl_tarea> listarTareas(int tema)
	{
		ArrayList<Tbl_tarea> listaTarea = new ArrayList<Tbl_tarea>();
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT tarea_id, titulo, descripcion, fecha_inicio, fecha_fin from vw_tema_tarea where tema_id = ? AND estado <> 3",
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, tema);
			rsTarea = ps.executeQuery();
			
			while(rsTarea.next())
			{
				Tbl_tarea tbltarea = new Tbl_tarea();
				
				tbltarea.setId(rsTarea.getInt("tarea_id"));
				tbltarea.setTitulo(rsTarea.getString("titulo"));
				tbltarea.setDescripcion(rsTarea.getString("descripcion"));
				tbltarea.setFecha_inicio(rsTarea.getDate("fecha_inicio"));
				tbltarea.setFecha_fin(rsTarea.getDate("fecha_fin"));
				listaTarea.add(tbltarea);	
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarTareas "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaTarea;
	}
	
	public String ArrayToJson(ArrayList<Tbl_tarea> actividades) {
		System.out.println("pasa por json");
		JSONArray jsonA = new JSONArray();
		for(Tbl_tarea actividad : actividades) {
			JSONObject jsonO = new JSONObject();
			jsonO.put("id", actividad.getId());
			jsonO.put("titulo", actividad.getTitulo());
			jsonO.put("descripcion", actividad.getDescripcion());
			jsonO.put("inicio", actividad.getFecha_inicio().toString());
			jsonO.put("end", actividad.getFecha_fin().toString());
			
			jsonA.put(jsonO);
		}
		
		return jsonA.toString();
	}
	
}
