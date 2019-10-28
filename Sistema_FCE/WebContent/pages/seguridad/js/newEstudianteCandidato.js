let contador = 0 // solo para saber cuantos hay y asignar el siguiente valor
let ids = [] // valores que hay en el dom actualmente
let correo = []

function agregar(){
	
	let datos = {
		email: document.getElementById("email").value,
		color: "#17a2b8"
	}
	
	if ( correo.indexOf(datos.email) == -1){
		contador++
		correo.push(datos.email)
		addToList(datos)
	}else{
		console.warn("correo ya esta agregado")
		alert("correo ya esta agregado")
	}
}

function addToList(datos){
	let ultimo = $('#list')

	// agregamos el id del nuevo elemento
	// que estara en el dom
	ids.push(contador.toString())
	
	ultimo.append(
		"<div class='lista-item row' id="+ contador +" style='background-color:  " + datos.color + "'>" +
			"<input class='col-lg-11' id='nombre" + contador + "' name='nombre" + contador +"' required disabled value=" + datos.email + ">" +
			"<span class='col-lg-1' onclick=\"Delete('" + contador + "')\"><img src=\"./times.svg\" ></span>" +
		"</div>"
	);
	document.getElementById("values").value = correo.toString()
}

function Delete(id){
	let index = ids.indexOf(id);
	ids.splice(index,1);
	
	let c2 = $("#nombre" + id).val()
	let index2 = correo.indexOf(c2)
	correo.splice(index2,1)
	
	$("#" + id).remove("#" +id);
	document.getElementById("values").value = correo.toString()
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
})