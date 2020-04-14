<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

<% String idtema = request.getParameter("idtema");
 
 
 if (idtema == null){
	 response.sendRedirect("../../Error.jsp");
	 return;
 }
 
 %>
<div class="card">
	<div class="card-body">
		<h3>Cierre de la Culminación de Estudio</h3>
		
		<p>
			Ya se ha subido el archivo final para esta Culminación de estudio
			<br>
			de no ser así, comuníquise con el administrador del sistema o con su tutor
		</p>
		
		<br>
		<p>Si quiere guardar la carta como PDF presione <strong>Ctrl + P</strong> al mismo tiempo</p>
		<a href="./carta_aval.jsp?idTema=<%=idtema %>" target="_blank" class="btn btn-outline-primary" >Ver carta aval</a>
	</div>
</div>


<script>
let idTema = <%=idtema%>;

(function mensajes(){

    let uri = new URL(window.location.href)
    let msg =  uri.searchParams.get("msg")

    if (msg != null){
      window.history.replaceState("any", "any", "./carta_aval.jsp?idtema=" + idTema);
    }
})();
</script>
