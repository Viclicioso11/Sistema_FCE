package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import entidades.Tbl_usuario;
import datos.DT_usuario;
import datos.DT_usuario_tema;

/**
 * Servlet implementation class SL_tema
 */
@WebServlet("/SL_tema")
public class SL_tema extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_tema() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//De prueba
	    String filtro = request.getParameter("filtro");
		System.out.println("nada mas "+filtro);
		
		DT_usuario dtus = new DT_usuario();
		DT_usuario_tema dtem = new DT_usuario_tema();
		Tbl_usuario tus = new Tbl_usuario();
		
		//devolvemos el nombre del usuario si existe
		tus = dtus.obtenerNombreEstudiante(filtro);
		
		if(tus.getId() == 0) {
			
			response.setContentType("text/plain"); 
		    response.setCharacterEncoding("UTF-8"); 
		    response.getWriter().write("Usuario no válido");  
		    
		}else {
			
			if(dtem.validarUsuarioTema(tus.getId())) {
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("Usuario no válido");   
			}
			else {
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write(""+ tus.getNombres() + " " + tus.getApellidos());  
			}
			
		}
		
	
		
		
		//Esto es para la respuesta al ajax
		
		
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	
		//Para el file del archivo a subir
		//Part archivo = request.getPart("fl_propuesta_fce");
		
		
		
	}

}
