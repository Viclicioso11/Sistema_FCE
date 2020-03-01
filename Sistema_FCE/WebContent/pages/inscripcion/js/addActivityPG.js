// Inicio de manipulacion del Dom

// esto es para el date Picker
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

function formatDate(date) {
	
  var day = date.getDate();
  var monthIndex = date.getMonth();
  var year = date.getFullYear();

  return day + '/' + (monthIndex +1) + '/' + year;
}

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
    console.log(x,y);
    console.log(offset);
    y += 40;
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
	defaultDate : minDate,
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

        let data = JSON.stringify(eventos);
        
        console.log(data);
        $.ajax({

            type: "GET",
            url: "../../SL_actividad_pg",
            data: {opc: '2', eventos: data, id: idP},
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

// funcion agregar Vista1

function addEvent(e){
    
    e.preventDefault()
    let dateRange = e.target[1].value

    try{
    	let evento = {
    	        id : idEvento++,
    	        title: e.target[0].value,
    	        description: e.target[2].value,
    	        backgroundColor: '#007bff',
    	        borderColor    : '#007bff',
    	        textColor: "#fff",
   	    }
    	
	    dateRange = dateRange.split("-")
	    
	    dateRange[0] = parseDF(dateRange[0],1);
    	dateRange[1] = parseDF(dateRange[1],1);
    	
    	
	    evento.start = new Date(dateRange[0])
	    
	    if(dateRange[0].trim() != dateRange[1].trim()){
	        evento.end = new Date(dateRange[1].trim())
	        evento.end.setDate(evento.end.getDate() +1)
	    }
	    calendar.addEvent(evento)
    	calendar.gotoDate(evento.start)
    }catch(error){
    	console.log(error)
    }
    
}

function parseDF(date, opc){
	
	let  String = ""
	switch(opc){
		case 1:
			date = date.split("/")
			String = date[2] + "/" + date[1] + "/" + date[0];
		case 2:
			date = date.split("-")
			String = date[2] + "/" + date[1] + "/" + date[0];
		default:
			break;
	}
	return String;
}