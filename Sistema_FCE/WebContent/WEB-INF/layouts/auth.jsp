<%@ page import="entidades.Vw_rol_opcion, datos.DT_rol_opcion, java.util.ArrayList;"%>
    
<% 

	// objetos para las opciones
	DT_rol_opcion Dtro = new DT_rol_opcion();
    ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();    
    listOpciones = Dtro.getOpciones(session.getAttribute("listOpciones"));

	//objetos para el login
    String loginUser = "";

	loginUser = (String) session.getAttribute("login");
	loginUser = loginUser == null ? "":loginUser;
	
	if(loginUser.equals("")) {
		response.sendRedirect("index.jsp");
	}
	
	
	//Recuperamos la url de la pag actual
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index+1);
	boolean permiso = false;
	
	//Buscamos si el rol tiene permisos para ver esta pagina
	for(Vw_rol_opcion vro : listOpciones) {
		
		if(vro.getOpcion().trim().equals(miPagina.trim()) ) {
			permiso = true;
			break;
			
		} else	{
			permiso = false;
		}
		
	}
	
	if(!permiso) {
		response.sendRedirect("../../Error.jsp");
	}
	
	
%>