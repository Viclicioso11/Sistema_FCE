package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Tbl_usuario;
import datos.DT_usuario;

/**
 * Servlet implementation class SL_usuario
 */
@WebServlet("/SL_usuario")
public class SL_usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_usuario() 
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
<<<<<<< HEAD
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		////////////////////VARIABLE DE CONTROL //////////////////////
		String opc = request.getParameter("opc");
		int opcion = 0;
		
		opc = opc==null?"0":opc;
		System.out.println("opc: "+opc);
		opcion = Integer.parseInt(opc);
		System.out.println("opcion: "+opcion);
		
		///////// RECUPERAMOS EL ID DEL USUARIO A ELIMINAR //////////
		String idEliminar = request.getParameter("userID");
		int idUser = 0;
		
		idEliminar = idEliminar==null?"0":idEliminar;
		System.out.println("idEliminar: "+idEliminar);
		idUser = Integer.parseInt(idEliminar);
		System.out.println("idUser: "+idUser);
		
		Tbl_usuario tus = new Tbl_usuario();
		DT_usuario dtus = new DT_usuario();
		switch(opcion)
		{
		case 1:
		{
			try
			{
				tus.setId(idUser);
				
				if(dtus.eliminarUser(tus))
				{
					response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=3");
		}
		else
		{
			response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=4");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Servlet: Error eliminarUser()");
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
			response.sendRedirect("../seguridad/tblusuarios.jsp?msj=ERROR");
		}
		}
=======
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
	
>>>>>>> 46d1921a4e1d22538118dc9ade0004ac784959ac
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
		
		Tbl_usuario tus = new Tbl_usuario();
		DT_usuario dtus = new DT_usuario();
		
		switch(opcion)
		{
			case 1:
			{
				try
				{
					tus.setCarne(request.getParameter("carne"));
					tus.setNombres(request.getParameter("nombres"));
					tus.setApellidos(request.getParameter("apellidos"));
					tus.setCorreo(request.getParameter("correo"));
					tus.setContrasena(request.getParameter("contrasenia"));
					
					
					
					if(dtus.guardarUser(tus))
					{
						response.sendRedirect("./pages/seguridad/newUser.jsp?msj=1");
					}
					else
					{
						response.sendRedirect("./pages/seguridad/newUser.jsp?msj=2");
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar el Usuario!!!");
				}
				break;
			}
			case 2:
			{
				try
				{
					tus.setId(Integer.parseInt(request.getParameter("IdUser")));
					tus.setCarne(request.getParameter("carne"));
					tus.setNombres(request.getParameter("nombres"));
					tus.setApellidos(request.getParameter("apellidos"));
					tus.setCorreo(request.getParameter("correo"));
					tus.setContrasena(request.getParameter("contrasenia"));
					
					if(dtus.modificarUser(tus))
					{
						response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=1");
					}
					else
					{
						response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=2");
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
					System.out.println("Servlet: Error al editar el Usuario!!!");
				}
				break;
			}
			case 3:
			{
				try
				{
					tus.setCarne(request.getParameter("carne"));
					tus.setContrasena(request.getParameter("contrasena"));
					
					
					if(dtus.validarUsuario(tus.getCarne(), tus.getContrasena()))
					{
						response.sendRedirect("./sistema.jsp?msj="+tus.getCarne());
					}
					else
					{
						response.sendRedirect("./index.jsp?msj=2");
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
					System.out.println("Servlet: Error al intentar autenticar el Usuario.");
				}
				break;
				
				
				
			}
			
			default:
			{
				response.sendRedirect("index.jsp?msj=ERROR");
			}
		}
		
		
		
		
		
	}

}
