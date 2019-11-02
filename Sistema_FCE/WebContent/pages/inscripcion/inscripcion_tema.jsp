    <%@page import="entidades.Tbl_rol"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
     <% 
    /*
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
	}
	*/
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


<%
/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
String mensaje = "";
mensaje = request.getParameter("msj");
mensaje = mensaje==null?"":mensaje;


%>


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
	            <h1>Registro [Tema FCE]</h1>
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
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_tema" method="post" enctype="mulltipart/form-data">
                <div class="card-body">
                  <input name="opc" id="opc" type="hidden" value="1"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  
                  <!-- div de tema y subida de archivo-->
	        	<div class="row">
                   <div class="col-sm-6">
                    <label for="exampleInputEmail1">TEMA de Forma de Culminación de Estudios:</label>
                    <input type="text" id="tema" name="tema" class="form-control" 
                    placeholder="Tema de FCE" required>         
                  </div>
		           <div class="col-sm-6">
                    <label for="exampleInputFile">Propuesta de Forma de Culminación de Estudios:</label>
                    <div class="input-group">
                      <div class="custom-file">
                        <input  onchange="ponerNombreArchivo(this)" type="file" class="custom-file-input" id="fl_propuesta_fce" name="fl_propuesta_fce">
                        <label class="custom-file-label" for="exampleInputFile">Elija el documento de Propuesta FCE</label>
                        <input type="hidden" name ="nombreArchivo" id="nombreArchivo" value="" >
                      </div>
                    </div>
                  </div>
		        </div>
		        
		        <!-- fin div hidden de estudiante 1-->  
		        <br/>
		        
		        <div class="row">
                <div class="form-group col-sm-6">
                   <label for="exampleInputPassword1">Seleccione la cantidad de Integrantes </label>
           				<select onchange="aparecer_ocultar_est()" class="form-control select2" name="cantidad_integrantes" id="cantidad_integrantes" style="width: 100%;" required="required">
           				  <option value="0">Seleccione...</option>
	            			<option value="1">1</option>
	            			<option value="2">2</option>
	            			<option value="3">3</option>
	           			</select>
	           	</div>		
        		</div>
        		
        		
        		<!-- div hidden de estudiante 1-->
	        	<div id="estudiante1" class="row">
		          <div class="col-sm-6">
                    <label for="exampleInputEmail1">Carné:</label>
                    <input onchange="ponerNombreEstudiante1()" type="text" id="carne1" name="carne1" class="form-control" 
                    placeholder="Carné Estudiante" required>
		          </div>
		          <div class="col-sm-6">  
                    <label for="exampleInputEmail1">Nombre Estudiante:</label>
                    <input type="text" id="nombre1" name="nombre1" class="form-control" 
                    placeholder="Nombre Estudiante" required>
		          </div>
		        </div>
                <!-- fin div hidden de estudiante 1-->  
                
                <!-- div hidden de estudiante 2-->
	        	<div id="estudiante2" class="row">
		          <div class="col-sm-6">
		            
                    <label for="exampleInputEmail1">Carné:</label>
                    <input type="text" id="carne2" name="carne2" class="form-control" 
                    placeholder="Carné Estudiante" required>
               
		          </div>
		          <div class="col-sm-6">		           
                  
                    <label for="exampleInputEmail1">Nombre Estudiante:</label>
                    <input type="text" id="nombre2" name="nombre2" class="form-control" 
                    placeholder="Nombre Estudiante" required>
                  
		          </div>
		        </div>
                <!-- fin div hidden de estudiante 2-->  
                  
                <!-- div hidden de estudiante 3-->
	        	<div id="estudiante3" class="row">
		          <div class="col-sm-6">
		            
                    <label for="exampleInputEmail1">Carné:</label>
                    <input  type="text" id="carne3" name="carne3" class="form-control" 
                    placeholder="Carné Estudiante" required>
              
		          </div>
		          <div class="col-sm-6">
		
                    <label for="exampleInputEmail1">Nombre Estudiante:</label>
                    <input type="text" id="nombre3" name="nombre3" class="form-control" 
                    placeholder="Nombre Estudiante" required>

		          </div>
		        </div>
                <!-- fin div hidden de estudiante 3-->  
                
                <br/>
                <div class="col-sm-6">
	            <h4>Palabras Clave [Descriptivas]</h4>
	          	</div>
                    <!-- div palabras claves-->
	        	<div class="row">
		          <div class="col-sm-4">
		             <div class="form-group">
                    <label for="exampleInputEmail1">Palabra Clave 1</label>
                    <input type="text" id="clave1" name="clave1" class="form-control" 
                    placeholder="Ingrese una palabra clave" required>
                  </div>
		          </div>
		          <div class="col-sm-4">
		             <div class="form-group">
                    <label for="exampleInputEmail1">Palabra Clave 2</label>
                    <input type="text" id="clave2" name="clave2" class="form-control" 
                    placeholder="Ingrese una palabra clave" required>
                  </div>
		          </div>
		          
		           <div class="col-sm-4">
		             <div class="form-group">
                    <label for="exampleInputEmail1">Palabra Clave 3</label>
                    <input type="text" id="clave3" name="clave3" class="form-control" 
                    placeholder="Ingrese una palabra clave" required>
                  </div>
		          </div>
		        </div>
               <!-- div palabras claves-->
                 
                 <br/>
                <div class="col-sm-6">
	            <h4>Información FCE [Descripción Global]</h4>
	          	</div>
	          	
	          	        <!-- div detalles FCE-->
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
			            	    
			            	    for(Tbl_tipo_fce ttf : listTipoFce)
			            	    {
			            		%>
			            		 <option value="<%=ttf.getId()%>"><%=ttf.getTipo()%></option>
			            		<%	
			            		} 
			            		%>
	           				</select>
        			</div>
		          </div>
		          
		           <div class="col-sm-4">
		             
		             <div class="form-group">
	                   <label for="exampleInputPassword1">Ambito de FCE: </label>
	           				<select class="form-control select2" name="ambito_fce" id="ambito_fce" style="width: 100%;" required="required">
	           				  <option value="0">Seleccione un ámbito de FCE...</option>
	            				<%
			            		DT_ambito dtam = new DT_ambito();
			            	    ArrayList<Tbl_ambito> listAmbito = new ArrayList<Tbl_ambito>();
			            	    listAmbito = dtam.listarAmbitos();
			            	    
			            	    for(Tbl_ambito tam : listAmbito)
			            	    {
			            		%>
			            		 <option value="<%=tam.getId()%>"><%=tam.getAmbito()%></option>
			            		<%	
			            		} 
			            		%>
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
	
	<!-- Footer -->
  		<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  	<!-- ./Footer -->

