document.getElementById('estudiante1').style.display = "none";
document.getElementById('estudiante2').style.display = "none";
document.getElementById('estudiante3').style.display = "none";

/////////// VARIABLES DE CONTROL MSJ ///////////
var nuevo = 0;
nuevo = "<%=mensaje%>";


if(nuevo == "1")
    successAlert('�xito', 'El nuevo registro ha sido almacenado!!!')
if(nuevo == "2")
    errorAlert('Error', 'Revise los datos e intente nuevamente!!!')

/**
 * aqui se hace lo del tag input
 */

var input = document.getElementById("palabrasC")
var tags = new Tagify(input)
tags.addTags(["hola mundo"])
