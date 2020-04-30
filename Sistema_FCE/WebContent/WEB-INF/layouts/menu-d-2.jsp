<%@ page import="entidades.*,datos.*, java.util.*;"%>

<%

	/*
		
	*/
  	String loginUser = "";
  	String rolIdTexto = session.getAttribute("id").toString();
  	
  	
  	String nombre = session.getAttribute("nombre").toString();
  	String apellido = session.getAttribute("apellido").toString();
  	
  	loginUser = (String) session.getAttribute("login");
  	loginUser = loginUser==null?"":loginUser;
  	
  	int rol_id = 0;

  	if(rolIdTexto != null) {
  		rol_id = Integer.parseInt(rolIdTexto);
    }
  	
  	char letraNombre = ' ';
  	if(nombre.charAt(0) == ' ') {
  		letraNombre = nombre.toUpperCase().charAt(1);
  	}else {
  		letraNombre =  nombre.toUpperCase().charAt(0);
  	}
  	
  	
  	/*
  		obtener opciones
  	*/
  	DT_rol_opcion DTROL = new DT_rol_opcion();
	ArrayList <Vw_rol_opcion> arrayOpciones = new ArrayList <Vw_rol_opcion>();
	arrayOpciones = DTROL.getOpciones(session.getAttribute("listOpciones"));
	
	
