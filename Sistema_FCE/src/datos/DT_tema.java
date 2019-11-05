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
	
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection c = PoolConexion.getConnection();
	private ResultSet rsTema;
	Calendar cal = Calendar.getInstance();
	
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
			this.getResulset();
			rsTema.moveToInsertRow();
			rsTema.updateString("tema", tem.getTema());
			rsTema.updateString("fecha", fechaHoy);
			rsTema.updateString("palabras_claves", tem.getPalabras_claves());
			rsTema.updateInt("id_ambito", tem.getId_ambito());
			rsTema.updateInt("id_carrera",tem.getId_carrera());
			rsTema.updateInt("id_tipo_fce", tem.getId_tipo_fce());
			rsTema.insertRow();
			rsTema.moveToCurrentRow();
			guardado = true;
			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR guardarTema(): "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	
	public int obtenerIdTema(String tema) {
		int id_tema = 0;
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT id from tbl_tema where tema = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, tema);
			rsTema = ps.executeQuery();
			if(rsTema.next())
			{
				id_tema = rsTema.getInt("id");
				
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerIDUser() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return id_tema;
	}
	
	
	
	
	public void getResulset() {
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tema", 
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
			
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_usuario_tema ", 
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
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_tema where id = ?", 
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
				
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerTema() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return tem;
	}
	
	//retorna los nombres y apellidos de los estudiantes y sus carne
	public ArrayList<Tbl_usuario> obtenerEstudiante(int id_tema)
	{
		Tbl_usuario tus  = new Tbl_usuario();
		 ArrayList<Tbl_usuario> estudiantes = new  ArrayList<Tbl_usuario>();
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT nombres, apellidos, usuario_id from vw_tema  where tema_id = ?", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, id_tema);
			rsTema = ps.executeQuery();
			
			while(rsTema.next())
			{
				
				tus.setId(rsTema.getInt("usuario_id"));
				tus.setNombres(rsTema.getString("nombres"));
				tus.setApellidos(rsTema.getString("apellidos"));
				estudiantes.add(tus);
				
			}
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en obtenerEstudiantes() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return estudiantes;
	}
	
	//Vamos a editar los valores de la FCE que el usuario desee
	public boolean modificarTema(Tbl_tema tem)
	{
		//para obtener el valor de la fecha del sistema
				String dia = Integer.toString(cal.get(Calendar.DATE));
				String mes = Integer.toString(cal.get(Calendar.MONTH));
				String anio = Integer.toString(cal.get(Calendar.YEAR));
				String fechaHoy = ""+anio+"/"+mes+"/"+dia;
				
		boolean modificado=false;	
		try
		{

			this.getResulset();;
			rsTema.beforeFirst();
			while (rsTema.next())
			{
				if(rsTema.getInt(1) == tem.getId())
				{
					rsTema.moveToInsertRow();
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
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificaTEma() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	
	//Este metodo elimina una fila de la tabla tema_usurio cuando se es eliminado a un estudiante de un tema de fce

	public boolean eliminarEstudiante(int id_usuario)
	{
		boolean eliminado=false;
		
		try
		{
			PreparedStatement ps = c.prepareStatement("SELECT * from tbl_usuario_tema", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsTema = ps.executeQuery();
			
			
			rsTema.beforeFirst();
			while (rsTema.next())
			{
				if(rsTema.getInt("id_usuario") == id_usuario)
				{
						rsTema.deleteRow();
						eliminado=true;
						break;
				}
					
				}
			}
		catch(Exception e)
		{
			System.err.println("ERROR eliminaEstudiante() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	

}
