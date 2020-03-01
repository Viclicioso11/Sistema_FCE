package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.util.ArrayList;
import java.sql.Date;
import entidades.Tbl_plan_graduacion;


public class DT_plan_graduacion {

	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsPg;
	
	//listamos todos los planes para llenar tabla de planes
	public ArrayList<Tbl_plan_graduacion> listPlanes()
	{
		ArrayList<Tbl_plan_graduacion> listaPlanes = new ArrayList<Tbl_plan_graduacion>();
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_plan_graduacion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsPg = ps.executeQuery();
			
			
			while(rsPg.next())
			{
				Tbl_plan_graduacion tpg  = new Tbl_plan_graduacion();
				tpg.setId(rsPg.getInt("id"));
				tpg.setDescripcion(rsPg.getString("descripcion"));
				tpg.setFecha_inicio(rsPg.getDate("fecha_inicio"));//obtenemos la fecha de la base de datos y la convertimos en cadena
				tpg.setFecha_fin(rsPg.getDate("fecha_fin"));
				tpg.setEstado(rsPg.getInt("estado"));
				tpg.setCohorte(rsPg.getString("cohorte"));
				listaPlanes.add(tpg);
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaPlanes;
	}
	
	
	public void getRs(Connection con) {
		try
		{

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_plan_graduacion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsPg = ps.executeQuery();
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	public boolean ExistePG(int idPG) {
		boolean existe = false;
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_plan_graduacion where id=?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idPG);
			rsPg = ps.executeQuery();
			
			if(rsPg.next()) {
				existe = true;
			}

			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
		return existe;
	}
	
	//Funcion para guardar plan de graduacion
	public boolean guardarPlanG(Tbl_plan_graduacion tplan ) throws ParseException {
			
		boolean guardado = false;		
		Date fecha_inicio = new Date(tplan.getFecha_inicio().getTime() );
		Date fecha_fin = new Date(  tplan.getFecha_fin().getTime() );
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRs(con);
			rsPg.moveToInsertRow();
			rsPg.updateString("cohorte", tplan.getCohorte());
			rsPg.updateString("descripcion", tplan.getDescripcion());
			rsPg.updateDate("fecha_inicio",  fecha_inicio);
			rsPg.updateDate("fecha_fin", fecha_fin );
			rsPg.updateInt("estado",1);
			
			
			rsPg.insertRow();
			rsPg.moveToCurrentRow();
			
			guardado = true;
			connectionP.closeConnection(con);
		}
		catch (Exception e) 
		{
			System.err.println("ERROR en guardarPlanG(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	//Funcion para editar el plan de graduacion
	public boolean editarPlanG(Tbl_plan_graduacion tplan)
	{
		boolean modificado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_plan_graduacion", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsPg = ps.executeQuery();
			
			
			rsPg.beforeFirst();
			while (rsPg.next())
			{
				if(rsPg.getInt(1)== tplan.getId())
				{
					
					Date fecha_inicio = new Date(tplan.getFecha_inicio().getTime() );
					Date fecha_fin = new Date(  tplan.getFecha_fin().getTime() );
					
					rsPg.updateString("descripcion", tplan.getDescripcion());
					rsPg.updateDate("fecha_inicio",fecha_inicio);
					rsPg.updateDate("fecha_fin",fecha_fin);
					rsPg.updateRow();
					modificado=true;
					break;
				}
			}

			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR editarCronograma() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	//Metodo para obtener los datos del PLan de Graduacion
	public Tbl_plan_graduacion obtenerPlanG(int id_planG)
	{
		Tbl_plan_graduacion tplan = new Tbl_plan_graduacion();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_plan_graduacion where id = ? AND estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_planG);
			rsPg = ps.executeQuery();
			
			while(rsPg.next())
			{
				
				tplan.setId(rsPg.getInt("id"));
				tplan.setCohorte(rsPg.getString("cohorte"));
				tplan.setDescripcion(rsPg.getString("descripcion"));
				tplan.setFecha_inicio(rsPg.getDate("fecha_inicio"));
				tplan.setFecha_fin(rsPg.getDate("fecha_fin"));
			}

			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listarActividadesCronograma "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tplan;
	}

	public int obtenerIdPg(java.util.Date fechaInicio, java.util.Date fechaFin, String descripcion) {
		int id_pg = 0;
		
		try
		{
			Date Finicio = new Date( fechaInicio.getTime());
			Date Ffin = new Date( fechaFin.getTime());
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			
			PreparedStatement ps = con.prepareStatement("SELECT id from tbl_plan_graduacion WHERE fecha_inicio = ? AND fecha_fin = ? AND"
					+ " descripcion = ?",
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			ps.setDate(1,Finicio);
			ps.setDate(2, Ffin);
			ps.setString(3, descripcion);
			
			rsPg = ps.executeQuery();
			
			rsPg.beforeFirst();
			if(rsPg.next())
			{
				id_pg = rsPg.getInt("id");
				
			}

			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerID_PG() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return id_pg;
	}
			
	public static void main(String[] args) {
	}
	
}
