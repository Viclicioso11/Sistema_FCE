let contador = 1 // solo para saber cuantos hay y asignar el siguiente valor
let ids = ['1'] // valores que hay en el dom actualmente
let email = []

function agregar() {

	let datos = {
		email: $('#email').val(),
		color: "#17a2b8"
	}

	valEmail(datos.email)
	if(datos.email != ""){

		if(valEmail(datos.email) == false){
			messenger("#valid")
		}
		else if (email.indexOf(datos.email) == -1) {
			addToList(datos)
		}else{
			$('#email').val("")
			messenger("#error")
		}
	}else{
		messenger("#empty")
	}

}

function messenger(id){
	$(id).fadeIn()
	setTimeout(() => {
		$(id).fadeOut()
	}, 2000);
}

function valEmail(email) {
    let valid = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i
	if(valid.test(email))
		return true
	else
		return false
}



function addToList(datos){

	let ultimo = $('#list')

	contador++
	// agregamos el id del nuevo elemento
	// que estara en el dom
	ids.push(contador.toString())
	email.push(datos.email)

	ultimo.append(
		"<div class='lista-item row' id="+ contador +" style='background-color:  " + datos.color + "'>" +
			"<input class='col-lg-11' id='nombre" + contador + "' name='nombre" + contador +"' required disabled value=" + datos.email + ">" +
			"<span class='col-lg-1' onclick=\"Delete('" + contador + "')\"><img src=\"./times.svg\" ></span>" +
		"</div>"
	);

	$('#email').val("")
	$("#values").val(email.toString())
}

function Delete(id){
	let index = ids.indexOf(id)
	ids.splice(index,1)

	let mail = $("#nombre" + id ).val()
	let index2 = email.indexOf(mail)
	email.splice(index2, 1)

	$("#" + id).remove("#" +id);
	$("#values").val(email.toString())
}
