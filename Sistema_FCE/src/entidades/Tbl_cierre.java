package entidades;

import java.util.Date;

public class Tbl_cierre {
	int id;
	int idTema;
	Date fecha;
	String doc;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdTema() {
		return idTema;
	}
	public void setIdTema(int idTema) {
		this.idTema = idTema;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getDoc() {
		return doc;
	}
	public void setDoc(String doc) {
		this.doc = doc;
	}
	
	
}
