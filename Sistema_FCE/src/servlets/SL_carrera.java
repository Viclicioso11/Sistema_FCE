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
	
	 public SL_carrera() 
	    {
	        super();
	        // TODO Auto-generated constructor stub
	    }

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			// TODO Auto-generated method stub
			//response.getWriter().append("Served at: ").append(request.getContextPath());
			
////////////////////VARIABLE DE CONTROL //////////////////////
			String opc = request.getParameter("opc");
			int opcion = 0;

			opc = opc==null?"0":opc;
			System.out.println("opc: "+opc);
			opcion = Integer.parseInt(opc);
			System.out.println("opcion: "+opcion);
			
			
			DT_carrera dtopc = new DT_carrera();
			int id = Integer.parseInt(request.getParameter("id_carrera"));
			
			switch(opcion) {
				case 1:
					try {
						
						if(dtopc.eliminarCarrera(id))
						{
							response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=4");
						}
						else
						{
							response.sendRedirect("./pages/seguridad/tblcarrera.jsp?msj=5");
						}
						
					}catch(Exception e) {
						e.printStackTrace();
						System.out.println("Servlet: Error al Eliminar la carrera!!!");
					}
			}
			
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			// TODO Auto-generated method stub
			//		doGet(request, response);
			
			String opc = request.getParameter("opc");
			int opcion = 0;

			opc = opc==null?"0":opc;
			System.out.println("opc: "+opc);
			opcion = Integer.parseInt(opc);
			System.out.println("opcion: "+opcion);
			
			Tbl_carrera topc = new Tbl_carrera();
			DT_carrera dtopc = new DT_carrera();
			
			switch(opcion)
			{
				case 1:
				{
					try
					{
						topc.setId_facultad(Integer.parseInt(request.getParameter("facultad")));
						topc.setNombre(request.getParameter("nombre"));
						
						
						if(dtopc.guardarCarrera(topc))
						{
							response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=1");
						}
						else
						{
							response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=2");
						}
					}
					catch(Exception e)
					{
						e.printStackTrace();
						System.out.println("Servlet: Error al guardar la carrera!!!");
					}
					break;
				}
				case 2:
				{
					topc.setId(Integer.parseInt(request.getParameter("IdCarrera")));
					topc.setId_facultad(Integer.parseInt(request.getParameter("facultad")));
					topc.setNombre(request.getParameter("nombre"));
							
					if(dtopc.modificarCarrera(topc))
					{
						response.sendRedirect("./pages/mantenimiento/tblcarrera.jsp?msj=3");
					}
					else
					{
						response.sendRedirect("./pages/mantenimiento/editCarrera.jsp?msj=2");
					}
					break;
								
				}
				default:
				{
					response.sendRedirect("../mantenimiento/tblcarrera.jsp?msj=ERROR");
				}
			}
			
			
			
			
			
		}

	
	
	
	
	
	

}
