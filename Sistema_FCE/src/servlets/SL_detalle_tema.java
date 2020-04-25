package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_carrera;
import datos.DT_cierre;
import datos.DT_tema;
import datos.DT_usuario;
import datos.DT_vw_tema;
import datos.DT_vw_tema_estudiante;
import entidades.Tbl_tema;
import entidades.Tbl_usuario;
import entidades.Vw_tema;
import entidades.Vw_tema_estudiante;

/**
 * Servlet implementation class SL_detalle_tema
 */
@WebServlet("/SL_detalle_tema")
public class SL_detalle_tema extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_detalle_tema() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
  //vamos a retornar la info a imprimir en pantalla como json
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id_tema_texto = request.getParameter("id_tema");
		int id_tema = 0;

		if (id_tema_texto != null){
			id_tema = Integer.parseInt(id_tema_texto);
		}

		if(id_tema != 0){
			
			this.cartaInfo(response, id_tema);
			
			
				
			
		}else {
			response.getWriter().append("{\"existe\": false}");
		}
		
		
	}
	
private void cartaInfo(HttpServletResponse response, int idTema) throws IOException {
		
		//request.getContextPath();
		DT_tema Ttema = new DT_tema();
		DT_vw_tema dwtema = new DT_vw_tema();
		DT_usuario Tusuario = new DT_usuario();
		Tbl_tema tema = new Tbl_tema();
		Vw_tema vtem = new Vw_tema();
		Tbl_usuario usuario = new Tbl_usuario();
		DT_vw_tema_estudiante dtEstudiante = new DT_vw_tema_estudiante();
		ArrayList<Vw_tema_estudiante> Estudiantes = new ArrayList<Vw_tema_estudiante>();
		DT_cierre cierre = new DT_cierre();
		
		
		
		//obteniendo datos
		vtem = dwtema.obtenerTema(idTema);
		tema = Ttema.obtenerTema(idTema);
		
		usuario  = Tusuario.obtenerNombreTutor(cierre.getCartaTutor(idTema));//obteniendo tutor
		Estudiantes = dtEstudiante.listarTemas_estudiante(idTema);//obteniendo estudiantes de un tema
		String fecha = setFecha(tema.getFecha());
		String carrera_nombre = vtem.getCarrera();
		String ambito = vtem.getAmbito();
		String tipo_fce = vtem.getTipo_fce();
		
		response.getWriter().append(this.cartaInfoJSON(tema, usuario, Estudiantes, carrera_nombre, ambito, tipo_fce, fecha));
	}
	
	private String cartaInfoJSON(Tbl_tema tema, Tbl_usuario usuario, ArrayList<Vw_tema_estudiante> Estudiantes, 
	String carrera_nombre, String ambito, String tipo, String fecha) {
		
		String json = "";
		
		json = "{\"existe\": true,";
		json += "\"titulo\": \"" + tema.getTema() + "\",";
		json += "\"tutor\": \"" + usuario.getNombres() + " " + usuario.getApellidos() + "\" ,";
		json += "\"carrera\": \"" + carrera_nombre + "\", ";
		json += "\"ambito\": \"" + ambito + "\", ";
		json += "\"tipo\": \"" + tipo + "\", ";
		json += "\"fecha\": \"" + fecha + "\", ";
		json += "\"estudiantes\": [";
		
		
		for(int i =0; i < Estudiantes.size(); i++) {
			Vw_tema_estudiante estudiante = Estudiantes.get(i);
			
			if(i == (Estudiantes.size() -1)) {
				json += "\"" + estudiante.getNombres() + " " + estudiante.getApellidos()  + "\"";
			}else {
				json += "\"" + estudiante.getNombres() + " " + estudiante.getApellidos()  + "\",";
			}
		}
		
		json += "]}";
		
		return json;
	}
	
	  String setFecha(String fecha) {
	    	
	    	String[] arregloFecha = fecha.split("/");
	    	String mes = "";
	    	//para poner la fecha
			String[] arregloMeses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
	    	int numMes = Integer.parseInt(arregloFecha[1]);
	    	mes = arregloMeses[numMes - 1];
	    	
	    	String fechaTexto = arregloFecha[2] + " de " + mes + " del "+ arregloFecha[0];
	    	
	    	return fechaTexto;
	    	
	    	
	    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
