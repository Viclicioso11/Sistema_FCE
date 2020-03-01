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
 * initialización de 
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
    eventClick  : function(info){
    	let fechaInicio = moment(info.event.start).format('YYYY/MM/DD');
    	let fechaFin = moment(info.event.end).format('YYYY/MM/DD');
    	//al hacer click sobre uno de los eventos, mandamos todos estos valores al metodo que los setea en los campos
    	verActividad(info.event.title, info.event.extendedProps.description, info.event.id, fechaInicio, fechaFin);
    	
    },
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
//funcion para poner los detalles de la actividad en los campos de actividad
function verActividad(nombre, descripcion,id, fechaInicio, fechaFin){
	
	document.getElementById("nombreActividad").value = nombre;
	document.getElementById("descripcionActividad").value = descripcion;
	document.getElementById("fechaActividad").value = fechaInicio + "-" + fechaFin;
	
	//alert('Título: ' + nombre );
	//alert('ID: ' + id);
}

// mostramos todas las actividades

function addEvent(descripcion, nombre, fechaInicio, fechaFin, id, color){
 
    console.log(descripcion)
    console.log(nombre)
   console.log(fechaInicio)
   console.log(fechaFin)
   console.log(id)
   
   
    let evento = {
        id : id,
        title: nombre,
        description: descripcion,
        backgroundColor: color,
        borderColor    : '#170421',
        textColor: "#000",
    }

    evento.start = new Date(fechaInicio.trim())
    
    if(fechaInicio.trim() !=fechaFin.trim()){
        evento.end = new Date(fechaFin.trim())
        evento.end.setDate(evento.end.getDate() +1)
    }
    	calendar.addEvent(evento);
    
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