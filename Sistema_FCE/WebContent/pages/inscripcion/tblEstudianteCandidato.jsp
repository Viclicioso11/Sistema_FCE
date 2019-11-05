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
	}*/
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
  <title>AdminLTE 3 | DataTables</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <!--   <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css"> -->

  <!-- DATATABLE NEW -->
  <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
  <!-- DATATABLE NEW buttons -->
  <link href="../../plugins/DataTablesNew/Buttons-1.5.6/css/buttons.dataTables.min.css" rel="stylesheet">

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <style>
    .cardPad{padding: 0% 2% !important;}
    .card-header{background-color: #17a2b8; color: #fff;}
    .redirect{color: #17a2b8;}
    .redirect > i{margin-right: 5px;}
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
              		<h3 class="card-title">Historial de Estudiantes Candidatos</h3>
              	<%}else{ %>
              		<h3 class="card-title">Estudiantes Candidatos</h3>
              	<%} %>
              	
              	
              <!--<a href="#">Agregar Estudiante Candidato <i class="fas fa-plus-circle"></i></a>-->
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <a href="./newEstudianteCandidato.jsp" class="redirect"> <i class="fas fa-plus"></i>Agregar Estudiante Candidato</a>
              <br><br>
              <table id="Tbl_ec" name="Tbl_ec" class="table table-bordered">
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
<!-- <script src="../../plugins/datatables/jquery.dataTables.js"></script> -->
<!-- <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script> -->

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

<script>
  function deleteOpciones(id) {
  	  $.jAlert(
        {
  		    'type': 'confirm',
  		    'confirmQuestion': '�Est� seguro de eliminarlo?',
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

      $(".dt-buttons button").removeClass("dt-button").addClass("btn btn-info")

      $("#Tbl_ec").css({
        "border": "none",
        "padding-top": "20px",
      })
      $("tr").css({"height": "49px"})
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
      	window.history.pushState({page: "another"}, "tblEstudianteCandidato", "/Sistema_FCE/pages/seguridad/tblEstudianteCandidato.jsp")
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
</script>
</body>
</html>