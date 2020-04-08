<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*,java.text.SimpleDateFormat" %>
<%
	String idtema = request.getParameter("idTema");
	
	
	if (idtema == null){
		 response.sendRedirect("../../Error.jsp");
		 return;
	}

	Date dNow = new Date();
   SimpleDateFormat ft = 
   new SimpleDateFormat ("MM/dd/yyyy");
   String currentDate = ft.format(dNow);

   /* OBTENEMOS LOS DATOS DE USUARIO A SER EDITADOS */
   vw_tema_tutor tet= new vw_tema_tutor();
   DT_tema te = new DT_tema();
   Vw_tema_estudiante tee = new Vw_tema_estudiante();
	  
   
   int id = Integer.parseInt(idtema);

	 /*  tema = te.obtenerTema(id); */
   ArrayList<vw_tema_tutor> aval = new ArrayList<vw_tema_tutor>();
   aval= te.obtenertemasaval(id);
   for(vw_tema_tutor Aval: aval)
   {
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta  charset="utf-8"/>
<title>carta aval</title>
</head>

</head>

<body lang="Es-MX" style="tab-interval:35.4pt">
   <div class="WordSection1">
      	<p class="MsoNormal" text-aling="left" style="margin-top:0cm;margin-right: 0cm;">
     		 <o:p>&nbsp;</o:p>
     	 </p>
      	<p class="MsoNormal" style="margin-top:0cm; margin-right: 0cm;margin-bottom: 5.75pt; margin-left: 25pt;">Managua, <%=currentDate%></p>
        <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 5.85pt;margin-left: 0cm;text-align: left;text-indent: 0cm;">
       	  <span style="mso-spacerun:yes">&nbsp;</span>
        </p>
     	 <p class="MsoNormal" text-aling="left" style="margin-left: -25;text-align:left">
       	  <b style="mso-bidi-font-weight:normal">Msc. Mauricio Garcia Sotelo</b>
     	 </p>
     	 <p class="MsoNormal" text-aling="left" style="margin-left:0cm;text-align:left; text-indent: 0cm;">
        	 <i style="mso-bidi-font-style:normal">Director</i>
      	</p>
    	 <p class="MsoNormal" style="margin-left: -.25pts">Departamento de Desarrollo Tecnologico</p>
     	 <p class="MsoNormal" style="margin-left: -.25pt">Facultad de Ciencia, Tecnologia y Ambiente</p> 
    	 <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 5.75pt;margin-left: 0cm;text-align: left;text-indent: 0cm;">
        	 <span style="mso-spacerun:yes">&nbsp;</span>
      	</p>
    	 <p class="MsoNormal" text-aling="left" style="margin-left: -25;text-align:left">
         	<b style="mso-bidi-font-weight:normal">Estimado Master Garcia:</b>
      	</p>
     	 <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 5.75pt;margin-left: 0cm;text-align: left;text-indent: 0cm;">
        	 <span style="mso-spacerun:yes">&nbsp;</span>
      	</p>
     	 <p class="MsoNormal" style="margin-top: 0cm; margin-right: 0cm;margin-bottom:7.35pt;margin-left: -.25pt;">Yo, el Licenciado:  <%=Aval.getNombre_tutor()%> <%=Aval.getApellido_tutor()%>   de tutor de la Forma de Culminacion de Estudios: (<%=Aval.getTipo_fce() %>) titulada: <%=Aval.getTema() %></p>
	     	<ul>
	     	 <%
	     	 	  DT_vw_tema_estudiante dte = new DT_vw_tema_estudiante();
	     	   
	     		ArrayList<Vw_tema_estudiante> tema_estudiante = new ArrayList<Vw_tema_estudiante>();
	     	    tema_estudiante= dte.listarTemas_estudiante(id);  
	     	   
	     	  	for (Vw_tema_estudiante Tees: tema_estudiante){
	     		 %>
	     	 	 	<li><%=Tees.getNombres() %> <%=Tees.getApellidos() %></li>
	      		<%}; 
	      		%> 
	      	 
	      	 </ul>
	      <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 5.75pt;margin-left: 0cm;text-align: left;text-indent: 0cm;">
         <span style="mso-spacerun:yes">&nbsp;</span>
      	 </p>
     	 <p class="MsoNormal" style="margin-top: 0cm; margin-right: 0cm; margin-bottom: 8.1pt; margin-left: -.25pt;line-height: 150%;">Por tanto, 
       	  <b style="mso-bidi-font-weight:normal">otorgo la aceptacion y el aval del trabajo entregado</b>
        	 para su presentacion y evaluacion en acto de disertacio, para optar al titulo de <%=Aval.getCarrera() %>(Concentracion en Sistemas de informacion) que otorga la Universidad Centroamericana (UCA).
      	</p>
     	 <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 13.8pt;margin-left: 0cm;;text-indent: 0cm;">
         	<span style="mso-spacerun:yes">&nbsp;</span>
      	</p>
     	 <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 13.65pt;margin-left: 0cm;text-align: left;text-indent: 0cm;">
         	<span style="mso-spacerun:yes">&nbsp;</span>
      	</p>
      	<p class="MsoNormal" style="margin-left: -.25pt">Ratifica y firma</p>
     	 <p class="MsoNormal" text-aling="left" style="margin-top: 0cm;margin-right: 0cm; margin-bottom: 6.2pt;margin-left: 0cm;text-align: left">
    	     <b style="mso-bidi-font-weight:normal">Lic. <%=Aval.getNombre_tutor()%> <%=Aval.getApellido_tutor()%> </b>
      	</p>
      	<p class="MsoNormal" text-aling="left" style="margin-left: 0cm;text-align: left;text-indent: 0cm">
        	<span style="font-size: 11.opt;line-height: 107%;font-family: Calibri, sans-serif;mso-fareast-font-family:calibri">
            	 <span style="mso-spacerun:yes">&nbsp;</span>
         	</span>
      	</p>
   </div>
 <%} %>
</body>
</html>


