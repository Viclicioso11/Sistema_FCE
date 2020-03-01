package entidades;

import java.util.*;

public class Tbl_actividad_pg {

	//ATRIBUTOS
	private int id;
	private String descripcion;
	private Date fecha_inicio;
	private Date fecha_fin;
	private String nombre;
	private int estado;
	private int id_plan_graduacion;
	
	
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
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public int getId_plan_graduacion() {
		return id_plan_graduacion;
	}
	public void setId_plan_graduacion(int id_plan_graduacion) {
		this.id_plan_graduacion = id_plan_graduacion;
	}

	
	
}
