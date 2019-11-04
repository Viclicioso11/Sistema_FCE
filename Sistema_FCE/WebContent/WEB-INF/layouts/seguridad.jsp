<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
<%
  	ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
	//Recuperamos el Arraylist de la sesion creada en sistema.jsp
	listOpciones = (ArrayList <Vw_rol_opcion>) session.getAttribute("listOpciones");

  //Recuperamos la url de la pag actual
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index+1);
	System.out.println("miPagina ="+miPagina);
	boolean permiso = false;
	String opcionActual = "";
	//Buscamos si el rol tiene permisos para ver esta pagina
	for(Vw_rol_opcion vro : listOpciones)
	{
		opcionActual = vro.getOpcion().trim();
		System.out.println("opcionActual ="+opcionActual);

		if(opcionActual.equals(miPagina.trim())) {
			permiso = true;
			break;
		}else	{
			permiso = false;
		}
	
	}

	if(!permiso) {
		response.sendRedirect("../../Error.jsp");
	}
%>