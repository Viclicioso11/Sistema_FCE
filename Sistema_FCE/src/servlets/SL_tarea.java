package servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_ambito;
import datos.DT_grupo_tarea;
import entidades.Tbl_ambito;
import entidades.Tbl_tarea;

/**
 * Servlet implementation class SL_tarea
 */
@WebServlet("/SL_tarea")
public class SL_tarea extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_tarea() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		DT_grupo_tarea dtgrut = new DT_grupo_tarea();
		
		String opc = request.getParameter("opc");
		int opcion = 0;
		
		if(opc != null) {
			opcion = Integer.parseInt(opc);
		}
		
		
		switch(opcion) {
		
		case 1 : 
			
			String estadoTexto = request.getParameter("estado");
			String idTemaTexto = request.getParameter("tema");
			String idTareaTexto = request.getParameter("tarea");
			
			if(dtgrut.cambiarEstadoTarea(idTareaTexto, idTemaTexto, estadoTexto)) {
				
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("1");  
				
			} else {
				
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("2");  
			}
			

			break;
			
		case 2: 
			
			String idTema = request.getParameter("tema");
			String idTarea = request.getParameter("tarea");
			
			if(dtgrut.eliminarTareaGrupo(idTarea, idTema)) {

				response.sendRedirect("./pages/acompanamiento/tbltareas_grupo.jsp?msj=4&id_tem="+idTema);
				
			} else {
				
				response.sendRedirect("./pages/acompanamiento/tbltareas_grupo.jsp?msj=5&id_tem="+idTema);
			}
			
			
			break;
		
		
		default: 
			
			response.sendRedirect("./pages/acompanamiento/tblgrupos_fce");
			
			break;
		
		
		
		}
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DT_grupo_tarea dtgrut = new DT_grupo_tarea();
		Tbl_tarea tbtar = new Tbl_tarea();
		
		//para cambiar el formato de la fecha
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String opc = request.getParameter("opc");
		int opcion = 0;

		tbtar.setTitulo(request.getParameter("tituloTarea"));
		tbtar.setId_actividad_cronograma(Integer.parseInt(request.getParameter("id_actividad")));
		tbtar.setDescripcion(request.getParameter("descripcionTarea"));
		
		String idsTemasTexto = request.getParameter("id_grupos");
		String[] arregloIdTemas = {};
		if(idsTemasTexto != null) {
			arregloIdTemas = idsTemasTexto.split(",");
		}
		
		//este es para cuando sea un solo grupo, caso individual
		String idTemaTexto = request.getParameter("id_grupo");
		
		try {
			
			String fechasTexto = request.getParameter("dateRange");
			String[] fechas = fechasTexto.split("-");
			
			tbtar.setFecha_inicio(formatter.parse(fechas[0]));
			tbtar.setFecha_fin(formatter.parse(fechas[1]));
			
		}catch (Exception e) {
			System.out.println("Error parseando fecha");
		}
		
		
		
		if(opc != null) {
			opcion = Integer.parseInt(opc);
		}
		
		
		switch(opcion) {
		//giardamos tareas grupales
		case 1: 
			
			if(dtgrut.guardarTareaGrupal(tbtar)) {
				
				int id_tarea = dtgrut.obtenerIdTarea(tbtar);
				
				
				if(dtgrut.asignarTareaGrupo(arregloIdTemas, id_tarea)) {
					
					response.sendRedirect("./pages/acompanamiento/newtarea_grupal.jsp?msj=1");
				} else {
					
					response.sendRedirect("./pages/acompanamiento/newtarea_grupal.jsp?msj=2");
				}
				
			} else {
				
				response.sendRedirect("./pages/acompanamiento/newtarea_grupal.jsp?msj=2");
				
			}
			
			
			break;
				//guardamos individualmente
		case 2 :
			
			if(dtgrut.guardarTareaGrupal(tbtar)) {
				
				int id_tarea = dtgrut.obtenerIdTarea(tbtar);
				
				if(dtgrut.asignarTareaGrupoIndividual(idTemaTexto, id_tarea)) {
					
					response.sendRedirect("./pages/acompanamiento/newtarea.jsp?msj=1");
				} else {
					
					response.sendRedirect("./pages/acompanamiento/newtarea.jsp?msj=2");
				}
				
				
			} else {
				
				response.sendRedirect("./pages/acompanamiento/newtarea.jsp?msj=2");
				
			}
			
			
			break;
			
			//editamos las actividades individualmente
		case 3 :
			
			
			String id_tarea_texto = request.getParameter("id_tarea");
			int id_tarea = 0;
			if(id_tarea_texto != null) {
				id_tarea = Integer.parseInt(id_tarea_texto);
			}
			//para luego redirigir a la pantalla de todas las tareas de un grupo
			String id_tema_texto = request.getParameter("id_tema");
			int id_tema = 0;
			if(id_tema_texto != null) {
				id_tema = Integer.parseInt(id_tema_texto);
			}
			
			
			tbtar.setId(id_tarea);
			
			if(dtgrut.editarTarea(tbtar)) {
				
				response.sendRedirect("./pages/acompanamiento/tbltareas_grupo.jsp?msj=3"+"&id_tem="+id_tema);
				
			} else {
				
				response.sendRedirect("./pages/acompanamiento/editTarea.jsp?msj=2&id_tarea="+id_tarea+"&id_tem="+id_tema);
				
			}
			
			
		default :
		
		
		}
	}

}
