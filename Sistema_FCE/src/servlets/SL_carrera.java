package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_carrera;
import entidades.Tbl_carrera;

@WebServlet("/SL_carrera")
public class SL_carrera extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public SL_carrera() {
		super();
	}

	/**
	 * @see 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String opc = request.getParameter("opc");
		int opcion = 0;

		opc = opc==null?"0":opc;
		opcion = Integer.parseInt(opc);
		
		
		DT_carrera dtopc = new DT_carrera();
		int id = Integer.parseInt(request.getParameter("id_carrera"));
		
		switch(opcion) {
			case 1:
				//inicio del case 1
				try {
					boolean eliminado = dtopc.eliminarCarrera(id);
					if(eliminado) {
						response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=4");
						return;
					}
					
					if(!eliminado)	{
						response.sendRedirect("./pages/seguridad/tblcarrera.jsp?msj=5");
						return;
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al Eliminar la carrera!!!");
				}
				
			default:
				response.sendRedirect("./pages/seguridad/tblcarrera.jsp");
				return;
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String opc = request.getParameter("opc");
		int opcion = 0;

		opc = opc==null?"0":opc;
		opcion = Integer.parseInt(opc);
		
		Tbl_carrera topc = new Tbl_carrera();
		DT_carrera dtopc = new DT_carrera();
		
		switch(opcion)
		{
			case 1:
				//inicio del case 1
				try	{
					
					topc.setId_facultad(Integer.parseInt(request.getParameter("facultad")));
					topc.setNombre(request.getParameter("nombre"));
					
					boolean guardado = dtopc.guardarCarrera(topc);
					
					if(guardado) {
						response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=1");
						return;
					}
					if(!guardado) {
						response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=2");
						return;
					}
					
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar la carrera!!!");
				}
				break;
				
			case 2:
				//inicio del case 2
				topc.setId(Integer.parseInt(request.getParameter("IdCarrera")));
				topc.setId_facultad(Integer.parseInt(request.getParameter("facultad")));
				topc.setNombre(request.getParameter("nombre"));
						
				boolean editado = dtopc.modificarCarrera(topc);
				
				if(editado) {
					response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=3");
					return;
				}
				
				if(!editado) {
					response.sendRedirect("./pages/mantenimiento/editCarrera.jsp?msj=2");
					return;
				}
				
				break;
						
			default:
				response.sendRedirect("../mantenimiento/tblcarrera.jsp?msj=ERROR");
				return;
				
		}
	}

	
	
	
	
	
	

}
