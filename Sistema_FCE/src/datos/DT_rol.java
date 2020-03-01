package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import entidades.Tbl_rol;
import entidades.Vw_rol_opcion;


public class DT_rol {

	// Getting ConnectionPolling instance
	ConnectionPooling connectionP = ConnectionPooling.getInstance();
	private ResultSet rsRol;
	private ResultSet rsRolOpc;
	
	
	//Metodo para devolver un arreglo con todos los roles que hay en la bd
	public ArrayList<Tbl_rol> listRol()
	{
		ArrayList<Tbl_rol> listaRol = new ArrayList<Tbl_rol>();
		
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRol = ps.executeQuery();
			while(rsRol.next())
			{
				Tbl_rol trol = new Tbl_rol();
				trol.setId(rsRol.getInt("id"));
				trol.setRol(rsRol.getString("rol"));
				trol.setDescripcion(rsRol.getString("descripcion"));
				trol.setEstado(rsRol.getInt("estado"));
				listaRol.add(trol);	
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			System.out.println("Fin del la consulta");
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listRol() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return listaRol;
	}
	
	public void getRS(Connection con) {
		try
		{			
			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol where estado <> 3", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRol = ps.executeQuery();
		}
		catch (Exception e)
		{
			System.out.println("DATOS: ERROR en listUser() "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	//Metodo para guardar un rol
	public boolean guardarRol(Tbl_rol trol) {
			
		boolean guardado = false;
			
			try
			{
				//Getting connection thread, important!
				Connection con = connectionP.getConnection();

				this.getRS(con);
				rsRol.moveToInsertRow();
				rsRol.updateString("rol", trol.getRol());
				rsRol.updateString("descripcion", trol.getDescripcion());
				rsRol.updateInt("estado",1);
				
				rsRol.insertRow();
				rsRol.moveToCurrentRow();
				
				guardado = true;
				// Closing connection thread, very important!
				connectionP.closeConnection(con);
			}
			catch (Exception e) 
			{
				System.err.println("ERROR en guardarRol(): "+e.getMessage());
				e.printStackTrace();
			}
			
			return guardado;
	}
	
	//Funcion para mofificar un rol
	public boolean modificarRol(Tbl_rol trol)
	{
		boolean modificado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsRol.beforeFirst();
			while (rsRol.next())
			{
				if(rsRol.getInt(1)==trol.getId())
				{
					rsRol.updateString("rol", trol.getRol());
					rsRol.updateString("descripcion", trol.getDescripcion());
					rsRol.updateInt("estado", 2);
					rsRol.updateRow();
					modificado=true;
					break;
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch (Exception e)
		{
			System.err.println("ERROR modificarRol() "+e.getMessage());
			e.printStackTrace();
		}
		return modificado;
		
	}
	
	//metodo para eliminar un rol
	public boolean eliminarRol(Tbl_rol trol)
	{
		boolean eliminado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			this.getRS(con);
			rsRol.beforeFirst();
			while (rsRol.next())
			{
				if(rsRol.getInt(1)==trol.getId())
				{
					rsRol.updateInt("estado",3);
					rsRol.updateRow();
					eliminado=true;
					break;
				}
			}
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
		}
		catch(Exception e)
		{
			System.err.println("ERROR eliminarRol() "+e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	// Metodo para obtenero un rol
	public Tbl_rol obtenerRol(int idRol)
	{
		Tbl_rol trol  = new Tbl_rol();
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();
			this.getRS(con);
			
			if(rsRol.next())
			{
				trol.setId(rsRol.getInt("id"));
				trol.setRol(rsRol.getString("rol"));
				trol.setDescripcion(rsRol.getString("descripcion"));
				trol.setEstado(rsRol.getInt("estado"));
			}
				
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
			
		} catch (Exception e) {
			System.out.println("DATOS: ERROR en ObtenerRol() "+ e.getMessage());
			e.printStackTrace();
		}
		
		return trol;
	}
		
	
	//Funcion para asignar un rol a un usuario
	public boolean asignarRolUsuario(int id_usuario, int id_rol)
	{
		boolean asignado=false;	
		
		try
		{
			//Getting connection thread, important!
			Connection con = connectionP.getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * from tbl_rol_usuario", 
					ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
					ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			rsRol = ps.executeQuery();
			
			rsRol.moveToInsertRow();
			rsRol.updateInt("id_rol", id_rol);
			rsRol.updateInt("id_usuario", id_usuario);
			
			rsRol.insertRow();
			rsRol.moveToCurrentRow();
			asignado = true;
			
			// Closing connection thread, very important!
			connectionP.closeConnection(con);
				
		} catch (Exception e)	{
			System.out.println("DATOS: ERROR en asignarRolUsuario() "+ e.getMessage());
			e.printStackTrace();
		}
		return asignado;
		
	}
		
///////////////////////////// METODO PARA LISTAR ROL & OPCIONES /////////////////////////////
    public ArrayList<Vw_rol_opcion> listRolOpc(int idRol)
    {
       ArrayList<Vw_rol_opcion> listRolOpc = new ArrayList<Vw_rol_opcion>();
       try
       {
    	 //Getting connection thread, important!
    	 Connection con = connectionP.getConnection();

         PreparedStatement ps = con.prepareStatement("SELECT * FROM public.vw_rol_opcion where rol_id=?", 
         ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, 
         ResultSet.HOLD_CURSORS_OVER_COMMIT);
         ps.setInt(1, idRol);
         
         rsRolOpc = ps.executeQuery();
         
        while(rsRolOpc.next()) {
        	
          Vw_rol_opcion vtrop = new Vw_rol_opcion();
          vtrop.setRol_id(rsRolOpc.getInt("rol_id"));
          vtrop.setRol(rsRolOpc.getString("rol"));
          vtrop.setOpcion_id(rsRolOpc.getInt("opcion_id"));
          vtrop.setOpcion(rsRolOpc.getString("opcion"));
          listRolOpc.add(vtrop);
         }
     	// Closing connection thread, very important!
		connectionP.closeConnection(con);
      
        } catch (Exception e) {
          System.out.println("DATOS: ERROR en listRolOpc() "+ e.getMessage());
          e.printStackTrace();
        }

        return listRolOpc;
      }
}
