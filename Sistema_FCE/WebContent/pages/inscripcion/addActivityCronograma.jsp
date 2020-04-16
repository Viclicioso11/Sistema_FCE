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
    
<% 
	String paramId = request.getParameter("cronogramaID");
	int idC = 0;
	boolean redireccionar = false;
	if(paramId != null){
		idC = Integer.parseInt(paramId);
	}else{
		redireccionar = true;
	}
	
	int msj = request.getParameter("msj") == null ? 0 : Integer.parseInt(request.getParameter("msj"));
		
	Tbl_cronograma tblCrono = new Tbl_cronograma();
	DT_cronograma DTcro = new DT_cronograma();
	Tbl_actividad_pg tblAct = new Tbl_actividad_pg();
	DT_actividad_pg DTpg = new DT_actividad_pg();
	
	ArrayList<Tbl_actividad_cronograma> actividades = new ArrayList<Tbl_actividad_cronograma>();
	
	if(idC == 0){
		redireccionar = true;
	}else if(DTcro.ExisteCrono(idC) == false){
		redireccionar = true;
	}else{
		tblCrono = DTcro.obtenerDetallesCronograma(idC);
		actividades = DTcro.listarActividadesCronograma(idC);
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Actividades del Cronograma de Actividades</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">

  <!-- fullCalendar -->
  <link rel="stylesheet" href="../../plugins/fullcalendar/main.min.css">
  <link rel="stylesheet" href="../../plugins/fullcalendar-daygrid/main.min.css">
  <link rel="stylesheet" href="../../plugins/fullcalendar-timegrid/main.min.css">
  <link rel="stylesheet" href="../../plugins/fullcalendar-bootstrap/main.min.css">

  <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

<!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <!-- DATATABLE NEW -->
  <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
  <!-- DATATABLE NEW buttons -->
  <link href="../../plugins/DataTablesNew/Buttons-1.5.6/css/buttons.dataTables.min.css" rel="stylesheet">

  <script>
	let redireccionar = <%=redireccionar%>
	
	if(redireccionar){
		window.location.href= "./tblcronograma.jsp";
	}
  </script>
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
            <h1>Actividades del Cronograma de Actividades</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Cronograma de Actividades</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">


          <!-- create events column -->
          <div class="col-md-4">

            <div class="sticky-top mb-3">


              <div class="card" id="vista1">
                <div class="card-header">
                  <h3 class="card-title">Crear Actividad</h3>
                </div>
                <div class="card-body">

                  <form id="addEvent" role="form"  method="POST" action="../../SL_actividad_crono">
                  
					<input type="hidden" id="opc" name="opc">
					<input type="hidden" name="idactividad" id="idactividad">
					<!-- para recargar la misma p�gina al editar o guardar -->
					<input type="hidden" name="idCrono" id="idCrono" value="<%=idC%>">
					
                    <div class="form-group">
                      <label >Titulo de la actividad</label>
                      <input type="text" id="nombre" name="nombre" class="form-control form-control-sm" required autocomplete="off">
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

                    <div class="form-group">
                      <label >Descripci�n de la actividad</label>
                      <textarea class="form-control form-control-sm" id="descripcion" name="descripcion"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" id="btn-agregar">Agregar</button>
                    <button type="reset" class="btn btn-danger" id="btn-cancelar" onclick="cancelar()">Cancelar</button>&nbsp;&nbsp;
                    
                  </form>
                </div>
              </div>
              

            </div>
          </div>
          <!-- /.col -->
		  <!-- table -->
		  <div id="tblAct" class="col-md-8">	
		  	<div class="card">
		  		<div class="card-body">
		  			<table id="tableA" class="table table-bordered">
				  		<thead>
			                <tr>
			                  <th>t�tulo</th>
			                  <th>Descripci�n</th>
			                  <th>Inicio</th>
			                  <th>Fin</th>
			                  <th>Opciones</th>
			                </tr>
		                </thead>
		                <tbody>
		                <% 
		                	for(Tbl_actividad_cronograma actividad: actividades){
		                %>
		                	<tr id="actividadId<%=actividad.getId()%>">
		                	  <th><%=actividad.getNombre() %></th>
		                	  <th><%=actividad.getDescripcion() %></th>
		                	  <th><%=actividad.getFecha_inicio().toString() %></th>
		                	  <th><%=actividad.getFecha_fin().toString() %></th>
		                	  <th>
		                	  	<a href="#" onclick="editar(<%=actividad.getId()%>)"><i class="far fa-edit"></i></a>&nbsp;&nbsp;
		                	  	<a href="#" onclick="eliminarActividad(<%=actividad.getId()%>)"><i class="far fa-trash-alt"></i></a>
		                	  </th>
		                	</tr>
		                <%} %>
		                </tbody>
				  	</table>
		  		</div>
		  	</div>
		  	
		  </div>
		 
		  
          <!-- calendar column 
          <div class="col-md-7">
            <div class="card card-primary">
              <div class="card-body p-0">
                <!-- THE CALENDAR 
                <div id="calendar"></div>
              </div>
              <!-- /.card-body 
            </div>
            <!-- /.card 
          </div>  end calendar column -->
         

        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
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


<!-- fullCalendar 2.2.5 -->
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/fullcalendar/main.min.js"></script>
<script src="../../plugins/fullcalendar-daygrid/main.min.js"></script>
<script src="../../plugins/fullcalendar-timegrid/main.min.js"></script>
<script src="../../plugins/fullcalendar-interaction/main.min.js"></script>
<script src="../../plugins/fullcalendar-bootstrap/main.min.js"></script>
<script src="../../plugins/fullcalendar/locales/es.js"></script>

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

<!-- jAlert js -->
<script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
<script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>

<script>

	let minDate = "<%=tblCrono.getFecha_inicio()%>"
	let maxDate = "<%=tblCrono.getFecha_fin()%>"
	let idPG = <%=idC%>
</script>
<script src="./js/addActivityCrono.js"></script>

<script>
/*
 * inicializando el date-range-picker
 */
 
minDate = formatDate(new Date(minDate));
maxDate = formatDate(new Date(maxDate));

$('#dateRange').daterangepicker({
    "locale": local,
    minDate: minDate,
    maxDate: maxDate,
    startDate : minDate
})

/*
 * inicializando tabla
 */
$('#tableA').DataTable({
  dom: 'Bfrtip',
  buttons: ['pdf','excel','print'],
  "order": []
})
$("#tableA").css({
  "border": "none",
  "padding-top": "20px",
})
$("tbody th").css({"font-weight": "500"})

//asignando valores necesarios
$("#opc").val(1)
$("#idP").val(<%=idC%>)
$("#calendar").css({"display": "none"})


function editar(id){
	
	//poner la informacion en el form
	
	//primero se rescata la informacion
	let row = $("#actividadId"+id)
	
	let titulo = row.children()[0].innerText
	let descripcion = row.children()[1].innerText
	let inicio = row.children()[2].innerText
	let fin = row.children()[3].innerText
	
	/**/
	inicio= parseDF(inicio,2);
	fin = parseDF(fin,2);

	/*seteando valores en form*/
	$("#dateRange").data('daterangepicker').setStartDate(inicio)
	$("#dateRange").data('daterangepicker').setEndDate(fin)
	$("#nombre").val(titulo)
	$("#descripcion").val(descripcion)
	$("#idactividad").val(id)
	/**/
	$("#btn-agregar")[0].innerText = "Actualizar"
	$("#opc").val(2) //opc 2 editar
}

function eliminarActividad(idActividadCrono){
	

	  $.jAlert({
		    'type': 'confirm',
		    'confirmQuestion': '�Est� seguro de eliminar actividad seleccionada?',
		    'onConfirm': function(e, btn){
		      e.preventDefault();
   		  window.location.href= "../../SL_actividad_crono?id_actividad_crono="+idActividadCrono+"&id_cronograma=<%=idC%>";
		      btn.parents('.jAlert').closeAlert();
		    },
		    'onDeny': function(e, btn){
		      e.preventDefault();
		      btn.parents('.jAlert').closeAlert();
		    }
		  });
	
}





function cancelar(){
	$("#btn-agregar")[0].innerText = "Agregar"
	$("#opc").val(1)//opc 1 Guardar
}

//funciones de mensajes
function alertC(type, mensaje, title) {
  	console.log("pasa por aqui")
  		$.jAlert({
  		'type':  "modal",
      'theme': type,
  		'title': title,
  		'content': mensaje,
      'onClose': function() {
      	window.history.pushState({page: "another"}, "addactivityPG", "/Sistema_FCE/pages/inscripcion/addActivityPG2.jsp?idPG="+idPG)
    	}
  	});
  }
    /////////// VARIABLES DE CONTROL MSJ ///////////
  let nuevo = <%=msj%>
  
    if(nuevo == 1){
    	alertC("green","La actividad se ha agregado" ,"Exito")
    }
    if(nuevo == 2){
    	alertC("green","La actividad se ha editado" ,"Exito")
    }
    if(nuevo == 3){
    	alertC("red","Error al guardar la actividad " ,"Error")
    }
    if(nuevo == 4){
    	alertC("red","Error al editar la actividad" ,"Error")
    }
    if(nuevo == 5){
    	alertC("green","Actividad eliminada correctamente" ,"�xito")
    }
    if(nuevo == 6){
    	alertC("red","Error al eliminar la actividad" ,"Error")
    }
  
</script>
</body>
</html>