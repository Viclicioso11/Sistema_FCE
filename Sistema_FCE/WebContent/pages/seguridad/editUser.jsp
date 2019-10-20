<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.Tbl_usuario,datos.DT_usuario;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editar Usuario</title>
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
String idUser = "";
idUser = request.getParameter("userID");
idUser = idUser==null?"0":idUser;

int user = 0;
user = Integer.parseInt(idUser); 

/* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
Tbl_usuario tus = new Tbl_usuario();
DT_usuario dtus = new DT_usuario();

tus = dtus.obtenerUser(user);
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
	            <h1>Edición [Usuario]</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblusuarios.jsp">Seguridad</a></li>
	              <li class="breadcrumb-item active">Edición Usuario</li>
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
                <h3 class="card-title">Edición Usuario</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_usuario" method="post">
                <div class="card-body">
                  <input name="opc" id="opc" type="hidden" value="2"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  <input name="IdUser" id="IdUser" type="hidden"> <!-- ESTE INPUT ES UTILIZADO EL ID_USER A EDITAR -->
                  <div class="form-group">
                    <label for="exampleInputEmail1">Nombre de Usuario:</label>
                    <input type="text" id="username" name="username" class="form-control" 
                    placeholder="Nombre de Usuario" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Contraseña: </label>
                    <input type="password" id="password" name="password" class="form-control" 
                    title="Recuerde usar teclas mayúsculas, minúsculas, números y caracteres especiales..." 
                    placeholder="Ingrese su Contraseña" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Confirmar Contraseña: </label>
                    <input type="password" id="password2" name="password2" onchange="pwdEquals()" class="form-control" 
                    title="Recuerde usar teclas mayúsculas, minúsculas, números y caracteres especiales..." 
                    placeholder="Ingrese nuevamente su Contraseña" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Primer Nombre:</label>
                    <input type="text" id="nombre1" name="nombre1" class="form-control" 
                    placeholder="Primer Nombre" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Segundo Nombre:</label>
                    <input type="text" id="nombre2" name="nombre2" class="form-control"  placeholder="Nombre de Usuario">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Primer Apellido:</label>
                    <input type="text" id="apellido1" name="apellido1" class="form-control" 
                    placeholder="Primer Apellido" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Segundo Apellido:</label>
                    <input type="text" id="apellido2" name="apellido2" class="form-control" 
                    placeholder="Segundo Apellido">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" 
                    placeholder="Ingrese una cuenta de correo electrónico válida, Ejemplo: ejemplo@ejemplo.com" required>
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
  function pwdEquals()
  {
	  var pwd1 = "";
	  var pwd2 = "";
	  
	  pwd1 = $("#password").val();
	  pwd2 = $("#password2").val();
	  
	  if(pwd1 != pwd2)
	  {
		  errorAlert('Error', 'Revise la contraseña ingresada');
		  $("#password").css("border-color", "red");
		  $("#password").val("");
		  $("#password2").css("border-color", "red");
		  $("#password2").val("");
	  }
	  else
		{
		  $("#password").css("border-color", "#ced4da");
		  $("#password2").css("border-color", "#ced4da");
		}
		  
  }
  </script>
  
  <script>
    $(document).ready(function ()
    {
		/////////////// ASIGNAR VALORES A LOS CONTROLES AL CARGAR LA PAGINA ///////////////
    	
    	$("#IdUser").val("<%=tus.getId()%>");
    	$("#username").val("<%=tus.getCarne()%>");
    	$("#password").val("<%=tus.getContrasena()%>");
    	$("#nombre1").val("<%=tus.getNombres()%>");
    	$("#apellido1").val("<%=tus.getApellidos()%>");
    	$("#email").val("<%=tus.getCorreo()%>");
    	
    	///////////// VALIDAR QUE LAS CONTRASEÑAS SON LAS MISMAS ///////////////
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      nuevo = "<%=mensaje%>";

      if(nuevo == "1")
      {
        successAlert('Éxito', 'El registro ha sido modificado!!!');
      }
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!');
      }
    
      

    });
    </script>

</body>
</html>