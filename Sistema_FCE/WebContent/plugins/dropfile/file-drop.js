const inputChange = (e) => {
  e.preventDefault()
  let texto = document.querySelector("#file-drop p")
  texto.textContent = `${e.target.files.length} archivo(s) seleccionado`
  
  let holder = document.querySelector("#file-drop")
  if ( holder.classList.contains("file-container-hover")){
    holder.classList.remove("file-container-hover")
  }
}

const dragEnter = (e) =>{
  e.preventDefault()
  let holder = document.querySelector("#file-drop")
  if ( !holder.classList.contains("file-container-hover")){
    holder.classList.add("file-container-hover")
  }
}

const dragLeave = (e) => {
  e.preventDefault()
  let holder = document.querySelector("#file-drop")
  if ( holder.classList.contains("file-container-hover")){
    holder.classList.remove("file-container-hover")
  }
}

//input change
let input = document.querySelector("#file-drop-input")
input.addEventListener("change", inputChange.bind(this))

let fileHold = document.querySelector("#file-drop")
fileHold.addEventListener("dragenter", dragEnter.bind(this), false)
fileHold.addEventListener("dragleave", dragLeave.bind(this), false)