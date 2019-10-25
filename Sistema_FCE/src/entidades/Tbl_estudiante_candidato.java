package entidades;

public class Tbl_estudiante_candidato {
	
	//Atributos
	private int id;
	private String correo;
	private int notificado;
	private int estado;
	
	
	//Metodos Get Y Set
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public int getNotificado() {
		return notificado;
	}
	public void setNotificado(int notificado) {
		this.notificado = notificado;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	

	
}
