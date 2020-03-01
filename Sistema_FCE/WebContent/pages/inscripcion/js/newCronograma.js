// Inicio de manipulacion del Dom

// esto es para el date Picker
$(".vista2").css({"display": "none"})

$('#dateRange').daterangepicker({
    "locale": {
        "format": "YYYY/MM/DD",
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
})

$('#dateRangeCronograma').daterangepicker({
    "locale": {
        "format": "YYYY/MM/DD",
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
})

// fin de la manipulacion del Dom


/**
 * initializacion de 
 * variables del calendar
 */
var idEvento = 0;//nos apoyara para asignar un id al evento
var date = new Date()
var d    = date.getDate(),
    m    = date.getMonth(),
    y    = date.getFullYear()

var Calendar = FullCalendar.Calendar
var Draggable = FullCalendarInteraction.Draggable

var calendarEl = document.getElementById('calendar')
var containerEvents = document.getElementById('external-events')
var checkbox = document.getElementById('drop-remove')

//calendar settings
var calendarP = [ 'bootstrap', 'interaction', 'dayGrid' ]
var calendarH = {left  : 'prev,next today',center: 'title', right: ''}

function deleteE(e){
    let {event, jsEvent, view} = e

    if(isOnTrash(jsEvent.clientX, jsEvent.clientY)) {
        calendar.getEventById(event.id).remove()
    }
}

function isOnTrash(x, y) {

    var external_events = $('#trash');
    var offset = external_events.offset();
    offset.right = external_events.width() + offset.left;
    offset.bottom = external_events.height() + offset.top;

    // Compare
    if (x >= offset.left
        && y >= offset.top
        && x <= offset.right
        && y <= offset .bottom) { return true; }
    return false;
}

function dropE(info){
    if (checkbox.checked) {
      info.draggedEl.parentNode.removeChild(info.draggedEl);
    }
}

function getEvents(){
    let inicio = []
    let fin = []
    let eventos = calendar.getEvents().map( evento =>{

        let {id, title, start, end} = evento
        
        let descripcion = evento.extendedProps.description
        descripcion = descripcion == null ? "" : descripcion

        if (end != null)
            end.setDate(end.getDate() -1)
        else
            end = start

        inicio.push(start)
        fin.push(end)

        return {
            id     : id,
            titulo : title,
            inicio : start.toLocaleString(),
            end    : end.toLocaleString(),
            descripcion : descripcion
        }
    });

    return {eventos: eventos, finA: fin, inicioA: inicio};
}

var calendar = new Calendar(calendarEl, {
    plugins     : calendarP,
    header      : calendarH,
    themeSystem : 'bootstrap',
    locale      : 'es',
    //events    : eventosData,
    editable    : true,
    droppable   : true,
    drop        : dropE.bind(this),
    eventDragStop: deleteE.bind(this),
})

calendar.render()

function guardar(){

    //obteniendo los eventos
    let {eventos, finA, inicioA} = getEvents();

    

    if (eventos.length != 0){
        
        // ordenando las fechas de mayor a menor
        finA = finA.sort((a,b)=> a-b)
        inicioA = inicioA.sort((a,b) => a-b);

        //obteniendo inicio y fin 
        //de todo el plan de graduacion
        let fin = finA[finA.length -1].toLocaleString()
        let inicio = inicioA[0].toLocaleString()

        let data = JSON.stringify(eventos);
        
        $.ajax({

            type: "GET",
            url: "../../SL_planG",
            data: {opc: '1', eventos: data, inicio: inicio, fin: fin},
            contentType : "application/json",
            error : function(){ 
                errorAlert('ERROR', 'Contacte con administrador de sitio');
            },
            success: function(msg){
                 console.log(msg)
            }
        });

    }else{
        console.warn("ponga al menos una actividad");
    }
}

/**
 * Fin del calendar
 */


 /**
  * Inicio funciones Agregar
  */
function onChangeView(){
    let val = document.getElementById("idVista").value;
    
    if(val == 1 ){
        $("#vista1").fadeIn()
        $(".vista2").fadeOut()
    }else{
        $("#vista1").fadeOut()
        $(".vista2").fadeIn()
    }
}

// funcion agregar Vista1
document.querySelector("#addEvent").addEventListener("submit", addEvent.bind(this))

function addEvent(e){
    
    e.preventDefault()
    let dateRange = e.target[1].value
    
    console.log(e.target[0].value)
    console.log(e.target[2].value)
   console.log(e.target[1].value)
    
    let evento = {
        id : idEvento++,
        title: e.target[0].value,
        description: e.target[2].value,
        backgroundColor: '#ffc107',
        borderColor    : '#ffc107',
        textColor: "#000",
    }

    dateRange = dateRange.split("-")

    evento.start = new Date(dateRange[0])
    
    if(dateRange[0].trim() != dateRange[1].trim()){
        evento.end = new Date(dateRange[1].trim())
        evento.end.setDate(evento.end.getDate() +1)
    }

    if(guardarActividadCrono() == true){
    	calendar.addEvent(evento);
    	
    	document.getElementById("nombreActividad").value = "";
    	document.getElementById("descripcionActividad").value = "";
    }	
    
}


/** 
 * funciones para la vista 
 * 2 de crear actividades
 */
function ini_events(eventos) {
    eventos.each(function () {
        // it doesn't need to have a start or end
        var eventObject = {
        title: $.trim($(this).text())
        }

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject)

        // make the event draggable using jQuery UI
        $(this).draggable({
        zIndex        : 1070,
        revert        : true, // will cause the event to go back to its
        revertDuration: 0  //  original position after the drag
        })

    })
}

//iniciando los eventos
ini_events($('#external-events div.external-event'))

// dando permiso para que se puedan
// arrastrar al 

new Draggable(containerEvents, {
    itemSelector: '.external-event',
    eventData: function(eventEl) {
        return {
        id: idEvento++, 
        title: eventEl.innerText,
        backgroundColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
        borderColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
        textColor: window.getComputedStyle( eventEl ,null).getPropertyValue('color'),
        }
    }
})

var currColor = "#ffc107"
$('#color-chooser > li > a').click(function() {
    currColor = $(this).css('color')
    let estilos = {
      'background-color': currColor,
      'border-color'    : currColor
    }
    $('#add-new-event').css(estilos)
})

$('#add-new-event').click(function () {

    let val = $('#new-event').val()

    if (val.length == 0) { return }
    
    let event = $('<div />')
    let estilos = {
      'background-color': currColor,
      'border-color'    : currColor,
      'color'           : '#fff'
    }

    event.css(estilos).addClass('external-event')
    event.html(val)
    $('#external-events').prepend(event)
    $('#new-event').val('')

    ini_events(event)
})

//vamos a guardar todos los detalles del cronograma
function guardarCronograma(){
	
	descripcionCronograma = $("#descripcionCronograma").val();
	tipoCronograma = $("#tipoCronograma").val();
	
	fechas = $("#dateRangeCronograma").val();
	
	var Arreglofechas = fechas.split("-")
	
	var fechaInicio = Arreglofechas[0].trim()
	var fechaFin = Arreglofechas[1].trim()
	
	if( descripcionCronograma == "" || tipoCronograma == "" ||  fechaInicio == "" || fechaFin == ""){
		 errorAlert('Error', 'Hay campos vacíos');
	}else{
		
		var inicio = new Date(fechaInicio)
		var fin = new Date(fechaFin)
		//validamos si la fecha final no es menor a la inicial
		if(inicio > fin){
			errorAlert('Error', 'La fecha inicial no puede ser mayor a la fecha final');
		}else{
			//validamos el caso contrario
			if(fin < inicio){
				errorAlert('Error', 'La fecha final no puede ser menor a la fecha inicial');
			}else{
				
				
				$.jAlert({
				    'type': 'confirm',
				    'confirmQuestion': '¿Está seguro de guardar estos detalles de cronograma?',
				    'onConfirm': function(e, btn){
				     e.preventDefault();
				     
				     $.ajax({
				         type: "GET",
				         async : false, 
				         url: "../../SL_cronograma",
				         data:{descripcion : descripcionCronograma, tipo : tipoCronograma, fecha_in : fechaInicio, fecha_fin : fechaFin, opc : 1} ,
				         contentType : "application/json",
				         error : function(){ 
				         	errorAlert('ERROR', 'Contacte con administrador de sitio');
				         },
				         success: function(msg){
				         	if(msg == "0"){
				         		warningAlert('Error', 'No se ha guardado el cronograma');
				         	}
				         	else{
				         		//la informacion traida del servlet la separamos por -
				         		var informacion = msg.split("*");	
				         		//ponemos el id del cronograma
				         		document.getElementById("id_cronograma").value = informacion[0].trim();
				         		//ponemos la fecha de inicio
				         		document.getElementById("fecha_inicio_cron").value = informacion[1].trim();
				         		//ponemos la fecha fin
				         		document.getElementById("fecha_fin_cron").value = informacion[2].trim();
				         		$("#detalle_cronograma").fadeOut();
				         		//mostramos el de crear actividades
				        		$("#vista1").fadeIn();
				        		
				        		successAlert('Éxito', 'Cronograma guardado correctamente');
				            	 
				         	}
				         	 
				         }
				     }); 
				     	     
				     btn.parents('.jAlert').closeAlert();
				    },
				    'onDeny': function(e, btn){
				      e.preventDefault();
				      btn.parents('.jAlert').closeAlert();
				    }
				  });
				
			}
		}
	}

}

//Vamos a guardar las actividades
function guardarActividadCrono(){
	
	descripcionActividad = $("#descripcionActividad").val();
	nombreActividad = $("#nombreActividad").val();
	id_cronograma = $("#id_cronograma").val();
	fecha_inicio_crono = $("#fecha_inicio_cron").val();
	fecha_fin_crono = $("#fecha_fin_cron").val();
	
	console.log("id"+id_cronograma);
	fechas = $("#dateRange").val();
	
	var Arreglofechas = fechas.split("-");
	
	var fechaInicio = Arreglofechas[0].trim();
	var fechaFin = Arreglofechas[1].trim();
	
	if( descripcionActividad == "" || tipoCronograma == "" ||  fechaInicio == "" || fechaFin == ""){
		 errorAlert('Error', 'Hay campos vacíos');
		 
	}else{
		
		var inicio = new Date(fechaInicio);
		var fin = new Date(fechaFin);
		var inicioCrono = new Date (fecha_inicio_crono);
		var finCrono = new Date (fecha_fin_crono);
		
		
		//validamos si la fecha final no es menor a la inicial
		if(inicio < inicioCrono){
			errorAlert('Error', 'La fecha inicial no puede ser anterior a la fecha inicial del cronograma');
			return false
		}else{
			//validamos el caso contrario
			if(fin > finCrono){
				errorAlert('Error', 'La fecha final no puede ser luego a la fecha final del cronograma');
				return false
			}else{
					var mensaje 
				     $.ajax({
				         type: "GET",
				         async : false, 
				         url: "../../SL_actividad_crono",
				         data:{descripcion : descripcionActividad, nombre : nombreActividad, fecha_in : fechaInicio, fecha_fin : fechaFin, opc : 1, idCrono : id_cronograma} ,
				         contentType : "application/json",
				         error : function(){ 
				         	errorAlert('ERROR', 'Contacte con administrador de sitio');
				         },
				         success: function(msg){
				         	if(msg == "0"){
				         		warningAlert('Error', 'No se ha agregado la actividad');
				         	}
				         	else{
				        		successAlert('Éxito', 'Actividad agregada correctamente');	
				        		mensaje = msg
				         	}
				         	 
				         }
				     }); 
			
					if(mensaje == "0"){
						return false;
					}else{
						return true;
					}
			}
		}
	}

}

//let string = "[{ \"hola\":\"ji\"},{ \"hola\": 0}]" // todo eso es una cadena
// var actividades =  JSON.parse(string)
//console.log(actividad)


/* async function getData(){
try{
    let response = await fetch("../SL_vw_Tema",{});
    response = await response.text();
    console.log(response)
}catch(e){
    console.log(e)
}
} */