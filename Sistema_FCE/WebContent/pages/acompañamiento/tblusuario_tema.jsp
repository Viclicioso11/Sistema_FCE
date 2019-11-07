
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
   
    <!-- ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
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
	}
	 -->

    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Asignar tutor a FCE</title>
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
  	<jsp:include page="/WEB-INF/layouts/menu2.jsp"></jsp:include>
  <!-- SIDEBAR -->


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Asignar tutor a FCE</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#"></a>Acompa�amiento</li>
              <li class="breadcrumb-item active">Asignar tutor a FCE</li>
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
              <a href="../seguridad/newUser.jsp">Agregar Usuario <i class="fas fa-plus-circle"></i></a>
               &nbsp; &nbsp; &nbsp; &nbsp;
                <a href="../inscripcion/inscripcion_tema.jsp">Incripcion de tema<i class="fas fa-user-tag"></i></a>
            </div>
              
            <!-- /.card-header -->
            <div class="card-body">
              <table id="example2" class="display">
                <thead>
                <tr>
                  <th>Id</th>
                  <th>Tema</th>
                  <th>Tipo</th>
                  <th>Tutor</th>
                  <th>Opcion</th>
                </tr>
                </thead>
                <tbody>
                <%
                	DT_vw_usuario_tema dtuste = new DT_vw_usuario_tema();
                	DT_vw_rol_usuario dtus = new DT_vw_rol_usuario();
                					ArrayList<Vw_usuario_tema> listarUsuarioTema = new ArrayList<Vw_usuario_tema>();
                  	        		listarUsuarioTema = dtuste.listUsuarioTema();
                  	        		ArrayList<Vw_usuario_rol> listarTutor = new ArrayList<Vw_usuario_rol>();
                  	       			listarTutor = dtus.listarTutor(); 		
                  	       
                  	        		
                  	        		String TemaFCE = "";
                  	        		String TipoFCE="";
                  	        		String Tutor = "";
                  	        		for(Vw_usuario_tema tuste : listarUsuarioTema)
                  	        		{
                  	        			TemaFCE=TemaFCE==null?" ":TemaFCE;
                  	        			TipoFCE=TipoFCE==null?" ":TipoFCE;
                  	        			Tutor=Tutor==null?"":Tutor;
                  	        			
                  	        		
                  	        			
                %>
	                <tr>
	                  <td><%=tuste.getId_tema()%></td>
	                  <td><%=tuste.getTema() %></td>
	                  <td><%=tuste.getTipo() %></td>
	                 <td><%=tuste.getTipo() %></td>

	                  <td>
	                  <div class="input-group-prepend">
								<button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">
									Asignar
								</button>
								<ul class="dropdown-menu">
								<li class="dropdown-item"><a data-toggle="modal" data-target="#addMember">Asignar tutor</a></li>
								<li class="dropdown-item"><a onclick="EliminarMembers()">Eliminar tutor</a></li>
								</ul>
								
								<input type="hidden" id="carne" name="carne"/>
							</div>
	                  </td>
	                </tr>
	             <%
	        		}   
	             %>
                </tbody>
                <tfoot>
                <tr>
                 <th>Id</th>
                  <th>Tema</th>
                  <th>Tipo</th>
                  <th>Tutor</th>
                  <th>Opcion</th>
                </tfoot>
              </table>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->


          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Sistema Formacion de Culminaci�n de Estudio</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              
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
  
  <!-- Modal -->
	  <div class="modal fade" id="addMember" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
		  <div class="modal-content">

			<div class="modal-header">
			  <h5 class="modal-title" id="exampleModalLabel">Vista de Tutores</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>

			<!-- modal body -->
			
			<br />
			
			<div class="form-group" style="padding-left: 5%;width: 90%;">
				<table>
		          <thead>
		          </thead>
		          <tbody class="table">
		              <tr>
		                  <td>1</td>
		                  <td>2</td>
		              </tr>
		              <tr>
		                  <td>3</td>
		                  <td>4</td>
		              </tr>
		          </tbody>
		      </table>
						
				<br />	
				<button type="button" class="btn btn-primary" onclick="Addmember()" data-dismiss="modal">Agregar</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>  
			</div>
			<!-- end modal body -->
		  </div>
		</div>
	  </div>
	 <!-- end modal -->
  
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
    $("#example1").DataTable();
//     $('#example2').DataTable({
//       "paging": true,
//       "lengthChange": false,
//       "searching": true,
//       "ordering": false,
//       "info": true,
//       "autoWidth": false,
      
//     });
    $('#example2').DataTable({
        dom: 'Bfrtip',
        buttons: [
        'pdf',
        'excel',
        'print'
        ]

      });
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
      successAlert('�xito', 'El registro ha sido almacenado correctamente.');
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

