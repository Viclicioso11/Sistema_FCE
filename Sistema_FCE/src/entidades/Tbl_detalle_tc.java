package entidades;

//Esta clase es para los detalles del cronograma con el tema
public class Tbl_detalle_tc {

	//ATRIBUTOS
	private int id;
	private int id_actividad_crono;
	private int id_actividad_pg;
	private int id_tema_crono;
	private int estado;
	
	//METODOS
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_actividad_crono() {
		return id_actividad_crono;
	}
	public void setId_actividad_crono(int id_actividad_crono) {
		this.id_actividad_crono = id_actividad_crono;
	}
	public int getId_actividad_pg() {
		return id_actividad_pg;
	}
	public void setId_actividad_pg(int id_actividad_pg) {
		this.id_actividad_pg = id_actividad_pg;
	}
	public int getId_tema_crono() {
		return id_tema_crono;
	}
	public void setId_tema_crono(int id_tema_crono) {
		this.id_tema_crono = id_tema_crono;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	
	
}
