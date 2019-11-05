function ponerNombreArchivo(archivo){

    var file = archivo.files[0];
    var objetoHidden = document.formulario.nombreArchivo;
    
    objetoHidden.value = file.name;
    console.log(file.name);
 
}

/*
    con ajax mandamos el valor del carne al servlet, para que nos de el 
    callback con el nombre del usuario
*/

  
/*
    un esta en proceso
*/

function EliminarMembers(){
    menberT.removeAllTags()
    successAlert('Éxito', 'Se han eliminado los pasticipantes')
}



//metodo para el editar
function AddmemberEditar(){
    let member = document.getElementById("addM").value;
    actualCarne = member
    
    $.ajax({
        type: "GET",
        url: "../../SL_edicion_tema",
        data:{filtro : member} ,
        contentType : "application/json",
        error : function(){ 
        	errorAlert('ERROR', 'Contacte con administrador de sitio');
        },
        success: function(msg){
        	
        	if(msg == "2"){
        		warningAlert('Error', 'Usuario no válido o no disponible');
        	}
        	else{
        		successAlert('Éxito', 'Participante añadido: '+ msg);
        		menberT.addTags([msg]);
           	 
        	}
        	 
        }
    }); 
    
   
}


function Addmember(){
    let member = document.getElementById("addM").value;
    actualCarne = member
    
    $.ajax({
        type: "GET",
        url: "../../SL_tema",
        data:{filtro : member} ,
        contentType : "application/json",
        error : function(){ 
        	errorAlert('ERROR', 'Contacte con administrador de sitio');
        },
        success: function(msg){
        	
        	if(msg == "2"){
        		warningAlert('Error', 'Usuario no válido o no disponible');
        	}
        	else{
        		successAlert('Éxito', 'Participante añadido: '+ msg);
        		menberT.addTags([msg]);
           	 
        	}
        	 
        }
    }); 
    
   
}

function editPalabrasClaves(){
	
}

function InputPalabra(){
    console.clear()
    let inputVal = document.getElementById("palabras").value
    inputVal = util(inputVal)

    let values = inputVal.split(",")
    
    let valor = []
    for (let value of values){
        value = util(value)
        value = util(value.split(":").pop())
        valor.push(value)
    }
    console.table(valor)
    document.getElementById("palabrasClave").value = valor.toString()
}

function util(string){
    string = string.split("")
    string.pop()
    string.shift()
    return string.join("")
}