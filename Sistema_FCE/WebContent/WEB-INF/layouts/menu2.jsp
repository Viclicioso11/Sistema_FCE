<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-light-primary elevation-4">
    <!-- Brand Logo -->
    <a href="../../sistema.jsp" class="brand-link navbar-gray-dark">
      <img src="../../dist/img/logo.jpg" alt="inicio del sistema.jsp" class="brand-image img-circle elevation-3">
      <span class="brand-text font-weight-light">Sistema FCE</span>
    </a>
     <%
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
  	
  	%>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
           <img src="../../dist/img/letrasNombre/letra<%=letraNombre%>.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block"><%=nombre%> <%=apellido%></a>
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
          
         <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-graduation-cap"></i>
              <p>
                Inscripci�n
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../inscripcion/tblEstudianteCandidato.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Estudiantes</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../inscripcion/tblplan_graduacion.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Planes</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../inscripcion/tblcronograma.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Cronogramas</p>
                </a>
              </li>
            </ul>
          </li>
          
          
          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-book"></i>
              <p>
                Acompa�amiento
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../acompanamiento/tbltema.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Temas</p>
                </a>
              </li>
            </ul>
            <% //si es tutor
              if (rol_id == 3) {%>
             <ul class="nav nav-treeview">
              <li class="nav-item">
              
                <a href="../acompanamiento/tblgrupos_fce.jsp" class="nav-link">
                
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Tutor�as</p>
                </a>
              </li>
            </ul>
            <% } %>
          </li>
          
          
         <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-cogs"></i>
              <p>
                Mantenimiento
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
            
              <li class="nav-item">
                <a href="../mantenimiento/tblfacultades.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Facultades</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="../mantenimiento/tblcarrera.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Carreras</p>
                </a>
              </li>
        
              <li class="nav-item">
                <a href="../mantenimiento/tbl_tipo_fce.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Tipos FCE</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="../mantenimiento/tblambito.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n �mbitos</p>
                </a>
              </li>
            </ul>
          </li>
               
          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-shield-alt"></i>
              <p>
                Seguridad
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../seguridad/tblusuarios.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Control Usuarios</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../seguridad/tblroles.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Control Roles</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../seguridad/tblopciones.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Control de Opciones</p>
                </a>
              </li>
            </ul>
          </li>
          
 
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>