<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="entidades.Tbl_usuario, datos.DT_usuario, entidades.Vw_usuario_rol ;" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
 <title>AdminLTE 3 | Log in</title>
 <!-- Tell the browser to be responsive to screen width -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Font Awesome -->
 <link rel="stylesheet" href="./plugins/fontawesome-free/css/all.min.css">
 <!-- Ionicons -->
 <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
 <!-- icheck bootstrap -->
 <link rel="stylesheet" href="./plugins/icheck-bootstrap/icheck-bootstrap.min.css">
 <!-- Theme style -->
 <link rel="stylesheet" href="dist/css/adminlte.min.css">
 <!-- Google Font: Source Sans Pro -->
 <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
 <!-- jAlert css  -->
<link rel="stylesheet" href="./plugins/jAlert/dist/jAlert.css" />


<%

/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
String mensaje = "";
mensaje = request.getParameter("msj");
mensaje = mensaje==null?"":mensaje;

%>


</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>Sistema de Control FCE</b></a>
  </div>
  <!-- /.login-logo -->
  
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Ingresa tu informaci�n para iniciar sesi�n</p>
      
      

      <form role="form" action="SL_usuario" method="post">
        <div class="input-group mb-3">
        
        <input name="opc" id="opc" type="hidden" value="3"> <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
        
          <input id="carne" name="carne" type="text" class="form-control" placeholder="ID">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input id="contrasena" name="contrasena" type="password" class="form-control" placeholder="Contrase�a">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                Recordar contrase�a
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      
<!-- Aqu� estaba las posibilidades de entrar con google o facebook -->
	
      <!-- /.social-auth-links -->

      <p class="mb-1">
        <a href="#">Olvid� mi contrase�a</a>
      </p>
     
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="./plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="./plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- JAlerts js -->
  <script src="./plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="./plugins/jAlert/dist/jAlert-functions.min.js"> </script>

 <script>
 $(document).ready(function ()
{
 var nuevo = 0;
 nuevo = "<%=mensaje%>";



 if(nuevo == "2")
 {
   errorAlert('Aviso', 'Carn� o contrase�a no v�lidos');
 }
 
});

 
   
 </script>

</body>
</html>