  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
  
   
 <%

 String rol_texto = session.getAttribute("id").toString();
 int id_rol = 0;
if(rol_texto != null) {
	
	id_rol = Integer.parseInt(rol_texto);
	
}

%>

<%


DT_usuario_tema dtut = new DT_usuario_tema();
DT_vw_tema_tarea dtttar = new DT_vw_tema_tarea();
DT_tipo_fce dtfc = new DT_tipo_fce();

String id_usuario_texto = "";

id_usuario_texto = session.getAttribute("idUsuario").toString();

	int id_usuario = 0;

	if(id_usuario_texto != null) {
		id_usuario = Integer.parseInt(id_usuario_texto);
 }

int id_tema = 0;
String ListaTarea;
id_tema = dtut.ibtenerIdTema(id_usuario);

ArrayList<Tbl_tarea> listaTarea = new ArrayList<Tbl_tarea>();

//obtenemos todas las tareas del estudiante correspondiente
listaTarea = dtttar.listarTareas(id_tema);
ListaTarea = dtttar.ArrayToJson(listaTarea);

%>
<div>
	<div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Sistema</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Calendario</li>
            </ol>
          </div><!-- /.col -->
        </div>
      </div><!-- /.container-fluid -->
    </div>

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
      
        <div class="row">
				     <!-- calendar column -->
          <div class="col-md-12">
            <div class="card">
              <div class="card-body">
                <!-- THE CALENDAR -->
                <div id="calendarTarea"></div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- end calendar column -->

        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    <!-- jQuery -->
		<script src="plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI -->
		<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
		<script>
		    $(document).ready(function ()
		    {
		    	let colores = ["#22e694", "#ed6d5f", "#d18de0", "#e1eb5e", "#f2c144", "#87c3f5", "#f7e4f3", "#b4f0cf", "#aeed7e"];
		    	let actividades = <%=ListaTarea%>;
		    	<%System.out.print(ListaTarea);%>
		
		    	for(let i =0; i < actividades.length; i++){
		    		
		    		agregar(actividades[i],colores[i%10]);
		    	}
		
		    });
    </script>
    <!-- /.content -->
</div>
    
	  