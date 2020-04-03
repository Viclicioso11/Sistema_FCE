package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

import entidades.Tbl_tema;
import entidades.Tbl_usuario;
import entidades.Tbl_usuario_tema;



public class DT_tema {
	
	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsTema;
	Calendar cal = Calendar.getInstance();
	DT_cronograma dtcronogra = new DT_cronograma();
	
	public boolean guardarTema(Tbl_tema tem)
	{
		boolean guardado = false;
		
		//para obtener el valor de la fecha del sistema
		String dia = Integer.toString(cal.get(Calendar.DATE));
		String mes = Integer.toString(cal.get(Calendar.MONTH));
		String anio = Integer.toString(cal.get(Calendar.YEAR));
		String fechaHoy = ""+anio+"/"+mes+"/"+dia;
		
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getResulset(con);
			
			rsTema.moveToInsertRow();
			rsTema.updateString("tema", tem.getTema());
			rsTema.updateString("fecha", fechaHoy);
			rsTema.updateString("palabras_claves", tem.getPalabras_claves());
			rsTema.updateInt("id_ambito", tem.getId_ambito());
			rsTema.updateInt("id_carrera",tem.getId_carrera());
			rsTema.updateInt("id_tipo_fce", tem.getId_tipo_fce());
			rsTema.updateInt("estado", 1);
			rsTema.updateString("url", tem.getUrl());
			rsTema.insertRow();
			rsTema.moveToCurrentRow();
			guardado = true;
			
			connectionP.closeConnection(con);
			
		} catch (Exception e)	{
			System.err.println("ERROR guardarTema(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	
	public int obtenerIdTema(String tema) {
		int id_tema = 0;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT id from tbl_tema where tema = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, tema);
			rsTema = ps.executeQuery();
			if(rsTema.next())
			{
				id_tema = rsTema.getInt("id");
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerIDUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return id_tema;
	}
	
	
	
	
	public void getResulset(Connection con) {
		try
		{

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_tema", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsTema = ps.executeQuery();
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerOpciones() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	public boolean guardarUsuariosTema(ArrayList<Tbl_usuario_tema> usuariosTema) {
		
	boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario_tema ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsTema = ps.executeQuery();
			
			//vamos a guardar la cantidad de usuarios que vengan 
			for(Tbl_usuario_tema tust : usuariosTema) {
				rsTema.moveToInsertRow();
				rsTema.updateInt("id_usuario", tust.getId_usuario());
				rsTema.updateInt("id_tema", tust.getId_tema());
				
				rsTema.insertRow();
				rsTema.moveToCurrentRow();
				guardado = true;
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
				
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarUsuarioTema(): "+e.getMessage());
			e.printStackTrace();
			guardado = false;
		}
		
		return guardado;
	}
	
	
	//*************************************************************************
	//METODOS PARA EDITAR LA FCE//////////////////////////////
	//*********************************************************************
	
	public Tbl_tema obtenerTema(int id)
	{
		Tbl_tema tem  = new Tbl_tema();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_tema where id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id);
			rsTema = ps.executeQuery();
			if(rsTema.next())
			{
				
				tem.setId(rsTema.getInt("id"));
				tem.setTema(rsTema.getString("tema"));
				tem.setPalabras_claves(rsTema.getString("palabras_claves"));
				tem.setId_ambito(rsTema.getInt("id_ambito"));
				tem.setId_carrera(rsTema.getInt("id_carrera"));
				tem.setId_tipo_fce(rsTema.getInt("id_tipo_fce"));
				tem.setUrl(rsTema.getString("url"));
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerTema() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tem;
	}
	
	//Metodo para guardar un estudiante en un tema fce
	public boolean guardarEstudianteTema(int id_tema, int id_usuario) {
		
	boolean guardado = false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario_tema ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsTema = ps.executeQuery();
		
			rsTema.moveToInsertRow();
			rsTema.updateInt("id_usuario", id_usuario);
			rsTema.updateInt("id_tema", id_tema);
			
			rsTema.insertRow();
			rsTema.moveToCurrentRow();
			guardado = true;
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
				
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarEstudianteTema(): "+e.getMessage());
			e.printStackTrace();
			guardado = false;
		}
		
		return guardado;
	}
	
	
	
	//retorna los nombres y apellidos de los estudiantes y sus carne
	public ArrayList<Tbl_usuario> obtenerEstudiante(int id_tema)
	{
		
		 ArrayList<Tbl_usuario> estudiantes = new  ArrayList<Tbl_usuario>();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT nombres, apellidos, carne, usuario_id from vw_tema_editar  where tema_id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_tema);
			rsTema = ps.executeQuery();
			
			while(rsTema.next())
			{
				Tbl_usuario tus  = new Tbl_usuario();
				tus.setId(rsTema.getInt("usuario_id"));
				tus.setNombres(rsTema.getString("nombres"));
				tus.setApellidos(rsTema.getString("apellidos"));
				tus.setCarne(rsTema.getString("carne"));
				estudiantes.add(tus);
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerEstudiantes() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return estudiantes;
	}
	
	//Vamos a editar los valores de la FCE que el usuario desee
	//boolean url es para verificar si al modificar cambiaron o no la url (otro archivo)
	public boolean modificarTema(Tbl_tema tem, boolean url)
	{
		//para obtener el valor de la fecha del sistema
		String dia = Integer.toString(cal.get(Calendar.DATE));
		String mes = Integer.toString(cal.get(Calendar.MONTH));
		String anio = Integer.toString(cal.get(Calendar.YEAR));
		String fechaHoy = ""+anio+"/"+mes+"/"+dia;
		
		boolean modificado=false;	
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getResulset(con);
			
			rsTema.beforeFirst();
			while (rsTema.next())
			{
				if(rsTema.getInt(1) == tem.getId())
				{
					if(url) {
						rsTema.updateString("url", tem.getUrl());
					}
					rsTema.updateString("tema", tem.getTema());
					rsTema.updateString("fecha", fechaHoy);
					rsTema.updateString("palabras_claves", tem.getPalabras_claves());
					rsTema.updateInt("id_ambito", tem.getId_ambito());
					rsTema.updateInt("id_carrera",tem.getId_carrera());
					rsTema.updateInt("id_tipo_fce", tem.getId_tipo_fce());
					rsTema.updateRow();
					modificado=true;
					break;
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificaTEma() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	
	//Este metodo elimina una fila de la tabla tema_usurio cuando se es eliminado a un estudiante de un tema de fce

	public boolean eliminarEstudiante(int id_usuario, int id_tema)
	{
		boolean eliminado=false;
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_usuario_tema WHERE id_usuario = ? AND id_tema = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_usuario);
			ps.setInt(2, id_tema);
			rsTema = ps.executeQuery();
			
			
			rsTema.beforeFirst();
			while (rsTema.next())
			{
				if(rsTema.getInt("id_usuario") == id_usuario && rsTema.getInt("id_tema") == id_tema)
				{
						rsTema.deleteRow();
						eliminado=true;
						break;
				}
					
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminaEstudiante() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	
	
	/**
	 * Metodos para asignar un 
	 * tutor a una fce
	 * 
	 * */
	//Asignar tutor a FCE
	
	public boolean asignartutor(int id_tutor, int id_tema) {

		boolean asignado = false;
		try {
			
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from public.tbl_tema where id = ? ", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			ps.setInt(1, id_tema);

			rsTema = ps.executeQuery();
			
			if(rsTema.next()) {

				rsTema.updateInt("tutor", id_tutor);
				rsTema.updateRow();
				asignado = true;
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);

		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return asignado;
			
	}
	
	//al guardar un tema, asignar el cronograma al que este será asignado
	
	public boolean asignarTemaCronograma(int id_tema) {
		
		//obtenemos el id del cronograma en dependencia de la fecha de inscripcion respecto a inicio o fin de un cronograma
		
		int id_cronograma = dtcronogra.obtenerIdCronogramaFechas();
			
		

		boolean asignado = false;
		try {
			
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from public.tbl_tema_cronograma	", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsTema = ps.executeQuery();
			
			rsTema.moveToInsertRow();
			rsTema.updateInt("id_cronograma", id_cronograma);
			rsTema.updateInt("id_tema", id_tema);
				
			rsTema.insertRow();
			rsTema.moveToCurrentRow();
			
			asignado = true;
			// Closing connection thread, very important!
			connectionP.closeConnection(con);

		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return asignado;
			
	}

	
	public ArrayList<Tbl_tema> listarTemasTutor(int id_tutor) {
		
		ArrayList<Tbl_tema> listaTemas = new ArrayList<Tbl_tema>();
		
		try {
			
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from public.tbl_tema WHERE tutor = ? AND estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_tutor);
			
			rsTema = ps.executeQuery();
			
			while ( rsTema.next() ) {
				
				Tbl_tema tbtema = new Tbl_tema();
				
				tbtema.setId(rsTema.getInt("id"));
				tbtema.setTema(rsTema.getString("tema"));
				
				listaTemas.add(tbtema);
				
			}
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);

		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return listaTemas;	
		
	}
	
	//retorna los nombres y apellidos de los estudiantes y sus carne
	public String obtenerNombreTema(int id_tema)
	{
		
		String nombre = "";
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT tema from tbl_tema  where id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_tema);
			rsTema = ps.executeQuery();
			
			if(rsTema.next())
			{
				nombre = rsTema.getString("tema");
				
				
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerEstudiantes() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return nombre;
	}
	

}
