package servlets;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
//utils
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
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
@MultipartConfig()
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
		//***
		Tbl_tema tema = new Tbl_tema();
		DT_tema dtema = new DT_tema();
		DT_usuario dtus = new DT_usuario();
		String id_ambito_texto = "";
		String id_tipo_texto = "";
		String id_carrera_texto = "";
		
		//para la subida de archivo
		String UPLOAD_DIRECTORY = "archivo_tema";
		String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
	    final Part filePart = request.getPart("fl_propuesta_fce");
	    String fileName = getFileName(filePart);//pbtiene el nombre real del part (archivo) a subir
	    
	    //si el método no devuelve un nombre y devuelve false
	    if(fileName == "false") {
	    	fileName = "archivoPropuesta";
	    }
	    //---	
		ArrayList<Tbl_usuario_tema> usuariosTema = new ArrayList<Tbl_usuario_tema>();
		
		//obteniendo todo lo de la petición
		String palabrasClaves = request.getParameter("palabrasClave");
		String nombreTema = request.getParameter("tema");
		
		tema.setTema(request.getParameter("tema"));
		
		id_ambito_texto = request.getParameter("ambito_fce");
		id_tipo_texto = request.getParameter("tipo_fce");
		id_carrera_texto = request.getParameter("carrera");
		
		
		
		if(id_ambito_texto != null && id_tipo_texto != null && id_carrera_texto != null) {	
			tema.setId_ambito(Integer.parseInt(id_ambito_texto));
			tema.setId_carrera(Integer.parseInt(id_carrera_texto));
			tema.setId_tipo_fce(Integer.parseInt(id_tipo_texto));
		}
		
		tema.setPalabras_claves(palabrasClaves);
		
		String[] carnes = (request.getParameter("carne")).split(",");
		String url = "";
			
			//guardamos en el objeto la url del archivo
			
			url = uploadPath + File.separator + fileName;
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
						//si todo se guarda subimos el archivo
						if(subirArchivo(filePart, uploadPath, fileName)) {
							response.sendRedirect("sistema.jsp?msj=1");
							return;
						}
						else {
							response.sendRedirect("./pages/inscripcion/inscripcion_tema.jsp?msj=2");
							return;
						}
						
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
	
	
	//esto permitirá subir el archivo a la ruta específicada
	public boolean subirArchivo(Part filePart, String uploadPath, String fileName) throws IOException {
		
	    OutputStream out = null;
	    InputStream filecontent = null;
	    File uploadDir = new File(uploadPath);
	   
		System.out.println(uploadDir);
		
		if (!uploadDir.exists()) {
			if(uploadDir.mkdir()) {
				
				//si lgora subir archivo return true
			    try {
			        out = new FileOutputStream(new File(uploadPath + File.separator
			                + fileName));
			        filecontent = filePart.getInputStream();

			        int read = 0;
			        final byte[] bytes = new byte[1024];

			        while ((read = filecontent.read(bytes)) != -1) {
			            out.write(bytes, 0, read);
			        }
			       return true;
			     
			    } catch (FileNotFoundException fne) {
			        
			        System.out.println("<br/> ERROR: " + fne.getMessage());
			        return false;

			    } finally {
			        if (out != null) {
			            out.close();
			        }
			        if (filecontent != null) {
			            filecontent.close();
			        }
			    }
				
			}
		} else {
			
			 try {
			        out = new FileOutputStream(new File(uploadPath + File.separator
			                + fileName));
			        filecontent = filePart.getInputStream();

			        int read = 0;
			        final byte[] bytes = new byte[1024];

			        while ((read = filecontent.read(bytes)) != -1) {
			            out.write(bytes, 0, read);
			        }
			        return true;
			     
			    } catch (FileNotFoundException fne) {
			      
			        System.out.println("<br/> ERROR: " + fne.getMessage());
			        return false;

			    } finally {
			        if (out != null) {
			            out.close();
			        }
			        if (filecontent != null) {
			            filecontent.close();
			        }
			     
			    }
			
		}
		
		return false;
	}
	/*
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
	*/
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
