<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*,datos.*, java.util.*;"%>
    
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
<title>Editar Carrera</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
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
/* RECUPERAMOS EL VALOR DE LA VARIABLE userID */
String idCarrera = "";
idCarrera = request.getParameter("id_carrera");
idCarrera = idCarrera==null?"0":idCarrera;
int carrera = 0;
carrera = Integer.parseInt(idCarrera); 
/* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
Tbl_carrera tcarrera = new Tbl_carrera();
DT_carrera dtcarrera = new DT_carrera();
tcarrera = dtcarrera.obtenerCarrera(carrera);
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
	            <h1>Edición [Carrera]</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblcarrera.jsp">Gestión de Carreras</a></li>
	              <li class="breadcrumb-item active">Edición Carrera</li>
	            </ol>
	          </div>
	        </div>
	      </div><!-- /.container-fluid -->
	    </section>
	
	<!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- left column -->
          <div class="col-md-12">
            <!-- general form elements -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Edición de Carrera</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_carrera" method="post">
                <div class="card-body">
                  <input name="opc" id="opc" type="hidden" value="2"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  <input name="IdCarrera" id="IdCarrera" type="hidden"> <!-- ESTE INPUT ES UTILIZADO EL ID_opcion A EDITAR -->
                  <div class="form-group">
                    <label for="exampleInputEmail1">Nombre Carrera:</label>
                    <input type="text" id="nombre" name="nombre" class="form-contopcion" 
                    placeholder="Nombre de Opcion" required>
                  </div>	
                  
                      <div class="form-group">
                   <label for="exampleInputPassword1">Seleccione la facultad de la carrera: </label>
           				<select class="form-control select2" name="facultad" id="facultad" style="width: 100%;" required="required">
           				  <option value="0">Seleccione una Facultad...</option>
            				<%
		            		DT_carrera dtr = new DT_carrera();
		            	    ArrayList<Tbl_facultad> listarFacultad = new ArrayList<Tbl_facultad>();
		            	    listarFacultad = dtr.listarFacultad();
		            	    
		            	    for(Tbl_facultad tr : listarFacultad)
		            	    {
		            		%>
		            		 <option value="<%=tr.getId()%>"><%=tr.getNombre() %></option>
		            		<%	
		            		} 
		            		%>
           				</select>
        		</div>
                  
                  
                  
                  
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                  <button type="submit" class="btn btn-primary">Guardar</button>
                  <button type="button" class="btn btn-danger">Cancelar</button>
                </div>
              </form>
            </div>
            <!-- /.card -->
           </div>
          </div>
         </div>       
    </section>
    <!-- /.content -->
	


</div>

	<!-- Footer -->
  		<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  	<!-- ./Footer -->
  	
 </div>
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
    <!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
  
  <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
		$("#IdCarrera").val("<%=tcarrera.getId()%>");
    	$("#nombre").val("<%=tcarrera.getNombre()%>");
    	$("#facultad").val("<%=tcarrera.getId_facultad()%>");
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      
      nuevo = "<%=mensaje%>";
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente.');
      }
    
      
    });
    </script>

</body>
</html>