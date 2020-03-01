package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import entidades.Tbl_rol_opcion;
import datos.DT_rol_opcion;

/**
 * Servlet implementation class SL_rol_opcion
 */
@WebServlet("/SL_rol_opcion")
public class SL_rol_opcion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_rol_opcion() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//RECUPERAMOS EL ID DEL USUARIO Y EL ROL A ELIMINAR
		DT_rol_opcion dtrop= new DT_rol_opcion();
		
		String id_opcion = request.getParameter("id_opcion");
		String id_rol = request.getParameter("id_rol");
		

		if(id_opcion != null && id_rol != null) {
			
			try	{
				
				int id_opcion_enviar = Integer.parseInt(id_opcion);
				int id_rol_enviar = Integer.parseInt(id_rol);
				
				if(dtrop.eliminarRolOpcion(id_opcion_enviar, id_rol_enviar)) {
					response.sendRedirect("./pages/seguridad/tblrol_opcion.jsp?msj=4");
					return;
				}else {
					response.sendRedirect("./pages/seguridad/tblrol_opcion.jsp?msj=5");
					return;
				}
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("Servlet: Error eliminarRolOpcion()");
			}
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Tbl_rol_opcion trop = new Tbl_rol_opcion();	
		DT_rol_opcion dtrop = new DT_rol_opcion();

		try {
			
			trop.setId_opcion(Integer.parseInt(request.getParameter("id_opcion")));
			trop.setId_rol(Integer.parseInt(request.getParameter("id_rol")));
			
			if(dtrop.existeRolOpcion(trop.getId_opcion(), trop.getId_rol())) {
				response.sendRedirect("./pages/seguridad/tblrol_opcion.jsp?msj=2");
				return;
				
			}else {
				
				if(dtrop.guardarRolOpcion(trop.getId_rol(), trop.getId_opcion()))	{
					response.sendRedirect("./pages/seguridad/tblrol_opcion.jsp?msj=1");
					return;
				} else	{
					response.sendRedirect("./pages/seguridad/tblrol_opcion.jsp?msj=2");
					return;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("Servlet: Error al guardar la opción del rol!");
		}
		
	}

}
