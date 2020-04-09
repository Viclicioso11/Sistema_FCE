
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;" %>

    <% 
    /*
    ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
	//Recuperamos el Arraylist de la sesion creada en sistema.jsp
	listOpciones = (ArrayList <Vw_rol_opcion>) session.getAttribute("listOpciones");

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

	} 
	*/
%>

<%
	String msj = "";
	msj = request.getParameter("msj");
	int mensaje = 0;
	
	if(msj != null){
		mensaje  = Integer.parseInt(msj); 
	}
	
	DT_cronograma dtcrono = new DT_cronograma();
	DT_tema dtma = new DT_tema();
	//para traer la info de la tarea
	Tbl_tarea ttar = new Tbl_tarea();
	DT_grupo_tarea dtgru = new DT_grupo_tarea();
	
	// es el id del cronograma actual
	int id_cronograma = dtcrono.obtenerIdCronogramaFechas();
	
	//para obtener el id del tema al cual asignar la nueva tarea
	
	String id_tarea_texto = "";
	id_tarea_texto = request.getParameter("id_tarea");
	int id_tarea = 0;
	
	if(id_tarea_texto != null) {
		id_tarea = Integer.parseInt(id_tarea_texto);
		ttar = dtgru.obtenerInfoTarea(id_tarea);
		
	}
	//para luego de editar volver a las tareas de un tema espec�fico
	String id_tema_texto = "";
	id_tema_texto = request.getParameter("id_tema");
	int id_tema = 0;

	if(id_tema_texto != null) {
		id_tema = Integer.parseInt(id_tema_texto);
	}
	
	
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Creaci�n de Tarea</title>
  
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  
  <!-- date picker -->
  <link href="../../plugins/date-picker/datepicker.css">
  
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />
  
    <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  
  
   <!-- DATATABLE NEW -->
    <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
    <!-- DATATABLE NEW buttons -->
    <link href="../../plugins/DataTablesNew/Buttons-1.5.6/css/buttons.dataTables.min.css" rel="stylesheet">
  
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
	<!-- Navbar -->
 	<jsp:include page="/WEB-INF/layouts/topbar2.jsp"></jsp:include>
	<!-- /.navbar -->

	<!-- SIDEBAR -->
 	<jsp:include page="/WEB-INF/layouts/menu2.jsp"></jsp:include>
	<!-- SIDEBAR	 -->
	
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Edici�n de la tarea: <%=ttar.getTitulo() %></h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Gesti�n tareas de grupo</a></li>
              <li class="breadcrumb-item active">Creaci�n de nueva tarea</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
    <form id="formEditar" action="../../SL_tarea" method="POST">
      <div class="row">
      
      
      <!-- tabla de actividades cronograma -->
      <div class="col-12">
          <div class="card">
            <div class="card-header">
               <h2>Seleccionar actividad del cronograma</h2>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <table id="Tbl_rol" class="table-bordered">
                <thead>
                <tr>
                  <th>T�tulo</th>
                  <th>Fecha Inicio</th>
                  <th>Fecha Fin</th>
                  <th>Seleccionar</th>
                </tr>
                </thead>
                <tbody>
                <%
                  	ArrayList<Tbl_actividad_cronograma> listAct = new ArrayList<Tbl_actividad_cronograma>();
                  	listAct = dtcrono.listarActividadesCronograma(id_cronograma);
                  	        		
                  	for(Tbl_actividad_cronograma tcrom : listAct)
                  	{
                %>
	                <tr>
	                  <td><%=tcrom.getNombre()%></td>
	                  <td><%=tcrom.getFecha_inicio()%></td>
	                  <td><%=tcrom.getFecha_fin()%></td>
	                  <td id ="<%=tcrom.getId()%>" onclick="setFechasLimites('<%=tcrom.getFecha_inicio()%>','<%=tcrom.getFecha_fin()%>', '<%=tcrom.getId()%>');" title="Seleccionar esta actividad">
	                  	<a href="#" onclick="setFechasLimites('<%=tcrom.getFecha_inicio()%>','<%=tcrom.getFecha_fin()%>', '<%=tcrom.getId()%>');"><i class="fas fa-check"  title="Seleccionar esta actividad"></i></a>
	                  </td>
	                </tr>
	             <%
	        		}   
	             %>
                </tbody>
              </table>
              
             	
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->

          </div>
             </div>
           <!-- /.row --> 
           
        <!-- aqu� inician los detalles de la tarea -->
        
        <div class = "card">
        
        	<div class = "card-body">
       
      
		         <div class="row">
		         
			         <div class="col-sm-12">
			         
				         <div class="form-group">
				                <label for="tituloTarea">T�tulo tarea:</label>
				                <input type="text"  id="tituloTarea" name="tituloTarea" class="form-control"  required>
				         </div>
			         
			         	  <div class="form-group">
			                      <label>Rango de Fecha:</label>
			                      <div class="input-group">
			                        <div class="input-group-prepend">
			                          <span class="input-group-text">
			                            <i class="far fa-calendar-alt"></i>
			                          </span>
			                        </div>
			                       <input type="text" class="form-control float-right form-control-sm" id="dateRange" name="dateRange" required autocomplete="off">
			                      </div>
			               </div>
			         </div>
			         
			         <div class="col-sm-6">
			         
			         	<div class="form-group">
			               <label for="tituloTarea">Descripci�n tarea:</label>
			               <textarea  id="descripcionTarea" name="descripcionTarea" class="form-control"  required></textarea>
			         	</div>
			         	
			         </div>
	            <input type="hidden" id="id_actividad" name="id_actividad" required>
	            <input type="hidden" id="opc" name="opc" value="3">
	            <input type="hidden" id="id_tarea" name="id_tarea" value="<%=id_tarea%>">
	            <input type="hidden" id="id_tema" name="id_tema" value="<%=id_tema%>">
            
         
         	 </div>
         	 <button type="button" class="btn btn-primary" onclick="editarTarea()">Guardar</button>
	         <button type="reset" class="btn btn-danger" onclick="limpiarCampos()">Cancelar</button>
         </div>
       </div>
      <!-- /.row -->
      
      
      </form>
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
<!-- Bootstrap -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jQuery UI -->
<script src="../../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<!-- <script src="../dist/js/demo.js"></script> -->

