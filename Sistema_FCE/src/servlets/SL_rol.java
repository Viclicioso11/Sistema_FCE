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
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		//Obtenemos la variable de control opc
		
				String opc = request.getParameter("opc");
				int opcion = 0;

				opc = opc==null?"0":opc;
				System.out.println("opc: "+opc);
				opcion = Integer.parseInt(opc);
				System.out.println("opcion: "+opcion);
				
				
		///////// RECUPERAMOS EL ID DEL USUARIO A ELIMINAR //////////
				String idEliminar = request.getParameter("rolID");
				int idRol = 0;
				
				idEliminar = idEliminar==null?"0":idEliminar;
				System.out.println("idEliminar: "+idEliminar);
				idRol = Integer.parseInt(idEliminar);
				System.out.println("idRol: "+idRol);
				
				Tbl_rol trol = new Tbl_rol();
				DT_rol dtrol = new DT_rol();
				
				switch(opcion)
				{
					case 1:
					{
						try
						{
							trol.setId(idRol);
							
							if(dtrol.eliminarRol(trol))
							{
								response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=4");
							}
							else
							{
								response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=5");
							}
						}
						catch(Exception e)
						{
							e.printStackTrace();
							System.out.println("Servlet: Error eliminarRol()");
						}
						break;
					}
					case 2:
					{
						//SIN CODIGO AUN
						break;
					}
					
					default:
					{
						response.sendRedirect("../seguridad/tblroles.jsp?msj=ERROR");
					}
		
		
				}

	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String opc = request.getParameter("opc");
		int opcion = 0;
		
		
		opc = opc==null?"0":opc;
		System.out.println("opc: "+opc);
		opcion = Integer.parseInt(opc);
		System.out.println("opcion: "+opcion);
		
		Tbl_rol trol = new Tbl_rol();
		DT_rol dtrol = new DT_rol();
		
		switch(opcion)
		{
			case 1:
			{
				
				trol.setRol(request.getParameter("rol"));
				trol.setDescripcion(request.getParameter("descripcion"));
				
				if(dtrol.guardarRol(trol))
				{
					response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=1");
				}
				else
				{
					response.sendRedirect("./pages/seguridad/newRol.jsp?msj=2");
				}
				
					
				break;
			}
			
			case 2:
			{
				trol.setId(Integer.parseInt(request.getParameter("IdRol")));
				trol.setRol(request.getParameter("rol"));
				trol.setDescripcion(request.getParameter("descripcion"));
				
				if(dtrol.modificarRol(trol))
				{
					response.sendRedirect("./pages/seguridad/tblroles.jsp?msj=3");
				}
				else
				{
					response.sendRedirect("./pages/seguridad/editRol.jsp?msj=2");
				}
				break;
					
			}
			
			default:
			{
				response.sendRedirect("../seguridad/tblroles.jsp?msj=ERROR");
			}
		
		}
		
		
	}

}
