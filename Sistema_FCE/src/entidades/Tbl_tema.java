package entidades;

public class Tbl_tema {

	//ATRIBUTOS
		private int id;
		private String tema;
		private String fecha;
		private String palabras_claves;
		private int id_ambito;
		private int id_carrera;
		private int id_tipo_fce;
		

		//METODOS
		
		
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
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
		public int getId_ambito() {
			return id_ambito;
		}
		public void setId_ambito(int id_ambito) {
			this.id_ambito = id_ambito;
		}
		public int getId_carrera() {
			return id_carrera;
		}
		public void setId_carrera(int id_carrera) {
			this.id_carrera = id_carrera;
		}
		public int getId_tipo_fce() {
			return id_tipo_fce;
		}
		public void setId_tipo_fce(int id_tipo_fce) {
			this.id_tipo_fce = id_tipo_fce;
		}
		
		
		
		
		
}
