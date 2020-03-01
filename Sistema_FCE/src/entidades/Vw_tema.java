package entidades;

public class Vw_tema {
	
	private String tema;
	private String tipo_fce;
	private String  ambito;
	private String carrera;
	private int tutor;
	private String fecha;
	private String palabras_claves;
	private int id_tema;
	private String 	nombre_tutor;
	
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
	public String getAmbito() {
		return ambito;
	}
	public void setAmbito(String ambito) {
		this.ambito = ambito;
	}
	public String getCarrera() {
		return carrera;
	}
	public void setCarrera(String carrera) {
		this.carrera = carrera;
	}
	public int getTutor() {
		return tutor;
	}
	public void setTutor(int tutor) {
		this.tutor = tutor;
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
	public String getTipo_fce() {
		return tipo_fce;
	}
	public void setTipo_fce(String tipo_fce) {
		this.tipo_fce = tipo_fce;
	}
	public String getNombre_tutor() {
		return nombre_tutor;
	}
	public void setNombre_tutor(String nombre_tutor) {
		this.nombre_tutor = nombre_tutor;
	}
	
}
