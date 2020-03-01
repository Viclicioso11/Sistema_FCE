<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="entidades.Tbl_usuario, datos.DT_usuario, datos.DT_rol, entidades.Tbl_rol ,entidades.Vw_usuario_rol, java.util.*" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
 <title>Inicio de sesión</title>
 <!-- Tell the browser to be responsive to screen width -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Font Awesome -->
 <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
 <!-- Ionicons -->
 <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
 <!-- icheck bootstrap -->
 <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
 <!-- Theme style -->
 <link rel="stylesheet" href="dist/css/adminlte.min.css">

 
 <!-- Google Font: Source Sans Pro -->
 <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
 <!-- jAlert css  -->
<link rel="stylesheet" href="plugins/jAlert/dist/jAlert.css">

	<style type="text/css">
		#body{
			background-image: url("./dist/img/estudiantes.png");
			background-size: cover;
			background-position: center center;
		}
	</style>
<%	
   response.setHeader( "Pragma", "no-cache" );
   response.setHeader( "Cache-Control", "no-store" );
   response.setDateHeader( "Expires", 0 );
   response.setDateHeader( "Expires", -1 );
%>


<%

/* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
String mensaje = "";
mensaje = request.getParameter("msj");
mensaje = mensaje==null?"":mensaje;

%>



</head>
<body id="body">

<div class="login-box">
  <div class="login-logo">
    <a href="#" style="color: #fff"><b>Sistema de Control FCE</b></a>
  </div>
  <!-- /.login-logo -->
  
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Ingresa tu información para iniciar sesión</p>
      
      

      <form role="form" action="SL_login" method="post">
        
        <!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
        <input name="opc" id="opc" type="hidden" value="3">
        
        <div class="input-group mb-3">
          <input id="carne" name="login" type="text" class="form-control" placeholder="ID carné" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input id="contrasena" name="contrasena" type="password" class="form-control" placeholder="Contraseña" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        
         <div class="input-group mb-3">
           <select class="form-control select2" name="id_rol" style="width: 100%;" required>
             <option value="0">Seleccione un Rol...</option>
            	<%
            		DT_rol dtr = new DT_rol();
            	    ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
            	    listRol = dtr.listRol();
            	    for(Tbl_rol tr : listRol)
            	    {
            	%>
            		<!-- creando los valores del login -->
            		<option value="<%=tr.getId()%>"><%=tr.getRol() %></option>
            	<%}%>
           </select>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
              <label for="remember">
                Recordar contraseña
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block btn-flat">Iniciar Sesión</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      
<!-- Aquí estaba las posibilidades de entrar con google o facebook -->
	
      <!-- /.social-auth-links -->

      <p class="mb-1">
        <a href="#">Olvidé mi contraseña</a>
      </p>
     
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- JAlerts js -->
 <script src="plugins/jAlert/dist/jAlert.min.js"></script>
 <script src="plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
 


<script>
$(document).ready(function ()
{
	(function mensajes(){
	    let uri = new URL(window.location.href)
	    let msj =  uri.searchParams.get("msj")


	    if (msj == 2){
	    	errorAlert('Aviso', 'Carné o contraseña no válidos');
	    }
	    
	    if (msj != null){
	      window.history.replaceState("any", "any", "index.jsp");
	    }
	})();
 
});

 </script>



</body>
</html>