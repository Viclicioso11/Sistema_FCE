

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

var carne = [];
var actualCarne = "";

var palabras = [];
var actualPalabra = "";
