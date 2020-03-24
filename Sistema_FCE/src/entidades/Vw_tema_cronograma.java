package entidades;

public class Vw_tema_cronograma {
	
	//ATRIBUTOS
	
	private int id;
	private int id_cronograma;
	private int id_tema;
	private String tema;
	private int id_tutor;
	private int estado_tema;
	private String descripcion_cronograma;
	private int estado_cronograma;
	

	//METODOS
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_cronograma() {
		return id_cronograma;
	}
	public void setId_cronograma(int id_cronograma) {
		this.id_cronograma = id_cronograma;
	}
	public int getId_tema() {
		return id_tema;
	}
	public void setId_tema(int id_tema) {
		this.id_tema = id_tema;
	}
	public String getTema() {
		return tema;
	}
	public void setTema(String tema) {
		this.tema = tema;
	}
	public int getId_tutor() {
		return id_tutor;
	}
	public void setId_tutor(int id_tutor) {
		this.id_tutor = id_tutor;
	}
	public int getEstado_tema() {
		return estado_tema;
	}
	public void setEstado_tema(int estado_tema) {
		this.estado_tema = estado_tema;
	}
	public String getDescripcion_cronograma() {
		return descripcion_cronograma;
	}
	public void setDescripcion_cronograma(String descripcion_cronograma) {
		this.descripcion_cronograma = descripcion_cronograma;
	}
	public int getEstado_cronograma() {
		return estado_cronograma;
	}
	public void setEstado_cronograma(int estado_cronograma) {
		this.estado_cronograma = estado_cronograma;
	}
	

}
