package servlets;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DT_tema;

/**
 * Servlet implementation class SL_descarga_archivos
 */
@WebServlet("/SL_descarga_archivos")
public class SL_descarga_archivos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_descarga_archivos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//DT_tema dtema = new DT_tema();
		
		String url = request.getParameter("url");
		/*int id_tema = 0;
		if(id_tema_texto != null) {
			id_tema = Integer.parseInt(id_tema_texto);
		}
		*/
		/*int index = fullPath.lastIndexOf("\\");
		String fileName = fullPath.substring(index + 1);
		String path = fullPath.substring(index - 1);*/
		
		//String fullPath = dtema.obtenerURLTema(id_tema); 
		
		System.out.println("RUTA DADA: "+ url);
		
		
		  Path p = Paths.get(url);
		  String fileName = p.getFileName().toString();
		  String directory = p.getParent().toString() + "\\";
		
		System.out.println(directory + fileName);
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		response.setContentType("APPLICATION/OCTET-STREAM");
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ fileName + "\"");
 
		FileInputStream fileInputStream = new FileInputStream(directory
				+ fileName);
 
		int i;
		while ((i = fileInputStream.read()) != -1) {
			out.write(i);
		}
		fileInputStream.close();
		out.close();

		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
