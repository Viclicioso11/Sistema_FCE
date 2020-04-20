
//para validar cuando se deseleccione una u otra
var actividad;
var actividad2;
var elemento;
var id_actividad = 0;
var arrayActividad;
var opcion;
var opcion2;
var url;

function limpiarCampos(){
	/*rol =  document.getElementById(rol);
	rol.style.backgroundColor = "white";
	*/
	for(var i = 0; i < elemOpciones.length; i++){

			opcion = document.getElementById(elemOpciones[i]);
			opcion.style.backgroundColor = "white";
			
		
	}
	
	if(actividad != null) {
		elemento = document.getElementById(actividad);
		elemento.style.backgroundColor = "white";
	}
	
	elemento = document.getElementById("descripcionTarea");
	elemento.val("");
	elemento = document.getElementById("tituloTarea");
	elemento.val("");
	
	
	elemOpciones = [];

	
}




function editarTema() {
	
	let tema = $("#tema").val();
	
	
	let usuarios = $("#members").val();

	let palabrasClaves = $("#palabrasClave").val();
	
	let carrera = $("#carrera").val();
	
	let tipo_fce = $("#tipo_fce").val();
	
	let ambito_fce = $("#ambito_fce").val();
	
	
	let formSub = document.getElementById("formEditar");
	
	
	if( tema == "" ) {
		
		errorAlert('Error', 'Debe escribir el título de su FCE');
		
	} else if( palabrasClaves == "" ){
	
		errorAlert('Error', 'Debe escribir almenos una palabra clave');
		
	} else if( carrera == 0 ){
	
		errorAlert('Error', 'Debe seleccionar la carrera a la que pertenece');
		
	} else if( tipo_fce == 0 ){
		
		errorAlert('Error', 'Debe seleccionar el tipo de FCE para su tema');
		
	} else if( ambito_fce == 0 ){
		
		errorAlert('Error', 'Debe seleccionar el ámbito de su FCE');
		
	} else {
		
		formSub.submit();
	}
	
}



function  descargarArchivo()
{
	 let id = document.getElementById("id_tema").value;		
	 
	
		     
	    	 $.ajax({
	    	        type: "GET",
	    	        url: "../../SL_descarga_archivos",
	    	        data:{id_tema : id} ,
	    	        contentType : "application/json",
	    	        error : function(){ 
	    	        	console.log("error al descargar archivo")
	    	        },
	    	        success: function(msg){
	    	        	console.log("archivoDescargado")
	    	        }
	    	    });
		     
}


