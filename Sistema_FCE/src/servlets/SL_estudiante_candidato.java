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
		DT_correo correoDriver = new DT_correo();
		String mensaje = "probando";
		String internetAddresses = "kenned.mena@est.uca.edu.ni";
		correoDriver.enviarCorreo(mensaje, internetAddresses);
		*/
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

		
		//recorriendo los correos obtenidos del form
		for (int i = 0; i < correos.length; i++) { 
			
			String correo = correos[i].toString(); // pasando el correo acutal a una variable
			System.out.println(correo);
			if(correoDriver.enviarCorreo(mensaje, correo)) {//enviar metodo
				
			}else {
				response.sendRedirect("./pages/seguridad/newEstudianteCandidato.jsp?msj=2");
			}
		}
			
		for (int i = 0; i < correos.length; i++) {
			Tbl_estudiante_candidato tblec = new Tbl_estudiante_candidato();
			tblec.setCorreo(correos[i]);
			dtec.guardarEstudianteCandidato(tblec);
		}
	
		response.sendRedirect("./pages/seguridad/newEstudianteCandidato.jsp?msj=1");
		
	}

}