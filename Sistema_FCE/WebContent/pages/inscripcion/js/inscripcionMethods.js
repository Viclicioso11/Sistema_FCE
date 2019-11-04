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