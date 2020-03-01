// Inicio de manipulacion del Dom

// esto es para el date Picker
$(".vista2").css({"display": "none"})

$('#dateRange').daterangepicker({
    "locale": {
        "format": "MM/DD/YYYY",
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

var calendarEl = document.getElementById('calendar')

//calendar settings
var calendarP = [ 'bootstrap', 'interaction', 'dayGrid' ]
var calendarH = {left  : 'prev,next today',center: 'title', right: ''}

function deleteE(e){
    let {event, jsEvent} = e

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



// funcion agregar Vista1
document.querySelector("#addEvent").addEventListener("submit", addEvent.bind(this))

function addEvent(e){
    
    e.preventDefault()
    let dateRange = e.target[1].value


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

    calendar.addEvent(evento)
    
}

function agregar(evento){
    
    let add = {
        id : evento.id,
        title: evento.titulo,
        description: evento.descripcion,
        start: new Date(evento.inicio),
        end: new Date(evento.end),
        backgroundColor: '#ffc107',
        borderColor    : '#ffc107',
        textColor: "#000",
    }

    calendar.addEvent(add);
}

/** 
 * funciones para la vista 
 * 2 de crear actividades
 */

 function GetActividadesDB(id){
	 console.log(id);
	 if(id != 0){
	    $.ajax({
	
	        type: "GET",
	        url: "../../SL_actividad_pg",
	        data: {opc: '1', idP: id},
	        contentType : "application/json",
	        error : function(){ 
	            errorAlert('ERROR', 'Contacte con administrador de sitio');
	        },
	        success: function(msg){
	             console.log(msg)
	        }
	    });
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