package servlets;

//utils
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Collection;
import javax.servlet.http.Part;
import java.io.InputStream ;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// capa de entidades y datos
import entidades.Tbl_tema;
import entidades.Tbl_usuario;
//import entidades.Tbl_usuario_tema;
import datos.DT_tema;
import datos.DT_usuario;
import datos.DT_usuario_tema;

/**
 * Servlet implementation class SL_tema
 */
@WebServlet("/SL_edicion_tema")
@MultipartConfig()
public class SL_edicion_tema extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    /**
     * @see
     */
    public SL_edicion_tema() {
        super();
    }

	/**
	 * @see
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String opcion = request.getParameter("opc");
		int opc = Integer.parseInt(opcion);
	    String carne = request.getParameter("carne");
		
		DT_usuario dtus = new DT_usuario();
		DT_usuario_tema dtem = new DT_usuario_tema();
		Tbl_usuario tus = new Tbl_usuario();
		DT_tema dte = new DT_tema();
		
		switch(opc) {
		
		case 1:
			//Guardamos en la tabla el estudiante añadido
			
			int id_tema = Integer.parseInt(request.getParameter("tema"));
			int id_estudiante = dtus.obtenerIDUser(carne);
			
			if(id_estudiante == 0) {
				
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("2");  
			    
			}else {
				//validamos si el usuario pertenece a un tema ya
				if(dtem.validarUsuarioTema(id_estudiante)) {
					response.setContentType("text/plain"); 
				    response.setCharacterEncoding("UTF-8"); 
				    response.getWriter().write("2");   
				}
				else {
					dte.guardarEstudianteTema(id_tema, id_estudiante);
					response.setContentType("text/plain"); 
				    response.setCharacterEncoding("UTF-8");
				    response.getWriter().write(""+ tus.getNombres() + " " + tus.getApellidos());  
				}
				
			}
			
			break;
			
		case 2:
			//traemos de la peticion los valores del id del tema y el estudiante para eliminarlo
			int id_tem = Integer.parseInt(request.getParameter("tema"));
			
			int id_est = Integer.parseInt(request.getParameter("id"));
			if(dte.eliminarEstudiante(id_est, id_tem)) {
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("1"); 
			}else {
				response.setContentType("text/plain"); 
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write("2"); 
			}
			break;
		}
		
		
	 
	}

	/**
	 * @see 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Tbl_tema tema = new Tbl_tema();
		//Tbl_usuario_tema tust = new Tbl_usuario_tema();
		DT_tema dtema = new DT_tema();
		
		// construyendo objeto tema
		tema.setTema(request.getParameter("tema"));
		tema.setId(Integer.parseInt(request.getParameter("id_tema")));
		tema.setPalabras_claves(request.getParameter("palabrasClave"));
		tema.setId_ambito(Integer.parseInt(request.getParameter("ambito_fce")));
		tema.setId_carrera(Integer.parseInt(request.getParameter("carrera")));
		tema.setId_tipo_fce(Integer.parseInt(request.getParameter("tipo_fce")));
		
		String url = "";
		//creamos el objeto que tiene la ruta al directorio
		File uploads = new File("C:\\glassfish5\\glassfish\\domains\\domain1\\archivo_tema");
		//obtenemos nuestro part
		Part filePart = request.getPart("fl_propuesta_fce");
		String fileName = getFileName(filePart);
		
		if(fileName.equals("")) {
			if(dtema.modificarTema(tema, false)) {
				response.sendRedirect("./pages/acompanamiento/tbltema.jsp?msj=3");
				return;
			}else {
				response.sendRedirect("./pages/inscripcion/editInscripcion_fce.jsp?msj=2");
				return;
			}
		}else {
			 
			try {
				File f = new File(fileName);
				File file = new File(uploads, f.getName());
				
				InputStream input = filePart.getInputStream();
			    Files.copy(input, file.toPath());
			    
			  } catch (Exception e){
			        response.setContentType("text/html");
			        PrintWriter out = response.getWriter();
			        out.print("<body>Failed to upload file <br>" + e.getMessage());
			  }
			
			url = "C:\\glassfish5\\glassfish\\domains\\domain1\\archivo_tema"+fileName;
			tema.setUrl(url);
			
			if(dtema.modificarTema(tema, true)) {
				response.sendRedirect("./pages/acompanamiento/tbltema.jsp?msj=3");
				return;
			}else {
				response.sendRedirect("./pages/inscripcion/editInscripcion_fce.jsp?msj=2");
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
                //String nombreArchivo = fileName;
                return fileName.replace("\"", "");
            }
        }
        return "false";
    }

}
