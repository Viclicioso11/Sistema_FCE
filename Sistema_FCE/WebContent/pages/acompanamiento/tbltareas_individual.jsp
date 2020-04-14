<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

<% /*
    ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
	//Recuperamos el Arraylist de la sesion creada en sistema.jsp
	listOpciones = (ArrayList <Vw_rol_opcion>) session.getAttribute("listOpciones");
=======
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

	for(Vw_rol_opcion vro : listOpciones)*/
	/*{
		opcionActual = vro.getOpcion().trim();
		System.out.println("opcionActual ="+opcionActual);
		if(opcionActual.equals(miPagina.trim()))
		{

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

	} 
	

		return;
	}
*/
%>

<%
   /* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
   String mensaje = "";
   mensaje = request.getParameter("msj");
   mensaje = mensaje==null ? "":mensaje;
   
   DT_tema dtma = new DT_tema();
   DT_usuario_tema dtust = new DT_usuario_tema();
   
   
   
   String id_usuario_texto = "";
   
   id_usuario_texto = session.getAttribute("idUsuario").toString();
   
  	int id_usuario = 0;

  	if(id_usuario_texto != null) {
  		id_usuario = Integer.parseInt(id_usuario_texto);
    }
   
   int id_tema = 0;
   
   id_tema = dtust.ibtenerIdTema(id_usuario);
   
   
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Tareas asignadas</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <!-- select2 css -->
  <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

  <!-- DATATABLE NEW -->
  <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
  <!-- DATATABLE NEW buttons -->
  <link href="../../plugins/DataTablesNew/Buttons-1.5.6/css/buttons.dataTables.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="./css/listas.css">


</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  

  <!-- Navbar -->
  	<jsp:include page="/WEB-INF/layouts/topbar2.jsp"></jsp:include>
  <!-- /.navbar -->
 

  <!-- SIDEBAR -->
  	<jsp:include page="/WEB-INF/layouts/menu2.jsp"></jsp:include>
  <!-- SIDEBAR -->


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
  
  
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Tareas asignadas</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#"></a>Inicio</li>
              <li class="breadcrumb-item active">Tareas asignadas</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">	
            </div>
              
            <!-- /.card-header -->
            <div class="card-body">
            
            <%
            	//si tiene un tema asignado carga tareas, sino aparece un texto
            	
            	if(id_tema != 0) {
            		
            %>
            
	            <ul class="list-group">
	            <%
	                	DT_grupo_tarea dttar = new DT_grupo_tarea();
	         	        				
	         	        //mostrando las tareas asignadas a un grupo
	         	       	ArrayList<Vw_tema_tarea> tareas = new  ArrayList<Vw_tema_tarea> ();
	         	       	tareas = dttar.listarTareasGrupo(id_tema);
	      	        	
	      	        	for(Vw_tema_tarea vttar : tareas)	{
	      	        		
	               	%>
	               	<li class = "list-group-item ">
	               		<div class = "row-fluid"> 
		               		<div class = "col-md-4">
		               			<a class="ref-color" href="#"><i class="fas fa-file-word"></i> <%=vttar.getTitulo_tarea()%></a>
		               			<p><%=vttar.getDescripcion_tarea()%></p>	
		               		</div>
		               		
		               		<div class = "col-md-2">
		               		
		               		<b><p style="text-align: center;">Inicia</p></b>
		               		<p style="text-align: center;"><%=vttar.getFecha_inicio()%></p>		
		               		
		               		</div>
		               		
		               		<div class = "col-md-2">
		               		
		               		<b><p style="text-align: center;">Termina</p></b>
		               		<p style="text-align: center;"><%=vttar.getFecha_fin()%></p>	
		               		
		               		
		               		</div>
		               		
		               		<div class = "col-md-2">
		               			<div class="form-group">
			           				<select onchange="editarEstadoEstudiante('<%=vttar.getTarea_id()%>')" class="form-control select2" id="estadoTarea" name="estadoTarea" style="width: 100%;" required>
			           				<%
			           				if(vttar.getEstado() == 0) {
			           				%>
			           				  <option selected value="0">Pendiente</option>
			           				<% 
			           				} else {
			           				%>
			           				  <option value="0">Pendiente</option>
			           				<% }%>
			           				
			           				<%
			           				if(vttar.getEstado() == 1) {
			           				%>
			           				  <option selected value="1">Entregada</option>
			           				  <script>	
			           				  //si ya fue entregada no puede editarlo
			           				  document.getElementById("estadoTarea").disabled=true;  
			           				  </script>
			           				<% 
			           				} else {
			           				%>
			           				  <option value="1">Entregada</option>
			           				<% }%>
			           				<%
			           				if(vttar.getEstado() == 2) {
			           				%>
			           				  <option selected value="2">Retrasada</option>	
			           				<% 
			           				} else {
			           				%>
			           				  <option value="2">Retrasada</option>	
			           				<% }%>
			           				  
			           				  	
           				  
           							</select>
        						</div>	
		               		</div>
		               		
		               		<input type="hidden" id="id_tem" name = "id_tem" value="<%=id_tema%>">
		               		<input type="hidden" id="opc" name = "opc" value="2">
		               		
		                </div>
		            </li>
	             <%}%>
	            </ul>
            
            <%} // fin del if
            	//si no tiene un tema
            	else {
            		
            %>
            
		            
		        <h3>Usted aún no ha inscrito un Tema de Forma de Culminación de Estudios</h3>
				
				<p>
					Si ya ha inscrito un tema de FCE y esta pantalla aparece, contáctese con coordinación.
					<br>
				</p>
		            
            
            <%
            	}
            %>
     
          </div>
          <!-- /.card-body -->
          </div>
          <!-- /.card -->

        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Footer -->
  	<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  <!-- ./Footer -->
  
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- DataTables -->
<!-- <script src="../../plugins/datatables/jquery.dataTables.js"></script> -->
<!-- <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script> -->

<!-- DATATABLE NEW -->
  <script src="../../plugins/DataTablesNew/DataTables-1.10.18/js/jquery.dataTables.js"></script>

<!-- DATATABLE NEW buttons -->
  <script src="../../plugins/DataTablesNew/Buttons-1.5.6/js/dataTables.buttons.min.js"></script>

<!-- js DATATABLE NEW buttons print -->
  <script src="../../plugins/DataTablesNew/Buttons-1.5.6/js/buttons.html5.min.js"></script>
  <script src="../../plugins/DataTablesNew/Buttons-1.5.6/js/buttons.print.min.js"></script>

   <!-- js DATATABLE NEW buttons pdf -->
  <script src="../../plugins/DataTablesNew/pdfmake-0.1.36/pdfmake.min.js"></script>
  <script src="../../plugins/DataTablesNew/pdfmake-0.1.36/vfs_fonts.js"></script>

  <!-- js DATATABLE NEW buttons excel -->
  <script src="../../plugins/DataTablesNew/JSZip-2.5.0/jszip.min.js"></script>

<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Select2 -->

<script src="../../plugins/select2/js/select2.full.min.js"></script>

<!-- page script -->

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  <!--  js de la carpeta js local -->
  <script src="./js/tbltareas.js" defer></script>



<script>

  
      /////////// VARIABLES DE CONTROL MSJ ///////////
 var mensaje =  "<%=mensaje%>"

 if(mensaje == "1")
   successAlert('Éxito', 'El registro ha sido almacenado correctamente.')
 
 if(mensaje == "3")
   successAlert('Éxito', 'El registro ha sido modificado correctamente.')
 
 if(mensaje == "4")
   successAlert('Éxito', 'El registro ha sido eliminado correctamente.')
 
 if(mensaje == "5")
   errorAlert('Error', 'El registro no se ha podido eliminar.')
   
   
</script>

</body>
</html>

