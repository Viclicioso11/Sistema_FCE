package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import datos.DT_carrera;
import datos.DT_cierre;
import datos.DT_tema;
import datos.DT_usuario;
import datos.DT_vw_tema_estudiante;
import entidades.Tbl_cierre;
import entidades.Tbl_tema;
import entidades.Tbl_usuario;
import entidades.Vw_tema_estudiante;

/**
 * Servlet implementation class SL_cierre
 */
@WebServlet("/SL_cierre")
@MultipartConfig(location="C:\\glassfish5\\glassfish\\domains\\domain1\\archivo_tema")
public class SL_cierre extends HttpServlet {
	private static final long serialVersionUID = 1L;
    String nombreArchivo = "";
    String url = "C:\\glassfish5\\glassfish\\domains\\domain1\\archivo_tema";
    String[] tipoarchivos = {"docx", "doc", "odt", "zip", "rar"};
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_cierre() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String carta = request.getParameter("carta");

		if (carta == null){
			carta = "0";
		}

		if(carta != "0"){
			int idTema = Integer.parseInt(request.getParameter("idTema").toString());
			DT_tema Ttema = new DT_tema();
			
			if(Ttema.existeTema(idTema)) {
				this.cartaInfo(response, idTema);
			}else {
				response.getWriter().append("{\"existe\": false}");
			}
			
		}
	}
	
	private void cartaInfo(HttpServletResponse response, int idTema) throws IOException {
		
		//request.getContextPath();
		DT_tema Ttema = new DT_tema();
		DT_usuario Tusuario = new DT_usuario();
		Tbl_tema tema = new Tbl_tema();
		Tbl_usuario usuario = new Tbl_usuario();
		DT_vw_tema_estudiante dtEstudiante = new DT_vw_tema_estudiante();
		ArrayList<Vw_tema_estudiante> Estudiantes = new ArrayList<Vw_tema_estudiante>();
		DT_cierre cierre = new DT_cierre();
		DT_carrera carrera = new DT_carrera();
		
		//obteniendo datos
		tema = Ttema.obtenerTema(idTema);
		usuario  = Tusuario.obtenerNombreTutor(cierre.getCartaTutor(idTema));//obteniendo tutor
		Estudiantes = dtEstudiante.listarTemas_estudiante(idTema);//obteniendo estudiantes de un tema
		String carrera_nombre = carrera.obtenerCarrera(tema.getId_carrera()).getNombre();
		response.getWriter().append(this.cartaInfoJSON(tema, usuario, Estudiantes, carrera_nombre));
	}
	
	private String cartaInfoJSON(Tbl_tema tema, Tbl_usuario usuario, ArrayList<Vw_tema_estudiante> Estudiantes, String carrera_nombre ) {
		String json = "";
		
		json = "{\"existe\": true,";
		json += "\"titulo\": \"" + tema.getTema() + "\",";
		json += "\"tutor\": \"" + usuario.getNombres() + " " + usuario.getApellidos() + "\" ,";
		json += "\"carrera\": \"" + carrera_nombre + "\", ";
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.cerrarFCE(request, response);
	}
	
	
	private void cerrarFCE(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int idtema = Integer.parseInt(request.getParameter("idtema").toString());
		boolean verificadoArchivo = false;
		Tbl_cierre cierre = new Tbl_cierre();
		DT_tema dtTema = new DT_tema();
		DT_cierre dtCierre = new DT_cierre();
		
		try {
			if(!dtTema.existeTema(idtema)) {
				response.sendRedirect("./pages/acompanamiento/cierre_fce.jsp?msg=2&idtema=" + idtema);
				System.out.println("Se ha tratado de cerrar un tema que no existe");
				return;
			}
			
			
			verificadoArchivo = this.verificarArchivo(request, response);
			if(verificadoArchivo) {
				cierre.setIdTema(idtema);
				cierre.setDoc(this.url + "\\" + this.nombreArchivo);
			}
			
			if(!verificadoArchivo) {
				response.sendRedirect("./pages/acompanamiento/cierre_fce.jsp?msg=2&idtema=" + idtema);
				System.out.println("Se ha tratado de subir un archivo dañado o de diferente extension a la solicitada");
				return;
			}
			
			if(dtCierre.cerrarFCE(cierre)) {
				response.sendRedirect("./pages/acompanamiento/cierre_fce.jsp?msg=1&idtema=" + idtema);
				return;
			}else {
				response.sendRedirect("./pages/acompanamiento/cierre_fce.jsp?msg=2&idtema=" + idtema);
				return;
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		response.sendRedirect("./pages/acompanamiento/cierre_fce.jsp?msg=2&idtema=" + idtema);
		return;
		
	}
	
	private boolean verificarArchivo(HttpServletRequest request, HttpServletResponse response) {
		boolean verificado = false;
		int idtema = Integer.parseInt(request.getParameter("idtema").toString());
		
		try {
			response.setContentType("text/html;charset=UTF-8");
			Collection<Part> parts = request.getParts();
			
			for(Part part: parts) {
				String name = this.getFileName(part);
				
				if(name != "false" && this.archivoAdmitido(name)) {
					this.nombreArchivo = "archivofinal_tema" + idtema + "_" + name;
					part.write(this.nombreArchivo);
					verificado = true;
				} 
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return verificado;
	}
	
	private String getFileName(Part part) {
        String contentHeader = part.getHeader("content-disposition");
        String[] subHeaders = contentHeader.split(";");
         
        for(String current : subHeaders) {
            if(current.trim().startsWith("filename")) {
                int pos = current.indexOf('=');
                String fileName = current.substring(pos+1);
                System.out.println(fileName);
                return fileName.replace("\"", "");
            }
        }
        return "false";
    }
	
	private boolean archivoAdmitido(String name) {
		boolean admitido = false;
		
		name = name.toLowerCase();
		name = name.substring(name.indexOf(".") + 1);
		
		for(String tipoArchivo: this.tipoarchivos) {
			if (tipoArchivo.equals(name)) {
				admitido = true;
				break;
			}
		}
		return admitido;
	}

}
