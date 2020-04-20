package servlets;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
/*
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
*/

/**
 * Servlet implementation class SL_prueba_fichero
 */
@WebServlet("/SL_prueba_fichero")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
maxFileSize = 1024 * 1024 * 5, 
maxRequestSize = 1024 * 1024 * 5 * 5,
location="")
public class SL_prueba_fichero extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_prueba_fichero() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		String UPLOAD_DIRECTORY = "archivo_tema";
		String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
		File uploadDir = new File(uploadPath);
		System.out.println(uploadDir);
		if (!uploadDir.exists()) {
			if(uploadDir.mkdir()) {
				
				for(Part part : request.getParts()) {
					
					String fileName = getFileName(part);
					if(fileName != "false") {
						System.out.println(uploadPath + File.separator + fileName);
						part.write(uploadPath + File.separator + fileName);
						
						response.sendRedirect("./pages/inscripcion/inscripcion_prueba.jsp?msj=1");
						return;
					}
					
				}
				
			}
		} else {
			
			for(Part part : request.getParts()) {
				
				String fileName = getFileName(part);
				if(fileName != "false") {
					System.out.println(uploadPath + File.separator + fileName);
					part.write(uploadPath + File.separator + fileName);
					response.sendRedirect("./pages/inscripcion/inscripcion_prueba.jsp?msj=1");
				}
			}
			
			
		}
		*/
		
		String UPLOAD_DIRECTORY = "archivo_tema";
		String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
		File uploadDir = new File(uploadPath);
		
	    final Part filePart = request.getPart("fl_propuesta_fce");
	    
	    final String fileName = getFileName(filePart);
	    OutputStream out = null;
	    InputStream filecontent = null;
	    final PrintWriter writer = response.getWriter();
	    
		System.out.println(uploadDir);
		
		if (!uploadDir.exists()) {
			if(uploadDir.mkdir()) {
				

			    try {
			        out = new FileOutputStream(new File(uploadPath + File.separator
			                + fileName));
			        filecontent = filePart.getInputStream();

			        int read = 0;
			        final byte[] bytes = new byte[1024];

			        while ((read = filecontent.read(bytes)) != -1) {
			            out.write(bytes, 0, read);
			        }
			        response.sendRedirect("./pages/inscripcion/inscripcion_prueba.jsp?msj=http://localhost:8080/Sistema_FCE/archivo_tema/"+fileName);
					return;
			        //writer.println("New file " + fileName + " created at " + uploadPath);
			     
			    } catch (FileNotFoundException fne) {
			        writer.println("You either did not specify a file to upload or are "
			                + "trying to upload a file to a protected or nonexistent "
			                + "location.");
			        
			        writer.println("<br/> ERROR: " + fne.getMessage());

			    } finally {
			        if (out != null) {
			            out.close();
			        }
			        if (filecontent != null) {
			            filecontent.close();
			        }
			        if (writer != null) {
			            writer.close();
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
			        response.sendRedirect("./pages/inscripcion/inscripcion_prueba.jsp?msj=http://localhost:8080/Sistema_FCE/archivo_tema/"+fileName);
					return;
			        //writer.println("New file " + fileName + " created at " + uploadPath);
			     
			    } catch (FileNotFoundException fne) {
			        writer.println("You either did not specify a file to upload or are "
			                + "trying to upload a file to a protected or nonexistent "
			                + "location.");
			        writer.println("<br/> ERROR: " + fne.getMessage());

			    } finally {
			        if (out != null) {
			            out.close();
			        }
			        if (filecontent != null) {
			            filecontent.close();
			        }
			        if (writer != null) {
			            writer.close();
			        }
			    }
			
		}
		
		
	    
	   

		
		
		
		
		
		
		
		
		

		
		
	}
	
	public String getFileName(Part part) {
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

}
