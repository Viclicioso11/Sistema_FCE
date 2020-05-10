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

<%
	//para saber qué FCE cargarles a cada tutor end ependencia de su id
	String id_tutor_texto = session.getAttribute("idUsuario").toString();
		
   /* RECUPERAMOS EL VALOR DE LA VARIABLE MSJ */
   String mensaje = "";
   mensaje = request.getParameter("msj");
   mensaje = mensaje==null ? "":mensaje;
  
   
 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Avance de cronograma</title>
  <!-- Imagen del título-->
 <link  rel="icon"   href="../../dist/img/favicon.png" type="image/png" />
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <!-- select2 css -->
  <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <link rel="stylesheet" href="./css/listas.css">


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
            <h1>Avance de temas de cronograma</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="../../sistema.jsp">Sistema FCE</a> / <li>
              <li class="breadcrumb-item active">Avance de temas de cronograma</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              
              <div class = "row-fluid"> 
		               <div class = "col-md-6">
		               	   <p>Porcentaje de avance global </p>
		               </div>
			                 
			   <%
			   DT_tema_cronograma dtc = new DT_tema_cronograma();
       			//para el porcentaje
       			DT_grupo_tarea dtgrut = new DT_grupo_tarea();
			    double porcentajeGlobal = dtgrut.calcularPorcentajeGlobal();
			   
			   %>
			           <div class = "col-md-6"> 
				           <div class="progress" >
			  				   <div id="barra_progreso" class="progress-bar" role="progressbar" style="width: <%=porcentajeGlobal%>%" aria-valuenow="<%=porcentajeGlobal%>" aria-valuemin="0" aria-valuemax="100"><%=String.format("%.2f" ,porcentajeGlobal)%>%</div>
						   </div>
						</div>
		       </div>
		                
            </div>
              
            <!-- /.card-header -->
            <div class="card-body">
            
            	<a href="../acompanamiento/newtarea_grupal_admin.jsp?">Crear tarea para grupos <i class="fas fa-plus-circle"></i></a>
            
	            <ul class="list-group">
	            <%
	                	
	            		double porcentaje = 0.0;
	         	        				
	         	       	ArrayList<Vw_tema_cronograma> temas = new  ArrayList<Vw_tema_cronograma> ();
	         	       	temas = dtc.listar_temas_administrador();
	      	        	
	      	        	for(Vw_tema_cronograma vtc : temas)	{
	      	        		
	      	        		porcentaje = dtgrut.calcularPorcentajeAvanceFCE(vtc.getId_tema());
	               	%>
	               	<li class = "list-group-item ">
	               		<div class = "row-fluid"> 
		               		<div class = "col-md-6">
		               			<a class="ref-color" href="../../pages/acompanamiento/tbltareas_grupo.jsp?id_tem=<%=vtc.getId_tema()%>"><%=vtc.getTema()%> del <%=vtc.getDescripcion_cronograma()%></a>	
		               		</div>
			                 
			                 <div class = "col-md-6"> 
				                  <div class="progress" >
			  					  	<div id="barra_progreso" class="progress-bar" role="progressbar" style="width: <%=porcentaje%>%" aria-valuenow="<%=porcentaje%>" aria-valuemin="0" aria-valuemax="100"><%=porcentaje%>%</div>
								  </div>
							  </div>
		                </div>
		            </li>
	             <%}%>
	            </ul>
            
     
          </div>
          <!-- /.card-body -->
          </div>
          <!-- /.card -->

        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Footer -->
  	<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  <!-- ./Footer -->
  
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>


<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- Select2 -->
<script src="../../plugins/select2/js/select2.full.min.js"></script>
<!-- jAlert js -->
<script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
<script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  
  

<script>
	function linkVercro(idcro){
		
		window.location.href="../../pages/inscripcion/verCronograma.jsp?id_cronograma="+idcro;
	}

</script>

<script>
function addActividad(idcro){
	window.location.href="../../pages/inscripcion/verCronograma.jsp?cronogramaID="+idcro;
}
function linkEditarcro(idcro){
	window.location.href="../../pages/inscripcion/editCronograma.jsp?id_cronograma="+idcro;
}

function setIdTema(id, id2){
	idTema = id
	tutorfieldId = id2
	console.log(idTema, tutorfieldId)
}
//Variables
var idTema = 0
var tutorfieldId = ""

/////////// VARIABLES DE CONTROL MSJ ///////////
 var mensaje =  "<%=mensaje%>"

 if(mensaje == "1")
   successAlert('Éxito', 'El registro ha sido almacenado correctamente.')
 
 if(mensaje == "3")
   successAlert('Éxito', 'El registro ha sido modificado correctamente.')
 
 if(mensaje == "4")
   successAlert('Éxito', 'El registro ha sido eliminado correctamente.')
 
 if(mensaje == "5")
   errorAlert('Error', 'El registro no se ha podido eliminar.')
 
</script>

</body>
</html>

