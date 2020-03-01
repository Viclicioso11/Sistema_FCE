package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Tbl_usuario;
import datos.DT_rol;
import datos.DT_usuario;
import negocios.NG_usuario;

/**
 * Servlet implementation class SL_usuario
 */
@WebServlet("/SL_usuario")
public class SL_usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see 
     */
    public SL_usuario()  {
        super();
    }

	/**
	 * @see
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//VARIABLE DE CONTROL
		String opc = request.getParameter("opc");
		int opcion = 0;
		
		opc = opc==null?"0":opc;
		opcion = Integer.parseInt(opc);
		
		// RECUPERAMOS EL ID DEL USUARIO A ELIMINAR
		String idEliminar = request.getParameter("userID");
		int idUser = 0;
		
		idEliminar = idEliminar==null?"0":idEliminar;
		idUser = Integer.parseInt(idEliminar);
		
		Tbl_usuario tus = new Tbl_usuario();
		DT_usuario dtus = new DT_usuario();
		switch(opcion)
		{
			case 1:
				//inicio del case 1
				try	{
					// eliminar usuario
					tus.setId(idUser);	
					if(dtus.eliminarUser(tus))	{
						response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=4");
						return;
					} else	{
						response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=5");
						return;
					}
					
				} catch(Exception e)	{
					e.printStackTrace();
					System.out.println("Servlet: Error eliminarUser()");
				}
				
				break;
			
			default:
				response.sendRedirect("../seguridad/tblusuarios.jsp?msj=ERROR");
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
		
		Tbl_usuario tus = new Tbl_usuario();	
		DT_usuario dtus = new DT_usuario();
		DT_rol dtrol = new DT_rol();
		//DT_estudiante_candidato dtsc = new DT_estudiante_candidato();
		NG_usuario ngu = new NG_usuario();
		
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
					int id_rol = Integer.parseInt(request.getParameter("rol"));
					int id_usuario = 0;
					
					//guardar usuario
					int guardado = ngu.ngGuardarUser(tus);
					
					// si se guardar el usuario le 
					//sera asignado un rol por default
					if(guardado == 1) {
						id_usuario = dtus.obtenerIDUser(tus.getCarne());
						
						if(dtrol.asignarRolUsuario(id_usuario, id_rol)) {
							response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=1");
							return;
						}
						
					} else {
						response.sendRedirect("./pages/seguridad/newUser.jsp?msj=" + guardado);
						return;
					}
					
				} catch(Exception e)	{
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
					
					if(dtus.modificarUser(tus))	{
						response.sendRedirect("./pages/seguridad/tblusuarios.jsp?msj=3");
						return;
					} else	{
						response.sendRedirect("./pages/seguridad/editUser.jsp?msj=2");
						return;
					}
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al editar el Usuario!!!");
				}
				
				break;
			}
			case 3:
			{

				
			}
			case 4:
			{
				
				
				try
				{
					tus.setNombres(request.getParameter("nombres"));
					tus.setApellidos(request.getParameter("apellidos"));
					tus.setCarne(request.getParameter("carne"));
					tus.setCorreo(request.getParameter("correo"));
					tus.setContrasena(request.getParameter("contrasenia"));
					int id_rol = Integer.parseInt(request.getParameter("id_rol"));

					//Validamos que el correo que puso el usuario existe en la tabla de correos posibles					
					
					int guardado = ngu.ngGuardarEstudiante(tus, id_rol);
					if (guardado == 1) {
						if(id_rol == 1) {
							response.sendRedirect("./pages/inscripcion/tblEstudianteCandidato.jsp?msj=5");
							return;
						}else {
							response.sendRedirect("sistema.jsp?msj=2");
							return;
						}
					}else {
						response.sendRedirect("./pages/inscripcion/newStudent.jsp?msj=" + guardado);
						return;
					}	
						
						
				} catch(Exception e)	{
					e.printStackTrace();
					System.out.println("Servlet: Error al intentar autenticar el Usuario.");
				}
				break;
				
			}
			
			
			default:
				response.sendRedirect("index.jsp?msj=ERROR");
				return;
		}
		
	}

}
