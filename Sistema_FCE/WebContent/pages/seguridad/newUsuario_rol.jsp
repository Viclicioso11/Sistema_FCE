<%@page import="entidades.Tbl_rol"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Asignar Rol a Usuario</title>
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
idUser = request.getParameter("id_user");
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
	            <h1>Registro de nuevo Rol a Usuario</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblusuarios.jsp">Seguridad</a></li>
	              <li class="breadcrumb-item active">Asignaci�n de rol a usuario</li>
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
                <h3 class="card-title">Asignaci�n Rol</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_usuario_rol" method="post">
                <div class="card-body">
        		<!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  <input name="id_usuario" id="id_usuario" type="hidden"> <!-- ESTE INPUT ES UTILIZADO EL ID_USER A EDITAR -->
                   
                   <div class="form-group">
                    <label for="exampleInputEmail1">N�mero de Carne:</label>
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
                    placeholder="Ingrese una cuenta de correo electr�nico v�lida, Ejemplo: ejemplo@ejemplo.com" required>
                  </div>
                  </div>
                  <div class="form-group">
                   <label for="exampleInputPassword1">Seleccione un Rol para el usuario: </label>
           				<select class="form-control select2" name="id_rol" style="width: 100%;" required="required">
           				  <option value="0">Seleccione un Rol...</option>
            				<%
		            		DT_rol dtr = new DT_rol();
		            	    ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
		            	    listRol = dtr.listRol();
		            	    
		            	    for(Tbl_rol tr : listRol)
		            	    {
		            		%>
		            		 <option value="<%=tr.getId()%>"><%=tr.getRol() %></option>
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
    	
    	$("#id_usuario").val("<%=tus.getId()%>");
    	$("#carne").val("<%=tus.getCarne()%>");
    	$("#contrasenia").val("<%=tus.getContrasena()%>");
    	$("#nombres").val("<%=tus.getNombres()%>");
    	$("#apellidos").val("<%=tus.getApellidos()%>");
    	$("#correo").val("<%=tus.getCorreo()%>");
    	
    	///////////// VALIDAR QUE LAS CONTRASE�AS SON LAS MISMAS ///////////////
     
      /////////// VARIABLES DE CONTROL MSJ ///////////
      var nuevo = 0;
      nuevo = "<%=mensaje%>";

      if(nuevo == "1")
      {
        successAlert('�xito', 'El registro ha sido modificado!!!');
      }
      if(nuevo == "2")
      {
        errorAlert('Error', 'Revise los datos e intente nuevamente!!!');
      }
    
      

    });
    </script>

</body>
</html>