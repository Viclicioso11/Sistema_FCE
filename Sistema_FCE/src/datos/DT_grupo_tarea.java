package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import entidades.Tbl_detalle_grupo_tarea;
import entidades.Tbl_tarea;
import entidades.Tbl_tema;
import entidades.Vw_tema_tarea;

public class DT_grupo_tarea {
	
	 // Getting ConnectionPolling instance
		ConnectionPooling connectionP = ConnectionPooling.getInstance();
		private ResultSet rsTarea;
		
		
		
		public boolean guardarTareaGrupal(Tbl_tarea tarea) {
			
			boolean guardado = false;
			

			try
			{
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();

				
				PreparedStatement ps = con.prepareStatement("SELECT * from tbl_tarea ", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				
				rsTarea = ps.executeQuery();
				
				
				rsTarea.moveToInsertRow();
				
				java.sql.Date sqlInicio = new java.sql.Date(tarea.getFecha_inicio().getTime());
				java.sql.Date sqlFin = new java.sql.Date(tarea.getFecha_fin().getTime());
				
				rsTarea.updateString("titulo", tarea.getTitulo());
				rsTarea.updateInt("estado", 1);
				rsTarea.updateInt("id_actividad_cronograma", tarea.getId_actividad_cronograma());
				if(tarea.getDescripcion() != "" ) {
					rsTarea.updateString("descripcion", tarea.getDescripcion());
				}
				rsTarea.updateDate("fecha_inicio", sqlInicio);
				rsTarea.updateDate("fecha_fin", sqlFin);
				rsTarea.insertRow();
				rsTarea.moveToCurrentRow();
				
				guardado = true;
				
				
				// Closing connection thread, very important!
				connectionP.closeConnection(con);
					
			}
			catch (Exception e) 
			{
				System.err.println("ERROR guardarTareaGrupal(): "+e.getMessage());
				e.printStackTrace();
				guardado = false;
			}
			
			return guardado;
			
		}
		
		//para asignar tarea a todos los grupos seleccionados
		public boolean asignarTareaGrupo(String[] ids_grupos, int id_tarea) {
			
			boolean guardados = false;
			Tbl_detalle_grupo_tarea tbdeg = new Tbl_detalle_grupo_tarea(); 
			
			try
			{
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();

				
				PreparedStatement ps = con.prepareStatement("SELECT * from tbl_detalle_grupo_tarea ", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				
				rsTarea = ps.executeQuery();
				
				
				for(int i = 0; i < ids_grupos.length; i++) {
					
					rsTarea.moveToInsertRow();
					
					rsTarea.updateInt("id_tema",Integer.parseInt(ids_grupos[i]));
					rsTarea.updateInt("id_tarea", id_tarea);
					rsTarea.updateInt("estado", 0);
					rsTarea.insertRow();
					rsTarea.moveToCurrentRow();
					
				}
				
				guardados = true;
				
				
				// Closing connection thread, very important!
				connectionP.closeConnection(con);
					
			}
			catch (Exception e) 
			{
				System.err.println("ERROR AsignarTareaGrupo(): "+e.getMessage());
				e.printStackTrace();
				guardados = false;
			}
			
					
			
			return guardados;
			
		}
		
		//para asignar tarea a un solo grupo
		public boolean asignarTareaGrupoIndividual(String id_grupo, int id_tarea) {
			
			boolean guardados = false;
			Tbl_detalle_grupo_tarea tbdeg = new Tbl_detalle_grupo_tarea(); 
			
			try
			{
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();

				
				PreparedStatement ps = con.prepareStatement("SELECT * from tbl_detalle_grupo_tarea ", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				
				rsTarea = ps.executeQuery();
				
				
					rsTarea.moveToInsertRow();
					
					rsTarea.updateInt("id_tema",Integer.parseInt(id_grupo));
					rsTarea.updateInt("id_tarea", id_tarea);
					rsTarea.updateInt("estado",0);
					rsTarea.insertRow();
					rsTarea.moveToCurrentRow();
				
				guardados = true;
				
				
				// Closing connection thread, very important!
				connectionP.closeConnection(con);
					
			}
			catch (Exception e) 
			{
				System.err.println("ERROR asignarTareaGrupoIndividual(): "+e.getMessage());
				e.printStackTrace();
				guardados = false;
			}
			
					
			
			return guardados;
			
		}
		
		public int obtenerIdTarea(Tbl_tarea tarea) {
			
			int id_tarea = 0;
			
			java.sql.Date sqlInicio = new java.sql.Date(tarea.getFecha_inicio().getTime());
			java.sql.Date sqlFin = new java.sql.Date(tarea.getFecha_fin().getTime());
			
			try
			{
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();
				
				PreparedStatement ps = con.prepareStatement("SELECT id from tbl_tarea where titulo = ? and fecha_inicio = ? and fecha_fin = ? and id_actividad_cronograma = ?", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setString(1, tarea.getTitulo());
				ps.setDate(2, sqlInicio);
				ps.setDate(3, sqlFin);
				ps.setInt(4, tarea.getId_actividad_cronograma());
				
				rsTarea = ps.executeQuery();
				
				while(rsTarea.next())	{
					id_tarea = rsTarea.getInt("id");
					
				}
				// Closing connection thread, very important!
				connectionP.closeConnection(con);
			}
			catch (Exception e)
			{
				System.out.println("DATOS: ERROR en obtenerIdTarea() "+ e.getMessage());
				e.printStackTrace();
			}
			
			return id_tarea;
				
		}
	
		
		public ArrayList<Vw_tema_tarea> listarTareasGrupo(int id_tema) {
			
			ArrayList<Vw_tema_tarea> listaTareasAsignadas = new ArrayList<Vw_tema_tarea>();
			
			try {
				
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();

				PreparedStatement ps = con.prepareStatement("SELECT * from public.Vw_tema_tarea WHERE tema_id = ?", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setInt(1, id_tema);
				
				rsTarea = ps.executeQuery();
				
				while ( rsTarea.next() ) {
					
					Vw_tema_tarea vttar = new Vw_tema_tarea();
					
					vttar.setId(rsTarea.getInt("id"));
					vttar.setEstado(rsTarea.getInt("estado"));
					vttar.setTarea_id(rsTarea.getInt("tarea_id"));
					vttar.setTitulo_tarea(rsTarea.getString("titulo"));
					vttar.setDescripcion_tarea(rsTarea.getString("descripcion"));
					vttar.setTema_id(rsTarea.getInt("tema_id"));
					vttar.setNombre_tema(rsTarea.getString("tema"));
					vttar.setFecha_inicio(rsTarea.getDate("fecha_inicio"));
					vttar.setFecha_fin(rsTarea.getDate("fecha_fin"));
					
					listaTareasAsignadas.add(vttar);
					
				}
				
				// Closing connection thread, very important!
				connectionP.closeConnection(con);

			} catch(Exception e) {
				System.out.println(e.getMessage());
			}
			
			return listaTareasAsignadas;	
			
		}
		
		//cada vez que se entregue una tarea o el tutor cambie los estados de la tarea
		public boolean cambiarEstadoTarea(String id_tarea, String id_tema, String estado) {
			
			boolean cambiado = false;
			
			try {
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();
				

				PreparedStatement ps = con.prepareStatement("SELECT * FROM public.tbl_detalle_grupo_tarea WHERE id_tema = ? AND id_tarea = ?", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setInt(1, Integer.parseInt(id_tema));
				ps.setInt(2, Integer.parseInt(id_tarea));
				
				rsTarea = ps.executeQuery();
				
				rsTarea.beforeFirst();
				if(rsTarea.next()) {
					
						rsTarea.updateInt("estado", Integer.parseInt(estado));
						
						rsTarea.updateRow();
						cambiado = true;

				}
				connectionP.closeConnection(con);
				
			} catch (Exception e) {
				System.err.println("ERROR cambiarEstadoTarea "+e.getMessage());
				e.printStackTrace();
			}
			
			
			return cambiado;
			
		}
		
		
		public double calcularPorcentajeAvanceFCE(int id_tema) {
			
			double porcentaje = 0.0;
			
			int totalTareas = 0;
			int entregadas = 0;
			
			try {
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();
				

				PreparedStatement ps = con.prepareStatement("SELECT estado FROM public.tbl_detalle_grupo_tarea WHERE id_tema = ?", 
						ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
						ResultSet.HOLD_CURSORS_OVER_COMMIT);
				ps.setInt(1, id_tema);
				
				rsTarea = ps.executeQuery();
				
				rsTarea.beforeFirst();
				while(rsTarea.next()) {
					
				totalTareas++;
				if(rsTarea.getInt("estado") == 1) {
					
					entregadas++;
				}
						
				}
				connectionP.closeConnection(con);
				
				if(totalTareas != 0) {
				
				porcentaje = (entregadas * 100) / totalTareas;	
				
				}
				
				
			} catch (Exception e) {
				System.err.println("ERROR cambiarEstadoTarea "+e.getMessage());
				e.printStackTrace();
			}
			
			
			
			return porcentaje;
		}
		
		
		
			//eliminamos la relacion de una tarea con un grupo
				public boolean eliminarTareaGrupo(String id_tarea, String id_tema) {
					
					boolean eliminado = false;
					
					try {
						//Getting connection thread, important!
						Connection con = connectionP.getConnection();
						

						PreparedStatement ps = con.prepareStatement("SELECT * FROM public.tbl_detalle_grupo_tarea WHERE id_tema = ? AND id_tarea = ?", 
								ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
								ResultSet.HOLD_CURSORS_OVER_COMMIT);
						ps.setInt(1, Integer.parseInt(id_tema));
						ps.setInt(2, Integer.parseInt(id_tarea));
						
						rsTarea = ps.executeQuery();
						
						rsTarea.beforeFirst();
						if(rsTarea.next()) {
							
								rsTarea.deleteRow();
								
								eliminado = true;

						}
						connectionP.closeConnection(con);
						
					} catch (Exception e) {
						System.err.println("ERROR cambiarEstadoTarea "+e.getMessage());
						e.printStackTrace();
					}
					
					
					return eliminado;
					
				}
				
			//todos los datos utilizados en el editar tarea
			public Tbl_tarea obtenerInfoTarea(int id_tarea) {
					
				Tbl_tarea tarea = new Tbl_tarea();
				
					
				try
				{
						//Getting connection thread, important!
					Connection con = connectionP.getConnection();
						
					PreparedStatement ps = con.prepareStatement("SELECT * from tbl_tarea WHERE id = ?", 
							ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
							ResultSet.HOLD_CURSORS_OVER_COMMIT);
					ps.setInt(1, id_tarea);
					
					rsTarea = ps.executeQuery();
						
					if(rsTarea.next())	{
						tarea.setTitulo(rsTarea.getString("titulo"));
						tarea.setDescripcion(rsTarea.getString("descripcion"));
						tarea.setFecha_inicio(rsTarea.getDate("fecha_inicio"));
						tarea.setFecha_fin(rsTarea.getDate("fecha_fin"));
						tarea.setId_actividad_cronograma(rsTarea.getInt("id_actividad_cronograma"));
							
					}
						// Closing connection thread, very important!
					connectionP.closeConnection(con);
				}
				catch (Exception e)
				{
					System.out.println("DATOS: ERROR en obtenerInfoTarea() "+ e.getMessage());
					e.printStackTrace();
				}
					
				return tarea;
						
				}
			
			
			public boolean editarTarea(Tbl_tarea tarea) {
				
				boolean editado = false;
				

				try
				{
					//Getting connection thread, important!
					Connection con = connectionP.getConnection();

					
					PreparedStatement ps = con.prepareStatement("SELECT * from tbl_tarea  WHERE id = ?", 
							ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
							ResultSet.HOLD_CURSORS_OVER_COMMIT);
					
					ps.setInt(1, tarea.getId());
					
					rsTarea = ps.executeQuery();
					
					
					if(rsTarea.next()) {
						
						java.sql.Date sqlInicio = new java.sql.Date(tarea.getFecha_inicio().getTime());
						java.sql.Date sqlFin = new java.sql.Date(tarea.getFecha_fin().getTime());
						
						rsTarea.updateString("titulo", tarea.getTitulo());
						rsTarea.updateInt("estado", 1);
						rsTarea.updateInt("id_actividad_cronograma", tarea.getId_actividad_cronograma());
						if(tarea.getDescripcion() != "" ) {
							rsTarea.updateString("descripcion", tarea.getDescripcion());
						}
						rsTarea.updateDate("fecha_inicio", sqlInicio);
						rsTarea.updateDate("fecha_fin", sqlFin);
						rsTarea.updateRow();
						
						editado = true;
					}
					
					// Closing connection thread, very important!
					connectionP.closeConnection(con);
						
				}
				catch (Exception e) 
				{
					System.err.println("ERROR editarTarea(): "+e.getMessage());
					e.printStackTrace();
				}
				
				return editado;
				
			}

}
