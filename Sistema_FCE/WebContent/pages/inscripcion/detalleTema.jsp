<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

<% 
/*
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
	*/
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


Tbl_tema ttma = new Tbl_tema();
DT_tema dttma = new DT_tema();

//un id solo de prueba para cargar
ttma = dttma.obtenerTema(tema);

String nombre_tutor = dttma.obtenerNombreTutor(tema);

if(nombre_tutor.equals("")) {
	nombre_tutor = "Sin tutor";
}

//para poner la url sin las comillas que trae de la base de datos
//ttma.setUrl(ttma.getUrl().replace("\"", ""));

%>

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Detalles del Tema FCE</title>
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


  <!-- DATATABLE NEW -->
    <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
    
	<!-- tag input -->
	<link rel="stylesheet" href="../../plugins/tag-input/tag-input.css">
	<script src="../../plugins/tag-input/tag-input.js"></script>

	<!-- scripst propios -->
	<script src="./js/inscripcionMethods.js"></script>

	<!-- css propio -->
	<link rel="stylesheet" href="./css/inscripcion.css">

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
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="#">Inscripciones</a></li>
	              <li class="breadcrumb-item active">Inscripción Tema</li>
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
	              	<h3>Detalles Tema FCE</h3>
	              </div>
	              
	              <!-- form start -->
	             
					
					<div class="card-body">
		                <input name="opc" id="opc" type="hidden" value="1"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
		                 
		                 <div class = "row">
		                 
		                 <div class = "col-sm-8">
		                 	<label for="exampleInputEmail1">Tema de Forma de Culminación de Estudios:</label>
							<input type="text" id="tema" name="tema" class="form-control" readonly>
		                 
		                 </div>
		                 
		                 <div class = "col-sm-4">
		                 	<a href="../../pages/inscripcion/detalle_tema_impreso.html?temaID=<%=tema%>">Descargar en formato PDF <i class="fas fa-file-pdf" title="Ver PDF"></i></a>
		                 
		                 </div>
		                 
		                 </div>
						
						
						
						
						<label for="exampleInputEmail1">Fecha de inscripción:</label>
						<input type="text" id="fecha" name="fecha" class="form-control" readonly>
						
						<label for="exampleInputEmail1">Tutor asignado:</label>
						<input type="text" id="tutor" name="tutor" class="form-control" readonly>
					
						<input type="hidden" id="id_tema" name="id_tema"/>
						
						<br/>
					
						<!-- -->
					<div class="row">

						
				       <div class="col-sm-10">
				        <div class="form-group">
				        	
	                      </div>
	                    </div>
				        	
				        </div>
				      
				       <div class="col-sm-2">
				       
	                    
				     </div>
					
			<hr>
						
			 <!-- /tabla integrantes-->
            <div id= "tbl_estudiante" class="card-body" >
				<label for="exampleInputPassword1">Integrantes de Tema FCE</label>
	            <br/>
	           
	              <table id="estudiantes" class="table table-bordered">
	                <thead>
	                <tr>
	                  <th>Carné/ID</th>
	                  <th>Nombres</th>
	                  <th>Apellidos</th>
	                 
	                </tr>
	                </thead>
	                <tbody>
	                <%
	              //aquí se traen los usuarios con sus nombres, apellidos y el id
	
	                ArrayList<Tbl_usuario> estudiantes = new ArrayList<Tbl_usuario>();
	                estudiantes = dttma.obtenerEstudiante(tema);
	
	                  	        		for(Tbl_usuario tus : estudiantes)
	                  	        		{
	                %>
		                <tr>
		                  <td><%=tus.getCarne()%></td>
		                  <td><%=tus.getNombres() %></td>
		                  <td><%=tus.getApellidos() %></td>
		               
		                </tr>
		             <%
		        		}   
		             %>
	                </tbody>
	             
	              </table>
            </div>
            <hr>
		                
	
						<!-- tags input -->
						<label>Palabras Claves</label>
						<input type="text" class="form-control" id="palabras" value="" readonly>
						<input type="hidden" id="palabrasClave" name="palabrasClave"/>
						
		                <br/>
		                
			            <label for="exampleInputEmail1">Información General de la culminación de estudio</label>
		          	
			          	<div class="row">

				          <div class="col-sm-4">
				        	<div class="form-group">
			                   	<label for="exampleInputPassword1">Carrera: </label>
		           				<select class="form-control select2" name="carrera" id="carrera" style="width: 100%;" required="required" disabled>
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
		           				<select class="form-control select2" name="tipo_fce" id="tipo_fce" style="width: 100%;" required="required" disabled>
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
		           				<select class="form-control select2" name="ambito_fce" id="ambito_fce" style="width: 100%;" required="required" disabled>
		           				  <option value="0">Seleccione un ï¿½mbito de FCE...</option>
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
	                  
	                </div>


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
			  <h5 class="modal-title" id="exampleModalLabel">Asignación estudiante</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>

			<!-- modal body -->
			
			<br />
			
			<div class="form-group" style="padding-left: 5%;width: 90%;">
				<label for="exampleInputPassword1">Escriba el carné del participante </label>
				<input id="addM" class="form-control" type="text" />
				
				<br />	
				<button type="button" class="btn btn-primary" onclick="AddmemberEditar()" data-dismiss="modal">Agregar</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>  
			</div>
			<!-- end modal body -->
		  </div>
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

<!--  js de la carpeta js local -->
  <script src="./js/edit_inscripcion_fce.js" defer></script>
    
    
    
    <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
    	$("#id_tema").val("<%=ttma.getId()%>");
    	$("#tema").val("<%=ttma.getTema()%>");
    	let fecha = setFecha("<%=ttma.getFecha()%>");
    	
    	$("#fecha").val(fecha);
    	$("#tutor").val("<%=nombre_tutor%>");
    	$("#palabras").val("<%=ttma.getPalabras_claves()%>");
    	
    	
    	
     	var palabrasProbar = new Tagify(document.getElementById("palabras"),{maxTags: 6})
     	InputPalabra()
     	
     	palabrasProbar.on("add", function(){
     		InputPalabra()
     	})
     	
     	palabrasProbar.on("remove", function(){
     		InputPalabra()
     	})
     	
    		

   	///////////// VALIDAR SI NO SE GUARDO ///////////////
      
    var nuevo = 0;
    nuevo = "<%=mensaje%>";

 
    if(nuevo == "2")
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!')
    }); 
    </script>
    
    
    
    <script>
  	
    function setFecha(fecha) {
    	
    	let arregloFecha = fecha.split("/");
    	let mes = "";
    	let meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    	
    	mes = meses[arregloFecha[1] - 1];
    	
    	let fechaTexto = arregloFecha[2] + " de " + mes + " del año "+ arregloFecha[0];
    	
    	return fechaTexto;
    	
    	
    }

    
    </script>
    
    
</body>
</html>