<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="entidades.*, datos.*, java.util.*;"%>
<% 
	DT_rol_opcion Dtro = new DT_rol_opcion();
	ArrayList <Vw_rol_opcion> Opciones = new ArrayList <Vw_rol_opcion>();
	Opciones = Dtro.getOpciones(session.getAttribute("listOpciones"));
	
	//objetos para el login
    String loginUser = "";
	loginUser = (String) session.getAttribute("login");
	loginUser = loginUser == null ? "":loginUser;
	
	if(loginUser.equals("")) {
		response.sendRedirect("../../index.jsp?session=null");
		return;
	}
	if (Opciones.size() < 1){
		response.sendRedirect("../../index.jsp?opcs=null");
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


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
  <!-- scripst propios -->
  <!-- 
  <script src="./js/jquery-2.1.4.min.js"></script>
  <script src="./js/javascript.js"></script>
   -->
  <title>Evaluación tutor</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">

	<div class="wrapper">
		<!-- Navbar -->
	  	<jsp:include page="/WEB-INF/layouts/topbar2.jsp"></jsp:include>
   	    <!-- /.navbar -->
	 
	
	    <!-- SIDEBAR -->
	  	<jsp:include page="/WEB-INF/layouts/menu-d-2.jsp"></jsp:include>
	    <!-- SIDEBAR -->
	    
	     <!-- Content Wrapper. Contains page content -->
 		 <div class="content-wrapper">
 		 
 		 	<!-- Content Header (Page header) -->
		    <section class="content-header">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		           
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item"><a href="#"></a>Home</li>
		              <li class="breadcrumb-item active">Evaluación tutor</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		    
		    <section class="content">
		    	<div class="row">
		    		<div class="col-12">
		    	
		    		<div class="card">
		    			<div class="card-header">
		    				<h4>Evaluación tutor</h4>
		    				<p>En esta sección podras evaluar el desempeño del tutor</p>
		    			</div>
		    			
		    			<br/>
		    			<iframe 
		    			 src="https://docs.google.com/forms/d/e/1FAIpQLSeNvTCI3QALRy56BJgnVSWIGxtLMXKIDCIqs9-Hy6uWXLOQyg/viewform?embedded=true"
		    			 width="80%" 
		    			 height="1080" 
		    			 frameborder="0"
		    			 style="margin: 0% 10% 0% 10%">
		    				Cargando…
		    			</iframe>
		    		</div>
		    		</div>
		    	</div>
		    </section>
 		 </div>
 		 <!-- Footer -->
	     <jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
	     <!-- ./Footer -->
	</div>

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
</body>
</html>