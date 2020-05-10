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
<title>Asignar Tutor a Tema FCE</title>

<!-- Imagen del título-->
 <link  rel="icon"   href="../../dist/img/favicon.png" type="image/png" />
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
String idtema = "";
idtema = request.getParameter("id_tema");
idtema = idtema==null?"0":idtema;

int tema = 0;
tema = Integer.parseInt(idtema); 

/* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
Tbl_usuario_tema tuste = new Tbl_usuario_tema();
DT_usuario_tema dtuste = new DT_usuario_tema();

//tuste = dtuste.obtenertema(tema);
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
	            <h1>Registro de nuevo Rol a Usuario</h1>
	          </div>
	          <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="tblusuarios.jsp">Seguridad</a></li>
	              <li class="breadcrumb-item active">Asignación de rol a usuario</li>
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
                <h3 class="card-title">Asignación Rol</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" action="../../SL_usuario_rol" method="post">
                <div class="card-body">
        		<!-- ESTE INPUT ES UTILIZADO PARA EL CASE DEL SERVLET -->
                  <input name="id_usuario" id="id_usuario" type="hidden"> <!-- ESTE INPUT ES UTILIZADO EL ID_USER A EDITAR -->
                   
                   <div class="form-group">
                    <label for="exampleInputEmail1">Tema FCE:</label>
                    <input type="text" id="carne" name="carne" class="form-control" 
                    placeholder="Carnet de usuario" required>
                   </div>
                  
                  <div class="form-group">
                    <label for="exampleInputEmail1">Tipo FCE:</label>
                    <input type="text" id="nombres" name="nombres" class="form-control" 
                    placeholder="Nombres de Usuario" required>
                  </div>
                 
                  <div class="form-group">
                    <label for="exampleInputEmail1">Ambito:</label>
                    <input type="text" id="apellidos" name="apellidos" class="form-control" 
                    placeholder="Apellidos del Usuario" required>
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputEmail1">Carrera:</label>
                    <input type="email" id="correo" name="correo" class="form-control" 
                    placeholder="Ingrese una cuenta de correo electrónico válida, Ejemplo: ejemplo@ejemplo.com" required>
                  </div>
                  <div class="form-group">
                   <label for="exampleInputPassword1">Seleccione un Tutor para el tema FCE: </label>
           				<select class="form-control select2" name="id_rol" style="width: 100%;" required="required">
           				  <option value="0">Seleccione un Tutor...</option>
            				<%
		            		//DT_rol dtr = new DT_rol();
            				DT_vw_rol_usuario  vwRS= new DT_vw_rol_usuario();
		            	    //ArrayList<Tbl_rol> listRol = new ArrayList<Tbl_rol>();
		            	   ArrayList<Vw_usuario_rol> listarTutor = new ArrayList<Vw_usuario_rol>();
		            	 	listarTutor = vwRS.listarTutor();
		            			   
		            	    for(Vw_usuario_rol sr : listarTutor)
		            	    {
		            		%>
		            		 <option value="<%=sr.getId_rol()%>"><%=sr.getNombre() %></option>
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