package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import datos.DT_actividad_pg;
import entidades.Tbl_actividad_pg;

/**
 * Servlet implementation class SL_actividad_pg
 */
@WebServlet("/SL_actividad_pg")
public class SL_actividad_pg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_actividad_pg() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @solo para eliminar alguna actividad
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idActividad = 0;
		int idPg = 0;
		
		if(request.getParameter("id") != null && request.getParameter("idPg") != null) {
			idActividad = Integer.parseInt(request.getParameter("id"));
			idPg = Integer.parseInt(request.getParameter("idPg"));
		}else {
			response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG=");
			return;
		}
		
		
		if (idActividad == 0 || idPg == 0) {
			response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG=" + idPg);
			return;
		}
		
		DT_actividad_pg Dtapg = new DT_actividad_pg();
		
		if(Dtapg.eliminarActividad(idActividad)) {
			response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG=" + idPg + "&msj=5");
			return;
		}else {
			response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG=" + idPg + "&msj=6");
			return;
		}

		/*
		 5 eliminado
		 6 error eliminar 
		 */
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/**
		 * opc 1 = guardar
		 * opc 2 = actualizar
		 */
		DT_actividad_pg Dta = new DT_actividad_pg();
		Tbl_actividad_pg Tbla = new Tbl_actividad_pg();
		String opcS = request.getParameter("opc");
		int opc = 0;
		// convertiremos el string a int (opc)
		if(opcS != null) {
			opc = Integer.parseInt(opcS);
		}
		
		
		try {
			Tbla.setId_plan_graduacion(Integer.parseInt(request.getParameter("idP")));
			Tbla.setNombre(request.getParameter("titulo"));
			Tbla.setDescripcion(request.getParameter("descripcion"));
			String[] fecha = request.getParameter("dateRange").split("-");
			Tbla.setFecha_inicio(new SimpleDateFormat("dd/MM/yyyy").parse(fecha[0]));
			Tbla.setFecha_fin(new SimpleDateFormat("dd/MM/yyyy").parse(fecha[1]));
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		switch(opc) {
			case 1:
				boolean guardado = Dta.guardarActividadPG(Tbla, Tbla.getId_plan_graduacion());
				
				if(guardado) {
					response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG="+ Tbla.getId_plan_graduacion() + "&msj=1");
					return;
				}
				
				if(!guardado) {
					response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG="+ Tbla.getId_plan_graduacion() + "&msj=3");
					return;
				}
				
				break;
			case 2:
				
				Tbla.setId(Integer.parseInt(request.getParameter("idactividad")));
				boolean editado = Dta.editarActividad(Tbla); 
				
				if(editado) {
					response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG="+ Tbla.getId_plan_graduacion() + "&msj=2");
					return;
				}
				
				if(!editado) {
					response.sendRedirect("./pages/inscripcion/addActivityPG2.jsp?idPG="+ Tbla.getId_plan_graduacion() + "&msj=4");
					return;
				}
				break;
			default:
				break;
		}
		
		/**
		 * mensajes 
		 * 1: exito guardar
		 * 2: exito editar
		 * 3: error guardar
		 * 4: error editar 
		 */
		
	}
	
	@SuppressWarnings("unused")
	private void GuardarActividades(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//obtener todos las actividades de un plan G
		DT_actividad_pg DTa = new DT_actividad_pg();
		ArrayList<Tbl_actividad_pg> actividades = new ArrayList<Tbl_actividad_pg>();
		JSONArray actividadesJson = new JSONArray(request.getParameter("eventos"));
		actividades = DTa.parsearJson(actividadesJson);
		
		String idPlan = request.getParameter("id");
		int idP = Integer.parseInt(idPlan);
		
		if(DTa.guardarActividades(actividades, idP)) {
			response.sendRedirect("./pages/inscripcion/tblplan_graduacion.jsp?msj=2");
			return;
		}
	}

}
