<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>


 
<%
/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
String mensaje = "";
mensaje = request.getParameter("msj");
mensaje = mensaje==null?"":mensaje;
%>

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Registro Tema FCE</title>
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
	              <li class="breadcrumb-item"><a href="tblusuarios.jsp">Inscripción</a></li>
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
	              	<h3>Registro de tema</h3>
	              </div>
	              
	              <!-- form start -->
	              <form role="form" name="formulario" action="../../SL_tema" method="post" enctype="multipart/form-data">
					
					<div class="card-body">
		                <input name="opc" id="opc" type="hidden" value="1"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
		                 
						<label for="exampleInputEmail1">TEMA de Forma de Culminación de Estudios:</label>
						<input type="text" id="tema" name="tema" class="form-control" placeholder="Tema de FCE" required>
					
						<br/>
					
						<!-- -->
	                    <label for="exampleInputFile">Propuesta de Forma de Culminación de Estudios:</label>
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
								<li class="dropdown-item"><a data-toggle="modal" data-target="#addMember">Añadir compañero</a></li>
								<li class="dropdown-item"><a onclick="EliminarMembers()">Eliminar a todos</a></li>
								</ul>
								
								<input type="hidden" id="carne" name="carne"/>
							</div>
							<!-- /btn-group -->
							<input type="text" class="form-control" id="members" readonly>
						</div>
		                
						<br/>
	
						<!-- tags input -->
						<label>Palabras Claves</label>
						<input type="text" class="form-control" id="palabras" value="">
						<input type="hidden" id="palabrasClave" name="PalabrasClave"/>
						
		                <br/>
		                
			            <label for="exampleInputEmail1">Información General de la culminación de estudio</label>
		          	
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
				            		%>
				            		 <option value="<%=tca.getId()%>"><%=tca.getNombre()%></option>
				            		<%	
				            		} 
				            		%>
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
				            		%>
				            		 <option value="<%=ttf.getId()%>"><%=ttf.getTipo()%></option>
				            		<%}%>
		           				</select>
		        			</div>
				          </div>
				          
				           <div class="col-sm-4">
				             <div class="form-group">
			                    <label for="exampleInputPassword1">Ambito de FCE: </label>
		           				<select class="form-control select2" name="ambito_fce" id="ambito_fce" style="width: 100%;" required="required">
		           				  <option value="0">Seleccione un �mbito de FCE...</option>
		            				<%
				            		DT_ambito dtam = new DT_ambito();
				            	    ArrayList<Tbl_ambito> listAmbito = new ArrayList<Tbl_ambito>();
				            	    listAmbito = dtam.listarAmbitos();
				            	    
				            	    for(Tbl_ambito tam : listAmbito)  {
				            		%>
				            		 <option value="<%=tam.getId()%>"><%=tam.getAmbito()%></option>
				            		<%	}	%>
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
				<label for="exampleInputPassword1">Escriba el carné del participante </label>
				<input id="addM" class="form-control" type="text" />
				
				<br />	
				<button type="button" class="btn btn-primary" onclick="Addmember()" data-dismiss="modal">Agregar</button>
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
    
    var nuevo = 0;
    nuevo = "<%=mensaje%>";

    if(nuevo == "2")
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!')

    
    </script>
    
    
</body>
</html>