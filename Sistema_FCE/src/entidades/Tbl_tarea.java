package entidades;

import java.util.Date;

public class Tbl_tarea {
	
	//ATRIBUTOS
	private int id;
	private int id_actividad_cronograma;
	private String titulo;
	private String descripcion;
	private String archivo_url;
	private Date fecha_inicio;
	private Date fecha_fin;
	private int estado;
	
	//METODOS
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_actividad_cronograma() {
		return id_actividad_cronograma;
	}
	public void setId_actividad_cronograma(int id_actividad_cronograma) {
		this.id_actividad_cronograma = id_actividad_cronograma;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getArchivo_url() {
		return archivo_url;
	}
	public void setArchivo_url(String archivo_url) {
		this.archivo_url = archivo_url;
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
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	

}
