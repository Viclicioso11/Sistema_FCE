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
   mensaje = mensaje==null ? "":mensaje;
 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Gesti�n Plan de Graduaci�n</title>
  <!-- Imagen del t�tulo-->
 <link  rel="icon"   href="../../dist/img/favicon.png" type="image/png" />
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  
  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

	<!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.dataTables.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  
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
            <h1>Gesti�n Plan de Graduaci�n</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#"></a>Inscripci�n</li>
              <li class="breadcrumb-item active">Gesti�n Plan de Graduaci�n</li>
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
              <a href="../inscripcion/newPlanG.jsp">Crear Plan de Graduaci�n<i class="fas fa-plus-circle"></i></a>
               &nbsp; &nbsp; &nbsp; &nbsp;
                
            </div>
              
            <!-- /.card-header -->
            <div class="card-body" style="overflow-x: scroll;">
              <table id="tablePG" class="table table-bordered">
                <thead>
	                <tr>
	                  <th>#</th>
	                  <th>Cohorte</th>
	                  <th>Descripci�n</th>
	                  <th>Fecha de Inicio</th>
	                  <th>Fecha de Fin</th>
	                  <th>Opciones</th>
	                </tr>
                </thead>
                <tbody>
                <%
                	DT_plan_graduacion dtpg = new DT_plan_graduacion();
         	        				
         	        //TemasS para mostrar los temas sin tutor
         	       	ArrayList<Tbl_plan_graduacion> planes= new  ArrayList<Tbl_plan_graduacion> ();
         	       	planes = dtpg.listPlanes();
      	        	
      	        	for(Tbl_plan_graduacion plan : planes)	{
      	        		String tutor = "tutor no se ha asignado";
      	        		
               	%>
	                <tr>
	                  <td><%=plan.getId()%></td>
	                  <td><%=plan.getCohorte()%></td>
	                  <td><%=plan.getDescripcion()%></td>
	                  <td><%=plan.getFecha_inicio()%></td>
	                  <td><%=plan.getFecha_fin()%></td>
	                  
	                  
	                  <%  if(plan.getEstado() == 3){ //comienzo if   %>
	                   <td>
                	 	<a href="./verPlan_graduacion.jsp?planID=<%=plan.getId()%>"><i class="fas fa-eye" title="Ver"></i></a>
	                   </td>
	                   
	                  <%} else{//else    %>
	                  
	                  <td>
	                  	<a href="./addActivityPG2.jsp?idPG=<%=plan.getId()%>" title="agregar actividades"><i class="fas fa-plus"></i></a>
	                  		&nbsp;&nbsp;&nbsp;
                	 	<a href="./verPlan_graduacion.jsp?planID=<%=plan.getId()%>"><i class="fas fa-eye"title="Ver"></i></a>
		                	&nbsp;&nbsp;&nbsp;
	                  	<a href="./editarPlan_graduacion.jsp?planID=<%=plan.getId()%>"><i class="far fa-edit" title="Editar"></i></a>
	                  </td>
	                
	                  <%}// end if%>
	                </tr>
	            <%}// end for%>
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


<!-- Select2 -->
<script src="../../plugins/select2/js/select2.full.min.js"></script>

<!-- page script -->

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>

<script>
    $('#tablePG').DataTable({
        dom: 'Bfrtip',
        buttons: ['pdf','excel','print'],
        "order": []
    })



	function linkVerPlan(idPlan){
		
		window.location.href="../../pages/inscripcion/verPlan_graduacion.jsp?planID="+idPlan;
	}

	function linkEditarPlan(idPlan){
		window.location.href="../../pages/inscripcion/editarPlan_graduacion.jsp?planID="+idPlan;
	}
  
    /////////// VARIABLES DE CONTROL MSJ ///////////
	var mensaje =  "<%=mensaje%>"
	
	if(mensaje == "1")
	  successAlert('�xito', 'El registro ha sido almacenado correctamente.')
	
	if(mensaje == "3")
	  successAlert('�xito', 'El registro ha sido modificado correctamente.')
	
	if(mensaje == "4")
	  successAlert('�xito', 'El registro ha sido eliminado correctamente.')
	
	if(mensaje == "5")
	  errorAlert('Error', 'El registro no se ha podido eliminar.')
	
 
</script>

</body>
</html>

