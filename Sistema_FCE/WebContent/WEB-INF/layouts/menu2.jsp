<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="../../sistema.jsp" class="brand-link">
      <img src="../../dist/img/AdminLTELogo.png" alt="inicio del sistema.jsp" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">Sistema FCE</span>
    </a>
     <%
  	String loginUser = "";
  	int rolId = 0;
  	loginUser = (String) session.getAttribute("login");
  	loginUser = loginUser==null?"":loginUser;
  	%>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
           <img src="../../dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Bienvenido: <%=loginUser %></a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item has-treeview menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
             <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../../sistema.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Inicio</p>
                </a>
              </li>
            </ul>
          </li>
            
          <li class="nav-header">GESTIONES</li>
          
         <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-graduation-cap"></i>
              <p>
                Inscripción
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../inscripcion/tblEstudianteCandidato.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Estudiantes</p>
                </a>
              </li>
            </ul>
              <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../inscripcion/tblplan_graduacion.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Planes</p>
                </a>
              </li>
            </ul>
               <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../inscripcion/tblcronograma.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Cronogramas</p>
                </a>
              </li>
            </ul>
          </li>
          
          
          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="fas fa-book"></i>
              <p>
                Acompañamiento
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="../acompanamiento/tbltema.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Temas</p>
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
                <a href="../mantenimiento/tblfacultades.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Facultades</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="../mantenimiento/tblcarrera.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Carreras</p>
                </a>
              </li>
        
              <li class="nav-item">
                <a href="../mantenimiento/tbl_tipo_fce.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Tipos FCE</p>
                </a>
              </li>
              
              <li class="nav-item">
                <a href="../mantenimiento/tblambito.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Gestión Ámbitos</p>
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