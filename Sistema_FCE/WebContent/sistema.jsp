<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"session="true" import="entidades.*,datos.*, java.util.*;"%>
    
<% 
	DT_rol_opcion Dtro = new DT_rol_opcion();
	ArrayList <Vw_rol_opcion> Opciones = new ArrayList <Vw_rol_opcion>();
	Opciones = Dtro.getOpciones(session.getAttribute("listOpciones"));
	
	//objetos para el login
    String loginUser = "";
	loginUser = (String) session.getAttribute("login");
	loginUser = loginUser == null ? "":loginUser;
	
	if(loginUser.equals("")) {
		response.sendRedirect("index.jsp?session=null");
		return;
	}
	if (Opciones.size() < 1){
		response.sendRedirect("index.jsp?opcs=null");
		return;
	}
	
	//Recuperamos la url de la pag actual
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index+1);
	boolean permiso = false;
	
	//Buscamos si el rol tiene permisos para ver esta pagina
	for(Vw_rol_opcion opcion : Opciones) {	
		if(opcion.getOpcion().trim().equals(miPagina.trim()) ) {
			permiso = true;
			break;
		} else	{
			permiso = false;
		}
	}
	
	if(!permiso) {
		response.sendRedirect("../../Error.jsp");
		return;
	}
%>

<%

 String rol_texto = session.getAttribute("id").toString();
 int id_rol = 0;
if(rol_texto != null) {
	
	id_rol = Integer.parseInt(rol_texto);
	
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

 <title>Sistema FCE</title>

 <!-- Font Awesome Icons -->
 <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
 <!-- Theme style -->
 <link rel="stylesheet" href="dist/css/adminlte.min.css">
 <!-- Google Font: Source Sans Pro -->
 <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
 
 <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
 
  <!-- fullCalendar -->
  <link rel="stylesheet" href="plugins/fullcalendar/main.min.css">
  <link rel="stylesheet" href="plugins/fullcalendar-daygrid/main.min.css">
  <link rel="stylesheet" href="plugins/fullcalendar-timegrid/main.min.css">
  <link rel="stylesheet" href="plugins/fullcalendar-bootstrap/main.min.css">
  
  
    <!-- jAlert css  -->
	<link rel="stylesheet" href="plugins/jAlert/dist/jAlert.css" />
 
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  
  
  <!-- Navbar -->
  	<jsp:include page="WEB-INF/layouts/topbar.jsp"></jsp:include>
  <!-- /.navbar -->

  <!-- SIDEBAR -->
  	<jsp:include page="WEB-INF/layouts/menu-d-1.jsp"></jsp:include>
  <!-- SIDEBAR -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
   
		<%
		//para cada rol cargar un inicio distinto, y si no es aprte de los 3 primeros roles, que cargue un default
		switch (id_rol) {
		
		
		case 1: 
			
		%>
		<jsp:include page="inicioAdministrador.jsp"></jsp:include>
		
		<%
		//fin primer case
			break;

		case 2: 
		
		%>
		
		
		<%
		//fin segundo case
			break;
		
		case 3:
			
		%>	
		
		
		<%	
		//fin tercer case
			break;
		
		default: 
		%>	
		
		
		<%
		//fin default
		}//fin switch
		
		%>
		
		
		
		
		


  </div>
  <!-- /.content-wrapper -->

  <!-- Footer -->
  <jsp:include page="WEB-INF/layouts/footer.jsp"></jsp:include>
  <!-- ./Footer -->
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Bootstrap -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE -->
<script src="dist/js/adminlte.js"></script>
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>

<<<<<<< HEAD
<!-- OPTIONAL SCRIPTS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<script src="dist/js/demo.js"></script>
<script src="dist/js/pages/dashboard3.js"></script>


<!-- fullCalendar 2.2.5 -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/fullcalendar/main.min.js"></script>
<script src="plugins/fullcalendar-daygrid/main.min.js"></script>
<script src="plugins/fullcalendar-timegrid/main.min.js"></script>
<script src="plugins/fullcalendar-interaction/main.min.js"></script>
<script src="plugins/fullcalendar-bootstrap/main.min.js"></script>
<script src="plugins/fullcalendar/locales/es.js"></script>
=======
>>>>>>> 4a53f96cc0451659ef229a4097385bd34ae0e5c4

<!-- jAlert js -->
  <script src="plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  <!-- jAlert js -->
  <script src="./js/inicioAdmin.js"></script>

<script>
$(document).ready(function ()
{
	
	(function mensajes(){
	    let uri = new URL(window.location.href)
	    let msj =  uri.searchParams.get("msj")


	    if (msj == 1){
	    	successAlert('Exito', 'Su Tema FCE ha sido registrado');
	    }
	    
	    if (msj != null){
	      window.history.replaceState("any", "any", "/sistema.jsp")
	    }
	})();
 
});

</script>




</body>
</html>