package datos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.json.*;
import entidades.Tbl_actividad_pg;

public class DT_actividad_pg {
	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsPg;

	
	public ArrayList<Tbl_actividad_pg> parsearJson(JSONArray jsonA){
		ArrayList<Tbl_actividad_pg> actividades = new ArrayList<Tbl_actividad_pg>();
		
		try {
			
		
			for(int i=0; i < jsonA.length(); i++) {
				
				Tbl_actividad_pg actividad = new Tbl_actividad_pg();
				JSONObject json = new JSONObject();
				json = jsonA.getJSONObject(i);
				
				actividad.setNombre(json.getString("titulo"));
				actividad.setFecha_inicio( new SimpleDateFormat("dd/MM/yyyy").parse(json.getString("inicio")) );
				actividad.setFecha_fin( new SimpleDateFormat("dd/MM/yyyy").parse(json.getString("end")) );
				
				if(json.getString("descripcion") != null) {
					actividad.setDescripcion(json.getString("descripcion"));
				}else {
					System.out.println("no tiene descripcion");
				}
				
				// los otros campos se llenaran despues
				// ahorita solo nos interesa la info que nos envio
				// el formulario
				actividades.add(actividad);
			}
			
			
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return actividades;
	}
	
	
	public String ArrayToJson(ArrayList<Tbl_actividad_pg> actividades) {
		
		JSONArray jsonA = new JSONArray();
		for(Tbl_actividad_pg actividad : actividades) {
			JSONObject jsonO = new JSONObject();
			jsonO.put("id", actividad.getId());
			jsonO.put("titulo", actividad.getNombre());
			jsonO.put("descripcion", actividad.getDescripcion());
			jsonO.put("inicio", actividad.getFecha_inicio().toString());
			jsonO.put("end", actividad.getFecha_fin().toString());
			
			jsonA.put(jsonO);
		}
		
		return jsonA.toString();
	}
	//Guardamos las actividades que va agregando al plan de graduacion
	public boolean guardarActividadPG(Tbl_actividad_pg tap, int id_Pg) {
		boolean guardado = false;

		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_pg", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsPg = ps.executeQuery();
			
			rsPg.moveToInsertRow();
			
			/*
			java.sql.Date fecha_inicio = new java.sql.Date(tap.getFecha_inicio().getTime());
			java.sql.Date fecha_fin = new java.sql.Date(tap.getFecha_fin().getTime());
			
			*/
			Date inicio = new Date(tap.getFecha_inicio().getTime());
			Date fin = new Date(tap.getFecha_fin().getTime());
			
			rsPg.updateString("nombre", tap.getNombre());
			rsPg.updateString("descripcion", tap.getDescripcion());
			rsPg.updateDate("fecha_inicio", inicio);
			rsPg.updateDate("fecha_fin",fin);
			rsPg.updateInt("estado",1);
			rsPg.updateInt("id_plan_graduacion",id_Pg);
			
			rsPg.insertRow();
			rsPg.moveToCurrentRow();
			
			guardado = true;
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
				
		}
	
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en guardarActividadPlanG"+ e.getMessage());
			e.printStackTrace();
		}
		return guardado;
		
	}
	
	
	public boolean guardarActividades(ArrayList<Tbl_actividad_pg> actividades, int idP) {
		boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_pg", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsPg = ps.executeQuery();
			
			for(int i=0; i < actividades.size(); i++) {
				
				Date Finicio = new Date(actividades.get(i).getFecha_inicio().getTime());
				Date Ffin = new Date(actividades.get(i).getFecha_fin().getTime());
				
				rsPg.moveToInsertRow();
				rsPg.updateString("nombre", actividades.get(i).getNombre());
				rsPg.updateString("descripcion", actividades.get(i).getDescripcion());
				rsPg.updateDate("fecha_inicio", Finicio);
				rsPg.updateDate("fecha_fin", Ffin);
				rsPg.updateInt("estado",1);
				rsPg.updateInt("id_plan_graduacion",idP);
	
				rsPg.insertRow();
				rsPg.moveToCurrentRow();
			}
			guardado = true;
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
				
		}
		
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en guardarActividades del Plan de Graduacion"+ e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	
	@SuppressWarnings("unused")
	public boolean editarActividades(ArrayList<Tbl_actividad_pg> actividades, int idP)
	{
		boolean modificado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_pg", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsPg = ps.executeQuery();
			
			
			rsPg.beforeFirst();
			while (rsPg.next())
			{
				for (int i = 0 ; i < actividades.size() ; i++ ) {
					
			
					Date Finicio = new Date(actividades.get(i).getFecha_inicio().getTime());
					Date Ffin = new Date(actividades.get(i).getFecha_fin().getTime());
						
						rsPg.updateString("nombre", actividades.get(i).getNombre());
						rsPg.updateString("descripcion", actividades.get(i).getDescripcion());
						rsPg.updateDate("fecha_inicio", Finicio);
						rsPg.updateDate("fecha_fin", Ffin);
						rsPg.updateInt("estado",1);
						rsPg.updateInt("id_plan_graduacion",idP);
						rsPg.updateRow();
						modificado=true;
						break;
				}
			
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}
		
		catch (Exception e)
		{
			System.err.println("ERROR editarActividadCrono() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	public boolean editarActividad(Tbl_actividad_pg actividad) {
		boolean editado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_pg where id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			ps.setInt(1, actividad.getId());
			rsPg = ps.executeQuery();
			
			
			rsPg.beforeFirst();
			
			if(rsPg.next()) {
				Date inicio = new Date(actividad.getFecha_inicio().getTime());
				Date fin = new Date(actividad.getFecha_fin().getTime());
				
				rsPg.updateString("nombre", actividad.getNombre());
				rsPg.updateString("descripcion", actividad.getDescripcion());
				rsPg.updateDate("fecha_inicio", inicio);
				rsPg.updateDate("fecha_fin", fin);
				rsPg.updateInt("estado",1);
				rsPg.updateRow();
				editado=true;
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}	
		
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return editado;
	}
	
	//Funcion para obtener un arreglo con las actividades registradas en el Plan
	public ArrayList<Tbl_actividad_pg> listarActividadesPg(int id_plan)
	{		
		ArrayList<Tbl_actividad_pg> listaAct = new ArrayList<Tbl_actividad_pg>();
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_actividad_pg where id_plan_graduacion = ? AND estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_plan);
			rsPg = ps.executeQuery();
			
			while(rsPg.next())
			{
				Tbl_actividad_pg plan = new Tbl_actividad_pg();
				
				plan.setId(rsPg.getInt("id"));
				plan.setNombre(rsPg.getString("nombre"));
				plan.setDescripcion(rsPg.getString("descripcion"));
				plan.setFecha_inicio(rsPg.getDate("fecha_inicio"));
				plan.setFecha_fin(rsPg.getDate("fecha_fin"));
				plan.setId_plan_graduacion(rsPg.getInt("id_plan_graduacion"));
				listaAct.add(plan);	
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarActividadesCronograma "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaAct;
	}
	
	public static void main(String[] args) {
	}
}
