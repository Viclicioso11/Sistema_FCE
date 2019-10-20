package datos;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;
import javax.swing.JOptionPane;

public class PoolConexion 
{
	// EL PATRON SINGLETON EXIGE QUE LOS ATRIBUTOS Y LOS METODOS SEAN DECLARADOS STATIC Y PRIVADOS.
	private static PoolConexion INSTANCE = null; //CREA UNA INSTANCIA DE TIPO PoolConexion EN NULL 
	private static Connection con = null; //CREA UN OBJETO DE TIPO Connection
	private static DataSource dataSource; //CREA UN OBJETO DE TIPO DataSource
	private static String db = "FCE"; //VARIABLE CON EL NOMBRE DE LA BD
	private static String url = "jdbc:postgresql://localhost:5432/"+db; // VARIABLE CON LA URL DE CONEXION A LA BD
	private static String user = "postgres"; // VARIABLE CON EL USERNAME DE BD
	private static String pass = "Usuario123#."; // VARIABLE CON EL PASSWORD DE BD
	
	private PoolConexion() // CONSTRUCTOR DE LA CLASE
    {
		inicializaDataSource(); // INSTANCIA EL DATASOURCE (POOL)
    }
	
	private synchronized static void createInstance() // ESTE METODO ASIGNA A LA INSTANCIA <<INSTANCE>> LA INSTANCIA DEL OBJETO (POOL)
	{
		if(INSTANCE==null)
		{
			INSTANCE = new PoolConexion();
		}
	}
	
	public static PoolConexion getInstance() // ESTE METODO RETORNA LA INSTANCIA ÚNICA DEL OBJETO (POOL)
	{
		if(INSTANCE == null)
		{
			createInstance();
		}
		return INSTANCE;
	}
	
	

	 public final void inicializaDataSource() //ESTE METODO ASIGNA LOS VALORES DE FABRICA PARA LA CREACION DEL ORIGEN DE DATOS DE CONEXION
	 {

	 	org.apache.commons.dbcp.BasicDataSource basicDataSource = new org.apache.commons.dbcp.BasicDataSource();
        basicDataSource.setDriverClassName("org.postgresql.Driver");//SE ESPECIFICA EL DRIVER DE CONEXION 
        basicDataSource.setUsername(user); // SE ASIGNA EL USUARIO
        basicDataSource.setPassword(pass); // SE ASIGNA LA CONTRASEÑA
        basicDataSource.setUrl(url); // SE ASIGNA LA URL DE CONEXION A LA BD
        basicDataSource.setMaxActive(50); // SE ESPECIFICAN HASTA UN MAXIMO DE 50 HILOS DE CONEXION ACTIVOS A LA BD
        dataSource = basicDataSource; // AL OBJETO DE TIPO DATASOURCE PREVIAMENTE INSTANCIADO SE LE ASIGNA LA FABRICA DEL POOL DE CONEXIONES
	 }
	
	 
	 public static Connection getConnection()  //CON ESTE METODO SE OBTIENE UN HILO DE CONEXION ACTIVO
	 {	
		 if (EstaConectado()==false) 
		 {
			 try 
			 {
				 con = PoolConexion.dataSource.getConnection();
			 } 
			 catch (SQLException e) 
			 {
				 // TODO Auto-generated catch block
				 e.printStackTrace();
				 System.out.println(e.getMessage());
			 }
		 }
		 return con;
	 }

	 public static boolean EstaConectado() //CON ESTE METODO SE VALIDA SI EXISTE UNA CONEXION A LA BD ACTIVA
    {
    	boolean resp = false;
    	try
    	{
    		con = PoolConexion.dataSource.getConnection();
    		if ((con==null) || (con.isClosed()))
    			resp = false;
    		else
    			resp = true;
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    		System.out.println(e.getMessage());
    	}
    	
    	return resp;
    }

	    
	    
	    public static void main(String[] args) throws SQLException // ES LA COMPROBACION DE LA IMPLEMENTACIÓN DEL API DE POOL DE CONEXIONES CON EL PATRÓN SINGLETON
		{
			// TODO Auto-generated method stub
			PoolConexion.getInstance();
			Connection con = null;
	        
	        try 
	        {
		    	con = PoolConexion.getConnection();
		    	if(con!=null)
		    	{
		    		JOptionPane.showMessageDialog(null, "Conectado a " + db +" !");
		    		System.out.println("Conectado a "+db+" !!!");
		    	}
		    	else
		    	{
		    		JOptionPane.showMessageDialog(null, "Error al Conectar a "+db+" !!!");
		    		System.out.println("Error al Conectar a "+db+" !!!");
		    	}
	        }
	        finally
	        {
	            try 
	            {
	               con.close();
	               System.out.println("Se desconectó de "+db+"!!!");
	            } 
	            catch (SQLException ex) 
	            {
	            	ex.printStackTrace();
	                System.out.println(ex.getMessage());
	            }
	        }
	        
	            

		}
	
}
