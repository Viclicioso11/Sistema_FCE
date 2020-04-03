package entidades;

import java.util.Date;

public class Vw_tema_tarea {
	
	//ATRIBUTOS
	
	private int id;
	private int estado;
	private int tarea_id;
	private String titulo_tarea;
	private String descripcion_tarea;
	private Date fecha_inicio;
	private Date fecha_fin;
	private int id_actividad_cronograma;
	private int tema_id;
	private String nombre_tema;
	private int tutor_id;
	
	
	//METODOS
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public int getTarea_id() {
		return tarea_id;
	}
	public void setTarea_id(int tarea_id) {
		this.tarea_id = tarea_id;
	}
	public String getTitulo_tarea() {
		return titulo_tarea;
	}
	public void setTitulo_tarea(String titulo_tarea) {
		this.titulo_tarea = titulo_tarea;
	}
	public String getDescripcion_tarea() {
		return descripcion_tarea;
	}
	public void setDescripcion_tarea(String descripcion_tarea) {
		this.descripcion_tarea = descripcion_tarea;
	}
	public Date getFecha_inicio() {
		return fecha_inicio;
	}
	public void setFecha_inicio(Date fecha_inicio) {
		this.fecha_inicio = fecha_inicio;
	}
	public Date getFecha_fin() {
		return fecha_fin;
	}
	public void setFecha_fin(Date fecha_fin) {
		this.fecha_fin = fecha_fin;
	}
	public int getId_actividad_cronograma() {
		return id_actividad_cronograma;
	}
	public void setId_actividad_cronograma(int id_actividad_cronograma) {
		this.id_actividad_cronograma = id_actividad_cronograma;
	}
	public int getTema_id() {
		return tema_id;
	}
	public void setTema_id(int tema_id) {
		this.tema_id = tema_id;
	}
	public String getNombre_tema() {
		return nombre_tema;
	}
	public void setNombre_tema(String nombre_tema) {
		this.nombre_tema = nombre_tema;
	}
	public int getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(int tutor_id) {
		this.tutor_id = tutor_id;
	}
	
	
	

}
