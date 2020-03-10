package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_cronograma;
import entidades.Tbl_cronograma;

/**
 * Servlet implementation class SL_cronograma
 */
@WebServlet("/SL_cronograma")
public class SL_cronograma extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * Servlet SL_cronograma
     */
    public SL_cronograma() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
			
	}

	/**
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		String strOpc = request.getParameter("opc");
		int opc = 0;
		
		if(strOpc != null) {
			opc = Integer.parseInt(strOpc);
		}
		
		Tbl_cronograma tcro = new Tbl_cronograma();
		
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		
		String strIdTipoCro = request.getParameter("id_tipo_cronograma");	
		int idTipoCronograma = 0;
		
		if( strIdTipoCro != null) {
			idTipoCronograma = Integer.parseInt(strIdTipoCro);
		}
		if(idTipoCronograma == 0) {
			idTipoCronograma = 1;
		}
		

		DT_cronograma dtcro = new DT_cronograma();
		
		switch(opc) {
		//guardamos
		case 1:
			
			
			try {
				tcro.setFecha_inicio(formatter.parse(request.getParameter("fecha_in")));
				
				tcro.setDescripcion(request.getParameter("descripcion"));

				tcro.setTipo_cronograma(idTipoCronograma);

				tcro.setFecha_fin(formatter.parse(request.getParameter("fecha_fin")));
				
				if(dtcro.guardarCronograma(tcro)) {
					
					response.sendRedirect("./pages/inscripcion/tblcronograma.jsp?msj=1");

					return;
					
				}else {
					response.sendRedirect("./pages/inscripcion/tblcronograma.jsp?msj=3");
					return;

					
				}
				
			} catch (ParseException e) {
				System.out.println("DATOS: ERROR en parsearFechas "+ e.getMessage());
				e.printStackTrace();
			}
			break;
			
			
		//editamos
		
		case 2: 
		

			try {
				tcro.setDescripcion(request.getParameter("descripcion"));

				tcro.setTipo_cronograma(idTipoCronograma);


				tcro.setId(Integer.parseInt(request.getParameter("idCrono")));
				tcro.setFecha_inicio(formatter.parse(request.getParameter("fecha_in")));
				tcro.setFecha_fin(formatter.parse(request.getParameter("fecha_fin")));
				
				if(dtcro.editarCronograma(tcro)) {
					response.sendRedirect("./pages/inscripcion/tblcronograma.jsp?msj=1");

					return;
				}
				else {
					response.sendRedirect("./pages/inscripcion/tblcronograma.jsp?msj=2");
					return;

				}
				
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		}
		
	
		

	}

}
	
