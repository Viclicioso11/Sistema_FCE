package entidades;

public class Tbl_rol 
{
	//ATRIBUTOS
	private int id_rol;
	private String rol_name;
	private String rol_desc;
	private int estado;
	
	//METODOS
	public int getId_rol() {
		return id_rol;
	}
	public void setId_rol(int id_rol) {
		this.id_rol = id_rol;
	}
	public String getRol_name() {
		return rol_name;
	}
	public void setRol_name(String rol_name) {
		this.rol_name = rol_name;
	}
	public String getRol_desc() {
		return rol_desc;
	}
	public void setRol_desc(String rol_desc) {
		this.rol_desc = rol_desc;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	
	

}
