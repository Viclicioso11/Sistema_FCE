package datos;

import java.sql.Connection;
import java.sql.SQLException;
import org.apache.commons.dbcp.BasicDataSource;


public class ConnectionPooling {
    
	private static ConnectionPooling connectionPooling;
    private BasicDataSource dataSource;
	
    private ConnectionPooling() {
    	// making up settings to access 
    	// the DataBase
    	dataSource = new BasicDataSource();
    	dataSource.setDriverClassName("org.postgresql.Driver");
    	dataSource.setUsername("postgres");
    	dataSource.setPassword("Usuario123#.");
    	dataSource.setUrl("jdbc:postgresql://localhost:5432/FCE");
    	dataSource.setMaxActive(50);// change to 50 or more when production 
    	dataSource.setValidationQuery("select 1");
    	
    	//EN PRODUCCION
    	//dataSource.setUsername("fce3");
    	//dataSource.setPassword("^j5J$2bTs");
    	//dataSource.setUrl("jdbc:postgresql://165.98.12.158:5432/FCE");
    	
    	
    }
    
    /**
     * return connection thread
     */
    public Connection getConnection() throws SQLException {
    	return this.dataSource.getConnection();
    }
    
    /**
     * close connection thread 
     */
    public void closeConnection(Connection con) throws SQLException {
    	if (con != null) {
    		con.close();
    	}
    }

    /**
     * return Class Instance.
     * A new Instance when null, 
     * the instance when not null
     */
    public static ConnectionPooling getInstance() {
        if (connectionPooling == null){
        	connectionPooling = new ConnectionPooling();
        }
        return connectionPooling;
    }
    
}
