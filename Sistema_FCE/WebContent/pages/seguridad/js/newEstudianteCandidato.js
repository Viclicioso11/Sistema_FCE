let contador = 1 // solo para saber cuantos hay y asignar el siguiente valor
let ids = ['1'] // valores que hay en el dom actualmente

$('#submit').submit(function(e) {
	e.preventDefault()

	let datos = {
		email: $('#email'),
		color: "#17a2b8"
	}
	contador++
	addToList(datos)
});

function addToList(datos){
	let ultimo = $('#list')

	// agregamos el id del nuevo elemento
	// que estara en el dom
	ids.push(contador.toString())
	
	ultimo.append(
		"<div class='lista-item row' id="+ contador +" style='background-color:  " + datos.color.val() + "'>" +
			"<input class='c-lg-11' id='nombre" + contador + "' name='nombre" + contador +"' required disabled value=" + datos.email.val() + ">" +
			"<span class='c-lg-1' onclick=\"Delete('" + contador + "')\"><img src=\"./times.svg\" ></span>" +
		"</div>"
	);
	console.log(ids.toString());

}

function Delete(id){
	let index = ids.indexOf(id);
	ids.splice(index,1);
	console.log(ids.toString());
	$("#" + id).remove("#" +id);
}