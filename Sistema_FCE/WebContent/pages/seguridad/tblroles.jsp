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
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Gestión Roles</title>
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
  
  <%
	/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
	String mensaje = "";
	mensaje = request.getParameter("msj");
	mensaje = mensaje==null?"":mensaje;


%>
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
          
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              
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
            
              <h2>Gestión de Roles</h2>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
            
             <a href="../seguridad/newRol.jsp">Agregar Rol <i class="fas fa-plus-circle"></i></a>
              &nbsp; &nbsp; &nbsp; &nbsp;
               <a href="../seguridad/tblrol_opcion.jsp">Asignar Opciones <i class="fas fa-scroll"></i></a>
               <br/><br/>
            
              <table id="Tbl_rol" class="table table-bordered">
                <thead>
                <tr>
                  <th>Id</th>
                  <th>Rol</th>
                  <th>Descripción</th>
                  <th>Estado</th>
                  <th>Opciones</th>
                </tr>
                </thead>
                <tbody>
                <%
                	DT_rol dtrol = new DT_rol();
                  	        		ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
                  	        		listRol = dtrol.listRol();
                  	        
                  	        		String estado = "";
                  	        		
                  	        		for(Tbl_rol trol : listRol)
                  	        		{
                  	        			estado = trol.getEstado()==1||trol.getEstado()==2?"ACTIVO":"INACTIVO";
                %>
	                <tr>
	                  <td><%=trol.getId()%></td>
	                  <td><%=trol.getRol() %></td>
	                  <td><%=trol.getDescripcion() %></td>
	                  <td><%=estado %></td>
	                  <td>
	                  		<a href="#"onclick="linkEditRol('<%=trol.getId()%>');"><i class="far fa-edit"></i></a>&nbsp;&nbsp;
	                  		<a href="#" onclick="deleteRol('<%=trol.getId()%>');"><i class="far fa-trash-alt" title="Eliminar"></i> </a>
	                  </td>
	                </tr>
	             <%
	        		}   
	             %>
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
function linkEditRol(rol)
{
	var idRol = rol;
	window.location.href="../../pages/seguridad/editRol.jsp?rolID="+idRol;	
}
</script>

<script>
function deleteRol(rol)
{
	
	  $.jAlert({
		    'type': 'confirm',
		    'confirmQuestion': '¿Está seguro de eliminar el rol seleccionado?',
		    'onConfirm': function(e, btn){
		     e.preventDefault();
		     window.location.href="../../SL_rol?opc=1&rolID="+rol;
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
    $('#Tbl_rol').DataTable({
        dom: 'Bfrtip',
        buttons: [
        'pdf',
        'excel',
        'print'
        ]
      });
    
    $("#Tbl_rol").css({
        "border": "none",
        "padding-top": "20px",
      })
      $("tr").css({"height": "49px"})
      
  });
  
</script>

<script>
  $(document).ready(function ()
  {
   
    /////////// VARIABLES DE CONTROL MSJ ///////////
    var nuevo = 0;
    nuevo = "<%=mensaje%>";

    if(nuevo == "1")
    {
      successAlert('Éxito', 'El registro ha sido almacenado correctamente.');
    }
    
    if(nuevo == "3")
    {
      successAlert('Éxito', 'El registro ha sido modificado correctamente.');
    }
    
    if(nuevo == "4")
    {
      successAlert('Éxito', 'El registro ha sido eliminado correctamente.');
    }
    
    if(nuevo == "5")
    {
      errorAlert('Error', 'El registro no se ha podido eliminar.');
    }
    
    
    
  
    

  });
  </script>
</body>
</html>
