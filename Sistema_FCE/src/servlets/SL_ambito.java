package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_ambito;
import entidades.Tbl_ambito;

/**
 * Servlet implementation class SL_usuario
 */
@WebServlet("/SL_ambito")
public class SL_ambito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_ambito() {
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
		
		DT_ambito dtopc = new DT_ambito();
		int id = Integer.parseInt(request.getParameter("id_ambito"));
		
		switch(opcion) {
			case 1:
				try {
					
					boolean eliminar = dtopc.eliminarAmbito(id);
					
					if(eliminar) {
						response.sendRedirect("./pages/mantenimiento/tblambito.jsp?msj=4");
						return;
					}
					if(!eliminar) {
						response.sendRedirect("./pages/mantenimiento/tblambito.jsp?msj=5");
						return;
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al Eliminar el ambito!!!");
				}
		}
		
	}

	/**
	 * @see 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String opc = request.getParameter("opc");
		int opcion = 0;

		opc = opc==null? "0":opc;
		opcion = Integer.parseInt(opc);
		
		Tbl_ambito topc = new Tbl_ambito();
		DT_ambito dtopc = new DT_ambito();
		
		switch(opcion) {
			case 1:
				try
				{
					topc.setAmbito(request.getParameter("ambito"));
					topc.setDescripcion(request.getParameter("descripcion"));
					boolean guardado = dtopc.guardarAmbito(topc);
					
					if(guardado) {
						response.sendRedirect("./pages/mantenimiento/tblambito.jsp?msj=1");
						return;
					}
					
					if(!guardado) {
						response.sendRedirect("./pages/mantenimiento/tblambito.jsp?msj=2");
						return;
					}
					
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar el ambito!!!");
				}
				
				break;
				
			case 2:
				topc.setId(Integer.parseInt(request.getParameter("IdAmbito")));
				topc.setAmbito(request.getParameter("ambito"));
				topc.setDescripcion(request.getParameter("descripcion"));
				
				boolean editado = dtopc.editarAmbito(topc); 
				if(editado)	{
					response.sendRedirect("./pages/mantenimiento/tblambito.jsp?msj=3");
					return;
				}
				
				if(!editado) {
					response.sendRedirect("./pages/mantenimiento/editAmbito.jsp?msj=2");
					return;
				}
				break;
					
			default:
				response.sendRedirect("../mantenimiento/tblambito.jsp?msj=ERROR");
				return;
		}
		
	}

}