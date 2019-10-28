package datos;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


import entidades.Tbl_estudiante_candidato;


public class DT_correo {
	

	private String port = "587"; //587, 465
	private String host = "smtp.gmail.com";
	private String from = "nedmena@gmail.com";
	private boolean auth = true;
	private String username = "blabla@gmail.com";
	private String password = "KIMM090500";
	private Protocol protocol = Protocol.TLS;
	private boolean debug = true;
	
	public boolean enviarCorreo(String mensaje, String correo) {
		
		// La configuracion para enviar correo
		Properties properties = new Properties();
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port",port);
		properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		switch (protocol) {
		
		case TLS:
	        properties.put("mail.smtp.starttls.enable", "true");
	        break;
		case SMTP:
			properties.put("mail.smtp.ssl.enable", "true");
			break;
	    case SMTPS:
	        properties.put("mail.smtp.ssl.enable", "true");
	        break;
	    
	}

		Authenticator authenticator = null;
		
		if (auth) {
            properties.put("mail.smtp.auth", "true");
            authenticator = new Authenticator() {
                private PasswordAuthentication pa = new PasswordAuthentication("nedmena@gmail.com", "KIMM090500");
                @Override
                public PasswordAuthentication getPasswordAuthentication() {
                    return pa;
                }
            };
        }

		// Obtener la sesion
				Session session = Session.getInstance(properties, authenticator);
				session.setDebug(debug);
				
				// Crear el cuerpo del mensaje
				MimeMessage mimeMessage = new MimeMessage(session);
				
				try {

					// Agregar quien envio el correo
					mimeMessage.setFrom(new InternetAddress(from));

					// Los destinatarios
					InternetAddress[] correoEnviar = {new InternetAddress(correo)};

					// Agregar los destinatarios al mensaje
					mimeMessage.setRecipients(Message.RecipientType.TO,
							correoEnviar);

					// Agregar el asunto al correo
					mimeMessage.setSubject("Mensaje de Inscripción al Sistema de FCE");

					String cuerpoMensaje = "<strong>Presione el siguiente enlace para dirigirse al cuestionario de registro de estudiante</strong>";
					cuerpoMensaje += "<a href=\"http://localhost:8080/Sistema_FCE/pages/seguridad/newStudent.jsp\"</a><br><br>";
					cuerpoMensaje += mensaje;
						
					mimeMessage.setContent(cuerpoMensaje, "text/html");

					Transport.send(mimeMessage);
					
					System.out.println("Correo enviado");
					debug = true;

				} catch (Exception ex) {
					ex.printStackTrace();
				}
				
				return debug;
		
	}
}
