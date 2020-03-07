<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;" %>

<% 
	/*
		Esto es el objeto session
	*/
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
	int idPlan = 0;

	if (request.getParameter("planID") != null){
		idPlan = Integer.parseInt(request.getParameter("planID"));
	}else{
		response.sendRedirect("./tblplan_graduacion.jsp");
		return;
	}
	
	
	DT_plan_graduacion DTpg = new DT_plan_graduacion();
	String Actividades = "";
	String fechaInicio = "";
	
	if(idPlan == 0 ){
		response.sendRedirect("./tblplan_graduacion.jsp");
		return;
		
	}else if (!DTpg.ExistePG(idPlan)){
		response.sendRedirect("./tblplan_graduacion.jsp");
		return;
		
	}else{
		//obtener todos las actividades de un plan G
		DT_actividad_pg DTa = new DT_actividad_pg();
		
		//retrayendo las actividates
		ArrayList<Tbl_actividad_pg> actividades = new ArrayList<Tbl_actividad_pg>();
		actividades = DTa.listarActividadesPg(idPlan);
		Actividades = DTa.ArrayToJson(actividades);
		
		fechaInicio = DTpg.obtenerPlanG(idPlan).getFecha_inicio().toString();
	}
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Plan de Graduación</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">

  <!-- fullCalendar -->
  <link rel="stylesheet" href="../../plugins/fullcalendar/main.min.css">
  <!--
  <link rel="stylesheet" href="../../plugins/fullcalendar-daygrid/main.min.css">
  <link rel="stylesheet" href="../../plugins/fullcalendar-timegrid/main.min.css">
  -->
  <link rel="stylesheet" href="../../plugins/fullcalendar-bootstrap/main.min.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

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
            <h1>Plan de Graduación</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Plan de Graduación</li>
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
          <div class="col-md-12" style="padding: 0% 10%">
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
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>


<!-- fullCalendar 2.2.5 -->

<script src="../../plugins/fullcalendar/main.min.js"></script>
<script src="../../plugins/fullcalendar-bootstrap/main.min.js"></script>
<script src="../../plugins/fullcalendar/locales/es.js"></script>
<script src="../../plugins/fullcalendar-daygrid/main.min.js"></script>

<!-- 
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/fullcalendar-timegrid/main.min.js"></script>
<script src="../../plugins/fullcalendar-interaction/main.min.js"></script>
 -->
 
<!-- AdminLTE for demo purposes -->
<!-- <script src="../dist/js/demo.js"></script> -->
<!-- jQuery UI -->
<!-- <script src="../../plugins/jquery-ui/jquery-ui.min.js"></script>-->


<script src="./js/verPlanG.js"></script>

<script>
	let actividades = <%=Actividades%>;
	
	let fecha_inicio = "<%=fechaInicio%>";
	calendar.gotoDate(new Date(fecha_inicio))
	
	for(let i =0; i < actividades.length; i++){
		agregar(actividades[i]);
	}
</script>
</body>
</html>