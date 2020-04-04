package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import datos.DT_rol;
import datos.DT_usuario;
import entidades.Tbl_usuario;
import entidades.Vw_rol_opcion;

/**
 * Servlet implementation class SL_login
 */
@WebServlet("/SL_login")
public class SL_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public SL_login() {
        super();
    }

	/**
	 * @Logout
	 * se utilizara para cerrar la sesion
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hts = request.getSession(true);
		hts.setAttribute("login",null);
		hts.setAttribute("id", null);
		hts.setAttribute("listOpciones", null);
		response.sendRedirect("index.jsp");
		return;
	}

	/**
	 * @Login
	 * creando login
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DT_usuario dtus = new DT_usuario();
		String login = "";
		String contrasena = "";
		int id_rol = 0;
		int id_usuario = 0;
		Tbl_usuario tus = new Tbl_usuario();
		
		//obtenemos la info para 
		//verificar si el usuario existe
		login = request.getParameter("login");
		contrasena = request.getParameter("contrasena");
		id_rol = Integer.parseInt(request.getParameter("id_rol"));
		
		try	
		{
			
			if(dtus.dtverificarLogin(login, contrasena, id_rol))	{
				
				id_usuario = dtus.obtenerIDUser(login);
				
				tus = dtus.obtenerNombreUsuario(login);
				
				HttpSession hts = null;
				// creando atributos del login
				hts = this.crearAtributos(request, login, id_rol, id_usuario, tus);
				// guardar opciones
				this.guardarOpciones(hts, id_rol);
				
				response.sendRedirect("sistema.jsp");
				return;
				
			} else	{
				response.sendRedirect("index.jsp?msj=2");
				return;
			}
			
		} catch(Exception e)	{
			System.out.println("Servlet: El error es: "+e.getMessage());
			e.printStackTrace();
		}
		
		
	}
	
	public HttpSession crearAtributos(HttpServletRequest request,String login, int id_rol, int id_usuario, Tbl_usuario usuario ) {
		//creando sesion si es necesaria 
		//o obtener session activa
		
		HttpSession hts = request.getSession(true);
		hts.setAttribute("login", login);
		hts.setAttribute("id", id_rol);
		hts.setAttribute("idUsuario", id_usuario );
		hts.setAttribute("nombre", usuario.getNombres());
		hts.setAttribute("apellido",usuario.getApellidos());
		
		return hts;
	}
	
	public void guardarOpciones(HttpSession hts, int id_rol) {
		//creando sesion si es necesaria 
		//o obtener session activa
		
		//creando objeto para las sesiones
		ArrayList<Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
		DT_rol dtr = new DT_rol();
		
		//agregando opciones a la sesion activa
   		listOpciones = dtr.listRolOpc(id_rol);
    	hts.setAttribute("listOpciones", listOpciones);
    	return;
	}

}
