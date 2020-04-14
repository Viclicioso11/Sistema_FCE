

function editarEstado(id_tarea) {
	
	 let estadoTarea = document.getElementById("estadoTarea").value;	
	 let id_tema = document.getElementById("id_tem").value;		
	 

	    $.ajax({
	    	  type: "GET",
	    	  url: "../../SL_tarea",
	    	  data:{estado : estadoTarea, opc : 1, tarea : id_tarea, tema : id_tema} ,
	    	  contentType : "application/json",
	    	  error : function(){ 
	    	       errorAlert('ERROR', 'Contacte con administrador de sitio');
	    	  },
	    	  success: function(msg){
	    	      if(msg == "1"	){
	    	       
	    	        successAlert('Exito', 'Estado de tarea editado correctamente');
	    	        }
	    	        	
	    	      if(msg == "2"){
	    	        	warningAlert('Error', 'No se ha podido editar la tarea');
	    	      }
	    	        	
	    	    }
	    });
	
}


function editarEstadoEstudiante(id_tarea) {
	
	 let estadoTarea = document.getElementById("estadoTarea").value;	
	 let id_tema = document.getElementById("id_tem").value;		
	 

	    $.ajax({
	    	  type: "GET",
	    	  url: "../../SL_tarea",
	    	  data:{estado : estadoTarea, opc : 1, tarea : id_tarea, tema : id_tema} ,
	    	  contentType : "application/json",
	    	  error : function(){ 
	    	       errorAlert('ERROR', 'Contacte con administrador de sitio');
	    	  },
	    	  success: function(msg){
	    	      if(msg == "1"	){
	    	       
	    	        successAlert('Exito', 'Estado de tarea editado correctamente');
	    	        
	    	        if(estadoTarea == 1) {
	    	        	document.getElementById("estadoTarea").disabled = true;
	    	        }
	    	        
	    	        }
	    	        	
	    	      if(msg == "2"){
	    	        	warningAlert('Error', 'No se ha podido editar la tarea');
	    	      }
	    	        	
	    	    }
	    });
	
}