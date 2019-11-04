function ponerNombreEstudiante1(){

    var carne = $('#carne1').val();
    $.ajax({
        type: "GET",
        url: "../../SL_tema",
        data:{filtro : carne} ,
        contentType : "application/json",
        dataType: "json",
        error : function(){ 
            alert('Error'); 
        },
        success: function(msg){
            $('#nombre1').val(msg);
        }
    }); 
}
/*
    con ajax mandamos el valor del carne al servlet, para que nos de el 
    callback con el nombre del usuario
*/
  
function ponerNombreEstudiante2(){
		 
    var carne = $('#carne2').val();
    
    $.ajax({
        type: "GET",
        url: "../../SL_tema",
        data:{filtro : carne} ,
        contentType : "application/json",
        dataType: "json",
        error : function(){ 
            alert('Error'); 
        },
        success: function(msg){
        
            $('#nombre2').val(msg);
            
        }
    }); 
}

/*
    con ajax mandamos el valor del carne al servlet, para 
    que nos de el callback con el nombre del usuario
*/
  
function ponerNombreEstudiante1(){
		 
    var carne = $('#carne3').val();
    
    $.ajax({
        type: "GET",
        url: "../../SL_tema",
        data:{filtro : carne} ,
        contentType : "application/json",
        dataType: "json",
        error : function(){ 
            alert('Error'); 
        },
        success: function(msg){
        
            $('#nombre3').val(msg);
            
        }
    }); 
}
  
/*
    un esta en proceso
*/
function ponerNombreArchivo(nombre){
		  
    var archivo = "";
    
    $('#nombreArchivo').val(archivo);
    alert(archivo);
    
}
/*
    Este metodo valida cada vez que el select cambia de valor, y 
    asi mostrarle al usuario solo la cantidad necesaria
*/
function aparecer_ocultar_est() {

    if($("#cantidad_integrantes").val() == "0"){
    document.getElementById('estudiante1').style.display = "none";
    document.getElementById('estudiante2').style.display = "none";
    document.getElementById('estudiante3').style.display = "none";
    }
    
    if($("#cantidad_integrantes").val() == "1"){
    document.getElementById('estudiante1').style.display = "block";
    document.getElementById('estudiante2').style.display = "none";
    document.getElementById('estudiante3').style.display = "none";
    }
    
    if($("#cantidad_integrantes").val() == "2"){
    document.getElementById('estudiante1').style.display = "block";
    document.getElementById('estudiante2').style.display = "block";
    document.getElementById('estudiante3').style.display = "none";
    }
    
    if($("#cantidad_integrantes").val() == "3"){
    document.getElementById('estudiante1').style.display = "block";
    document.getElementById('estudiante2').style.display = "block";
    document.getElementById('estudiante3').style.display = "block";
    }
    
}

function EliminarMembers(){
    menberT.removeAllTags()
    let c = []
    carne = c
    successAlert('Éxito', 'Se han eliminado los pasticipantes')
    console.log(carne)
}

function Addmember(){
    let member = document.getElementById("addM").value
    actualCarne = member
    menberT.addTags([member])
    successAlert('Éxito', 'Participante añadido: '+ member)
    console.log(carne)
}