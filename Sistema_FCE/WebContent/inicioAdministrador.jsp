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

/* RECUPERAMOS EL VALOR DE LA VARIABLE cronogramaID */



/* OBTENEMOS LOS DATOS DEl cronograma a ver */


Tbl_cronograma tcro = new Tbl_cronograma();
DT_cronograma dtcro = new DT_cronograma();
DT_tipo_fce dtfc = new DT_tipo_fce();

//cargamos el cronograma actual 

int cronograma = dtcro.obtenerIdCronogramaFechas();

tcro = dtcro.obtenerDetallesCronograma(cronograma);
//para poner la url sin las comillas que trae de la base de datos
String tipoFCE = dtfc.obtenerTipoFceNombre(tcro.getTipo_cronograma());
ArrayList<Tbl_actividad_cronograma> listaActividades = new ArrayList<Tbl_actividad_cronograma>();

//obtenemos todas las actividades del cronograma correspondiente
listaActividades = dtcro.listarActividadesCronograma(cronograma);


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
                
					 <div class = "row"> 
		               <div class = "col-12 col-lg-6">
		               	   <p> <b>Porcentaje de avance de cronograma</b> </p>
		               </div>
			                 
			   <%
			   DT_tema_cronograma dtc = new DT_tema_cronograma();
       			//para el porcentaje
       			DT_grupo_tarea dtgrut = new DT_grupo_tarea();
			    double porcentajeGlobal = dtgrut.calcularPorcentajeGlobal();
			   
			   %>
			           <div class = "col-12 col-lg-6"> 
				           <div class="progress" >
			  				   <div id="barra_progreso" class="progress-bar" role="progressbar" style="background-color: #01284f; width: <%=porcentajeGlobal%>%" aria-valuenow="<%=porcentajeGlobal%>" aria-valuemin="0" aria-valuemax="100"><%=String.format("%.2f" ,porcentajeGlobal)%>%</div>
						   </div>
						</div>
		       </div>
			
              
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
		              		<div id = "calendarCrono"> </div>
		              	</div>
              	
              	</div>
              	
              	</div>
              	
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
      </div>
      
      
<script>
    $(document).ready(function ()
    {
    	
    	//Declaracion de variables para enviar al metodo para poner los eventos al calendario
    	let descripcion = "";
    	let nombre = "";
    	let fechaInicio = "";
    	let fechaFin = "";
    	let id = 0;
    	let colores = "";
    	
    	<%
    	//por cada iteracon coloca un evento en el calendario
    	String[] colores = {"#5be81e", "#22e694", "#ed6d5f", "#d18de0", "#e1eb5e", "#f2c144", "#87c3f5", "#f7e4f3", "#b4f0cf", "#aeed7e"};
    	int incColor = 0;
    	for(Tbl_actividad_cronograma tacro :listaActividades){
    		
    		%>	
    		
    		descripcion = "<%=tacro.getDescripcion()%>";
    		nombre = "<%=tacro.getNombre()%>";
    		fechaInicio = "<%=tacro.getFecha_inicio()%>";
    		fechaFin = "<%=tacro.getFecha_fin()%>";
    		id = <%=tacro.getId()%>;
    		colores = "<%=colores[incColor]%>";
    		
    		addEvent(descripcion, nombre, fechaInicio, fechaFin, id, colores);
    		
    		<%	
    		incColor++;
    	}
    		%>
    	
    	
    
    });
    </script>
      <!-- /.container-fluid -->
    </div>
    <!-- /.content -->