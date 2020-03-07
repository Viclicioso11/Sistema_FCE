<%
  	String loginUser = "";
  	int rolId = 0;

  	loginUser = (String) session.getAttribute("login");
  	loginUser = loginUser==null?"":loginUser;
%>  


  <!-- Main Sidebar Container -->
  <aside class="main-sidebar elevation-4 sidebar-light-primary">
    
    
    <!-- Brand Logo -->
    <a href="sistema.jsp" class="brand-link navbar-gray-dark">
      <img src="dist/img/logo.jpg" alt="inicio del sistema.jsp" class="brand-image img-circle elevation-3">
      <span class="brand-text font-weight-light">Sistema FCE</span>
    </a>
     
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block" id="">Bienvenido: <%=loginUser %></a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          
          <li class="nav-item">
            <a href="./sistema.jsp" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                HOME
              </p>
            </a>
          </li>
            
          <li class="nav-header">EXAMPLES</li>
         
          
          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-book"></i>
              <p>
                Inscripci�n
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <!-- sub nav -->
            <ul class="nav nav-treeview">
            
              <li class="nav-item">
                <a href="pages/inscripcion/tblEstudianteCandidato.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Estudiantes</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="pages/inscripcion/tblplan_graduacion.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Planes</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="pages/inscripcion/tblcronograma.jsp" class="nav-link">
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
                <a href="pages/acompanamiento/tbltema.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Temas</p>
                </a>
              </li>
            </ul>
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
                <a href="pages/mantenimiento/tblfacultades.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Facultades</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="pages/mantenimiento/tblcarrera.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Carreras</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="pages/mantenimiento/tbl_tipo_fce.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n Tipo FCE</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="pages/mantenimiento/tblambito.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gesti�n �mbito</p>
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
                <a href="pages/seguridad/tblusuarios.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Control Usuarios</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/seguridad/tblroles.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Control Roles</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/seguridad/tblopciones.jsp" class="nav-link">
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
