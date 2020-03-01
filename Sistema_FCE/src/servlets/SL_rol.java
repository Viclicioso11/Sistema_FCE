package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidades.Tbl_rol;
import datos.DT_rol;

/**
 * Servlet implementation class SL_rol
 */
@WebServlet("/SL_rol")
public class SL_rol extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_rol() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String opc = request.getParameter("opc");
		int opcion = 0;
	
		opc = opc==null?"0":opc;
		opcion = Integer.parseInt(opc);
		
		//RECUPERAMOS EL ID DEL USUARIO A ELIMINAR
		String idEliminar = request.getParameter("rolID");
		int idRol = 0;
		
		idEliminar = idEliminar==null?"0":idEliminar;
		idRol = Integer.parseInt(idEliminar);
		
		Tbl_rol trol = new Tbl_rol();
		DT_rol dtrol = new DT_rol();
		
		switch(opcion)
		{
			case 1:
			{
				try
				{
					trol.setId(idRol);
					
					if(dtrol.eliminarRol(trol))	{
						response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=4");
						return;
					} else	{
						response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=5");
						return;
					}
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error eliminarRol()");
				}
				break;
			}
			case 2:
			{
				break;
			}
			
			default:
			{
				response.sendRedirect("../seguridad/tblroles.jsp?msj=ERROR");
				return;
			}
	
	
		}

	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String opc = request.getParameter("opc");
		int opcion = 0;
		
		opc = opc==null?"0":opc;
		opcion = Integer.parseInt(opc);
		
		Tbl_rol trol = new Tbl_rol();
		DT_rol dtrol = new DT_rol();
		
		switch(opcion)
		{
			case 1:
			{
				
				trol.setRol(request.getParameter("rol"));
				trol.setDescripcion(request.getParameter("descripcion"));
				
				boolean guardado = dtrol.guardarRol(trol);
				
				if(guardado) {
					response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=1");
					return;
				}
				
				if(!guardado)	{
					response.sendRedirect("./pages/seguridad/newRol.jsp?msj=2");
					return;
				}
				break;
			}
			
			case 2:
			{
				trol.setId(Integer.parseInt(request.getParameter("IdRol")));
				trol.setRol(request.getParameter("rol"));
				trol.setDescripcion(request.getParameter("descripcion"));
				
				boolean editado = dtrol.modificarRol(trol);
				
				if(editado)	{
					response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=3");
					return;
				}
				
				if(!editado) {
					response.sendRedirect("./pages/seguridad/editRol.jsp?msj=2");
				}
				break;	
			}
			
			default:
			{
				response.sendRedirect("../seguridad/tblroles.jsp?msj=ERROR");
				return;
			}
		
		}
		
		
	}

}
