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
	mensaje = mensaje==null?"":mensaje;
	
	/*obtenemos el ambito*/
	String idCrono = "";
	idCrono = request.getParameter("id_cronograma");
	idCrono = idCrono==null ? "0":idCrono;
	int cronograma = Integer.parseInt(idCrono); 
	
	/* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
	Tbl_cronograma tcro = new Tbl_cronograma();
	DT_cronograma dtcro = new DT_cronograma();
	tcro = dtcro.obtenerDetallesCronograma(cronograma);
	
	//para las fechas en referencia a las actividades
	//posicion 0 limite inicio, posicion 1 limite final
	String[] limites = dtcro.limitesFecha(cronograma);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Cronograma de Actividades</title>
  
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
 	<jsp:include page="/WEB-INF/layouts/menu-d-2.jsp"></jsp:include>
	<!-- SIDEBAR -->
	
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Cronograma de Actividades</h1>
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
        
        <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Edición Cronograma de Actividades</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_cronograma" method="POST">
                <div class="card-body">
                
                  
                   <input name="opc" id="opc" type="hidden" value="2">
                   
                   <input name="idCrono" id="idCrono" type="hidden">
                  <div class="form-group">
                    <label for="cohorte">Descripción:</label>
                    <input type="text"  id="descripcion" name="descripcion" class="form-control"  required>
                  </div>
                  
                  <div class="form-group">
                   <label for="id_tipo_cronograma">Tipo de Cronograma: </label>
           				<select class="form-control select2" name="id_tipo_cronograma" id="id_tipo_cronograma" style="width: 100%;" required="required">
           				  <option value="0">Seleccione un tipo de cronograma...</option>
            				<%
		            		DT_tipo_fce dtfc = new DT_tipo_fce();
		            	    ArrayList<Tbl_tipo_fce> listTipo = new ArrayList<Tbl_tipo_fce>();
		            	    listTipo = dtfc.listarTipoFce();
		            	    
		            	    for(Tbl_tipo_fce tbtf : listTipo)
		            	    {
		            		%>
		            		 <option value="<%=tbtf.getId()%>"><%=tbtf.getTipo() %></option>
		            		<%	
		            		} 
		            		%>
           				</select>
        		</div>
                   
                    
                  <div class="form-group">
                      <label>Fecha de inicio</label>
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                          </span>
                        </div>
                        <input data-toggle="datepicker" class="form-control float-right form-control-sm" id="fecha_in" name="fecha_in" required >
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
                        <input data-toggle="datepicker" class="form-control float-right form-control-sm" id="fecha_fin" name="fecha_fin" required>
                      </div>
                  </div>
                  
                  <button type="submit" class="btn btn-primary">Editar</button>
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

<script src="./js/editCronograma.js"></script>
  <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
		let inicio = "<%=tcro.getFecha_inicio()%>";
		let fin = "<%=tcro.getFecha_fin()%>";
			
		var fechaInicio = new Date(inicio);
		var fechaFin = new Date(fin);
		
		inicio = fechaInicio.toLocaleDateString(undefined);
		fin = fechaFin.toLocaleDateString(undefined);
		
		
		$("#idCrono").val("<%=tcro.getId()%>");
    	$("#descripcion").val("<%=tcro.getDescripcion()%>");
    	$("#id_tipo_cronograma").val("<%=tcro.getTipo_cronograma()%>");
    	$("#fecha_in").val(inicio);
    	$("#fecha_fin").val(fin);
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      
      nuevo = "<%=mensaje%>";
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente.');
      }
    
      
    });
    </script>

<script>
let inicio = "<%=limites[0]%>";
let fin = "<%=limites[1]%>";

</script>


<script>

	inicio = formatDate(new Date(inicio));
	fin = formatDate(new Date(fin));
	
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
	
	$('#fecha_in').daterangepicker({
		singleDatePicker: true,
		maxDate : inicio,
	    locale: locale
	});
	
	$('#fecha_fin').daterangepicker({
		singleDatePicker: true,
		 minDate : fin,
	    locale: locale
	});
	
</script>



</body>

</html>