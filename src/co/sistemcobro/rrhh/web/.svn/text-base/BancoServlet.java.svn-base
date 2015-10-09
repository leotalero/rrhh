package co.sistemcobro.rrhh.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import co.sistemcobro.all.constante.EstadoEnum;
import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.rrhh.bean.Banco;
import co.sistemcobro.rrhh.bean.EmpleadoBanco;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.ejb.BancoEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;

/**
 * Servlet para gestionar los bancos.
 * @author jpuentes
 */
@WebServlet(name = "BancoServlet", urlPatterns = { "/page/banco" })
public class BancoServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(BancoServlet.class);
       
	@EJB
	private BancoEJB bancoEJB;
	@EJB
	private EmpleadoEJB empleadoEJB;
    
	
    public BancoServlet() {
        super();
    }

    /**
	 * Metodo Get.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * Metodo Post.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("action");
		accion = accion==null? "" : accion;
		try{
			if(accion.equals("crear_banco")){
				crear_banco(request, response);
			}else if(accion.equals("banco_insertar")){
				insertarBanco(request,response);
			}else if(accion.equals("banco_propiedades")){
				banco_propiedades(request,response);
			}else if(accion.equals("banco_deshabilitar")){
				banco_deshabilitar(request,response);
			}else if(accion.equals("empleado_vereditarbanco")){
				empleado_vereditarbanco(request,response);
			}else if(accion.equals("empleadobanco_editar")){
				empleadobanco_editar(request,response);
			}else if(accion.equals("empleadobanco_habilitar")){
				empleadobanco_habilitar(request,response);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
		
	}
	
	
	// Respuesta a peticiones.
	
	/**
	 * Respuesta a petición Crear Banco.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	private void crear_banco(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			request.setAttribute("idempleado",request.getParameter("idempleado"));
			request.setAttribute("bancos",bancoEJB.obtenerListaDeBancos());
			request.getRequestDispatcher("../pages/banco/banco_nuevo.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	/**
	 * Método para insertar un nuevo banco.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	private void insertarBanco(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		
		
		try{
			String idEmpleado = request.getParameter("idempleado");
			String idBancoSeleccionado = request.getParameter("idbancoasignado");
			String numeroCuenta = request.getParameter("numerocuenta");
			String vigenteDesde = request.getParameter("fechaVigencia");
			
			idEmpleado = idEmpleado == null? "" :idEmpleado.trim();
			idBancoSeleccionado = idBancoSeleccionado == null? "" : idBancoSeleccionado.trim();
			numeroCuenta = numeroCuenta == null? "" :numeroCuenta.trim();
			vigenteDesde = vigenteDesde == null? "" :vigenteDesde.trim();
			
			if(idEmpleado!=null && !idEmpleado.equals("") && idBancoSeleccionado!=null && !idBancoSeleccionado.equals("")){
				EmpleadoBanco nuevoEmpleadoBanco = new EmpleadoBanco();
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	            Date fechafir = formatter.parse(vigenteDesde);
	            long time = fechafir.getTime();
		        Timestamp timeVigenciaDesde = new Timestamp(time);
				
				
				nuevoEmpleadoBanco.setIdbanco(Long.valueOf(idBancoSeleccionado));
				nuevoEmpleadoBanco.setIdempleado(Long.valueOf(idEmpleado));
				nuevoEmpleadoBanco.setNumerocuenta(numeroCuenta);
				nuevoEmpleadoBanco.setVigentedesde(timeVigenciaDesde);
				nuevoEmpleadoBanco.setIdusuariocrea(user.getCodusuario());
				nuevoEmpleadoBanco.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				nuevoEmpleadoBanco = bancoEJB.insertarEmpleadoBanco(nuevoEmpleadoBanco);
				
				if (nuevoEmpleadoBanco.getIdempleadobanco() != null && nuevoEmpleadoBanco.getIdempleadobanco() != 0) {
					PrintWriter out = response.getWriter();
					out.println(nuevoEmpleadoBanco.getIdempleado());
					out.close();
				} else {
					throw new LogicaException("Error al grabar el nuevo Banco.");
				}
			}
			
		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
			
		}
	
	
	/**
	 * Responder a la accion de banco_propiedades.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	private void banco_propiedades(HttpServletRequest request,HttpServletResponse response) throws ServletException ,IOException{
		try{
			String idempleado = (String) request.getParameter("idempleado");
			
			if (idempleado != null) {
				List<EmpleadoBanco> empleadoBancoPropiedades = bancoEJB.buscarEmpleadoBancoPorIdEmpleado(Long.valueOf(idempleado));
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleadobanco", empleadoBancoPropiedades);
				request.setAttribute("empleado", empleado);
				request.getRequestDispatcher("../pages/banco/empleado_banco.jsp").forward(request, response);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Método para responder a la acción banco_deshabilitar.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	private void banco_deshabilitar(HttpServletRequest request,HttpServletResponse response)throws LogicaException, IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idempleadobanco = request.getParameter("idempleadobanco");
			String idempleado = request.getParameter("idempleado");

			idempleadobanco = idempleadobanco == null ? "": idempleadobanco.trim();

			EmpleadoBanco empleadoBanco =  new EmpleadoBanco();
			empleadoBanco.setIdempleadobanco(Long.valueOf(idempleadobanco));
			empleadoBanco.setIdusuariomod(user.getCodusuario());
			

			//Integer resultado = empleadoEJB.deshabilitarEmpleadoBanco(empleadobanco);
			Integer resultado = bancoEJB.deshabilitarEmpleadoBanco(empleadoBanco);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
				out.close();
			} else {
				throw new LogicaException("Error al deshabilitar la cuenta bancaria.");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
		
	}
	
	/**
	 * Método para responder a la acción editar empleado banco.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	private void empleado_vereditarbanco(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idempleadobanco = (String) request.getParameter("idempleadobanco");
			
			if (idempleado != null && idempleadobanco != null) {
				
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				EmpleadoBanco empleadoBanco = bancoEJB.obtenerEmpleadoBancoPorId(Long.valueOf(idempleadobanco));
				List<Banco>  bancos = bancoEJB.obtenerListaDeBancos();
				
				request.setAttribute("empleado", empleado);
				request.setAttribute("empleadobanco", empleadoBanco);
				request.setAttribute("bancos", bancos);
			}
			
			request.getRequestDispatcher("../pages/banco/empleadobanco_editarbanco.jsp").forward(request, response);
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Método para responder a la acción editar empleado banco.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException,LogicaException
	 */
	private void empleadobanco_editar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException,LogicaException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			String idEmpleado = request.getParameter("idempleado");
			String idEmpleadoBanco = request.getParameter("idempleadobanco");
			String idBancoSeleccionado = request.getParameter("idbancoasignado");
			String numeroCuenta = request.getParameter("numerocuenta");
			String vigenteDesde = request.getParameter("fechaVigencia");
			
			idEmpleado = idEmpleado == null? "" :idEmpleado.trim();
			idEmpleadoBanco = idEmpleadoBanco == null? "" :idEmpleadoBanco.trim();
			idBancoSeleccionado = idBancoSeleccionado == null? "" : idBancoSeleccionado.trim();
			numeroCuenta = numeroCuenta == null? "" :numeroCuenta.trim();
			vigenteDesde = vigenteDesde == null? "" :vigenteDesde.trim();
			
			if(idEmpleadoBanco!=null && !idEmpleadoBanco.equals("") && idBancoSeleccionado!=null && !idBancoSeleccionado.equals("")){
				EmpleadoBanco empleadoBanco = new EmpleadoBanco();
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	            Date fechafir = formatter.parse(vigenteDesde);
	            long time = fechafir.getTime();
		        Timestamp timeVigenciaDesde = new Timestamp(time);
				
				empleadoBanco.setIdempleado(Long.valueOf(idEmpleado));
				empleadoBanco.setIdempleadobanco(Long.valueOf(idEmpleadoBanco));
				empleadoBanco.setIdbanco(Long.valueOf(idBancoSeleccionado));
				empleadoBanco.setNumerocuenta(numeroCuenta);
				empleadoBanco.setVigentedesde(timeVigenciaDesde);
				
				empleadoBanco.setIdusuariomod(Integer.valueOf(user.getCodusuario()));
				empleadoBanco.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				Integer resultado = bancoEJB.editarEmpleadoBanco(empleadoBanco);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoBanco.getIdempleado());
					out.close();
				} else {
					throw new LogicaException("Error al editar los datos del empleado.");
				}
			} else {
				throw new LogicaException("Existen valores en blanco y no se puede guardar el registro.");
			}
				
		}catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
		
	}

	
	/**
	 * Método para habilitar un empleadoBanco.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws Exception,LogicaException 
	 */
	private void empleadobanco_habilitar(HttpServletRequest request,HttpServletResponse response) throws LogicaException,Exception{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idempleado = request.getParameter("idempleado");
			String idempleadobanco = request.getParameter("idempleadobanco");
			
			idempleado = idempleado == null ? "" : idempleado.trim();
			idempleadobanco = idempleadobanco == null ? "" : idempleadobanco.trim();
			
			EmpleadoBanco empleadoBanco = new EmpleadoBanco();
			
			empleadoBanco.setIdempleadobanco(Long.valueOf(idempleadobanco));
			empleadoBanco.setIdempleado(Long.valueOf(idempleado));
			empleadoBanco.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = bancoEJB.habilitarEmpleadoBanco(empleadoBanco);
					
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleadoBanco.getIdempleado());
				out.close();
			} else {
				throw new LogicaException("Error al eliminar el empleado.");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}
}