</div>
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  
  <!-- cpn ajax mandamos el valor del carne al servlet, para que nos de el callback con el nombre del usuario  -->
  <script>
  
  function ponerNombreEstudiante1(){
	 
	  var carne = $('#carne1').val();
	  
	  $.ajax({
		  type: "GET",
		  url: "../../SL_tema",
		  data:{filtro : carne} ,
		  contentType : "application/json",
		  dataType: "json",
		  error : function(){ 
              alert('Error'); 
          },
          success: function(msg){
            
        	  $('#nombre1').val(msg);
        	  
          }
	  }); 
  }
  
  </script>
  <!-- cpn ajax mandamos el valor del carne al servlet, para que nos de el callback con el nombre del usuario  -->
   <script>
  
  function ponerNombreEstudiante2(){
	 
	  var carne = $('#carne2').val();
	  
	  $.ajax({
		  type: "GET",
		  url: "../../SL_tema",
		  data:{filtro : carne} ,
		  contentType : "application/json",
		  dataType: "json",
		  error : function(){ 
              alert('Error'); 
          },
          success: function(msg){
            
        	  $('#nombre2').val(msg);
        	  
          }
	  }); 
  }
  
  </script>
 <!-- cpn ajax mandamos el valor del carne al servlet, para que nos de el callback con el nombre del usuario  -->
   <script>
  
  function ponerNombreEstudiante1(){
	 
	  var carne = $('#carne3').val();
	  
	  $.ajax({
		  type: "GET",
		  url: "../../SL_tema",
		  data:{filtro : carne} ,
		  contentType : "application/json",
		  dataType: "json",
		  error : function(){ 
              alert('Error'); 
          },
          success: function(msg){
            
        	  $('#nombre3').val(msg);
        	  
          }
	  }); 
  }
  
  </script>
  
  <!-- Aun esta en proceso -->
  <script>
  
  function ponerNombreArchivo(nombre){
	  
	  var archivo = nombre.files[0];
	  
	  $('#nombreArchivo').val() = archivo.name;
	  alert(archivo.name);
	  
  }
  
  </script>
 <!--fin de aun en proceso--> 
  
   <!-- Este metodo valida cada vez que el select cambia de valor, y asi mostrarle al usuario solo la cantidad necesaria -->
  <script>
  
  function aparecer_ocultar_est()
  {
  	
	  if($("#cantidad_integrantes").val() == "0"){
		document.getElementById('estudiante1').style.display = "none";
		document.getElementById('estudiante2').style.display = "none";
		document.getElementById('estudiante3').style.display = "none";
	  }
	  
	  if($("#cantidad_integrantes").val() == "1"){
		document.getElementById('estudiante1').style.display = "block";
		document.getElementById('estudiante2').style.display = "none";
		document.getElementById('estudiante3').style.display = "none";
		}
	  
	  if($("#cantidad_integrantes").val() == "2"){
		document.getElementById('estudiante1').style.display = "block";
		document.getElementById('estudiante2').style.display = "block";
		document.getElementById('estudiante3').style.display = "none";
		}
	  
	  if($("#cantidad_integrantes").val() == "3"){
		document.getElementById('estudiante1').style.display = "block";
		document.getElementById('estudiante2').style.display = "block";
		document.getElementById('estudiante3').style.display = "block";
		}
	  
  }
	
  </script>
    
  <script>
    $(document).ready(function ()
    {
     
    	document.getElementById('estudiante1').style.display = "none";
    	document.getElementById('estudiante2').style.display = "none";
    	document.getElementById('estudiante3').style.display = "none";
    
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      nuevo = "<%=mensaje%>";

      if(nuevo == "1")
      {
        successAlert('Éxito', 'El nuevo registro ha sido almacenado!!!');
      }
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!');
      }
    
      

    });
    </script>
    
    

</body>
</html>