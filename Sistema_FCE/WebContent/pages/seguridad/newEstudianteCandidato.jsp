<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

<%
  ArrayList <Vw_rol_opcion> listOpciones = new ArrayList <Vw_rol_opcion>();
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

		if(opcionActual.equals(miPagina.trim())) {
			permiso = true;
			break;
		}else	{
			permiso = false;
		}
	
	}

	if(!permiso) {
		response.sendRedirect("../../Error.jsp");
	}

%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 3 | General Form Elements</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <!-- Jalert -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <link rel="stylesheet" href="./css/newEstudianteCandidato.css">
  <script src="./js/xlsx.full.min.js"></script>
  <script src="./js/newEstudianteCandidato.js" defer></script>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">


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
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">General Form</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <form action="../../SL_estudiante_candidato" method="post">
      <section class="content">
        <div class="container-fluid">
          <div class="row">
            <!-- left column -->
            <div class="col-md-5">

              <!-- Input addon -->
              <div class="card card-info">
                <div class="card-header">
                  <h3 class="card-title">Agregar Estudiante Candidato</h3>
                </div>
                <div class="card-body">


                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    </div>
                    <input type="email" id="email" class="form-control" placeholder="Email">
                  </div>

                  <p class="alert" id="empty">Ingrese el correo por favor</p>
                  <p class="alert" id="error">El correo ya se ha a�adido</p>
                  <p class="alert" id="valid">Ingrese un correo valido por favor</p>
                  <button type="button" onclick="agregar()" class="btn btn-primary">Agregar</button>

                  <br/><br/>
                  <div class="form-group">
                    <div class="input-group">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="file">
                        <label class="custom-file-label" for="exampleInputFile" id="fileLabel">Escoger Archivo</label>
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <label>Mensaje</label>
                    <textarea class="form-control" rows="6" placeholder="escribe Algo" id="mensaje" name="mensaje"></textarea>
                  </div>

                  <button type="submit" class="btn btn-primary" id="enviar">Enviar</button>
                  <button type="button" class="btn btn-danger">Cancelar</button>
                </div>
                <!-- /.card-body -->
              </div>
              <!-- /.card -->

            </div>

            <!--/.col (left) -->
            <!-- right column -->
            <div class="col-md-7">
              <section class="c-lg-8" id="list">
                <h4 style="text-align: center">Lista de Estudiantes Candidatos</h4>
                <br>
              </section>
              <input type="hidden" id="values" name="values">
            </div>
            <!--/.col (right) -->
          </div>
          <!-- /.row -->
        </div><!-- /.container-fluid -->
      </section>
    </form>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- footer -->

</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- jAlert js -->
<script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
<script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>


</body>
</html>
