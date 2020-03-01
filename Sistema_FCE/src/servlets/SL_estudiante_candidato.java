package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_correo;
import datos.DT_estudiante_candidato;
import entidades.Tbl_estudiante_candidato;

/**
 * Servlet implementation class SL_login
 */
@WebServlet("/SL_estudiante_candidato")
public class SL_estudiante_candidato extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	DT_estudiante_candidato dtec = new DT_estudiante_candidato();
	
	
	/**
	 *	msj = 1 ok cuando se agrega
	 *	msj = 2 error cuando se agrega
	 *	msj = 3 ok cuando se elimina
	 *	msj = 4 error cuando se elimina
	 */
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_estudiante_candidato() {
        super();
    }

	/**
	 * @Eliminar_Estudiante
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int id = Integer.parseInt(request.getParameter("id").toString());
		if(dtec.EliminarEstudiante(id)) {
			response.sendRedirect("./pages/inscripcion/tblEstudianteCandidato.jsp?msj=3");
			return;
		}else {
			response.sendRedirect("./pages/inscripcion/tblEstudianteCandidato.jsp?msj=4");
			return;
		}
	}

	/**
	 * @Agregar o eliminar
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String correosText = request.getParameter("values").toString();
		String mensaje = request.getParameter("mensaje");
		String[] correos = correosText.split(",");
		DT_correo correoDriver = new DT_correo();

		
		//recorriendo los correos obtenidos del form
		for (int i = 0; i < correos.length; i++) { 
			
			String correo = correos[i].toString(); // pasando el correo acutal a una variable
			
			if(correoDriver.enviarCorreo(mensaje, correo)) {//enviar metodo
				
				/**
				 * si se envio lo guardamos en 
				 * la base de datos
				 * */
				Tbl_estudiante_candidato tblec = new Tbl_estudiante_candidato();
				tblec.setCorreo(correos[i]);
				tblec.setMensaje(mensaje);
				dtec.guardarEstudianteCandidato(tblec);
				
			}
			else {
				response.sendRedirect("./pages/inscripcion/tblEstudianteCandidato.jsp?msj=2");
				return;
			}
		}
	
		response.sendRedirect("./pages/inscripcion/tblEstudianteCandidato.jsp?msj=1");
		return;
		
	}

}