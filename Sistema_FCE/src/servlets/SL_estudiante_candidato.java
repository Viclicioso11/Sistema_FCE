package servlets;

import java.io.IOException;
import java.util.ArrayList;


import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_correo;
import datos.DT_estudiante_candidato;
import datos.DT_opcion;
import entidades.Tbl_estudiante_candidato;
import entidades.Tbl_opcion;

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
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	/*	// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		*/
		int id = Integer.parseInt(request.getParameter("id").toString());
		if(dtec.EliminarEstudiante(id)) {
			response.sendRedirect("./pages/seguridad/tblEstudianteCandidato.jsp?msj=3");
		}else {
			response.sendRedirect("./pages/seguridad/tblEstudianteCandidato.jsp?msj=4");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String correosText = request.getParameter("values").toString();
		String mensaje = request.getParameter("mensaje");
		
		System.out.println(correosText);
		System.out.println(mensaje);
		String[] correos = correosText.split(",");
		DT_correo correoDriver = new DT_correo();
		
		InternetAddress correosT[] = new InternetAddress[correos.length];
		
		try {
			for(int i=0; i< correos.length; i++) {
				String correo = correos[i].toString();
				correosT[i] = new InternetAddress(correo);
			}
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(correoDriver.enviarCorreo(mensaje, correosT)) {
			for (int i = 0; i < correos.length; i++) { 
				String correo = correos[i].toString();
				Tbl_estudiante_candidato tblec = new Tbl_estudiante_candidato();
				tblec.setCorreo(correos[i]);
				tblec.setMensaje(mensaje);
				dtec.guardarEstudianteCandidato(tblec);
			}
		}else {
			response.sendRedirect("./pages/seguridad/tblEstudianteCandidato.jsp?msj=2");
		}
		
		//recorriendo los correos obtenidos del form
		//for (int i = 0; i < correos.length; i++) { 
			
			//String correo = correos[i].toString(); // pasando el correo acutal a una variable
			//System.out.println(correo);
			
			//if(correoDriver.enviarCorreo(mensaje, correo)) {//enviar metodo
				
				/**
				 * si se envio lo guardamos en 
				 * la base de datos
				 * */
				//Tbl_estudiante_candidato tblec = new Tbl_estudiante_candidato();
				//tblec.setCorreo(correos[i]);
				//tblec.setMensaje(mensaje);
				//dtec.guardarEstudianteCandidato(tblec);
				
			//}
			//else {
				//response.sendRedirect("./pages/seguridad/tblEstudianteCandidato.jsp?msj=2");
			//}
		//}
	
		response.sendRedirect("./pages/seguridad/tblEstudianteCandidato.jsp?msj=1");
		
	}

}