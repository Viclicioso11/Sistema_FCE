package datos;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class DT_correo {


	private String port = "587"; //587, 465
	private String host = "smtp.gmail.com";
	private String from = "ninjas.devs@gmail.com";
	private boolean auth = true;
	private boolean debug = true;

	public boolean enviarCorreo(String mensaje, String correo) {

		boolean enviado = false;
		// La configuracion para enviar correo
		Properties properties = new Properties();
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port",port);
		properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		properties.put("mail.smtp.starttls.enable", "true");

		Authenticator authenticator = null;

		if (auth) {
            properties.put("mail.smtp.auth", "true");
            authenticator = new Authenticator() {
                private PasswordAuthentication pa = new PasswordAuthentication("ninjas.devs@gmail.com", "Ninja@developers");
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
			mimeMessage.setRecipients(Message.RecipientType.TO, correoEnviar);

			// Agregar el asunto al correo
			mimeMessage.setSubject("Mensaje de Inscripción al Sistema de FCE");

			String cuerpoMensaje = "<strong>Presione el siguiente enlace para dirigirse al cuestionario de registro de estudiante</strong>";
			cuerpoMensaje += "<a href=\"http://165.98.12.158:9090/Sistema_FCE/pages/inscripcion/newStudent.jsp\">Click</a><br><br>";
			cuerpoMensaje += mensaje;

			mimeMessage.setContent(cuerpoMensaje, "text/html");

			Transport.send(mimeMessage);

			System.out.println("Correo enviado");
			enviado = true;

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return enviado;

	}
	

}