%>
  	
 <!-- Main Sidebar Container -->
 <aside class="main-sidebar elevation-4 sidebar-light-primary">
   
   
   <!-- Brand Logo -->
   <a href="../../sistema.jsp" class="brand-link navbar-gray-dark">
     <img src="../../dist/img/logo.jpg" alt="inicio del sistema.jsp" class="brand-image img-circle elevation-3">
     <span class="brand-text font-weight-light">Sistema FCE</span>
   </a>
    
   <!-- Sidebar -->
   <div class="sidebar">
     <!-- Sidebar user panel (optional) -->
     <div class="user-panel mt-3 pb-3 mb-3 d-flex">
       <div class="image">
         <img src="../../dist/img/letrasNombre/letra<%=letraNombre%>.png" class="img-circle elevation-2" alt="User Image">
       </div>
       <div class="info">
         <a href="#" class="d-block" id=""><%=nombre%> <%=apellido%></a>
       </div>
     </div>

     <!-- Sidebar Menu -->
     <nav class="mt-2">
       <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
         <!-- Add icons to the links using the .nav-icon class
              with font-awesome or any other icon font library -->
         
         <li class="nav-item">
           <a href="../../sistema.jsp" class="nav-link active">
             <i class="nav-icon fas fa-tachometer-alt"></i>
             <p>
               HOME
             </p>
           </a>
         </li>
           
         <li class="nav-header">GESTIONES</li>
        
         <%	
         	/*
         		mostrar inscripcion
         	*/
         	String[] inscripcionO = {
         			"tblEstudianteCandidato.jsp",
         			"tblplan_graduacion.jsp",
         			"tblcronograma.jsp",
         			"inscripcion_tema.jsp",
         			"buscarTema.jsp",
         			"Informe_tema_tutor.jsp"};
         	
         	if(DTROL.isInOption(arrayOpciones, inscripcionO)){ //Comienzo if Inscripcion %>
         <li class="nav-item has-treeview">
           <a href="#" class="nav-link">
             <i class="fas fa-graduation-cap"></i>
             <p>
               Inscripción
               <i class="fas fa-angle-left right"></i>
             </p>
           </a>
           <!-- sub nav --> 
           
           <ul class="nav nav-treeview">
           	
           	 <%if(DTROL.isInOption(arrayOpciones, inscripcionO[0])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../inscripcion/tblEstudianteCandidato.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Estudiantes</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%if(DTROL.isInOption(arrayOpciones, inscripcionO[1])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../inscripcion/tblplan_graduacion.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Planes</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             
             <%if(DTROL.isInOption(arrayOpciones, inscripcionO[2])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../inscripcion/tblcronograma.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Cronogramas</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             
             <%if(DTROL.isInOption(arrayOpciones, inscripcionO[3])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../inscripcion/inscripcion_tema.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Inscribir Tema</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%if(DTROL.isInOption(arrayOpciones, inscripcionO[4])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../inscripcion/buscarTema.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Buscar Tema</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%if(DTROL.isInOption(arrayOpciones, inscripcionO[5])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../acompanamiento/Informe_tema_tutor.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Informe Tutores</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
           </ul>
         </li>
         <%}//fin del if Inscripcion(general) %>
         
         
         <%	
         	/*
         		mostrar Acompañamiento
         	*/
         	String[] AcompanamientoO = {
         			"tbltema.jsp",
         			"tblgrupos_fce.jsp",
         			"tbltareas_individual.jsp",
         			"tblgrupos_administrador.jsp",
         			"Listado_temas.jsp"};
         	
         	if(DTROL.isInOption(arrayOpciones, AcompanamientoO)){ //Comienzo if Acompañamiento %>
         <li class="nav-item has-treeview">
           
           <a href="#" class="nav-link">
             <i class="fas fa-book"></i>
             <p>
               Acompañamiento
               <i class="fas fa-angle-left right"></i>
             </p>
           </a>
           
           <ul class="nav nav-treeview">
           	 
           	 <%if(DTROL.isInOption(arrayOpciones, AcompanamientoO[0])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../acompanamiento/tbltema.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Temas</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%
           	 	if(DTROL.isInOption(arrayOpciones, AcompanamientoO[1])){
           	 %>
             <li class="nav-item">
               <a href="../acompanamiento/tblgrupos_fce.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Tutorías</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%
           	 	if(DTROL.isInOption(arrayOpciones, AcompanamientoO[2])){
           	 %>
             <li class="nav-item">
               <a href="../acompanamiento/tbltareas_individual.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Asignaciones</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             <%
             if(DTROL.isInOption(arrayOpciones, AcompanamientoO[3])){
           	 %>	           	 
             <li class="nav-item">	
               <a href="../acompanamiento/tblgrupos_administrador.jsp" class="nav-link">	
                 <i class="far fa-circle nav-icon"></i>	
                 <p>Avance Cronograma</p>	
               </a>	
             </li>	
             <%}//fin IF secundario %>
             
             <%
             if(DTROL.isInOption(arrayOpciones, AcompanamientoO[4])){
           	 %>	           	 
             <li class="nav-item">	
               <a href="../acompanamiento/Listado_temas.jsp" class="nav-link">	
                 <i class="far fa-circle nav-icon"></i>	
                 <p>Biblioteca de Temas</p>	
               </a>	
             </li>	
             <%}//fin IF secundario %>
             
           </ul>
         </li>
         <%}//fin Acompañamiento(general) %>
        
        <%
        	/*
        		mostrar evaluacion
        	*/
        	String[]  evaluacion = {"cierre_fce.jsp"};
        	if(DTROL.isInOption(arrayOpciones, evaluacion)){ //Comienzo if Evaluacion %>
        
        	<li class="nav-item has-treeview">
           
           <a href="#" class="nav-link">
             <i class="fas fa-tasks"></i>
             <p>
               Evaluación
               <i class="fas fa-angle-left right"></i>
             </p>
           </a>
           
           <ul class="nav nav-treeview">
           	 
           	 <%

             int id_user = Integer.parseInt(session.getAttribute("idUsuario").toString());
           	 
             if(id_user != 0){
            	 DT_usuario_tema dtTema = new DT_usuario_tema();
            	 int idtema = dtTema.ibtenerIdTema(id_user);
            	 
            	 if(DTROL.isInOption(arrayOpciones, evaluacion[0]) && idtema != 0){ %>
            		 
	             <li class="nav-item">
	               <a href="../acompanamiento/cierre_fce.jsp?idtema=<%=idtema%>" class="nav-link">
	                 <i class="far fa-circle nav-icon"></i>
	                 <p>Enviar Archivo Final</p>
	               </a>
	             </li>
             <%}}//fin IF secundario %>
             
           </ul>
         </li>
        
        <%}//fin Evaluacion(general) %>
        
        <%	
         	/*
         		mostrar Mantenimiento
         	*/
         	String[] MantenimientoO = {
         			"tblfacultades.jsp",
         			"tblcarrera.jsp",
         			"tbl_tipo_fce.jsp",
         			"tblambito.jsp"};
         	
         	if(DTROL.isInOption(arrayOpciones, MantenimientoO)){ //Comienzo if Mantenimiento %>
        <li class="nav-item has-treeview">
           <a href="#" class="nav-link">
             <i class="fas fa-cogs"></i>
             <p>
               Mantenimiento
               <i class="fas fa-angle-left right"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
           	
           	 <%if(DTROL.isInOption(arrayOpciones, MantenimientoO[0])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../mantenimiento/tblfacultades.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Facultades</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%if(DTROL.isInOption(arrayOpciones, MantenimientoO[1])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../mantenimiento/tblcarrera.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Carreras</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%if(DTROL.isInOption(arrayOpciones, MantenimientoO[2])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../mantenimiento/tbl_tipo_fce.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Tipo FCE</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
             <%if(DTROL.isInOption(arrayOpciones, MantenimientoO[3])){//Comienzo if Secundario%>
             <li class="nav-item">
               <a href="../mantenimiento/tblambito.jsp" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>Gestión Ámbito</p>
               </a>
             </li>
             <%}//fin IF secundario %>
             
           </ul>
        </li>
        <%}//Fin Mantenimiento (General) %>
        
        
        <%	
         	/*
         		mostrar Seguridad
         	*/
         	String[] seguridadO = {
         			"tblusuarios.jsp",
         			"tblroles.jsp",
         			"tblopciones.jsp"};
         	
         	if(DTROL.isInOption(arrayOpciones, seguridadO)){ //Comienzo if Seguridad %>
        <li class="nav-item has-treeview">
          <a href="#" class="nav-link">
            <i class="fas fa-shield-alt"></i>
            <p>
              Seguridad
              <i class="fas fa-angle-left right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview">
          
          	<%if(DTROL.isInOption(arrayOpciones, seguridadO[0])){//Comienzo if Secundario%>
            <li class="nav-item">
              <a href="../seguridad/tblusuarios.jsp" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p>Control Usuarios</p>
              </a>
            </li>
            <%}//fin IF secundario %>
            
            <%if(DTROL.isInOption(arrayOpciones, seguridadO[1])){//Comienzo if Secundario%>
            <li class="nav-item">
              <a href="../seguridad/tblroles.jsp" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p>Control Roles</p>
              </a>
            </li>
            <%}//fin IF secundario %>
            
            <%if(DTROL.isInOption(arrayOpciones, seguridadO[2])){ //Comienzo if Secundario%>
            <li class="nav-item">
              <a href="../seguridad/tblopciones.jsp" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p>Control de Opciones</p>
              </a>
            </li>
            <%}//fin IF secundario %>
            
          </ul>
        </li>
        <%}//Fin Seguridad (General) %>

       </ul>
     </nav>
     <br />
     <br />
     <!-- /.sidebar-menu -->
   </div>
   <!-- /.sidebar -->
 </aside>