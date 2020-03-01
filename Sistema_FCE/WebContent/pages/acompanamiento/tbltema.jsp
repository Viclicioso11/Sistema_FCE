<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
<% 
	DT_rol_opcion Dtro = new DT_rol_opcion();
	ArrayList <Vw_rol_opcion> Opciones = new ArrayList <Vw_rol_opcion>();
	Opciones = Dtro.getOpciones(session.getAttribute("listOpciones"));
	
	/* //objetos para el login
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
	} */
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
  
  <!-- scripst propios -->
  <!-- 
  <script src="./js/jquery-2.1.4.min.js"></script>
  <script src="./js/javascript.js"></script>
   -->
  <title>Asignar tutor a FCE</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- jAlert css  -->
  <link rel="stylesheet" href="../../plugins/jAlert/dist/jAlert.css" />

  <!-- select2 css -->
  <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

  <!-- DATATABLE NEW -->
  <link href="../../plugins/DataTablesNew/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet">
  <!-- DATATABLE NEW buttons -->
  <link href="../../plugins/DataTablesNew/Buttons-1.5.6/css/buttons.dataTables.min.css" rel="stylesheet">


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
              <li class="breadcrumb-item"><a href="#"></a>Acompañamiento</li>
              <li class="breadcrumb-item active">Asignar tutor a FCE</li>
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
             <h2>Asignar tutor a FCE</h2>
             
             
            <!-- /.card-header -->
            <div class="card-body">
               &nbsp; &nbsp; &nbsp; &nbsp;
                <a href="../inscripcion/inscripcion_tema.jsp">Incripción de tema <i class="fas fa-user-tag"></i></a>
                
                <br/><br/>
                 <div class="form-group">
			          <label>Temas FCE</label>
			          <select class="form-control" style="width: 100%;" id="vista" onchange="vistatabla()">
			          	<!-- rellenar con los id XD -->
			          			          	
			  			  <option value="2">Temas sin tutor asignados</option>
				          <option value ="3">Temas con tutor asignados</option>
			          </select>
		          
        		</div>
       		 <div class = "card" id= "vista1">
              <table id="example1" class="table table-bordered">
                <thead>
	                <tr>
	                  <th>Id</th>
	                  <th>Tema</th>
	                  <th>Tipo</th>
	                  <th>Fecha</th>
	                  <th>Tutor</th>
	                  <th>Asignar tutor</th>
	                  <th>Opciones</th>
	                </tr>
                </thead>
                <tbody>
                <%
                	DT_vw_tema dtema = new DT_vw_tema();
         	        				
         	        //TemasS para mostrar los temas sin tutor
         	       	ArrayList<Vw_tema> TemasS= new  ArrayList<Vw_tema> ();
         	       	TemasS = dtema.listarTemas();
         	       	TemasS = dtema.filtrarSintutor(TemasS);
      	        	String Tutor = "";
      	        	
      	        	for(Vw_tema temaS: TemasS)	{
      	        		String tutor = "tutor no se ha asignado";
      	        		
               	%>
	                <tr>
	                  <td><%=temaS.getId_tema() %></td>
	                  <td><%=temaS.getTema() %></td>
	                  <td><%=temaS.getTipo_fce() %></td>
	                  <td><%=temaS.getFecha() %></td>
	                  <td id="tutorName<%=temaS.getId_tema() %>"><%=tutor %></td>

	                  <td>
                		<button 
                			type="button" 
                			class="btn btn-default" 
                			data-toggle="modal" 
                			data-target="#asignTutor" 
                			onClick="setIdTema(<%=temaS.getId_tema()%>, 'tutorName<%=temaS.getId_tema() %>')">
             				Asignar tutor 
                		</button>
            		  
	                  </td>
	                   
	                  <td>
		                  <a href="#" onclick="editTema('<%=temaS.getId_tema()%>');"><i class="far fa-edit" ></i></a>
			          </td>
	                </tr>

	            <%}%>  
                </tbody>
              </table>
              </div>
              
              <br/><br/>
              
              <div class = "card" id="vista2">
			  <table id="example2" class="table table-bordered">
                <thead>
	                <tr>
	                  <th>Id</th>
	                  <th>Tema</th>
	                  <th>Tipo</th>
	                  <th>Fecha</th>
	                  <th>Tutor</th>
	          
	                 <th>Opciones</th>
	                </tr>
                </thead>    
	            <% 
	           		 DT_vw_tema dtemas = new DT_vw_tema();
	            	ArrayList<Vw_tema> TemasC = new ArrayList<Vw_tema>();
	            	TemasC = dtema.listarTemasTutor();
	            	
	            	for(Vw_tema temaC: TemasC)	{
	            %>
	                <tr>
	                  <td><%=temaC.getId_tema() %></td>
	                  <td><%=temaC.getTema() %></td>
	                  <td><%=temaC.getTipo_fce() %></td>
	                  <td><%=temaC.getFecha() %></td>
	                  <td id="tutorName"><%=temaC.getNombre_tutor() %></td>
				      <td>
		                  <a href="#" onclick="editTema('<%=temaC.getId_tema()%>');"><i class="far fa-edit" ></i></a>
			          </td>
	                </tr>
	            <%}%>
	              
                </tbody>
              </table>
              </div>
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

  		<div class="modal fade" id="asignTutor" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	      <div class="modal-dialog" role="document">
	        <div class="modal-content">
	  
	        <div class="modal-header">
	          <h5 class="modal-title" id="exampleModalLabel">Asignar tutor</h5>
	          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	          </button>
	 		</div>
			  
        <!-- modal body -->
        
        <br />
        <div class="form-group" style="margin:2%">
          <label class="col-form-label">Nombre del tutor:</label>
          <select class="form-control select2" style="width: 100%;" id="tutor">
          	<!-- rellenar con los id XD -->
          	<%
           		DT_vw_rol_usuario dtr = new DT_vw_rol_usuario();
          		ArrayList<Vw_usuario_rol> listarTutor = new ArrayList<Vw_usuario_rol>();
           	    listarTutor = dtr.listarTutor();
		            	    
           	    for(Vw_usuario_rol tr : listarTutor )  {
           	%>
        		 <option value="<%=tr.getId_user()%>"><%=tr.getNombre() %></option>
		    <%	}  %>
          </select>
          
          
          	<br />
        </div>
        <!-- end modal body -->
        <div class="modal-footer">
	         <button type="button" class="btn btn-primary" onclick="setTutor()" data-dismiss="modal">Asignar</button>
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>  
	    </div>
        </div>
      </div>
    </div>
             
              
            </div>
  
  <!-- Footer -->
  	<jsp:include page="/WEB-INF/layouts/footer.jsp"></jsp:include>
  <!-- ./Footer -->
  
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- DataTables -->
<!-- <script src="../../plugins/datatables/jquery.dataTables.js"></script> -->
<!-- <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script> -->

