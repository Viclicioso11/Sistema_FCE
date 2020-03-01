package entidades;

import java.util.Date;


public class Tbl_plan_graduacion {

	//ATRIBUTOS
	private int id;
	private String cohorte;
	private String descripcion;
	private Date fecha_inicio;
	private Date fecha_fin;
	private int estado;
	
	//METODOS
	public String getCohorte() {
		return cohorte;
	}
	public void setCohorte(String cohorte) {
		this.cohorte = cohorte;
	}
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
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
}
