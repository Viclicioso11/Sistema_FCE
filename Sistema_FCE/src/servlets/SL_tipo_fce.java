package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_tipo_fce;
import entidades.Tbl_tipo_fce;

/**
 * Servlet implementation class SL_usuario
 */
@WebServlet("/SL_tipo_fce")
public class SL_tipo_fce extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see 
     */
    public SL_tipo_fce()  {
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
		
		DT_tipo_fce dtopc = new DT_tipo_fce();
		int id = Integer.parseInt(request.getParameter("id_tipo"));
		
		switch(opcion) {
			case 1:
				try {
					
					if(dtopc.eliminarTipoFce(id))	{
						response.sendRedirect("./pages/mantenimiento/tbl_tipo_fce.jsp?msj=4");
						return;
					} else {
						response.sendRedirect("./pages/mantenimiento/tbl_tipo_fce.jsp?msj=5");
						return;
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al Eliminar el tipo fce!!!");
				}
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
		
		Tbl_tipo_fce topc = new Tbl_tipo_fce();
		DT_tipo_fce dtopc = new DT_tipo_fce();
		
		switch(opcion)
		{
			case 1:
				try
				{
					topc.setTipo(request.getParameter("tipofce"));
					topc.setDescripcion(request.getParameter("descripcion"));
					
					if(dtopc.guardarTipoFce(topc))	{
						response.sendRedirect("./pages/mantenimiento/tbl_tipo_fce.jsp?msj=1");
						return;
					} else	{
						response.sendRedirect("./pages/mantenimiento/tbl_tipo_fce.jsp?msj=2");
						return;
					}
				} catch(Exception e)	{
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar el tipo fce!!!");
				}
				
				break;
			case 2:
				
				topc.setId(Integer.parseInt(request.getParameter("IdTipo")));
				topc.setTipo(request.getParameter("tipofce"));
				topc.setDescripcion(request.getParameter("descripcion"));
						
				boolean editado = dtopc.editarTipoFce(topc); 
				if(editado)	{
					response.sendRedirect("./pages/mantenimiento/tbl_tipo_fce.jsp?msj=3");
					return;
				}
				
				if(!editado) {
					response.sendRedirect("./pages/mantenimiento/editTipofce.jsp?msj=2");
					return;
				}
				break;
			
			default:
				response.sendRedirect("../mantenimiento/tblambito.jsp?msj=ERROR");
				return;
				
		}
		
		
		
		
		
	}

}