package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Tbl_usuario_rol;
import datos.DT_estudiante_candidato;
import datos.DT_rol;
import datos.DT_usuario_rol;

/**
 * Servlet implementation class SL_usuario_rol
 */
@WebServlet("/SL_usuario_rol")
public class SL_usuario_rol extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_usuario_rol() 
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
		
		///////// RECUPERAMOS EL ID DEL USUARIO Y EL ROL A ELIMINAR //////////
		DT_usuario_rol dtur = new DT_usuario_rol();
		String id_usuario = request.getParameter("id_usuario");
		String id_rol = request.getParameter("id_rol");
		

		if(id_usuario != null && id_rol != null) {
			try
			{
				
				int id_usuario_enviar = Integer.parseInt(id_usuario);
				int id_rol_enviar = Integer.parseInt(id_rol);
				
				if(dtur.eliminarUsuarioRol(id_usuario_enviar, id_rol_enviar))
				{
					response.sendRedirect("./pages/seguridad/tbluser_rol.jsp?msj=4");
				}
				else
				{
					response.sendRedirect("./pages/seguridad/tbluser_rol.jsp?msj=5");
				}
			}
			catch(Exception e)
			{
			e.printStackTrace();
			System.out.println("Servlet: Error eliminarUserRol()");
			}
		}

		
	}	
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
	

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		//		doGet(request, response);
		

		
		Tbl_usuario_rol tur = new Tbl_usuario_rol();	
		DT_usuario_rol dtur = new DT_usuario_rol();

				try
				{
					
					tur.setId_user(Integer.parseInt(request.getParameter("id_usuario")));
					tur.setId_rol(Integer.parseInt(request.getParameter("id_rol")));
					
					if(dtur.existeUsuarioRol(tur.getId_user(), tur.getId_rol())) {
						response.sendRedirect("./pages/seguridad/tbluser_rol.jsp?msj=2");
					}else {
						if(dtur.guardarUsuariorRol(tur.getId_rol(), tur.getId_user()))
						{
							response.sendRedirect("./pages/seguridad/tbluser_rol.jsp?msj=1");
						}
						else
						{
							response.sendRedirect("./pages/seguridad/tbluser_rol.jsp?msj=2");
						}
					}
					
				}
				catch(Exception e)
				{
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar el Rol de usuario!!!");
				}
		
	}

}