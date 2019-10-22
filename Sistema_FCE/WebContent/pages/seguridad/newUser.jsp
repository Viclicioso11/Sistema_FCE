<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Nuevo Usuario</title>
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


%>


</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
	<!-- Navbar -->
	  	<jsp:include page="/WEB-INF/layouts/topbar.jsp"></jsp:include>
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
	            <h1>Registro [Nuevo Usuario]</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblusuarios.jsp">Seguridad</a></li>
	              <li class="breadcrumb-item active">Nuevo Usuario</li>
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
                <h3 class="card-title">Nuevo Usuario</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_usuario" method="post">
                <div class="card-body">
                  <input name="opc" id="opc" type="hidden" value="1"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  
                   <div class="form-group">
                    <label for="exampleInputEmail1">Numero de Carne:</label>
                    <input type="text" id="carne" name="carne" class="form-control" 
                    placeholder="Carnet de usuario" required>
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputEmail1">Nombres:</label>
                    <input type="text" id="nombres" name="nombres" class="form-control" 
                    placeholder="Nombres de Usuario" required>
                  </div>
                 
                  <div class="form-group">
                    <label for="exampleInputEmail1">Apellidos:</label>
                    <input type="text" id="apellidos" name="apellidos" class="form-control" 
                    placeholder="Apellidos del Usuario" required>
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputEmail1">Correo Institucional:</label>
                    <input type="email" id="correo" name="correo" class="form-control" 
                    placeholder="Ingrese una cuenta de correo electrónico válida, Ejemplo: ejemplo@ejemplo.com" required>
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputPassword1">Contraseña: </label>
                    <input type="password" id="contrasenia" name="contrasenia" class="form-control" 
                    title="Recuerde usar teclas mayúsculas, minúsculas, números y caracteres especiales..." 
                    placeholder="Ingrese su Contraseña" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Confirmar Contraseña: </label>
                    <input type="password" id="contrasenia2" name="contrasenia2" onchange="pwdEquals()" class="form-control" 
                    title="Recuerde usar teclas mayúsculas, minúsculas, números y caracteres especiales..." 
                    placeholder="Ingrese nuevamente su Contraseña" required>
                  </div>
                  

                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                  <button type="submit" class="btn btn-primary">Registrar</button>
                  <button type="reset" class="btn btn-danger">Cancelar</button>
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
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      nuevo = "<%=mensaje%>";

      if(nuevo == "1")
      {
        successAlert('Éxito', 'El nuevo registro ha sido almacenado!!!');
      }
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!');
      }
    
      

    });
    </script>

</body>
</html>