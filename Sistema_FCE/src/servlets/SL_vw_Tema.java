package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_tema;

/*
import entidades.Tbl_usuario;
import datos.DT_usuario;
import datos.DT_usuario_rol;
import datos.DT_usuario_tema;
import datos.DT_vw_rol_usuario;
import datos.DT_vw_tema;
import entidades.Vw_tema;
import entidades.Vw_usuario_rol;
*/
/**
 * Servlet implementation class SL_vw_Tema
 */
@WebServlet("/SL_vw_Tema")
public class SL_vw_Tema extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_vw_Tema() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub


		//Tbl_usuario tus = new Tbl_usuario();
		//DT_usuario dtus = new DT_usuario();
		DT_tema tema = new DT_tema();

		String tutorId = request.getParameter("tutorId");
		String temaId = request.getParameter("temaId");
		request.getHeader("");
		if(tutorId != null && temaId != null) {

			int tutorId_asignar = Integer.parseInt(tutorId);
			int temaId_asignar = Integer.parseInt(temaId); 

			if( tema.asignartutor(tutorId_asignar,temaId_asignar) ){

				//tus = dtus.obtenerNombreTutor(tutorId_asignar);
				response.getWriter().write("6");

			}else{
				response.getWriter().write("2");
			}

		}else {
			response.getWriter().write("2 sistema json jajaja");
		}
	}
		
		
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}