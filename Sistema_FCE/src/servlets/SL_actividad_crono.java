package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_cronograma;
import entidades.Tbl_actividad_cronograma;;

/**
 * Servlet implementation class SL_actividad_crono
 */
@WebServlet("/SL_actividad_crono")
public class SL_actividad_crono extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_actividad_crono() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//eliminar las actividades del cronograma seleccionadas
		DT_cronograma dtcro = new DT_cronograma();

		String strIdCrono = request.getParameter("id_actividad_crono");
		int idCrono = 0;
		if(strIdCrono != null) {
			idCrono = Integer.parseInt(strIdCrono);
		}
		
		//para que cada vez que se cargue la pagina tenga el id del cronograma seleccionado
		String cronograma = (request.getParameter("id_cronograma"));
		
		int id_cronograma = 0;
		if(cronograma != null) {
			id_cronograma = Integer.parseInt(cronograma);
		}
		
				//si guarda mandamos un 1 para verificar si guardo o no
				if(dtcro.eliminarActividadCronograma(idCrono)) {
					
					response.sendRedirect("./pages/inscripcion/addActivityCronograma.jsp?cronogramaID="+id_cronograma+"&msj=5");
					
				}
				else {
					response.sendRedirect("./pages/inscripcion/addActivityCronograma.jsp?cronogramaID="+id_cronograma+"&msj=6");
				}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//vamos a guardar o editar las actividades del cronograma seleccionadas
				String opcion = request.getParameter("opc");
				
				int opc = Integer.parseInt(opcion);
				
				if(opcion != null) {
					 opc  = Integer.parseInt(opcion);
				}
				
				Tbl_actividad_cronograma tac = new Tbl_actividad_cronograma();
				
				DT_cronograma dtcro = new DT_cronograma();

				String[] fecha = request.getParameter("dateRange").split("-");
				
				String cronograma = (request.getParameter("idCrono"));
				
				int id_cronograma = 0;
				if(cronograma != null) {
					id_cronograma = Integer.parseInt(cronograma);
				}
				
				switch (opc) {

				
				//el guardar va en caso 1 
				case 1 :

				try {
					tac.setFecha_inicio(new SimpleDateFormat("dd/MM/yyyy").parse(fecha[0]));
					tac.setFecha_fin(new SimpleDateFormat("dd/MM/yyyy").parse(fecha[1]));
					
					System.out.print("esta es la fecha inicio: " +tac.getFecha_inicio().toString());
					tac.setDescripcion(request.getParameter("descripcion"));
					tac.setNombre(request.getParameter("nombre"));
					//parseamos la fecha que venia en string
					
					
					if(dtcro.guardarActividadCrono(tac, id_cronograma)) {
					
						response.sendRedirect("./pages/inscripcion/addActivityCronograma.jsp?cronogramaID="+id_cronograma+"&msj=1");
						
					}
					else {
						response.sendRedirect("./pages/inscripcion/tblcronograma.jsp?msj=3");
					}
					
					
				} catch (ParseException e) {
					System.out.println("DATOS: ERROR en parsearFechas "+ e.getMessage());
					e.printStackTrace();
				}
				break;
				
				
				//Aqui se editan las actividades
				case 2: 
					
					try {
						tac.setId(Integer.parseInt(request.getParameter("idactividad"))); 
						
						
						tac.setFecha_inicio(new SimpleDateFormat("dd/MM/yyyy").parse(fecha[0]));
						tac.setFecha_fin(new SimpleDateFormat("dd/MM/yyyy").parse(fecha[1]));
						
						tac.setDescripcion(request.getParameter("descripcion"));
						tac.setNombre(request.getParameter("nombre"));
						
						if(dtcro.editarActividadCrono(tac)) {
						
							response.sendRedirect("./pages/inscripcion/addActivityCronograma.jsp?cronogramaID="+id_cronograma+"&msj=2");
							
						}else{
							response.sendRedirect("./pages/inscripcion/addActivityCronograma.jsp?cronogramaID="+id_cronograma+"&msj=4");
						}
							
					} catch (ParseException e) {
						System.out.println("DATOS: ERROR en parsearFechas "+ e.getMessage());
						e.printStackTrace();
					}
					break;
					
					
				
				}
		
	}

}
