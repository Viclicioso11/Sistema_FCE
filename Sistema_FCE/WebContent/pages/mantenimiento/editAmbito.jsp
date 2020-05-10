<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*,datos.*, java.util.*;"%>
    
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
	<meta charset="ISO-8859-1">
	<title>Editar Ambito</title>
	<!-- Imagen del título-->
 <link  rel="icon"   href="../../dist/img/favicon.png" type="image/png" />
	
	<!-- Tell the browser to be responsive to screen width -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- Font Awesome -->
	<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
	
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	
	<!-- Theme style -->
	<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
	
	<!-- Google Font: Source Sans Pro -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
	<!-- jAlert css  -->
	<link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />


<%
	/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
	String mensaje = "";
	mensaje = request.getParameter("msj");
	mensaje = mensaje==null?"":mensaje;
	
	/*obtenemos el ambito*/
	String idAmbito = "";
	idAmbito = request.getParameter("id_ambito");
	idAmbito = idAmbito==null ? "0":idAmbito;
	int ambito = Integer.parseInt(idAmbito); 
	
	/* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
	Tbl_ambito tAmbito = new Tbl_ambito();
	DT_ambito dtambito = new DT_ambito();
	tAmbito = dtambito.obtenerAmbito(ambito);
%>


</head>
<body class="hold-transition sidebar-mini">
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
	            <h1>Edición [Ambito]</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblambito.jsp">Gestión Ambito</a></li>
	              <li class="breadcrumb-item active">Edición Ambito</li>
	            </ol>
	          </div>
	        </div>
	      </div>
	      
	    </section>
	
		<!-- Main content -->
	    <section class="content">
	      <div class="container-fluid">
	      
	           <!-- general form elements -->
	           <div class="card card-primary">
	           
	             <div class="card-header">
	               <h3 class="card-title">Edición del Ambito</h3>
	             </div>
	             <!-- /.card-header -->
	             <!-- form start -->
	             <form role="form" action="../../SL_ambito" method="post">
	             
	               <div class="card-body">
	               
	                 <input name="opc" id="opc" type="hidden" value="2"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
	                 <input name="IdAmbito" id="IdAmbito" type="hidden"> <!-- ESTE INPUT ES UTILIZADO EL ID_Ambito A EDITAR -->
	                 
	                 <div class="form-group">
	                   <label for="exampleInputEmail1">Nombre del Ambito:</label>
	                   <input type="text" id="ambito" name="ambito" class="form-control" 
	                   placeholder="Nombre del Ambito" required>
	                 </div>
	                 
	                 <div class="form-group">
	                   <label for="exampleInputEmail1">Descripción del Ambito:</label>
	                   <input type="text" id="descripcion" name="descripcion" class="form-control" 
	                   placeholder="Descripción del nuevo Ambito">
	                 </div>
	                 
	               </div>
	               <!-- /.card-body -->
	
	               <div class="card-footer">
	                 <button type="submit" class="btn btn-primary">Guardar</button>
	                 <button type="button" class="btn btn-danger">Cancelar</button>
	               </div>
	             </form>
	           </div>
	           <!-- /.card -->
	      </div>       
	    </section>
    <!-- /.content -->
	
	


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

<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>

<!-- jAlert js -->
<script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
<script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
    <!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
  <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
		$("#IdAmbito").val("<%=tAmbito.getId()%>");
    	$("#ambito").val("<%=tAmbito.getAmbito()%>");
    	$("#descripcion").val("<%=tAmbito.getDescripcion()%>");
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      
      nuevo = "<%=mensaje%>";
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente.');
      }
    
      
    });
    </script>

</body>
</html>