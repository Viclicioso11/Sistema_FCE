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
	
    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
          
            <div class="card">
            	
              <div class="card-header">
                
				<h4>SISTEMA FCE</h4>
			
              
              </div>
             
             </div>
             
               <!-- /.card -->
          </div>
          <!-- /.col-md-6 -->
        
          <!-- /.col-md-6 -->
        </div>
              
        <div class="row">
				     <!-- calendar column -->
          <div class="col-md-12 col-lg-8">
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
			 	<div class = "col-12 col-lg-4">
              	
              	<div class = "card">
              		<div class = "card-body">
              		<h4 style="text-align: center;"> Otros servicios UCA </h4>
						<table style="margin: 7px auto 0px;">
							<tbody>
							<tr style="border-bottom: 1px solid #c8c8c8; border-top: 1px solid #c8c8c8;">
							<td style="text-align: center; width: 25%; padding: 5px;"><i class="fa fa-university"></i></td>
							<td style="width: 75%; padding: 5px;">
							<h5 style="margin: 2px 0px;"><span style="font-size: medium;"><a target="_blank" href="http://www.uca.edu.ni/">Sitio Principal UCA</a></span></h5>
							</td>
							</tr>
							<tr style="border-bottom: 1px solid #c8c8c8;">
							<td style="width: 25%; text-align: center; padding: 5px;"><i class="fas fa-globe-americas"></i></td>
							<td style="width: 75%; padding: 5px;">
							<h5 style="margin: 2px 0px;"><span style="font-size: medium;"><a target="_blank" href="https://serviciosenlinea.uca.edu.ni/ss/Home.aspx">Servicios en Línea</a></span></h5>
							</td>
							</tr>
							<tr style="border-bottom: 1px solid #c8c8c8;">
							<td style="width: 25%; text-align: center; padding: 5px;"><i class="fa fa-book"></i></td>
							<td style="width: 75%; padding: 5px;">
							<h5 style="margin: 2px 0px;"><span style="font-size: medium;"><a target="_blank" href="http://virtual.uca.edu.ni/">EVA</a></span></h5>
							</td>
							</tr>
							</tbody>
					</table>
						              	
              		</div>
              	</div>
              	</div> 




        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
      </div>
       
    <!-- jQuery -->
		<script src="plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI -->
		<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
		
		<script src="./js/inicioEstudiante.js"></script>
		
		
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
    
	  