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
	/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
	String mensaje = "";
	mensaje = request.getParameter("msj");
	mensaje = mensaje==null?"":mensaje;
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Gesti�n Estudiantes Candidatos</title>
  <!-- Imagen del t�tulo-->
 <link  rel="icon"   href="../../dist/img/favicon.png" type="image/png" />
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  
  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.dataTables.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  
  
  
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

 <style>
    .cardPad{padding: 0% 2% !important;}
    .redirect{color: #17a2b8;}
    .redirect > i{margin-right: 5px;}
  </style>

</head>
<body class="hold-transition sidebar-mini layout-fixed">
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

    <br><br><br>
    <!-- Main content -->
    <section class="content cardPad">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
            
            	<%
            		boolean x = true;
            		if (x){
            	%>
              		<h2> Historial de Estudiantes Candidatos</h2>
              	<%}else{ %>
              		<h2> Estudiantes Candidatos</h2>
              	<%} %>
              	
              	
              <!--<a href="#">Agregar Estudiante Candidato <i class="fas fa-plus-circle"></i></a>-->
            </div>
            <!-- /.card-header -->
            <div class="card-body" style="overflow-x: scroll">
              <a href="./newEstudianteCandidato.jsp" >Agregar Estudiante Candidato <i class="fas fa-plus-circle"></i></a>
              <br><br>
              <table id="Tbl_ec" class="table table-bordered">
                <thead>
                  <tr>
                    <th style="width: 15px">#</th>
                    <th>Correo</th>
                    <th>Fecha</th>
                    <th style="width: 20px">Eliminar</th>
                  </tr>
                </thead>
                <tbody>

                  <%
              	      DT_estudiante_candidato dtec = new DT_estudiante_candidato();
                	    ArrayList<Tbl_estudiante_candidato> estudiantes = new ArrayList<Tbl_estudiante_candidato>();
                      estudiantes = dtec.getEstudiante();

                	    for(Tbl_estudiante_candidato estudiante : estudiantes) {
                  %>
  	                <tr>
  	                  <td style="text-align:center"><%=estudiante.getId()%></td>
                      <td><%=estudiante.getCorreo()%></td>
                      <td><%=estudiante.getFecha()%></td>
                      <td style="text-align:center">
                        <a href="#" onclick="deleteOpciones('<%=estudiante.getId()%>');" style="color: #17a2b8;">
                          <i class="far fa-trash-alt" title="Eliminar"></i>
                        </a>
                      </td>
  	                </tr>
  	              <%}%>
                </tbody>
              </table>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
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

<!-- DataTables -->
<script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>

<!-- DATATABLE NEW buttons --> 
<script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>

<!-- js DATATABLE NEW buttons print -->
<script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>

<!-- js DATATABLE NEW buttons pdf -->
<script src="../../plugins/datatables-buttons/pdf/pdfmake.min.js"></script>
<script src="../../plugins/datatables-buttons/pdf/vfs_fonts.js"></script>

<!-- js DATATABLE NEW buttons excel -->
<script src="../../plugins/datatables-buttons/excel/jszip.min.js"></script>

<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>



<!-- jAlert js -->
<script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
<script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>

<script>
  function deleteOpciones(id) {
  	  $.jAlert(
        {
  		    'type': 'confirm',
  		    'confirmQuestion': 'Est� seguro de eliminarlo?',
  		    'onConfirm': function(e, btn){
  		      e.preventDefault();
       		  window.location.href= "../../SL_estudiante_candidato?id="+ id;
  		      btn.parents('.jAlert').closeAlert();
  		    },
  		    'onDeny': function(e, btn){
  		      e.preventDefault();
  		      btn.parents('.jAlert').closeAlert();
  		    }
  		  });
  }
</script>


<script>
  $(function () {
    $('#Tbl_ec').DataTable({
        dom: 'Bfrtip',
        buttons: ['pdf','excel','print'],
        "order": []
      })
  });
</script>

<script>

  function alertC(type, mensaje, title) {
  	console.log("pasa por aqui")
  		$.jAlert({
  		'type':  "modal",
      'theme': type,
  		'title': title,
  		'content': mensaje,
      'onClose': function() {
      	window.history.pushState({page: "another"}, "tblEstudianteCandidato", "/Sistema_FCE/pages/inscripcion/tblEstudianteCandidato.jsp")
    	}
  	});
  }
    /////////// VARIABLES DE CONTROL MSJ ///////////
  let nuevo = "";
  nuevo = "<%=mensaje%>"
  
  if(nuevo == "1"){
  	alertC("green", "Mensaje Eviando a todos los correos", "�xito")
  }
  if(nuevo == "2"){
  	alertC("red", "error al enviar los mensajes", "Error")
  }
  if(nuevo == "3"){
  	alertC("green", "correo eliminado", "�xito")
  }
  if(nuevo == "4"){
  	alertC("red", "No se ha podido eliminar correo", "Error")
  }

  if(nuevo == "5")
  {
    alertC("green", 'El Estudiante ha sido resgistrado correctamente.','�xito');
  }
  
  
</script>
</body>
</html>
