<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
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
	String paramId = request.getParameter("idPG");
	int idP = 0;
	boolean redireccionar = false;
	if(paramId != null){
		idP = Integer.parseInt(paramId);
	}else{
		redireccionar = true;
	}
	
	Tbl_plan_graduacion tblPG = new Tbl_plan_graduacion();
	DT_plan_graduacion DTpg = new DT_plan_graduacion();
	
	if(idP ==0){
		redireccionar = true;
	}else if(DTpg.ExistePG(idP) ==false){
		redireccionar = true;
	}else{
		tblPG = DTpg.obtenerPlanG(idP);
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Actividades del Plan de Graduación</title>
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

  <script>
	let redireccionar = <%=redireccionar%>
	
	if(redireccionar){
		window.location.href= "./tblplan_graduacion.jsp";
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


          <!-- create events column -->
          <div class="col-md-5">

            <div class="mb-3">


              <div class="card" id="vista1">
                <div class="card-header">
                  <h3 class="card-title">Crear Actividad</h3>
                </div>
                <div class="card-body">

                  <form id="addEvent">

                    <div class="form-group">
                      <label >Titulo de la actividad</label>
                      <input type="text" class="form-control form-control-sm" required autocomplete="off">
                    </div>

                    <div class="form-group">
                      <label>Rango de Fecha:</label>
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                          </span>
                        </div>
                        <input type="text" class="form-control float-right form-control-sm" id="dateRange" required autocomplete="off">
                      </div>
                    </div>

                    <div class="form-group">
                      <label >Descricion de la actividad</label>
                      <textarea class="form-control form-control-sm"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Agregar</button>
                    <button type="reset" class="btn btn-danger">Cancelar</button>

                  </form>
                </div>
              </div>
              
              <!-- Guardar -->
              <button type="button" class="btn btn-block btn-primary" onclick="guardar()">Guardar</button>

              <!-- trash -->
              <div class="card"style="margin-top: 10px;">
                <div class="card-body" id="trash" style="background-color: #dc3545;border-radius: .25rem;padding: 0.25rem;">
                  <p style="margin-bottom: 0 !important;text-align: center;color:  #fff;font-size: 150%;">
                    <i class="far fa-trash-alt"></i>
                  </p>
                </div>
              </div>

              

            </div>
          </div>
          <!-- /.col -->

          <!-- calendar column -->
          <div class="col-md-7">
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

<script>
	let minDate = "<%=tblPG.getFecha_inicio()%>"
	let maxDate = "<%=tblPG.getFecha_fin()%>"
	let idP = <%=idP%>
</script>
<script src="./js/addActivityPG.js"></script>

<script>

minDate = formatDate(new Date(minDate));
maxDate = formatDate(new Date(maxDate));

$('#dateRange').daterangepicker({
    "locale": local,
    minDate: minDate,
    maxDate: maxDate,
    startDate : minDate
})
</script>
</body>
</html>