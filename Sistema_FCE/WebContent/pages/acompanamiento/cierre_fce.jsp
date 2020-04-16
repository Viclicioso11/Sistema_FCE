<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
    
    
    
<%
 String idtema = request.getParameter("idtema");
 
 
 if (idtema == null){
	 response.sendRedirect("../../Error.jsp");
	 return;
 }
  
 DT_cierre dtCierre = new DT_cierre();
 boolean cierre = dtCierre.tieneCierre(Integer.parseInt(idtema));
%>



<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
  <!-- scripst propios -->
  <!-- 
  <script src="./js/jquery-2.1.4.min.js"></script>
  <script src="./js/javascript.js"></script>
   -->
  <title>Cierre de FCE</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css">
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  
  <!-- list tree view -->
  <link rel="stylesheet" href="./css/list_tree.css">
  
  <!-- dropfile -->
  <link rel="stylesheet" href="../../plugins/dropfile/file-drop.css">
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
		           
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item"><a href="#"></a>Acompañamiento</li>
		              <li class="breadcrumb-item active">Cierre de FCE</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		    
		    <section class="content">
		    	<div class="row">
		    		<div class="col-12">
		    		
		    		<%if(!cierre){//si esta FCE no se ha cerrado %>
			    		<jsp:include page="./cierre_nohecho.jsp"></jsp:include>
			    	<%} else { // si esta FCE ya se ha cerrado %>
			    		<jsp:include page="./Cierre_hecho.jsp"></jsp:include>
			    	<%}//fin del if-else %>
		    		</div>
		    	</div>
		    </section>
 		 </div>
 		 <!-- Footer -->
	     <jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
	     <!-- ./Footer -->
	</div>

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- jAlert js -->
<script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
<script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
<!-- dropfile -->
<%if(!cierre){//si esta FCE no se ha cerrado %>

<script src="../../plugins/dropfile/file-drop.js"></script>
<%}// si esta FCE ya se ha cerrado %>

<script>

let cerrado = false;
let idTema = <%=idtema%>;

(function mensajes(){
    let uri = new URL(window.location.href)
    let msg =  uri.searchParams.get("msg")


    if (msg == 1){
    	successAlert('Exito', 'Se ha enviado el archivo final');
    }
    if(msg == 2){
    	errorAlert('ERROR', 'No se ha podido enviar el archivo, por favor intentelo mas tarde o comuniquese con el administrador del sitio. verifique si el sistema soporta el archivo');
    }
    if (msg != null){
      window.history.replaceState("any", "any", "./cierre_fce.jsp?idtema=" + idTema);
    }
})();


if (!cerrado){
	
	let form = document.getElementById("form_cierre");
	document.getElementById("idtema").value = <%=idtema%>;
	
	document.getElementById("reset").addEventListener('click', function(e){
		e.preventDefault();
		form.reset();
		document.querySelector("#file-drop p").textContent = "Arrastra tus archivos aqui o Click aqui para buscar";
	});
}


</script>
</body>
</html>