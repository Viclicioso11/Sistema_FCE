

/////////// VARIABLES DE CONTROL MSJ ///////////

/**
 * aqui se hace lo del tag input
 */


var members = document.getElementById("members")
var menberT = new Tagify(members)

menberT.on('add', function(e){
    carne.push(actualCarne)
    $("#carne").val(carne.toString())
});

menberT.on('remove', function(e){
    
});

   
var carne = [];
var actualCarne = "";


/*
 * este es para la palabras claves
 * 
 */
var palabrasInput =new Tagify(document.getElementById("palabras"),{maxTags: 6})
palabrasInput.on("add", InputPalabra )
palabrasInput.on("remove", InputPalabra)

var palabras = [];
