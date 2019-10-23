package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_opcion;
import entidades.Tbl_opcion;

/**
 * Servlet implementation class SL_usuario
 */
@WebServlet("/SL_opcion")
public class SL_opcion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_opcion() 
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
		String opc = request.getParameter("opc");
		int opcion = 0;

		opc = opc==null?"0":opc;
		System.out.println("opc: "+opc);
		opcion = Integer.parseInt(opc);
		System.out.println("opcion: "+opcion);
		
		DT_opcion dtopc = new DT_opcion();
		int id = Integer.parseInt(request.getParameter("id"));
		
		switch(opcion) {
			case 1:
				try {
					
					if(dtopc.eliminarOpcion(id))
					{
						response.sendRedirect("./pages/seguridad/tblopciones.jsp?msj=4");
					}
					else
					{
						response.sendRedirect("./pages/seguridad/add_opcion.jsp?msj=5");
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al Eliminar la opcion!!!");
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
		
		Tbl_opcion topc = new Tbl_opcion();
		DT_opcion dtopc = new DT_opcion();
		
		switch(opcion)
		{
			case 1:
			{
				try
				{
					topc.setOpcion(request.getParameter("opcion"));
					topc.setDescripcion(request.getParameter("descripcion"));
					
					if(dtopc.guardarOpcion(topc))
					{
						response.sendRedirect("./pages/seguridad/tblopciones.jsp?msj=1");
					}
					else
					{
						response.sendRedirect("./pages/seguridad/tblopciones.jsp?msj=2");
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar la opcion!!!");
				}
				break;
			}
			case 2:
			{
				topc.setId(Integer.parseInt(request.getParameter("IdOpcion")));
				topc.setOpcion(request.getParameter("opcion"));
				topc.setDescripcion(request.getParameter("descripcion"));
						
				if(dtopc.editarOpcion(topc))
				{
					response.sendRedirect("./pages/seguridad/tblopciones.jsp?msj=3");
				}
				else
				{
					response.sendRedirect("./pages/seguridad/editopcion.jsp?msj=2");
				}
				break;
							
			}
			default:
			{
				response.sendRedirect("../seguridad/tblopciones.jsp?msj=ERROR");
			}
		}
		
		
		
		
		
	}

}
