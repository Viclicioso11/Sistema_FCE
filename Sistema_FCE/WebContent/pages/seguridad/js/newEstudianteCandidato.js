let contador = 1 // solo para saber cuantos hay y asignar el siguiente valor
let ids = ['1'] // valores que hay en el dom actualmente
let email = []
$("#enviar").prop('disabled', true)
let input = document.getElementById("file")
input.addEventListener('change', filePicked, false)

function agregar() {

	let datos = {
		email: $('#email').val(),
		color: "#17a2b8"
	}

	/*
		validating wheter the input value
		is valid, the input is empty,
		the email already exits
	*/
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

function agregarExcel(correo) {
	let datos = {
		email: correo,
		color: "#17a2b8"
	}

	/*
		validating wheter the input value
		is valid, the input is empty,
		the email already exits
	*/
	if(datos.email != ""){

		if(valEmail(datos.email) == false){
			return "invalido"
		}
		else if (email.indexOf(datos.email) == -1) {
			addToList(datos)
		}else{
			return "existente"
		}
	}else{
		return "vacio"
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

	$("#enviar").prop('disabled', false)
}

function Delete(id){
	let index = ids.indexOf(id)
	ids.splice(index,1)

	let mail = $("#nombre" + id ).val()
	let index2 = email.indexOf(mail)
	email.splice(index2, 1)

	$("#" + id).remove("#" +id);
	$("#values").val(email.toString())

	if(email.length == 0){
		$("#enviar").prop('disabled', true)
	}
}

function filePicked(e) {
  // Get The File From The Input
  	var File = e.target.files[0]
  	var Filename = File.name
	Filename = Filename.split('\\').pop()

	// validating if the file 
	//if an excel of xlsx
	if (Filename.split('.').pop() == "xlsx"){

		/*
			declaring variables
		*/
		var fileLabel = $("#fileLabel")
		fileLabel.html(Filename)
		var reader = new FileReader()

		// Ready The Event For When A File Gets Selected
		reader.onload = function(e) {

			var data = e.target.result
			var mensajesControl = []

			/*
				parsing the excel to a json struct
			*/
			var workbook = XLSX.read(data, {type: 'binary'})
			var first_sheet_name = workbook.SheetNames[0]
			var worksheet = workbook.Sheets[first_sheet_name]
			var correos = XLSX.utils.sheet_to_json(worksheet)


			for (let i =0; i < correos.length ; i++){
				mensajesControl.push(agregarExcel(correos[i].Correo))
			}

			if(mensajesControl.indexOf("vacio") != -1
				|| mensajesControl.indexOf("invalido") != -1
			 	|| mensajesControl.indexOf("existente") != -1){

				errorAlert('Error!', 'Algunos correos no se pudieron añadir, por favor revise o intente nuevamente');
			}
		}
	
		reader.onerror = function(ex) {console.log(ex)}
		reader.readAsBinaryString(File);

		$("#file").val("")

	}else{
		errorAlert('Error!', 'El archivo seleccionado no es un xlsx');
	}
}
