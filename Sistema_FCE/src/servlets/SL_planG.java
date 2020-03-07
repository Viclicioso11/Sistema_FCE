package servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import datos.DT_plan_graduacion;
import entidades.Tbl_plan_graduacion;

/**
 * Servlet implementation class SL_planG
 */
@WebServlet("/SL_planG")
public class SL_planG extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_planG() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcS = request.getParameter("opc");
		int opc = 0;
		
		// convertiremos el string a int (opc)
		if(opcS != null) {
			opc = Integer.parseInt(opcS);
		}
		
		switch(opc) {
			case 1:
				this.postPlanG(request, response);
				break;
			case 2:
				this.editPlanG(request, response);
				break;
			default:
		}
				
	}
	
	/*
	 * @Guardar PlanG con sus actividades 
	 */
	private void postPlanG(HttpServletRequest request, HttpServletResponse response) {
		
		DT_plan_graduacion DTplan = new DT_plan_graduacion();
		Tbl_plan_graduacion Tblplan = new Tbl_plan_graduacion();
		
		
		try {
			Date inicioPg = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("Finicio"));
			Date finPg = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("Ffin"));
			String descripcion = request.getParameter("descripcion");
			String cohorte = request.getParameter("cohorte");
			
			Tblplan.setCohorte(cohorte);
			Tblplan.setFecha_inicio(inicioPg);
			Tblplan.setFecha_fin(finPg);
			Tblplan.setDescripcion(descripcion);
			
			
			if(DTplan.guardarPlanG(Tblplan)) {			
				response.sendRedirect("./pages/inscripcion/tblplan_graduacion.jsp?msj=1");
				return;
			}else{
				response.sendRedirect("./pages/inscripcion/tblplan_graduacion.jsp?msj=2");
				return;
			}
			
		}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Servlet: Error al guardar plan de graduacion");
			
		}
	}
	
	
	/**
	 * editar plan de graduacion
	 */
	private void editPlanG(HttpServletRequest request, HttpServletResponse response) {
		
		DT_plan_graduacion DTplan = new DT_plan_graduacion();
		Tbl_plan_graduacion Tblplan = new Tbl_plan_graduacion();
		
		
		try {
			Date inicioPg = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("Finicio"));
			Date finPg = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("Ffin"));
			String descripcion = request.getParameter("descripcion");
			String cohorte = request.getParameter("cohorte");
			int idpg = Integer.parseInt(request.getParameter("idpg"));
			
			Tblplan.setCohorte(cohorte);
			Tblplan.setFecha_inicio(inicioPg);
			Tblplan.setFecha_fin(finPg);
			Tblplan.setDescripcion(descripcion);
			Tblplan.setId(idpg);
			
			System.out.println(Tblplan.getCohorte());
			System.out.println(Tblplan.getFecha_fin());
			System.out.println(Tblplan.getFecha_inicio());
			System.out.println(Tblplan.getDescripcion());
			
			if(DTplan.editarPlanG(Tblplan)) {			
				response.sendRedirect("./pages/inscripcion/tblplan_graduacion.jsp?msj=3");
				return;
			}else{
				response.sendRedirect("./pages/inscripcion/tblplan_graduacion.jsp?msj=4");
				return;
			}
			
		}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Servlet: Error al guardar plan de graduacion");
			
		}
	}
}
