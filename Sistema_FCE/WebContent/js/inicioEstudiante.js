var Calendar2 = FullCalendar.Calendar

var calendarE2 = document.getElementById('calendarTarea')

//calendar settings
var calendar2P = [ 'bootstrap', 'interaction', 'dayGrid' ]
var calendar2H = {left  : 'prev,next today',center: 'title', right: ''}



var calendar2 = new Calendar2(calendarE2, {
    plugins     : calendar2P,
    header      : calendar2H,
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

calendar2.render()


/**
 * Fin del calendar
 */

function agregar(evento, color){
    
    let add = {
        id : evento.id,
        title: evento.titulo,
        description: evento.descripcion,
        start: new Date(evento.inicio),
        end: new Date(evento.end),
        backgroundColor: color,
        borderColor    : '#ffc107',
        textColor: "#000",
    }
    calendar2.addEvent(add);
}