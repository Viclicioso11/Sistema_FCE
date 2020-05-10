  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
  
   
 <%

 String rol_texto = session.getAttribute("id").toString();
 String id_usuario_texto = session.getAttribute("idUsuario").toString();
 int id_rol = 0;
 int id_usuario = 0;
if(rol_texto != null) {
	
	id_rol = Integer.parseInt(rol_texto);
	
}
if(id_usuario_texto != null) {
	
	id_usuario = Integer.parseInt(id_usuario_texto);
	
}
%>


    <%

/* RECUPERAMOS EL VALOR DE LA VARIABLE cronogramaID */



/* OBTENEMOS LOS DATOS DEl cronograma a ver */


DT_vw_tema_tarea dttar = new DT_vw_tema_tarea();
ArrayList<Vw_tema_tarea> listaTareas = new ArrayList<Vw_tema_tarea>();


//cargamos la lista de tareas asignadas

listaTareas = dttar.listarTareasTutor(id_usuario);



%>
    <!-- Main content -->
    <div class="content">
   
   
		    <!-- jQuery -->
		<script src="plugins/jquery/jquery.min.js"></script>
		<!-- jQuery UI -->
		<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
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
              
              
              <div class = "row">
              
              
              	<div class = "col-12 col-lg-8">
              	
	              	<div class = "card card-primary">
		              	<div class = "card-body">	
		              		<div id = "calendarTutor"> </div>
		              	</div>
              	
              	</div>
              	
              	</div>
              	
              	<div class = "col-12 col-lg-4">
              	<div class = "row">
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
              	<div class = "row">
	              	<div class = "card">
	              		 <div class="card-body">
	              		 
	              		 <h4 style="text-align: center;"> Detalles de tarea </h4>
	              		 
	                    <div class="form-group">
	                      <label >Título tarea</label>
	                      <input id = "tituloTarea" type="text" class="form-control form-control-sm" required autocomplete="off">
	                    </div>
	
	   					<div class="form-group">
	                      <label >Descripción tarea</label>
	                      <input id = "descripcionTarea" type="text" class="form-control form-control-sm" required autocomplete="off">
	                    </div>
	                    
	                     <div class="form-group">
	                      <label>Rango de Fecha:</label>
	                      <div class="input-group">
	                        <div class="input-group-prepend">
	                          <span class="input-group-text">
	                            <i class="far fa-calendar-alt"></i>
	                          </span>
	                        </div>
	                        <input  type="text" class="form-control float-right form-control-sm" id="fechasTarea" required autocomplete="off">
	                      </div>
	                    </div>

               		 </div>
							
							              	
	              		</div>
	              	</div>
              	
              	</div>
              	
              	
              	</div>              
              
              </div>

        <!-- /.row -->
      </div>
      <script src="./js/inicioTutor.js"></script>
      
<script>
    $(document).ready(function ()
    {
    	
    	//Declaracion de variables para enviar al metodo para poner los eventos al calendario
    	let descripcion = "";
    	let titulo = "";
    	let fechaInicio = "";
    	let fechaFin = "";
    	let tema = "";
    	let id = 0;
    	let estado_tarea = 0;
    	let colores = "";
    	
    	<%
    	//por cada iteracon coloca un evento en el calendario
    	String[] colores = {"#e8791e", "#1e97e8", "#e82b1e"};
    	for(Vw_tema_tarea vttar :listaTareas){
    		
    		%>	
    		
    		descripcion = "<%=vttar.getDescripcion_tarea()%>";
    		titulo = "<%=vttar.getTitulo_tarea()%>";
    		fechaInicio = "<%=vttar.getFecha_inicio()%>";
    		fechaFin = "<%=vttar.getFecha_fin()%>";
    		id = <%=vttar.getId()%>;
    		
    		colores = "<%=colores[vttar.getEstado()]%>";
    		
    		addEvent(descripcion, titulo, fechaInicio, fechaFin, id, colores);
    		
    		<%	
    		
    	}
    		%>
    	
    	
    
    });
    </script>
      <!-- /.container-fluid -->
    
    
    <!-- /.content -->