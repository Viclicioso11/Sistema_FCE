<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
<% 
/* 	DT_rol_opcion Dtro = new DT_rol_opcion();
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
	} */
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
  <title>Buscar propuesta de Tema</title>
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
            
            
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              
              <br><br>
              <table id="Tbl_ec" class="table table-bordered">
                <thead>
                  <tr>
                    <th style="width: 15px">#</th>
                    <th>Tema</th>
                    <th>Tipo FCE</th>
                    <th>�mbito</th>
                    <th>Carrera</th>
                    <th>Palabras Claves</th>
                    <th>Fecha</th>
                    <th style="width: 20px">Opciones</th>
                  </tr>
                </thead>
                <tbody>

                  <%
              	      DT_vw_tema dtTema = new DT_vw_tema();
                  ArrayList<Vw_tema> temas = new ArrayList<Vw_tema>();
                      temas = dtTema.listarTemas();

                	    for(Vw_tema tema : temas) {
                  %>
  	                <tr>
  	                  <td style="text-align:center"><%=tema.getId_tema()%></td>
                      <td><%=tema.getTema()%></td>
                      <td><%=tema.getTipo_fce()%></td>
                      <td><%=tema.getAmbito()%></td>
                      <td><%=tema.getCarrera()%></td>
                      <td><%=tema.getPalabras_claves()%></td>
                      <td><%=tema.getFecha()%></td>
                      <td style="text-align:center">
                      <a href="../../pages/inscripcion/detalle_tema_impreso.html?temaID=<%=tema.getId_tema()%>"><i class="fas fa-file-pdf" title="Ver PDF"></i></a>
                      &nbsp;&nbsp;
                      <a href="../../pages/inscripcion/detalleTema.jsp?temaID=<%=tema.getId_tema()%>"><i class="fas fa-eye" title="Ver Detalle"  ></i></a>
		                  &nbsp;&nbsp;
                        <a href="../../SL_descarga_archivos?url=<%=tema.getUrl()%>" style="color: #17a2b8;">
                          <i class="fas fa-file-download" title="Descargar Propuesta"></i>
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
  $(function () {
    $('#Tbl_ec').DataTable({
        dom: 'Bfrtip',
        buttons: ['pdf','excel','print'],
        "order": []
      })

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
      	window.history.pushState({page: "another"}, "tblEstudianteCandidato", "/Sistema_FCE/pages/inscripcion/tblEstudianteCandidato.jsp")
    	}
  	});
  } 

  
  
</script>
</body>
</html>
