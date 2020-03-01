package entidades;

import java.util.Date;

public class Tbl_cronograma {


	//ATRIBUTOS
	private int id;
	private String descripcion;
	private Date fecha_inicio;
	private Date fecha_fin;
	private String tipo_cronograma;
	private int estado;
	
	//METODOS
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getTipo_cronograma() {
		return tipo_cronograma;
	}
	public void setTipo_cronograma(String tipo_cronograma) {
		this.tipo_cronograma = tipo_cronograma;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	
}
