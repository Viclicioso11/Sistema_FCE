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
 	
 	
 	//obtener todos los datos posibles
 	ArrayList<Tbl_tema> temas = new ArrayList<Tbl_tema>();
 	DT_tema dtTema = new DT_tema();
 	DT_vw_tema dtvwtema = new DT_vw_tema();
 	temas = dtTema.getTemas();
 	DT_cierre dtCierre = new DT_cierre();
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Biblioteca de temas</title>
  <!-- Imagen del título-->
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
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700">


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
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#"></a></li>
              <li class="breadcrumb-item active">Listado de temas FCE</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
            <h2>Listado de temas FCE</h2>
            </div>
              
            <!-- /.card-header -->
            <div class="card-body" style="overflow-x: scroll">
              <table id="table" class="table table-bordered">
                <thead>
	                <tr>
	                  <th>#</th>
	                  <th>Titulo</th>
	                  <th>Tipo FCE</th>
	                  <th>Fecha de inscripcion</th>
	                  <th>Cohorte</th>
	                  <th>Estudiantes</th>
	                  <th>Tutor</th>
	                  <th>Palabras Claves</th>
	                  <th>Estado</th>
	                </tr>
                </thead>
                <tbody>
                <%
                int i = 0;
                for(Tbl_tema tema: temas){//Inicio del for
                	String estudiantes = "";
                	String estado = "";
                	boolean cierre = false;
                	i++;
                	for(Tbl_usuario tuser: dtTema.obtenerEstudiante(tema.getId())){
  	                  estudiantes += tuser.getNombres()+" "+tuser.getApellidos()+"- ";	
  	                }
                	
                	
                	cierre = dtCierre.tieneCierre(tema.getId());
                	estado = cierre ? "Terminado": "En progreso";
                %>
	                <tr>
	                  <td><%=i%></td>
	                  <td><%=tema.getTema() %></td>
	                  <td><%=dtvwtema.obtenerTipoTema(tema.getId())%></td>
	                  <td><%=tema.getFecha() %></td>
	                  <td class="cohorte"><%=tema.getFecha() %></td>
	               	  <td><%=estudiantes%></td>
	                  <td><%=dtTema.obtenerNombreTutor(tema.getId()) %></td>
	                  <td><%=tema.getPalabras_claves() %></td>
	                  <td><%=estado%></td>
	                </tr>
	            <%}//Fin del for %>
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
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>

<script>
function cohorte(){
  let spans = document.querySelectorAll(".cohorte");
  
  spans.forEach(function(element){
	  element.innerHTML = new Date(element.innerHTML).getFullYear();
  })
}
cohorte();


$(function () {
  $('#table').DataTable({
      dom: 'Bfrtip',
      buttons: [
          'print'
      ]
    });
});
  
  
  
</script>
</body>
</html>

