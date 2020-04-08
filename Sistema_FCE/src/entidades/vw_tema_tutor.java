package entidades;

public class vw_tema_tutor {
	
	private String tema;
	private String fecha;
	private String palabras_claves;
	private int id_tutor;
	private String nombre_tutor;
	private String apellido_tutor;
	private String carrera;
	private String ambito;
	private String tipo_fce;
	private int id_tema;
	
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
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getPalabras_claves() {
		return palabras_claves;
	}
	public void setPalabras_claves(String palabras_claves) {
		this.palabras_claves = palabras_claves;
	}
	public int getId_tutor() {
		return id_tutor;
	}
	public void setId_tutor(int id_tutor) {
		this.id_tutor = id_tutor;
	}
	public String getNombre_tutor() {
		return nombre_tutor;
	}
	public void setNombre_tutor(String nombre_tutor) {
		this.nombre_tutor = nombre_tutor;
	}
	public String getApellido_tutor() {
		return apellido_tutor;
	}
	public void setApellido_tutor(String apellido_tutor) {
		this.apellido_tutor = apellido_tutor;
	}
	public String getCarrera() {
		return carrera;
	}
	public void setCarrera(String carrera) {
		this.carrera = carrera;
	}
	public String getAmbito() {
		return ambito;
	}
	public void setAmbito(String ambito) {
		this.ambito = ambito;
	}
	public String getTipo_fce() {
		return tipo_fce;
	}
	public void setTipo_fce(String tipo_fce) {
		this.tipo_fce = tipo_fce;
	}
	
}
