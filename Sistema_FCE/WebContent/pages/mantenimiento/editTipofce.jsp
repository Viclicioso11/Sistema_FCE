<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*,datos.*, java.util.*;"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editar Tipo FCE</title>
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
String idTipo = "";
idTipo = request.getParameter("TipofceID");
idTipo = idTipo==null?"0":idTipo;
int tipo = 0;
tipo = Integer.parseInt(idTipo); 
/* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
Tbl_tipo_fce tTipoFCE = new Tbl_tipo_fce();
DT_tipo_fce dtTipoFCE = new DT_tipo_fce();
tTipoFCE = dtTipoFCE.obtenerTipoFce(tipo);
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
	            <h1>Edición [Tipo FCE]</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblopcion.jsp">Gestión Tipo FCE</a></li>
	              <li class="breadcrumb-item active">Edición Tipo FCE</li>
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
                <h3 class="card-title">Edición de Tipo FCE</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form opcione="form" action="../../SL_opcion" method="post">
                <div class="card-body">
                  <input name="opc" id="opc" type="hidden" value="2"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  <input name="IdOpcion" id="IdOpcion" type="hidden"> <!-- ESTE INPUT ES UTILIZADO EL ID_opcion A EDITAR -->
                  <div class="form-group">
                    <label for="exampleInputEmail1">Nombre de Tipo FCE:</label>
                    <input type="text" id="opcion" name="opcion" class="form-contopcion" 
                    placeholder="Nombre de Opcion" required>
                  </div>	
                  <div class="form-group">
                    <label for="exampleInputEmail1">Descripción de Tipo FCE:</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-contopcion" 
                    placeholder="Descripción de la nueva opcion">
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
	
	<!-- Footer -->
  		<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  	<!-- ./Footer -->

</div>
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  
  <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
		$("#IdTipofce").val("<%=tTipoFCE.getId()%>");
    	$("#tipofce").val("<%=tTipoFCE.getTipo()%>");
    	$("#descripcion").val("<%=tTipoFCE.getDescripcion()%>");
     
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