<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>


    <% 
    /*
    ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
	//Recuperamos el Arraylist de la sesion creada en sistema.jsp
	listOpciones = (ArrayList <Vw_rol_opcion>)session.getAttribute("listOpciones");
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
		if(opcionActual.equals(miPagina.trim()))
		{
			permiso = true;
			break;
		}
		else
		{
			permiso = false;
		}
		
	}
	
	if(!permiso)
	{
		response.sendRedirect("../../Error.jsp");
	}*/
%>

 
<%
/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
String mensaje = "";
mensaje = request.getParameter("msj");
mensaje = mensaje==null?"":mensaje;


/* RECUPERAMOS EL VALOR DE LA VARIABLE temaID */
String idTema = "";
idTema = request.getParameter("temaID");
idTema = idTema==null?"0":idTema;

int tema = 0;
tema = Integer.parseInt(idTema); 

/* OBTENEMOS LOS DATOS DE TEMA A SER EDITADOS */
Tbl_usuario tus = new Tbl_usuario();
DT_usuario dtus = new DT_usuario();

Tbl_tema ttma = new Tbl_tema();
DT_tema dttma = new DT_tema();

ttma = dttma.obtenerTema(tema);

//ahora vamos a obtener los datos de los estudiantes correspondientes a ese tema



%>

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Edici髇 de Registro Tema FCE</title>
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

	<!-- tag input -->
	<link rel="stylesheet" href="../../plugins/tag-input/tag-input.css">
	<script src="../../plugins/tag-input/tag-input.js"></script>

	<!-- scripst propios -->
	<script src="./js/inscripcionMethods.js"></script>
	<script src="./js/inscripcionDom.js" defer></script>

	<!-- css propio -->
	<link rel="stylesheet" href="./css/inscripcion.css">

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
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblinscripciones.jsp">Inscripciones</a></li>
	              <li class="breadcrumb-item active">Inscripci髇 Tema</li>
	            </ol>
	          </div>
	        </div>
	      </div><!-- /.container-fluid -->
	    </section>
	
		<!-- Main content -->
	    <section class="content">
	      <div class="container-fluid">
	        <div class="row">
	          <!-- left column -->
	          <div class="col-md-12">
	            <!-- general form elements -->
	            <div class="card card-primary">
	            
	              <div class="card-header">
	              	<h3>Edici髇 de Registro de Tema FCE</h3>
	              </div>
	              
	              <!-- form start -->
	              <form role="form" name="formulario" action="../../SL_edicion_tema" method="post" enctype="multipart/form-data">
					
					<div class="card-body">
		                <input name="opc" id="opc" type="hidden" value="1"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
		                 
						<label for="exampleInputEmail1">TEMA de Forma de Culminaci贸n de Estudios:</label>
						<input type="text" id="tema" name="tema" class="form-control" placeholder="Tema de FCE" required>
					
						<input type="hidden" id="id_tema" name="id_tema"/>
						<br/>
					
						<!-- -->
	                    <label for="exampleInputFile">Propuesta de Forma de Culminaci贸n de Estudios:</label>
	                    <div class="input-group">
	                      <div class="custom-file">
	                        <input  type="file" class="custom-file-input" id="fl_propuesta_fce" name="fl_propuesta_fce">
	                        <label class="custom-file-label" for="exampleInputFile">Elija el documento de Propuesta FCE</label>
	                      </div>
	                    </div>
					
						
						<br />
						<label for="exampleInputPassword1">Seleccione la cantidad de Integrantes </label>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">
									Opciones
								</button>
								<ul class="dropdown-menu">
								<li class="dropdown-item"><a data-toggle="modal" data-target="#addMember">A帽adir compa帽ero</a></li>
								<li class="dropdown-item"><a onclick="EliminarMembers()">Eliminar a todos</a></li>
								</ul>
								
								<input type="hidden" id="carne" name="carne"/>
								<input type="hidden" id="id_estudiante_eliminado" name="id_estudiante_eliminado"/><!-- ESTE tendra los id de los usuarios que se han quitado de una fce -->
							</div>
							<!-- /btn-group -->
							<input type="text" class="form-control" id="members" readonly>
						</div>
		                
						<br/>
	
						<!-- tags input -->
						<label>Palabras Claves</label>
						<input type="text" class="form-control" id="palabras" value="">
						<input type="hidden" id="palabrasClave" name="palabrasClave"/>
						
		                <br/>
		                
			            <label for="exampleInputEmail1">Informaci贸n General de la culminaci贸n de estudio</label>
		          	
			          	<div class="row">

				          <div class="col-sm-4">
				        	<div class="form-group">
			                   	<label for="exampleInputPassword1">Carrera: </label>
		           				<select class="form-control select2" name="carrera" id="carrera" style="width: 100%;" required="required">
		           				  <option value="0">Seleccione una carrera...</option>
			        				<%
				            			DT_carrera dtca = new DT_carrera();
				            	    	ArrayList<Tbl_carrera> listCarrera = new ArrayList<Tbl_carrera>();
				            	    	listCarrera = dtca.listarCarreras();
				            	    
				            	    	for(Tbl_carrera tca : listCarrera)
				            	    	{
				            	    	if(tca.getId() == ttma.getId_carrera()){
				            		%>
				            		 <option selected="selected" value="<%=tca.getId()%>"><%=tca.getNombre()%></option>
				            		<%}
				            	    	else{
				            		 %>
				            		  <option value="<%=tca.getId()%>"><%=tca.getNombre()%></option>
				            		 <%}%>
				            		<%}%>
		           				</select>
		        			</div>
				          </div>
				          
				          <div class="col-sm-4">
				           	<div class="form-group">
			                   <label for="exampleInputPassword1">Tipo de FCE: </label>
		           				<select class="form-control select2" name="tipo_fce" id="tipo_fce" style="width: 100%;" required="required">
		           				  <option value="0">Seleccione un tipo de FCE...</option>
		            				<%
		            				DT_tipo_fce dttf = new DT_tipo_fce();
				            	    ArrayList<Tbl_tipo_fce> listTipoFce = new ArrayList<Tbl_tipo_fce>();
				            	    listTipoFce = dttf.listarTipoFce();
				            	    
				            	    for(Tbl_tipo_fce ttf : listTipoFce) {
				            	    	if(ttf.getId() == ttma.getId_tipo_fce()){
				            		%>
				            		 <option selected="selected" value="<%=ttf.getId()%>"><%=ttf.getTipo()%></option>
				            		 <%}
				            	    	else{
				            		 %>
				            		  <option value="<%=ttf.getId()%>"><%=ttf.getTipo()%></option>
				            		 <%}%>
				            		<%}%>
		           				</select>
		        			</div>
				          </div>
				          
				           <div class="col-sm-4">
				             <div class="form-group">
			                    <label for="exampleInputPassword1">Ambito de FCE: </label>
		           				<select class="form-control select2" name="ambito_fce" id="ambito_fce" style="width: 100%;" required="required">
		           				  <option value="0">Seleccione un 锟絤bito de FCE...</option>
		            				<%
				            		DT_ambito dtam = new DT_ambito();
				            	    ArrayList<Tbl_ambito> listAmbito = new ArrayList<Tbl_ambito>();
				            	    listAmbito = dtam.listarAmbitos();
				            	    
				            	    for(Tbl_ambito tam : listAmbito)  {
				            	    	if(tam.getId() == ttma.getId_ambito()){
				            		%>
				            		 <option selected="selected" value="<%=tam.getId()%>"><%=tam.getAmbito()%></option>
				            		  <%}
				            	    	else{
				            		 %>
				            		 <option value="<%=tam.getId()%>"><%=tam.getAmbito()%></option>
				            		 <%}%>
				            		<%}%>
		           				</select>
		        			</div>	
				          </div>

				        </div>
		               	<!--fin  div detalles fce-->
	
	                </div>
	                <!-- /.card-body -->
	
	                <div class="card-footer">
	                  <button type="submit" class="btn btn-primary">Registrar</button>
	                  <button type="reset" class="btn btn-danger">Cancelar</button>
	                </div>

	              </form>

	            </div>
	            <!-- /.card -->
	           </div>
	          </div>
	         </div>       
	    </section>
	    <!-- /.content -->
	
	  

	</div>
	
	<!-- Modal -->
	  <div class="modal fade" id="addMember" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
		  <div class="modal-content">

			<div class="modal-header">
			  <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>

			<!-- modal body -->
			
			<br />
			
			<div class="form-group" style="padding-left: 5%;width: 90%;">
				<label for="exampleInputPassword1">Escriba el carn茅 del participante </label>
				<input id="addM" class="form-control" type="text" />
				
				<br />	
				<button type="button" class="btn btn-primary" onclick="AddmemberEditar()" data-dismiss="modal">Agregar</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>  
			</div>
			<!-- end modal body -->
		  </div>
		</div>
	  </div>
	 <!-- end modal -->
	 
	<!-- Footer -->
  		<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  	<!-- ./Footer -->

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
    
    
    
    <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
    	$("#id_tema").val("<%=ttma.getId()%>");
    	$("#tema").val("<%=ttma.getTema()%>");
    	
    	let palabrasClaves = '<%=ttma.getPalabras_claves()%>';
    	
    	let valores = palabrasClaves.split(',');
    	
    	for (let valor of valores){

    		var palabrasInput = new Tagify(document.getElementById("palabras"),{maxTags: 6})
    		palabrasInput.on("add", valor )
	
        }
    	
    	$("#contrasenia").val("<%=tus.getContrasena()%>");
    	$("#nombres").val("<%=tus.getNombres()%>");
    	$("#apellidos").val("<%=tus.getApellidos()%>");
    	$("#correo").val("<%=tus.getCorreo()%>");
    	
    	///////////// VALIDAR SI NO SE GUARDO ///////////////
      
    var nuevo = 0;
    nuevo = "<%=mensaje%>";

 
    if(nuevo == "2")
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!')
    });
    </script>
    
    
    
    <script>
  

    
    </script>
    
    
</body>
</html>