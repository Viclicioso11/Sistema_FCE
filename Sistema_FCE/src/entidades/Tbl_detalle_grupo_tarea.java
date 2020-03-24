package entidades;

public class Tbl_detalle_grupo_tarea {
	
	//ATRIBUTOS
	private int id;
	private int id_detalle_grupo_tarea;
	private int id_tarea;
	private int estado;
	
	
	
	//METODOS
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_detalle_grupo_tarea() {
		return id_detalle_grupo_tarea;
	}
	public void setId_detalle_grupo_tarea(int id_detalle_grupo_tarea) {
		this.id_detalle_grupo_tarea = id_detalle_grupo_tarea;
	}
	public int getId_tarea() {
		return id_tarea;
	}
	public void setId_tarea(int id_tarea) {
		this.id_tarea = id_tarea;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}


}
