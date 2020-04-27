<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Nuevo Estudiante</title>
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
<body class="hold-transition login-page">

<div class="login-box">
  <div class="login-logo" style="background-color: #062844">
    <a href="#" style="color: #ffffff"><b>Sistema de Control FCE</b></a>
  </div>
  <!-- /.login-logo -->
  
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Ingresa tu informaci�n para registrarte</p>
      
      

      <form role="form" action="../../SL_usuario" method="post">
      
        <div class="input-group mb-3"> 
        
         <input name="id_rol" id="id_rol" type="hidden" value="2"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
        <input name="opc" id="opc" type="hidden" value="4"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
          <input id="carne" name="carne" type="text" class="form-control" placeholder="Carn� de estudiante UCA">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-id-card"></span>
            </div>
          </div>
        </div>
        
        <div class="input-group mb-3"> 
        
          <input id="nombres" name="nombres" type="text" class="form-control" placeholder="Nombres">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        
          <div class="input-group mb-3"> 
        
          <input id="apellidos" name="apellidos" type="text" class="form-control" placeholder="Apellidos">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        
         <div class="input-group mb-3"> 
        
          <input id="correo" name="correo" type="email" class="form-control" placeholder="Correo institucional UCA">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
       
        <div class="input-group mb-3">
          <input id="contrasenia" name="contrasenia" type="password" class="form-control" placeholder="Contrase�a">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input id="contrasenia2" name="contrasenia2" type="password" class="form-control" placeholder="Confirmar contrase�a">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
     
        <div class="row">
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      
<!-- Aqu� estaba las posibilidades de entrar con google o facebook -->
	
      <!-- /.social-auth-links -->

    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!--fin del divv-->

    <!-- /.content -->
	
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  
  <script>
  function ComparandoContrasenias()
  {
	  var pwd1 = "";
	  var pwd2 = "";
	  
	  pwd1 = $("#contrasenia").val();
	  pwd2 = $("#contrasenia2").val();
	  
	  if(pwd1 != pwd2)
	  {
		  errorAlert('Error', 'Revise la contrase�a ingresada');
		  $("#contrasenia").css("border-color", "red");
		  $("#contrasenia").val("");
		  $("#contrasenia2").css("border-color", "red");
		  $("#contrasenia2").val("");
	  }
	  else
		{
		  $("#contrasenia").css("border-color", "#ced4da");
		  $("#contrasenia2").css("border-color", "#ced4da");
		}
		  
  }
  </script>
  
  
  <script>
    $(document).ready(function ()
    {
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      nuevo = "<%=mensaje%>";

      if(nuevo == "2")
      {
        errorAlert('Error', 'El carn� digitado ya est� siendo utilizado.');
      }
      if(nuevo == "3")
      {
        errorAlert('Error', 'Correo ya siendo utilizado');
      }
      if(nuevo == "4")
      {
        errorAlert('Error', 'Correo no v�lido o ya siendo utilizado.');
      }
    
      

    });
    </script>

</body>
</html>