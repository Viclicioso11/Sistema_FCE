package entidades;

public class Tbl_carrera {


	//ATRIBUTOS
		private int id;
		private int id_facultad;
		private String nombre;
		private int estado;
		
		//METODOS
		
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public int getId_facultad() {
			return id_facultad;
		}
		public void setId_facultad(int id_facultad) {
			this.id_facultad = id_facultad;
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

		
}