<!-- datepicker -->
<script src="../../plugins/date-picker/datepicker.js"></script>
<script src="../../plugins/date-picker/datepicker.es.js"></script>


<!-- date-range-picker -->
<script src="../../plugins/inputmask/jquery.inputmask.bundle.js"></script>
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/daterangepicker/daterangepicker.js"></script>

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


  <!-- JS con todas las funciones para el edit-->
  <script src="./js/editTarea.js" defer></script>



<script>

	function setFechasLimites(minDate, maxDate, id_elem) {
		
		minDate = formatDate(minDate);
		maxDate = formatDate(maxDate);

		$('#dateRange').daterangepicker({
		    "locale": local,
		    minDate: minDate,
		    maxDate: maxDate,
		    startDate : minDate
		});
		
		seleccionaActividad(id_elem);
		
	}

</script>


<script>
  
  $(function () {
	  
	  $('#Tbl_rol').DataTable({

	      });
	    $("#Tbl_rol").css({
	        "border": "none",
	        "padding-top": "20px",
	      })
	      $("tr").css({"height": "49px"})
	  });

  
</script>


<script>
  
$(document).ready(function ()
	    {
			/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
	    	//tituloTarea
	    	//dateRange
	    	//descripcionTarea
	    	
	    	let RangoFechas = ""+formatDate('<%=ttar.getFecha_inicio()%>') + " - " + formatDate('<%=ttar.getFecha_fin()%>');
	    	
	    	console.log("<%=ttar.getFecha_inicio()%>");
			$("#tituloTarea").val("<%=ttar.getTitulo()%>");
	    	$("#descripcionTarea").val("<%=ttar.getDescripcion()%>");
	    	
	    	
	    	$("#dateRange").val(RangoFechas);
	    	
	    	//para que se seleccione la actividad con la que hab�a sido creada la actividad
	    	
	    	let elemento = document.getElementById("<%=ttar.getId_actividad_cronograma()%>");
			elemento.style.backgroundColor = "green";
	    	
			seleccionaActividad("<%=ttar.getId_actividad_cronograma()%>");
			
	    	///////////// VALIDAR QUE LAS CONTRASE�AS SON LAS MISMAS ///////////////
	     
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