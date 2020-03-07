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
	int idPlan = 0;

	if (request.getParameter("planID") != null){
		idPlan = Integer.parseInt(request.getParameter("planID"));
	}else{
		response.sendRedirect("./tblplan_graduacion.jsp");
		return;
	}
	
	
	int actividades = 0;
	DT_plan_graduacion DTpg = new DT_plan_graduacion();
	Tbl_plan_graduacion pg = new Tbl_plan_graduacion();
	
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
		actividades = DTa.countActividadPG(idPlan);
		pg = DTpg.obtenerPlanG(idPlan);
		
		pg.getCohorte();
		pg.getFecha_inicio();
		pg.getFecha_fin();
		pg.getDescripcion();
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
  
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  
  <!-- date picker -->
  <link href="../../plugins/date-picker/datepicker.css">
  
    <!-- timepicker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  
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
        
        <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Nuevo Plan de Graduación</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_planG" method="post">
                <div class="card-body">
                
                  
                  <input name="opc" id="opc" type="hidden" value="2">
                  <input name="idpg" id="idpg" type="hidden" value="<%=idPlan%>">
                  
                  <div class="form-group">
                    <label for="cohorte">Cohorte:</label>
                    <input type="text"  id="cohorte" name="cohorte" class="form-control" value="<%=pg.getCohorte()%>" required>
                  </div>
                  
                  <%if(actividades < 1){ //comienzo del if %>
	                  <div class="form-group">
	                      <label>Fecha de inicio</label>
	                      <div class="input-group">
	                        <div class="input-group-prepend">
	                          <span class="input-group-text">
	                            <i class="far fa-calendar-alt"></i>
	                          </span>
	                        </div>
	                        <input data-toggle="datepicker" class="form-control float-right form-control-sm" id="Finicio" name="Finicio" required  >
	                      </div>
	                  </div>
	                    
	                 <div class="form-group">
	                      <label>Fecha de Fin</label>
	                      <div class="input-group">
	                        <div class="input-group-prepend">
	                          <span class="input-group-text">
	                            <i class="far fa-calendar-alt"></i>
	                          </span>
	                        </div>
	                       <input data-toggle="datepicker" class="form-control float-right form-control-sm" id="Ffin" name="Ffin" required >
	                      </div>
	                 </div>
                  <%}//endif %>
                  
                  <%if(actividades > 0){ //comienzo del if %>
                  	<div class="form-group">
	                      <label>Fecha de inicio</label>
	                      <div class="input-group">
	                        <div class="input-group-prepend">
	                          <span class="input-group-text">
	                            <i class="far fa-calendar-alt"></i>
	                          </span>
	                        </div>
	                        <input class="form-control float-right form-control-sm" id="Finicio" name="Finicio"  readonly data-toggle="tooltip" data-placement="top" title="Tooltip on top">
	                      </div>
	                </div>
	                    
	                <div class="form-group">
	                      <label>Fecha de Fin</label>
	                      <div class="input-group">
	                        <div class="input-group-prepend">
	                          <span class="input-group-text">
	                            <i class="far fa-calendar-alt"></i>
	                          </span>
	                        </div>
	                        <input class="form-control float-right form-control-sm" id="Ffin" name="Ffin" readonly data-toggle="tooltip" data-placement="top" title="Tooltip on top">
	                      </div>
	                </div>
                  <%}// endif %>
                  
                  <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea  id="descripcion" name="descripcion" class="form-control" 
                     required></textarea>
                  </div>
                  
                  <button type="submit" class="btn btn-primary">Actualizar</button>
	              <button type="reset" class="btn btn-danger">Cancelar</button>
                </div>
                
                                
              </form>
          </div>
        
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

<!-- datepicker -->
<script src="../../plugins/date-picker/datepicker.js"></script>
<script src="../../plugins/date-picker/datepicker.es.js"></script>


<!-- date-range-picker -->
<script src="../../plugins/inputmask/jquery.inputmask.bundle.js"></script>
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/daterangepicker/daterangepicker.js"></script>


<script>

	let locale = {
	        "format": "DD/MM/YYYY",
	        "separator": " - ",
	        "applyLabel": "Guardar",
	        "cancelLabel": "Cancelar",
	        "fromLabel": "Desde",
	        "toLabel": "Hasta",
	        "customRangeLabel": "Custom",
	        "daysOfWeek": [
	            "Dom",
	            "Lun",
	            "Mar",
	            "Mier",
	            "Jue",
	            "Vie",
	            "Sab"
	        ],
	        "monthNames": [
	            "Enero",
	            "Febrero",
	            "Marzo",
	            "Abril",
	            "Mayo",
	            "Junio",
	            "Julio",
	            "Augosto",
	            "Septiembre",
	            "Octubre",
	            "Noviembre",
	            "Deciembre"
	        ],
	        "firstDay": 1
	    }
	
	$('[data-toggle="datepicker"]').daterangepicker({
		singleDatePicker: true,
	    locale: locale 
	})
	
	$(function () {
  		$('[data-toggle="tooltip"]').tooltip()
	})
	
	
	function setVal(){
		let fechainicio = "<%=pg.getFecha_inicio()%>";
		let fechafin = "<%=pg.getFecha_fin()%>";
		
		fechainicio = fechainicio.substring(8,10) + "/" + fechainicio.substring(5,7) + "/" + fechainicio.substring(0,4)
		fechafin = fechafin.substring(8,10) + "/" + fechafin.substring(5,7) + "/" + fechafin.substring(0,4)
		
		
		document.getElementById("Finicio").value = fechainicio;
		document.getElementById("Ffin").value = fechafin;
		document.getElementById("descripcion").value = "<%=pg.getDescripcion()%>";
		
		
		
	};
	
	setVal();
</script>

</body>
</html>