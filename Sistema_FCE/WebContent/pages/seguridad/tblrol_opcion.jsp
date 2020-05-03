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
  <title>Gesti�n Opciones de Rol</title>
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

	<div class="card" >
	<div class = "card-body" style="overflow-x: scroll">
    <!-- Main content -->
    <section class="content">
      <div class="row">
      
       <!-- /.col -->
        <div class="col-12 col-lg-8">
          <div class="card">
            <div class="card-header">
            <h2>Opciones Disponibles de Rol</h2>
            </div>
            <!-- /.card-header -->
            <div class="card-body" id="divTblOpciones" style="overflow-x: scroll">
            
            <input type="hidden" id="id_opciones" name="id_opciones">
              <table id="Tbl_opciones" class="table table-bordered">
                <thead>
                <tr>
                  <th>Opci�n</th>
                  <th>Descripci�n</th>
                  <th>Seleccionar</th>
                </tr>
                </thead>
                <tbody>
                <%
                	String rol = request.getParameter("id_rol");
                	int id_rol = 0;
                	if(rol != null){
                	id_rol = Integer.parseInt(rol);
     
                	DT_rol_opcion dtop = new DT_rol_opcion();
                  	ArrayList<Tbl_opcion> listOpcion = new ArrayList<Tbl_opcion>();
                  	listOpcion = dtop.listarOpcionesDisponibles(id_rol);
                  	
                  	        		
                  	for(Tbl_opcion top : listOpcion)
                  	{
                %>
	                <tr>
	                  <td><%=top.getOpcion()%></td>
	                  <td><%=top.getDescripcion() %></td>
	                  <td id ="<%=top.getId()%>">
	                  <a href="#"onclick="seleccionarOpcion('<%=top.getId()%>');"><i class="fas fa-check" title="Agregar"></i></a>
	                 
	                  </td>
	                </tr>
	             <%
	        		}  
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
      
      <!-- tabla de roles -->
      <div class="col-12 col-lg-4">
          <div class="card">
            <div class="card-header">
               <h2>Roles</h2>
            </div>
            <!-- /.card-header -->
            <div class="card-body" style="overflow-x: scroll">
              <table id="Tbl_rol" class="table-bordered">
                <thead>
                <tr>
                  <th>Rol</th>
                  <th>Seleccionar</th>
                  <th>Detalle</th>
                </tr>
                </thead>
                <tbody>
                <%
                	DT_rol dtrol = new DT_rol();
                  	ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
                  	listRol = dtrol.listRol();
                  	        		
                  	for(Tbl_rol trol : listRol)
                  	{
                %>
	                <tr>
	                  <td><%=trol.getRol()%></td>
	                  <td id ="filaRol<%=trol.getId()%>" onclick="seleccionarRol('filaRol<%=trol.getId()%>');" title="Seleccionar este rol">
	                  	<a href="#"onclick="seleccionarRol('filaRol<%=trol.getId()%>');"><i class="fas fa-check"  title="Seleccionar este Rol"></i></a>
	                  </td>
	                   <td>
	                  <a href="#" onclick="detalleRol(<%=trol.getId()%>);"><i class="fas fa-info-circle" title="Detalles"></i></a>
	                  </td>
	                </tr>
	             <%
	        		}   
	             %>
                </tbody>
              </table>
              
              <button type="button" class="btn btn-primary" id="btnAsignar" onClick="asignarOpcionRol()">Asignar</button>
              <button type="button" class="btn btn-danger" id="btnCancelar" onClick="limpiarCampos()">Cancelar</button>
              
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->

          </div>
             </div>
             
      <!-- /.row -->
    </section>
    </div>
    </div>
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
  
  <script src="./js/rol_opcion.js" defer></script>

<script>

</script>

<script>



function deleteOpcion(id_rol, id_opcion)
{
	
	  $.jAlert({
		    'type': 'confirm',
		    'confirmQuestion': '�Est� seguro de eliminar la opci�n del rol seleccionado?',
		    'onConfirm': function(e, btn){
		     e.preventDefault();
		     window.location.href="../../SL_rol_opcion?id_opcion="+id_opcion+"&id_rol="+id_rol;
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
    $('#Tbl_opciones').DataTable({
        dom: 'Bfrtip',
        buttons: [
        'pdf',
        'excel',
        'print'
        ]
      });
    
    $("#Tbl_opciones").css({
        "border": "none",
        "padding-top": "20px",
      })
      $("tr").css({"height": "49px"})
  });
  	
  $(function () {
	  
	  $('#Tbl_rol').DataTable({

	      });
	    $("#Tbl_rol").css({
	        "border": "none",
	        "padding-top": "20px",
	      })
	      $("tr").css({"height": "49px"})
	  });

  
</script>

<script>

//para guardar
function asignarOpcionRol(){
 
var opciones = $("#id_opciones").val();
var id_rol = "<%=rol%>";
 
	if(id_rol != "" && opciones != "" ){
	
		window.location.href= "../../SL_rol_opcion?opc=1&id_rol="+ id_rol+"&id_opciones="+opciones;
		id_rol = null;
		$("#id_opciones").val("");
		
	}else{
		errorAlert('Error', 'Debe seleccionar al menos una opci�n a un rol.');
	}
	
	
}
</script>

<script>
//para ver los detalles 
function detalleRol(id_rol){
 
	window.location.href="../../pages/seguridad/tbldetalle_rolp.jsp?id_rol="+id_rol;	
	
}
</script>


<script>
  $(document).ready(function ()
  {
   	//cuando se recargue la p�gina, para que quede seleccionada
	 var rolSelect = document.getElementById("filaRol<%=rol%>");
	 if(rolSelect != null){
		 rolSelect.style.backgroundColor = "green";
	 }
		 
    /////////// VARIABLES DE CONTROL MSJ ///////////
    var nuevo = 0;
    nuevo = "<%=mensaje%>";
    if(nuevo == "1")
    {
      successAlert('�xito', 'Registros almacenados correctamente.');
    }
    
    if(nuevo == "2")
    {
    	errorAlert('Error', 'El registro no almacenados.');
    }
    
    if(nuevo == "3")
    {
      successAlert('�xito', 'El registro ha sido modificado correctamente.');
    }
    
    if(nuevo == "4")
    {
      successAlert('�xito', 'El registro ha sido eliminado correctamente.');
    }
    
    if(nuevo == "5")
    {
      errorAlert('Error', 'El registro no se ha podido eliminar.');
    }
    
    
    
  
    
  });
  </script>
</body>

</html>