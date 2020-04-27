
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;" %>

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

<%

	/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
	String mensaje = "";
	mensaje = request.getParameter("msj");
	mensaje = mensaje==null ? "":mensaje;

	DT_cronograma dtcrono = new DT_cronograma();
	DT_tema dttema = new DT_tema();
	
	// es el id del cronograma actual
	int id_cronograma = dtcrono.obtenerIdCronogramaFechas();
	
%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Creación de tarea grupal</title>
  
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  
   <!-- DATATABLE NEW -->
    <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
    <!-- DATATABLE NEW buttons -->
    <link href="../../plugins/DataTablesNew/Buttons-1.5.6/css/buttons.dataTables.min.css" rel="stylesheet">
  
  
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  
  <!-- date picker -->
  <link href="../../plugins/date-picker/datepicker.css">
  
   <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />
  
    <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  
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
              
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    
    <section class="content">
    <form id="formGuardar" action="../../SL_tarea_admin" method="POST">
      <div class="row">
      
       <!-- /.col -->
        <div class="col-5">
          <div class="card">
            <div class="card-header">
            <h2>Seleccionar temas</h2>
            </div>
            <!-- /.card-header -->
            <div class="card-body" id="divTblOpciones">
            
            <input type="hidden" id="id_grupos" name="id_grupos" required>
            <input type="hidden" id="id_actividad" name="id_actividad" required>
            <input type="hidden" id="opc" name="opc" value="1">
            
            
              <table id="Tbl_opciones" class="table table-bordered">
                <thead>
                <tr>
                  <th>Tema</th>
                  <th>Seleccionar</th>
                </tr>
                </thead>
                <tbody>
                <%
     
                	DT_tema_cronograma dtcro = new DT_tema_cronograma();
                  	ArrayList<Vw_tema_cronograma> listTema = new ArrayList<Vw_tema_cronograma>();
                  	listTema = dtcro.listar_temas_administrador();
                  	
                  	        		
                  	for(Vw_tema_cronograma tem : listTema)
                  	{
                %>
	                <tr>
	                  <td><%=tem.getTema()%></td>
	                  <td id ="<%=tem.getId_tema()%>">
	                  <a href="#"onclick="seleccionaGrupo('<%=tem.getId_tema()%>');"><i class="fas fa-check" title="Seleccionar"></i></a>
	                 
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
        <!-- /.col -->
      
      <!-- tabla de roles -->
      <div class="col-7">
          <div class="card">
            <div class="card-header">
               <h2>Seleccionar actividad del cronograma</h2>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <table id="Tbl_rol" class="table-bordered">
                <thead>
                <tr>
                  <th>Título</th>
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
	                  <td id ="act<%=tcrom.getId()%>" onclick="setFechasLimites('<%=tcrom.getFecha_inicio()%>','<%=tcrom.getFecha_fin()%>', 'act<%=tcrom.getId()%>');" title="Seleccionar esta actividad">
	                  	<a href="#" onclick="setFechasLimites('<%=tcrom.getFecha_inicio()%>','<%=tcrom.getFecha_fin()%>', 'act<%=tcrom.getId()%>');"><i class="fas fa-check"  title="Seleccionar esta actividad"></i></a>
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
           
        <!-- aquí inician los detalles de la tarea -->
        
        <div class = "card">
        
        	<div class = "card-body">
       
      
		         <div class="row">
		         
			         <div class="col-sm-6">
			         
				         <div class="form-group">
				                <label for="tituloTarea">Título tarea:</label>
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
			               <label for="tituloTarea">Descripción tarea:</label>
			               <textarea  id="descripcionTarea" name="descripcionTarea" class="form-control"  required></textarea>
			         	</div>
			         	
			         </div>
         
         
         	 </div>
         	 <button type="button" class="btn btn-primary" onclick="guardarTareaGrupal()">Guardar</button>
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
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- date-range-picker -->
<script src="../../plugins/inputmask/jquery.inputmask.bundle.js"></script>
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/daterangepicker/daterangepicker.js"></script>
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
<!-- page script -->

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  <script src="./js/tarea_grupal.js" defer></script>

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
    $('#Tbl_opciones').DataTable({
        dom: 'Bfrtip',
        buttons: [
        'pdf',
        'excel',
        'print'
        ]
      });
    
    $("#Tbl_opciones").css({
        "border": "none",
        "padding-top": "20px",
      })
      $("tr").css({"height": "49px"})
  });
  	
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

		$('#dateRange').daterangepicker({
		    "locale": local
		})
		 
    /////////// VARIABLES DE CONTROL MSJ ///////////
    var nuevo = 0;
    nuevo = "<%=mensaje%>";
    if(nuevo == "1")
    {
      successAlert('Éxito', 'Registros almacenados correctamente.');
    }
    
    if(nuevo == "2")
    {
    	errorAlert('Error', 'El registro no almacenados.');
    }
    
    if(nuevo == "3")
    {
      successAlert('Éxito', 'El registro ha sido modificado correctamente.');
    }
    
    if(nuevo == "4")
    {
      successAlert('Éxito', 'El registro ha sido eliminado correctamente.');
    }
    
    if(nuevo == "5")
    {
      errorAlert('Error', 'El registro no se ha podido eliminar.');
    }
    
    
    
  
    
  });
  </script>
</body>
</html>