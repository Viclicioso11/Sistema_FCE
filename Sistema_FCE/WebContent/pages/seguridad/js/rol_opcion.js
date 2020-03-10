function asignarNuevaOpcion(opcion)
{
	var idRol = opcion;
	window.location.href="../../pages/seguridad/newRol_opcion.jsp?id_rol="+idRol;	
}

//para validar cuando se deseleccione una u otra
var rol;
var rol2;
var id_rol = 0;
var roles;
var opcion;
var opcion2;
var url;

var elemOpciones = [];
function seleccionarRol(id_elem){

		rol = id_elem;
		rol = document.getElementById(id_elem);
		rol.style.backgroundColor = "green";
		//dividimos la cadena del id y accedemos solo a la parte numerica despues de la l
		roles = id_elem.split("Rol");
		id_rol = roles[1];
		window.location.href="../../pages/seguridad/tblrol_opcion.jsp?id_rol="+id_rol;	

	
}

function seleccionarOpcion(id_eleml){
	
	opcion = document.getElementById(id_eleml);
	
	if(elemOpciones[0] == id_eleml ){
		elemOpciones.shift();
		opcion2 = id_eleml;
		opcion = document.getElementById(id_eleml);
		opcion.style.backgroundColor = "white";
		console.log(elemOpciones);
	
	}else{
		for(var i = 1; i < elemOpciones.length; i++){
			
			
			if(id_eleml == elemOpciones[i]){
				
				elemOpciones.splice(i,i);
				opcion2 = id_eleml;
				opcion = document.getElementById(id_eleml);
				opcion.style.backgroundColor = "white";
				console.log(elemOpciones);
				
		}
	
		}
	}
		
	
	if(opcion2 != id_eleml){
		elemOpciones.push(id_eleml);
		opcion = document.getElementById(id_eleml);
		opcion.style.backgroundColor = "green";
		//console.log(elemOpciones);
	}
	 $("#id_opciones").val(elemOpciones.toString())
	 console.log( $("#id_opciones").val());
	 opcion2 = opcion;
}



function limpiarCampos(){
	/*rol =  document.getElementById(rol);
	rol.style.backgroundColor = "white";
	*/
	for(var i = 0; i < elemOpciones.length; i++){

			opcion = document.getElementById(elemOpciones[i]);
			opcion.style.backgroundColor = "white";
			
		
	}
	
	elemOpciones = [];

	
}



