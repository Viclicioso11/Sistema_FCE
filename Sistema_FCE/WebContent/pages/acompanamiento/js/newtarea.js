
//para validar cuando se deseleccione una u otra
var actividad;
var actividad2;
var elemento;
var id_actividad = 0;
var arrayActividad;

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




function guardarTarea() {
	
	let descripcion = $("#descripcionTarea").val();
	
	let titulo = $("#tituloTarea").val();
	

	let idActividad = $("#id_actividad").val();
	
	let fechas = $("#dateRange").val();
	
	let formSub = document.getElementById("formGuardar");
	
	
	
	if( idActividad == "" ) {
		
		errorAlert('Error', 'Debe seleccionar una actividad del cronograma');
		
	} else if( titulo == "" ) {
		
		errorAlert('Error', 'Debe redactar un título para la tarea');
		
	} else if( fechas == "" ) {

		
	} else {
		//hacemos el submit
		
		formSub.submit();
	}
	
	
	
	
	
}


