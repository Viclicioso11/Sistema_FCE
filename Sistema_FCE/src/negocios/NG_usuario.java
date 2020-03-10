package negocios;

import datos.DT_estudiante_candidato;
import datos.DT_rol;
import datos.DT_usuario;
import entidades.Tbl_usuario;

public class NG_usuario {
	
	
	public int ngGuardarUser (Tbl_usuario tus) throws Exception {
        int guardado = 0;
		
		DT_usuario dtu = new DT_usuario();
		
		if(dtu.existeCarne(tus.getCarne()))	{
			guardado = 2; //EL USERNAME YA EXISTE
			
		} else if(dtu.existeCorreo(tus.getCorreo())){
			guardado = 3;
		} else if(dtu.guardarUser(tus)) {
			guardado = 1; //EL USUARIO HA SIDO GUARDADO CON EXITO.
		}
		return guardado;
		 
	}
	
	public int ngGuardarEstudiante (Tbl_usuario tus, int id_rol) throws Exception {
        int guardado = 0;
		
		DT_usuario dtu = new DT_usuario();
		DT_estudiante_candidato dtsc = new DT_estudiante_candidato();
		DT_rol dtrol = new DT_rol();
		
		//validamos si el estudiante esta en la lista de correos y si es estado 1
		if(dtsc.validarEstudianteCandidato(tus.getCorreo())) {
			
			
			if(dtu.existeCarne(tus.getCarne()))
			{
				guardado = 2; //EL carne YA EXISTE
			}
			else
			{
				if(dtu.existeCorreo(tus.getCorreo()))
				{
					guardado = 3; //EL CORREO YA EXISTE
				}
				else
				{
					if(dtu.guardarUser(tus))
					{
						int id_usuario = dtu.obtenerIDUser(tus.getCarne());
						dtsc.CambiarEstadoEstudianteCandidato(tus.getCorreo());//para que el estado del correo sea 3 y no se pueda volver a guardar
						dtrol.asignarRolUsuario(id_usuario, id_rol);//para guardar el rol del usuario como estudiante
						guardado = 1; //EL USUARIO HA SIDO GUARDADO CON EXITO.
					}
				}
				
			}
		}else {
			guardado = 4;
		}
	
		return guardado;
		 
	}
	
	
	
	

}

