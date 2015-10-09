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
import co.sistemcobro.rrhh.bean.AfiliacionEntidad;
import co.sistemcobro.rrhh.bean.AfiliacionTipo;
import co.sistemcobro.rrhh.bean.EmpleadoAfiliacion;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.ejb.AfiliacionEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;

/**
 * Servlet implementation class AfiliacionServlet
 * @author jpuentes
 */

@WebServlet(name = "AfiliacionServlet", urlPatterns = { "/page/afiliacion"})
public class AfiliacionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final static Logger log = Logger.getLogger(AfiliacionServlet.class.getName());
	
	@EJB
	private AfiliacionEJB afiliacionEJB;
	
	@EJB
	private EmpleadoEJB empleadoEJB;
	
    /**
     * Constructor.
     */
    public AfiliacionServlet() {
        super();
    }

	/**
	 * Método get.
	 * @param HttpServletRequest. la petición.
	 * @param HttpServletResponse. la respuesta.
	 * @throws IOException 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doPost(request, response);
	}

	/**
	 * Método post.
	 * @param HttpServletRequest. la petición.
	 * @param HttpServletResponse. la respuesta.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion =request.getParameter("action");
		accion = accion==null? "" : accion;
		try{
			if(accion.equals("afiliacion_propiedades")){
				afiliacion_propiedades(request,response);
			}else if(accion.equals("crear_afiliacion")){
				crear_afiliacion(request,response);
			}else if(accion.equals("afiliacion_insertar")){
				afiliacion_insertar(request,response);
			}else if(accion.equals("afiliacion_deshabilitar")){
				afiliacion_deshabilitar(request,response);
			}else if(accion.equals("empleadoafiliacion_habilitar")){
				empleadoafiliacion_habilitar(request,response);
			}else if(accion.equals("empleado_vereditarafiliacion")){
				empleado_vereditarafiliacion(request,response);
			}else if(accion.equals("empleadoafiliacion_editar")){
				empleadoafiliacion_editar(request,response);
			}else if(accion.equals("cargar_entidades")){
				cargar_entidades(request,response);
			}
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
		
	}
	
	
	/**
	 * Responder a la accion de afiliacion_propiedades.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	private void afiliacion_propiedades(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		try{
		String idempleado = (String) request.getParameter("idempleado");
		log.info("idempleado:"+idempleado);
		if (idempleado != null) {
			
			List<EmpleadoAfiliacion> listaEmpleadoAfiliacion = afiliacionEJB.obtenerAfiliacionesDeEmpleadoPorIdEmpleado(Long.valueOf(idempleado));
			if(listaEmpleadoAfiliacion!=null){
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				if(empleado!=null){
					request.setAttribute("empleadoafiliacion", listaEmpleadoAfiliacion);
					request.setAttribute("empleado", empleado);
					
					request.getRequestDispatcher("../pages/afiliacion/empleado_afiliacion.jsp").forward(request, response);
				
				}
			}else{
				log.info("listaEmpleadoAfiliacion null:");
			}
		}else{
			log.info("idempleado null:");
		}
		
	} catch (Exception e) {
		log.info("erorr :"+e);
		response.sendError(1, e.getMessage());
	}
	}
	
	
	/**
	 * Responder a la accion de crear_afiliacion.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	public void crear_afiliacion(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			
			request.setAttribute("idempleado",request.getParameter("idempleado"));
			request.setAttribute("tiposAfiliacion",afiliacionEJB.obtenerTiposDeAfiliacion());
			request.setAttribute("entidades",afiliacionEJB.obtenerEntidadesDeAfiliacion());
						
			request.getRequestDispatcher("../pages/afiliacion/afiliacion_nueva.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Método para insertar una afiliación.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	private void afiliacion_insertar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			String idEmpleado = request.getParameter("idempleado");
			String idTipoAsignado = request.getParameter("idtipoasignado");
			String idEntidadAsignada = request.getParameter("identidadasignada");
			String fechaInicio = request.getParameter("fechaInicioAfiliacion");
			String fechaFin = request.getParameter("fechaFinAfiliacion");
			String observacion = request.getParameter("observacion"); 
						
			idEmpleado = idEmpleado == null? "" :idEmpleado.trim();
			idTipoAsignado = idTipoAsignado == null? "" : idTipoAsignado.trim();
			idEntidadAsignada = idEntidadAsignada == null? "" :idEntidadAsignada.trim();
			fechaInicio = fechaInicio == null? "" :fechaInicio.trim();
			fechaFin = fechaFin == null? "" :fechaFin.trim();
			observacion = observacion == null? "" :observacion.trim();
			
			if(idEmpleado!=null && !idEmpleado.equals("") && idTipoAsignado!=null && !idTipoAsignado.equals("") && idEntidadAsignada!=null && !idEntidadAsignada.equals("")){
				
				EmpleadoAfiliacion empleadoAfiliacion =  new EmpleadoAfiliacion();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				
	            Date fechaInicioAfiliacion = formatter.parse(fechaInicio);
	            long time = fechaInicioAfiliacion.getTime();
		        Timestamp timeFechaInicio = new Timestamp(time);
				
				empleadoAfiliacion.setIdempleado(Long.valueOf(idEmpleado));
				empleadoAfiliacion.setIdafiliaciontipo(Long.valueOf(idTipoAsignado));
				empleadoAfiliacion.setIdafiliacionentidad(Long.valueOf(idEntidadAsignada));
				empleadoAfiliacion.setFechainicio(timeFechaInicio);
				
				if(fechaFin.equals("")){
					empleadoAfiliacion.setFechafin(null);
				}else{
					Date fechaFinAfiliacion = formatter.parse(fechaFin);
			        long timeF = fechaFinAfiliacion.getTime();
				    Timestamp timeFechaFin = new Timestamp(timeF);
				    empleadoAfiliacion.setFechafin(timeFechaFin);
				}
				
				if(observacion.equals("")){
					empleadoAfiliacion.setObservacion(null);
				}else{
					empleadoAfiliacion.setObservacion(observacion);
				}
				
				empleadoAfiliacion.setIdusuariocrea(user.getCodusuario());
				empleadoAfiliacion.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				empleadoAfiliacion = afiliacionEJB.insertarNuevaAfiliacion(empleadoAfiliacion);
				
				if (empleadoAfiliacion.getIdempleadoafiliacion() != null && empleadoAfiliacion.getIdempleadoafiliacion() != 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoAfiliacion.getIdempleado());
					out.close();
				} else {
					throw new LogicaException("Error al grabar la nueva afiliación.");
				}
				
			} else {
				throw new LogicaException("Error al grabar la nueva afiliación.");
			}
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
			
		}
	
	/**
	 * Método para responder a la acción afiliacion_deshabilitar.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	private void afiliacion_deshabilitar(HttpServletRequest request,HttpServletResponse response)throws LogicaException, IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idempleadoafiliacion = request.getParameter("idempleadoafiliacion");
			String idempleado = request.getParameter("idempleado");

			idempleadoafiliacion = idempleadoafiliacion == null ? "": idempleadoafiliacion.trim();

			EmpleadoAfiliacion empleadoAfiliacion =  new EmpleadoAfiliacion();
			
			empleadoAfiliacion.setIdempleadoafiliacion(Long.valueOf(idempleadoafiliacion));
			empleadoAfiliacion.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = afiliacionEJB.deshabilitarEmpleadoAfiliacion(empleadoAfiliacion);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
				out.close();
			} else {
				throw new LogicaException("Error al deshabilitar la afliación");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
		
	}
	

	/**
	 * Método para habilitar un empleadoAfiliacion.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws Exception,LogicaException 
	 */
	private void empleadoafiliacion_habilitar(HttpServletRequest request,HttpServletResponse response) throws LogicaException,Exception{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idempleado = request.getParameter("idempleado");
			String idempleadoafiliacion = request.getParameter("idempleadoafiliacion");
			
			idempleado = idempleado == null ? "" : idempleado.trim();
			idempleadoafiliacion = idempleadoafiliacion == null ? "" : idempleadoafiliacion.trim();
			
			EmpleadoAfiliacion empleadoAfiliacion = new EmpleadoAfiliacion();
			
			empleadoAfiliacion.setIdempleadoafiliacion(Long.valueOf(idempleadoafiliacion));
			empleadoAfiliacion.setIdempleado(Long.valueOf(idempleado));
			empleadoAfiliacion.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = afiliacionEJB.habilitarEmpleadoAfiliacion(empleadoAfiliacion);
					
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleadoAfiliacion.getIdempleado());
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
	
	

	/**
	 * Método para responder a la acción editar empleado afiliacion
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException
	 */
	private void empleado_vereditarafiliacion(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		try {
			
			String idempleado = (String) request.getParameter("idempleado");
			String idempleadoafiliacion = (String) request.getParameter("idempleadoafiliacion");
			
			if (idempleado != null && idempleadoafiliacion != null) {
				
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				EmpleadoAfiliacion empleadoAfiliacion = afiliacionEJB.obtenerEmpleadoAfiliacionPorId(Long.valueOf(idempleadoafiliacion));
				List<AfiliacionTipo> tiposDeAfiliacion = afiliacionEJB.obtenerTiposDeAfiliacion();
				
				//Long idAfiliacionTipo = afiliacionEJB.getIdAfiliacionTipoPorEmpleadoAfiliacion(Long.valueOf(idempleadoafiliacion));
//				List<AfiliacionEntidad> entidades = afiliacionEJB.getEntidadesPorTipoAfiliacion(idAfiliacionTipo);
				List<AfiliacionEntidad> entidades = afiliacionEJB.obtenerEntidadesDeAfiliacion();
				
				request.setAttribute("empleado", empleado);
				request.setAttribute("tipos", tiposDeAfiliacion);
				request.setAttribute("entidades", entidades);
				request.setAttribute("empleadoafiliacion", empleadoAfiliacion);
				
			}
			
			request.getRequestDispatcher("../pages/afiliacion/empleadoafiliacion_editarafiliacion.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Método para responder a la acción editar empleado afiliacion.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException,LogicaException
	 */
	private void empleadoafiliacion_editar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException,LogicaException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		log.info("En editar del servlet.");
		
		try{
			String idEmpleado = request.getParameter("idempleado");
			String idEmpleadoAfiliacion  = request.getParameter("idempleadoafiliacion");
			String idTipoAfiliacionSeleccionado = request.getParameter("idtipoasignado");
			String idEntidadSeleccionada = request.getParameter("identidadasignada");
			String fechaInicio = request.getParameter("fechaInicioAfiliacion_editar");
			String fechaFin = request.getParameter("fechaFinAfiliacion_editar");
			String observacion = request.getParameter("observacion");
			
			idEmpleado = idEmpleado == null? "" :idEmpleado.trim();
			idEmpleadoAfiliacion = idEmpleadoAfiliacion == null? "" :idEmpleadoAfiliacion.trim();
			idTipoAfiliacionSeleccionado = idTipoAfiliacionSeleccionado == null? "" : idTipoAfiliacionSeleccionado.trim();
			idEntidadSeleccionada = idEntidadSeleccionada == null? "" :idEntidadSeleccionada.trim();
			fechaInicio = fechaInicio == null? "" :fechaInicio.trim();
			fechaFin = fechaFin == null? "" :fechaFin.trim();
			observacion = observacion == null? "" :observacion.trim();
			
			
			if(idEmpleadoAfiliacion!=null && !idEmpleadoAfiliacion.equals("") && idTipoAfiliacionSeleccionado!=null && !idTipoAfiliacionSeleccionado.equals("")
				&& idEntidadSeleccionada!=null && !idEntidadSeleccionada.equals("")){
				
				EmpleadoAfiliacion empleadoAfiliacion = new EmpleadoAfiliacion();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	            
				Date fechaI = formatter.parse(fechaInicio);
	            long time = fechaI.getTime();
		        Timestamp timeFechaInicio = new Timestamp(time);
				
		        empleadoAfiliacion.setIdempleadoafiliacion(Long.valueOf(idEmpleadoAfiliacion));
		        empleadoAfiliacion.setIdempleado(Long.valueOf(idEmpleado));
		        empleadoAfiliacion.setIdafiliaciontipo(Long.valueOf(idTipoAfiliacionSeleccionado));
		        empleadoAfiliacion.setIdafiliacionentidad(Long.valueOf(idEntidadSeleccionada));
		        empleadoAfiliacion.setFechainicio(timeFechaInicio);
		        
		        if(fechaFin.equals("") || fechaFin==null){
					empleadoAfiliacion.setFechafin(null);
				}else{
					Date fechaFinAfiliacion = formatter.parse(fechaFin);
			        long timeF = fechaFinAfiliacion.getTime();
				    Timestamp timeFechaFin = new Timestamp(timeF);
				    empleadoAfiliacion.setFechafin(timeFechaFin);
				}
				
				if(observacion.equals("") || observacion==null){
					empleadoAfiliacion.setObservacion(null);
				}else{
					empleadoAfiliacion.setObservacion(observacion);
				}
				
				empleadoAfiliacion.setIdusuariomod(Integer.valueOf(user.getCodusuario()));
				empleadoAfiliacion.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				Integer resultado = afiliacionEJB.editarEmpleadoAfiliacion(empleadoAfiliacion);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoAfiliacion.getIdempleado());
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
	//cargar_entidades(request,response);
	public void cargar_entidades(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String idafiliaciontipo = request.getParameter("idafiliaciontipo");
			
			List<AfiliacionEntidad> lista = afiliacionEJB.getEntidadesPorTipoAfiliacion(Long.valueOf(idafiliaciontipo));
			
			request.setAttribute("entidades", lista);
			request.getRequestDispatcher("../pages/empleado/lista_entidades.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
}
