package servlets;

//utils
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.http.Part;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//capa de entidades y datos
import entidades.Tbl_tema;
import entidades.Tbl_usuario;
import entidades.Tbl_usuario_tema;
import datos.DT_tema;
import datos.DT_usuario;
import datos.DT_usuario_tema;

/**
 * Servlet implementation class SL_tema
 */
@WebServlet("/SL_tema")
@MultipartConfig(location="C:\\glassfish5\\glassfish\\domains\\domain1\\applications\\Sistema_FCE\\archivo_tema")
public class SL_tema extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_tema() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    private String nombreArchivo = "";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//De prueba
	    String filtro = request.getParameter("filtro");
		
		DT_usuario dtus = new DT_usuario();
		DT_usuario_tema dtem = new DT_usuario_tema();
		Tbl_usuario tus = new Tbl_usuario();
		
		//devolvemos el nombre del usuario si existe
		tus = dtus.obtenerNombreEstudiante(filtro);
		
		if(tus.getId() == 0) {
			
			response.setContentType("text/plain"); 
		    response.setCharacterEncoding("UTF-8"); 
		    response.getWriter().write("2");  
		    
		}else {
			
			if(dtem.validarUsuarioTema(tus.getId())) {
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("2");   
			}
			else {
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(""+ tus.getNombres() + " " + tus.getApellidos());  
			}
			
		}
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	//public static String dirUploadFiles;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Tbl_tema tema = new Tbl_tema();
		
		DT_tema dtema = new DT_tema();
		DT_usuario dtus = new DT_usuario();
		
		ArrayList<Tbl_usuario_tema> usuariosTema = new ArrayList<Tbl_usuario_tema>();
	
		String palabrasClaves = request.getParameter("palabrasClave");
		String nombreTema = request.getParameter("tema");
		
		tema.setTema(request.getParameter("tema"));
		tema.setId_ambito(Integer.parseInt(request.getParameter("ambito_fce")));
		tema.setId_carrera(Integer.parseInt(request.getParameter("carrera")));
		tema.setId_tipo_fce(Integer.parseInt(request.getParameter("tipo_fce")));
		tema.setPalabras_claves(palabrasClaves);
		
		String[] carnes = (request.getParameter("carne")).split(",");
		String url = "";
		
		if(processRequest(request, response)) {
			
			//guardamos en el objeto la url del archivo
			
			url = "C:\\glassfish5\\glassfish\\domains\\domain1\\applications\\Sistema_FCE\\archivo_tema"+nombreArchivo;
			tema.setUrl(url);
			//guardamos el tema
			if(dtema.guardarTema(tema)) {
				
				//obtenemos el id del tema, para guardar en la tabla tema usuario
				int idTema = dtema.obtenerIdTema(nombreTema);
				
				//si guardamos el temaCronograma
				if( dtema.asignarTemaCronograma(idTema) ) {
					
					//guardamos en un arraylist el id del usuario (segun el carne) y el id tema
					for(int i  = 0; i < carnes.length; i++) {
						
						int idUser = dtus.obtenerIDUser(carnes[i]);
						//seteamos en el objeto el id del usuario, al obtenerlo de la funcion al que le mandamos el carne
						Tbl_usuario_tema tust = new Tbl_usuario_tema();
						tust.setId_usuario(idUser);
						tust.setId_tema(idTema);
						usuariosTema.add(tust);
					}
					
					if(dtema.guardarUsuariosTema(usuariosTema)) {
						
						
						response.sendRedirect("sistema.jsp?msj=1");
						return;
					}else {
						response.sendRedirect("./pages/inscripcion/inscripcion_tema.jsp?msj=2");
						return;
					}
					
				}
				
			}else {				
				response.sendRedirect("./pages/inscripcion/inscripcion_tema.jsp?msj=2");
				return;
			}
		}
					
	}
	
	protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
		boolean guardado = false;
		try {
			
			response.setContentType("text/html;charset=UTF-8");
	        Collection<Part> parts = request.getParts();
	        for(Part part : parts) {
        		// se escribe el archivo pero con un nuevo nombre
        		// en este caso se manda a traer el nombre original
	        	String name = getFileName(part);
	        	
	        	if(name != "false") {
	        		part.write(name);
	        		guardado = true;
	        	}
	                
	        }
	        
		}catch(Exception e) {
			System.out.println(e);
		}
        
        return guardado;
    }
	
	public String getFileName(Part part) {
        String contentHeader = part.getHeader("content-disposition");
        String[] subHeaders = contentHeader.split(";");
         
        for(String current : subHeaders) {
            if(current.trim().startsWith("filename")) {
                int pos = current.indexOf('=');
                String fileName = current.substring(pos+1);
                System.out.println(fileName);
                nombreArchivo = fileName;
                return fileName.replace("\"", "");
            }
        }
        return "false";
    }

}