<!-- DATATABLE NEW -->
  <script src="../../plugins/DataTablesNew/DataTables-1.10.18/js/jquery.dataTables.js"></script>

<!-- DATATABLE NEW buttons -->
  <script src="../../plugins/DataTablesNew/Buttons-1.5.6/js/dataTables.buttons.min.js"></script>

<!-- js DATATABLE NEW buttons print -->
  <script src="../../plugins/DataTablesNew/Buttons-1.5.6/js/buttons.html5.min.js"></script>
  <script src="../../plugins/DataTablesNew/Buttons-1.5.6/js/buttons.print.min.js"></script>

   <!-- js DATATABLE NEW buttons pdf -->
  <script src="../../plugins/DataTablesNew/pdfmake-0.1.36/pdfmake.min.js"></script>
  <script src="../../plugins/DataTablesNew/pdfmake-0.1.36/vfs_fonts.js"></script>

  <!-- js DATATABLE NEW buttons excel -->
  <script src="../../plugins/DataTablesNew/JSZip-2.5.0/jszip.min.js"></script>

<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>

<!-- Select2 -->
<script src="../../plugins/select2/js/select2.full.min.js"></script>
<!-- page script -->

<!-- jAlert js -->
  <script src="../../plugins/jAlert/dist/jAlert.min.js"></script>
  <script src="../../plugins/jAlert/dist/jAlert-functions.min.js"> </script>
  <script type="text/javascript"></script>

<script>
  $('#example2').DataTable({
      dom: 'Bfrtip',
      buttons: [
      'pdf',
      'excel',
      'print'
      ],
  	  "order": []

  });
  
  $('#example1').DataTable({
      dom: 'Bfrtip',
      buttons: [
      'pdf',
      'excel',
      'print'
      ],
  	  "order": []

  });
  
  $("#example2, #example1").css({
      "border": "none",
      "padding-top": "20px",
    })
   $("tr").css({"height": "49px"})
    
    
  $("#vista2").css({"display": "none"})
  
  $('#tutor').select2({ theme: 'bootstrap4' })
  
      /////////// VARIABLES DE CONTROL MSJ ///////////
 var mensaje =  "<%=mensaje%>"

 if(mensaje == "1")
   successAlert('ï¿½xito', 'El registro ha sido almacenado correctamente.')
 
 if(mensaje == "3")
   successAlert('ï¿½xito', 'El registro ha sido modificado correctamente.')
 
 if(mensaje == "4")
   successAlert('ï¿½xito', 'El registro ha sido eliminado correctamente.')
 
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
	 let nTutor = $("#tutor")
	 
	 console.log(tutor,tema)
	 /*
	 *	hacer la funcion con ajax, post, 
	 *	y mandar tutor y tema y depues es logica tuya xd 
	 */
	 
	 /*
	 generarAlerts("../../SL_vw_Tema",{tutorId: tutor, temaId: tema},"GET",
			 [{
		 		'msg':'2',
		 		'func':function(){WarningAlert('Tutor no vï¿½lido o no disponible')}
			 },{
				'msg':'6',
			    'func':function(){SuccessAlert('Tutor Asignado')}
			 }])
			 
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
	        		warningAlert('Error', 'Tutor no vï¿½lido o no disponible');
	        	}
	        	else{
	        		successAlert('ï¿½xito', 'Tutor Asignado: '+ msg);
	        		$("#" + tutorfieldId).html(msg)
	           	 
	        	}
	        	 
	        }
	    });
	/*
		se pone en el la tabla el tutor
	*/
	
	
 }
   
 function editTema(idTema){
	 window.location.href= "../inscripcion/editInscripcion_fce.jsp?temaID="+ idTema;
 }
 
 
function vistatabla(){
	let val = document.getElementById("vista").value;
	
	if(val ==2){
		$("#vista1").fadeIn()
		$("#vista2").fadeOut()
	}else{
		$("#vista1").fadeOut()
		$("#vista2").fadeIn()
	}
	
	
	
	
	
}
		
	

</script>

</body>
</html>

