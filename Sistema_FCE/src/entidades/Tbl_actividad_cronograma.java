package entidades;

import java.util.Date;

public class Tbl_actividad_cronograma {

	//ATRIBUTOS
	private int id;
	private String nombre;
	private String descripcion;
	private Date fecha_inicio;
	private Date fecha_fin;
	private String archivo_url;
	private int estado;
	private int id_cronograma;
	
	//METODOS
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
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
	public String getArchivo_url() {
		return archivo_url;
	}
	public void setArchivo_url(String archivo_url) {
		this.archivo_url = archivo_url;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public int getId_cronograma() {
		return id_cronograma;
	}
	public void setId_cronograma(int id_cronograma) {
		this.id_cronograma = id_cronograma;
	}
	
	
	
}
