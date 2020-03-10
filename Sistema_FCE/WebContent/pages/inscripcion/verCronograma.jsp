<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

    <% /*
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
	

		return;
	}
	*/

%>
    
    
    <%

/* RECUPERAMOS EL VALOR DE LA VARIABLE cronogramaID */
String idCronograma = "";
idCronograma = request.getParameter("id_cronograma");
idCronograma = idCronograma==null?"0":idCronograma;

int cronograma = 0;
cronograma = Integer.parseInt(idCronograma); 

/* OBTENEMOS LOS DATOS DEl cronograma a ver */


Tbl_cronograma tcro = new Tbl_cronograma();
DT_cronograma dtcro = new DT_cronograma();
DT_tipo_fce dtfc = new DT_tipo_fce();

//un id solo de prueba para cargar
tcro = dtcro.obtenerDetallesCronograma(cronograma);
//para poner la url sin las comillas que trae de la base de datos
String tipoFCE = dtfc.obtenerTipoFceNombre(tcro.getTipo_cronograma());
ArrayList<Tbl_actividad_cronograma> listaActividades = new ArrayList<Tbl_actividad_cronograma>();

//obtenemos todas las actividades del cronograma correspondiente
listaActividades = dtcro.listarActividadesCronograma(cronograma);

%>
  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Visualizar Cronograma de Actividades</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  
    <!-- jAlert css  -->
	<link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

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
  <style>
  </style>
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
          <div class="col-sm-12">
            <h1>Cronograma de Actividades</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Gestión cronogramas</a></li>
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
				     <!-- calendar column -->
          <div class="col-md-8">
            <div class="card card-primary">
              <div class="card-body p-0">
                <!-- THE CALENDAR -->
                <div id="calendar"></div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- end calendar column -->
          <!-- create events column -->
          <div class="col-md-4">

				<div class="form-group">
           				<select onchange="cambiarVista()" class="form-control select2" id="vistas" name="vistas" style="width: 100%;" required="required">
           				  <option value="1">Detalles Cronograma</option>
           				  <option value="2">Detalles Actividades</option>		
           				  
           				</select>
        		</div>
        		
            <div class="sticky-top mb-3">
		<!-- 
              <div class="form-group">
                <select class="form-control" id="idVista" onchange="onChangeView()">
                  <option value="1">Crear Actividad Vista-1</option>
                  <option value="2">Crear Actividad Vista-2</option>
                </select>
              </div>
              -->
              
                     <!-- /.al seleccionar se llenaran estos campos --> 
              <div class="card" id="vista1">
                <div class="card-header">
                  <h3 class="card-title">Datos Actividad</h3>
                </div>
                <div class="card-body">

                  <form id="addEvent">

                    <div class="form-group">
                    
                      <label >Título de la actividad</label>
                      <input id="nombreActividad" type="text" class="form-control form-control-sm" required autocomplete="off">
                    </div>

                    <div class="form-group">
                      <label>Rango de Fecha:</label>
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                          </span>
                        </div>
                        <input type="text" class="form-control float-right form-control-sm" id="fechaActividad" required autocomplete="off">
                      </div>
                    </div>

                    <div class="form-group">
                      <label >Descripción de la actividad</label>
                      <textarea id="descripcionActividad" class="form-control form-control-sm"></textarea>
                    </div>

                  </form>
                </div>
              </div>
              
		<!-- /.para visualizar los detalles de cronograma -->
              <div class="card" id="detalle_cronograma">
                <div class="card-header">
                  <h3 class="card-title">Datos Cronograma</h3>
                </div>
                <div class="card-body">

                  <form >

                    <div class="form-group">
                      <label >Descripción del Cronograma</label>
                      <input id = "descripcionCronograma" type="text" class="form-control form-control-sm" required autocomplete="off">
                    </div>

   					<div class="form-group">
                      <label >Tipo de Cronograma</label>
                      <input id = "tipoCronograma" type="text" class="form-control form-control-sm" required autocomplete="off">
                    </div>
                    
                     <div class="form-group">
                      <label>Rango de Fecha:</label>
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                          </span>
                        </div>
                        <input  type="text" class="form-control float-right form-control-sm" id="fechaCronograma" required autocomplete="off">
                      </div>
                    </div>


                  </form>
                </div>
              </div>
                	<input type="hidden" id="id_cronograma" name="id_cronograma">
                    <input type="hidden" id="fecha_inicio_cron" name="id_cronograma">
                    <input type="hidden" id="fecha_fin_cron" name="id_cronograma">
            

            </div>
          </div>
          <!-- /.col -->

       

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

<script src="./js/verCronograma.js"></script>


<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>

<script>
function cambiarVista(){
	
	if( $("#vistas").val() == "2"){
		
		$("#vista1").fadeIn();
		$("#detalle_cronograma").fadeOut();
		
	}
	if($("#vistas").val() == "1"){
		$("#vista1").fadeOut();
		$("#detalle_cronograma").fadeIn();
		
	}
	
}

</script>	

<script>
    $(document).ready(function ()
    {
    	$("#vista1").css({"display": "none"})
    	//Declaracion de variables para enviar al metodo para poner los eventos al calendario
    	let descripcion = "";
    	let nombre = "";
    	let fechaInicio = "";
    	let fechaFin = "";
    	let id = 0;
    	let colores = "";
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    
    	$("#id_cronograma").val("<%=tcro.getId()%>");
    	$("#tipoCronograma").val("<%=tipoFCE%>");
    	$("#descripcionCronograma").val("<%=tcro.getDescripcion()%>");
    	$("#fechaCronograma").val("<%="Del "+tcro.getFecha_inicio().toString() +" al "+ tcro.getFecha_fin().toString()%>");
    	
    	<%
    	//por cada iteracon coloca un evento en el calendario
    	String[] colores = {"#5be81e", "#22e694", "#ed6d5f", "#d18de0", "#e1eb5e", "#f2c144", "#87c3f5", "#f7e4f3", "#b4f0cf", "#aeed7e"};
    	int incColor = 0;
    	for(Tbl_actividad_cronograma tacro :listaActividades){
    		
    		%>	
    		
    		descripcion = "<%=tacro.getDescripcion()%>";
    		nombre = "<%=tacro.getNombre()%>";
    		fechaInicio = "<%=tacro.getFecha_inicio()%>";
    		fechaFin = "<%=tacro.getFecha_fin()%>";
    		id = <%=tacro.getId()%>;
    		colores = "<%=colores[incColor]%>";
    		
    		addEvent(descripcion, nombre, fechaInicio, fechaFin, id, colores);
    		
    		<%	
    		incColor++;
    	}
    		%>
    	
    	
    
    });
    </script>

</body>

</html>