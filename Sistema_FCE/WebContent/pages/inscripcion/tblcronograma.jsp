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
  <title>Gestión de Cronograma</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <!-- select2 css -->
  <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  
  
</head>
<body class="hold-transition sidebar-mini layout-fixed">
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
            <h1>Gestión de Cronograma</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#"></a>Inscripción</li>
              <li class="breadcrumb-item active">Gestión de Cronograma</li>
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
              <a href="../inscripcion/newcronograma.jsp">Crear Cronograma<i class="fas fa-plus-circle"></i></a>
               &nbsp; &nbsp; &nbsp; &nbsp;
                
            </div>
              
            <!-- /.card-header -->
            <div class="card-body" style="overflow-x: scroll">
              <table id="example2" class="table table-bordered">
                <thead>
	                <tr>
	                  <th>Número de Cronograma</th>
	                  <th>Descripción</th>
	                  <th>Tipo</th>
	                  <th>Fecha de Inicio</th>
	                  <th>Fecha de Fin</th>
	                  <th>Opciones</th>
	                </tr>
                </thead>
                <tbody>
                <%
                	DT_cronograma dtc = new DT_cronograma();
         	        				
         	        //TemasS para mostrar los temas sin tutor
         	       	ArrayList<Tbl_cronograma> actividades = new  ArrayList<Tbl_cronograma> ();
         	       	actividades = dtc.listarCronogramas();
      	        	
      	        	for(Tbl_cronograma cro : actividades)	{
      	        		
      	        		
               	%>
	                <tr>
	                  <td><%=cro.getId()%></td>
	                  <td><%=cro.getDescripcion()%></td>
	                  <td><%=cro.getTipo_cronograma()%></td>
	                  <td><%=cro.getFecha_inicio()%></td>
	                  <td><%=cro.getFecha_fin()%></td>
	                  
	                  <%
	                  if(cro.getEstado() == 3){
	                	  //si el estado es igual tres no puede editar, solo ver, pues ya acabó
	                  %>
	                   <td>
                	 	<a href="#" onclick="linkVercro('<%=cro.getId()%>');"><i class="fas fa-eye" title="Ver"></i></a>
	                  </td>
	                  <%
	                  	}
	                  else{  
	                  %>
	                  
	                  <td>
	                  <a href="./addActivityCronograma.jsp?cronogramaID=<%=cro.getId()%>" title="agregar actividades"><i class="fas fa-plus"></i></a> 
	                  
	                  <a href="#" onclick="linkEditarcro('<%=cro.getId()%>');"><i class="far fa-edit" title="Editar"></i></a>
	                  
                	 	<a href="#" onclick="linkVercro('<%=cro.getId()%>');"><i class="fas fa-eye"title="Ver"></i></a>
		                    	
	                  </td>
	                </tr>
	                <%}%>
	            <%}%>
                </tbody>
              </table>
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
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>


<script src="../../plugins/select2/js/select2.full.min.js"></script>

<!-- page script -->

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
</script>

<script>

  
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
   
   
   
   var idTema = 0
   var tutorfieldId = ""
   
 function setIdTema(id, id2){
	idTema = id
	tutorfieldId = id2
	console.log(idTema, tutorfieldId)
 }
 
 function setTutor(){
	 
	 let tutor = $("#tutor").val()
	 let tema = idTema;
	 
	 console.table({tutor: tutor, temaId: tema})
	 /*
	 *	hacer la funcion con ajax, post, 
	 *	y mandar tutor y tema y depues es logica tuya xd 
	 */
	 $.ajax({
	        type: "GET",
	        url: "../../SL_vw_Tema",
	        data:{tutorId: tutor, temaId: tema} ,
	        contentType : "application/json",
	        error : function(){ 
	        	errorAlert('ERROR', 'Contacte con administrador de sitio');
	        },
	        success: function(msg){
	        	
	        	if(msg == "2"){
	        		warningAlert('Error', 'Tutor no válido o no disponible');
	        	}
	        	else{
	        		successAlert('Éxito', 'Tutor Asignado: '+ msg);
	        		$("#" + tutorfieldId).html(msg)
	           	 
	        	}
	        	 
	        }
	    });   
	/*
		se pone en el la tabla el tutor
	*/
	
	
 }
 
</script>

</body>
</html>

