var Calendar = FullCalendar.Calendar

var calendarEl = document.getElementById('calendar')

//calendar settings
var calendarP = [ 'bootstrap', 'dayGrid' ]
var calendarH = {left  : 'prev,next',center: 'title', right: ''}



var calendar = new Calendar(calendarEl, {
    plugins     : calendarP,
    header      : calendarH,
    themeSystem : 'bootstrap',
    locale      : 'es',
    editable    : false,
    droppable   : false,
	eventRender: function(event, element) {
        $(element).tooltip({
            title: event.title,
            container: "body"
        });
	},
})

calendar.render()


/**
 * Fin del calendar
 */

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