
//para validar cuando se deseleccione una u otra
var actividad;
var actividad2;
var elemento;
var id_actividad = 0;
var arrayActividad;
var opcion;
var opcion2;
var url;

var elemOpciones = [];
function seleccionaActividad(id_elem){

	if(actividad == id_elem) {
		elemento = document.getElementById(id_elem);
		elemento.style.backgroundColor = "white";
		$("#id_actividad").val("");
		actividad = null;
		actividad2 = null;
	}else{
		
		if (actividad2 == null) {
			
			actividad = id_elem;
			elemento = document.getElementById(id_elem);
			elemento.style.backgroundColor = "green";
				//dividimos la cadena del id y accedemos solo a la parte numerica despues de la l
			arrayActividad = actividad.split("t");
			id_actividad = arrayActividad[1];
						
			$("#id_actividad").val(id_actividad)
			console.log($("#id_actividad").val());
			actividad2 = actividad;
		} else {
			actividad = id_elem;
			elemento = document.getElementById(actividad2);
			elemento.style.backgroundColor = "white";
			
			elemento = document.getElementById(actividad);
			elemento.style.backgroundColor = "green";
			actividad2 = actividad;
			
			arrayActividad = actividad.split("t");
			id_actividad = arrayActividad[1];
					
			
			$("#id_actividad").val(id_actividad)
			console.log($("#id_actividad").val());
			
		}
		
		
		
	}
	
	
}

function seleccionaGrupo(id_eleml){
	
	opcion = document.getElementById(id_eleml);
	
	if(elemOpciones[0] == id_eleml ){
		elemOpciones.shift();
		opcion2 = id_eleml;
		opcion = document.getElementById(id_eleml);
		opcion.style.backgroundColor = "white";
		console.log(elemOpciones);
	
	}else{
		for(var i = 1; i < elemOpciones.length; i++){
			
			
			if(id_eleml == elemOpciones[i]){
				
				elemOpciones.splice(i,i);
				opcion2 = id_eleml;
				opcion = document.getElementById(id_eleml);
				opcion.style.backgroundColor = "white";
				console.log(elemOpciones);
				
		}
	
		}
	}
		
	
	if(opcion2 != id_eleml){
		elemOpciones.push(id_eleml);
		opcion = document.getElementById(id_eleml);
		opcion.style.backgroundColor = "green";
		//console.log(elemOpciones);
	}
	 $("#id_grupos").val(elemOpciones.toString());
	 console.log( $("#id_grupos").val());
	 opcion2 = opcion;
}


//esto es para el date Picker
let local = {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Guardar",
        "cancelLabel": "Cancelar",
        "fromLabel": "Desde",
        "toLabel": "Hasta",
        "customRangeLabel": "Custom",
        "daysOfWeek": [
            "Dom",
            "Lun",
            "Mar",
            "Mier",
            "Jue",
            "Vie",
            "Sab"
        ],
        "monthNames": [
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Augosto",
            "Septiembre",
            "Octubre",
            "Noviembre",
            "Deciembre"
        ],
        "firstDay": 1
 }

function formatDate(fecha) {
		
	 fecha = fecha + "";	
	 fecha = fecha.split("-");
	  
	  var day = fecha[2];
	  var monthIndex = fecha[1];
	  var year = fecha[0];
	  
	  return (day + '/' + (monthIndex) + '/' + year);
}



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




function guardarTareaGrupal() {
	
	let descripcion = $("#descripcionTarea").val();
	
	let titulo = $("#tituloTarea").val();
	
	let idGrupos = $("#id_grupos").val();

	let idActividad = $("#id_actividad").val();
	
	let fechas = $("#dateRange").val();
	
	let formSub = document.getElementById("formGuardar");
	
	
	if( idActividad == "" ) {
		
		errorAlert('Error', 'Debe seleccionar una actividad del cronograma');
		
	} else if ( idGrupos == "" ) {
		
		errorAlert('Error', 'Debe seleccionar al menos un tema para asignar tarea');
		
	} else if( titulo == "" ) {
		
		errorAlert('Error', 'Debe redactar un título para la tarea');
		
	} else if( fechas == "" ){
	
		errorAlert('Error', 'Debe seleccionar un rango de fechas para la tarea');
		
	} else {

		//hacemos el submit
		
		formSub.submit();
	}
	
	
	
	
	
}


