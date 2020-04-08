package servlets;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import datos.DT_cierre;
import datos.DT_tema;
import entidades.Tbl_cierre;

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
