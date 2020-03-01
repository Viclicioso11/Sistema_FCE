package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Tbl_facultad;
import datos.DT_facultad;

/**
 * Servlet implementation class SL_facultad
 */
@WebServlet("/SL_facultad")
public class SL_facultad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_facultad() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String opc = request.getParameter("opc");
		int opcion = 0;
		
		opc = opc==null?"0":opc;
		opcion = Integer.parseInt(opc);
		
		///////// RECUPERAMOS EL ID DEL USUARIO A ELIMINAR //////////
		String idEliminar = request.getParameter("facultadID");
		int idFacultad = 0;
		
		idEliminar = idEliminar==null?"0":idEliminar;
		idFacultad = Integer.parseInt(idEliminar);
		
		Tbl_facultad tfa = new Tbl_facultad();
		DT_facultad dtfa = new DT_facultad();
		
		switch(opcion)	{
		
			case 1:
				try	{
					
					tfa.setId(idFacultad);
					
					if(dtfa.eliminarFacultad(tfa))	{
						response.sendRedirect("./pages/mantenimiento/tblfacultades.jsp?msj=4");
						return;
					}else {
						response.sendRedirect("./pages/mantenimiento/tblfacultades.jsp?msj=5");
						return;
					}
					
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error eliminarFacultad()");
				}
				break;
			
			default:
				response.sendRedirect("../mantenimiento/tblfacultades.jsp?msj=ERROR");
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
		
		Tbl_facultad tfa = new Tbl_facultad();	
		DT_facultad dtfa = new DT_facultad();
		
		switch(opcion) {
			case 1:
				//inicio del case 1
				try	{
					
					tfa.setNombre(request.getParameter("nombre"));
					if(dtfa.guardarFacultad(tfa)) {
						response.sendRedirect("./pages/mantenimiento/tblfacultades.jsp?msj=1");
						return;
					} else	{
						response.sendRedirect("./pages/mantenimiento/newFacultad.jsp?msj=2");
						return;
					}
					
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al guardar el Facultad!!!");
				}
				
				break;
				
			case 2:
				//inicio del case 2
				try
				{
					tfa.setId(Integer.parseInt(request.getParameter("IdFacultad")));
					tfa.setNombre(request.getParameter("nombre"));
					
					if(dtfa.modificarFacultad(tfa))	{
						response.sendRedirect("./pages/mantenimiento/tblfacultades.jsp?msj=3");
						return;
					} else	{
						response.sendRedirect("./pages/mantenimiento/editFacultad.jsp?msj=2");
						return;
					}
					
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("Servlet: Error al editar el Facultad!!!");
				}
				break;
				
			case 3:
				/*
				try
				{
					tfa.setCarne(request.getParameter("carne"));
					tfa.setContrasena(request.getParameter("contrasena"));
					
					
					if(dtfa.validarUsuario(tfa.getCarne(), tfa.getContrasena()))
					{
						response.sendRedirect("./sistema.jsp?msj="+tfa.getCarne());
						return;
					}
					else
					{
						response.sendRedirect("./index.jsp?msj=2");
						return;
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
					System.out.println("Servlet: Error al intentar autenticar el Usuario.");
				}
				*/
				break;
				
			
			case 4:
				/*
				try 
				{ 
					//construimos el objeto
					tfa.setNombres(request.getParameter("nombres"));
					tfa.setApellidos(request.getParameter("apellidos"));
					tfa.setCarne(request.getParameter("carne"));
					tfa.setCorreo(request.getParameter("correo"));
					tfa.setContrasena(request.getParameter("contrasenia")); 
					int id_rol = Integer.parseInt(request.getParameter("id_rol")); 
					int id_facultad = 0;
					
					//Validamos que el correo que puso el facultad 
					//existe en la tabla de correos posibles 
					if(dtsc.validarEstudianteCandidato(tfa.getCorreo())) { 
						if(dtfa.guardarFacultad(tfa)) {
					
							//obtenemos el id del facultad guardado 
					 		id_facultad =	dtfa.obtenerIDFacultad(tfa.getCarne());
					 		//cambiamos el estado el correo que ya ha sido guardado 
							if(dtsc.CambiarEstadoEstudianteCandidato(tfa.getCorreo())){
							
								//asignamos el rol estudiante al facultad al guardar en la tabla facultad rol
								if(dtrol.asignarRolUsuario(id_facultad, id_rol)) {
									response.sendRedirect("./pages/seguridad/newStudent.jsp?msj=1");
									return; 
								}
					  
							}
					  
						}else { 
							response.sendRedirect("./pages/seguridad/newStudent.jsp?msj=2");
							return;
						}
					  
					} else { 
						response.sendRedirect("./pages/seguridad/newStudent.jsp?msj=2");
						return;
					} 
				} catch(Exception e) { 
					e.printStackTrace();
					System.out.println("Servlet: Error al intentar autenticar el Usuario."); 
				}
				 */
			 break;			
			
			default:
				response.sendRedirect("index.jsp?msj=ERROR");
				return;
				
		}
	}

}
