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
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.EmpleadoEducacion;
import co.sistemcobro.rrhh.ejb.EducacionEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;

/**
 * Clase para gestion de los datos sobre la educación de los empleados.
 * @author jpuentes
 */
@WebServlet(name = "EduccionServlet", urlPatterns = { "/page/educacion" })
public class EducacionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	Logger log = Logger.getLogger(EducacionServlet.class);
	
	@EJB
	private EducacionEJB educacionEJB;
	
	@EJB
	private EmpleadoEJB empleadoEJB;
	
    /**
     * Constructor.
     */
    public EducacionServlet() {
        super();
    }

	/**
	 * Método Get.
	 * @param HttpServletRequest. La peticion.
	 * @param HttpServletResponse. La respuesta.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * Método Post.
	 * @param HttpServletRequest. La peticion.
	 * @param HttpServletResponse. La respuesta.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("action");
		accion = accion==null? "" : accion;
		try{
			if(accion.equals("educacion_propiedades")){
				educacion_propiedades(request,response);
			}else if(accion.equals("crear_educacion")){
				crear_educacion(request,response);
			}else if(accion.equals("educacion_insertar")){
				educacion_insertar(request,response);
			}else if(accion.equals("empleado_vereditareducacion")){
				empleado_vereditareducacion(request,response);
			}else if(accion.equals("educacion_editar")){
				log.info("accion : "+accion);
				educacion_editar(request,response);
			}else if(accion.equals("educacion_deshabilitar")){
				educacion_deshabilitar(request,response);
			}else if(accion.equals("empleadoeducacion_habilitar")){
				educacion_habilitar(request,response);
			}
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Consultar el listado de propiedades de educacion de un empleado.
	 * @param HttpServletRequest. La peticion.
	 * @param HttpServletResponse. La respuesta.
	 * @throws ServletException ,IOException
	 */
	private void educacion_propiedades(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
		try{
			String idempleado = (String) request.getParameter("idempleado");
		
			if (idempleado != null) {
				
				List<EmpleadoEducacion> listaEmpleadoEducacion = educacionEJB.obtenerEducacionDeEmpleadoPorIdEmpleado(Long.valueOf(idempleado));
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleadoeducacion", listaEmpleadoEducacion);
				request.setAttribute("empleado", empleado);
				request.getRequestDispatcher("../pages/educacion/empleado_educacion.jsp").forward(request, response);
			}
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Responder a la accion de crear_educacion
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	public void crear_educacion(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			request.setAttribute("idempleado",request.getParameter("idempleado"));
			request.setAttribute("niveles",educacionEJB.obtenerNivelesDeEducacion());
			request.setAttribute("estados",educacionEJB.obtenerEstadosDeEducacion());
			request.getRequestDispatcher("../pages/educacion/educacion_nueva.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	

	/**
	 * Método para insertar la relación empleado_educacion.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	private void educacion_insertar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			
			String idEducacionNivel = request.getParameter("idnivelasignado");
			String idEducacionEstado = request.getParameter("idestadosignado");
			String idEmpleado = request.getParameter("idempleado");
			String institucion = request.getParameter("institucion");
			String carrera = request.getParameter("carrera");
			String titulo = request.getParameter("titulo");
			String fechaInicio = request.getParameter("fechaInicioEducacion");
			String fechaFin = request.getParameter("fechaFinEducacion");
			String observacion = request.getParameter("observacion");
				
			idEducacionNivel = idEducacionNivel == null? "" :idEducacionNivel.trim();
			idEducacionEstado = idEducacionEstado == null? "" : idEducacionEstado.trim();
			idEmpleado = idEmpleado == null? "" :idEmpleado.trim();
			institucion = institucion== null? "" :institucion.trim();
			carrera = carrera== null? "" :carrera.trim();
			titulo = titulo== null? "" :titulo.trim();
			fechaInicio = fechaInicio == null? "" :fechaInicio.trim();
			fechaFin = fechaFin == null? "" :fechaFin.trim();
			observacion = observacion == null? "" :observacion.trim();
			
			if(idEmpleado!=null && !idEmpleado.equals("") && idEducacionNivel!=null && !idEducacionNivel.equals("") && idEducacionEstado!=null && !idEducacionEstado.equals("")){
				
				EmpleadoEducacion empleadoEducacion =  new EmpleadoEducacion();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				
	            Date fechaInicioEducacion = formatter.parse(fechaInicio);
	            long time = fechaInicioEducacion.getTime();
		        Timestamp timeFechaInicio = new Timestamp(time);
				
				empleadoEducacion.setIdEducacionNivel(Long.valueOf(idEducacionNivel));
				empleadoEducacion.setIdEducacionEstado(Long.valueOf(idEducacionEstado));
				empleadoEducacion.setIdEmpleado(Long.valueOf(idEmpleado));
				empleadoEducacion.setInstitucion(institucion);
				empleadoEducacion.setCarrera(carrera);
				empleadoEducacion.setTitulo(titulo);
				empleadoEducacion.setFechaInicio(timeFechaInicio);
				
				if(fechaFin.equals("")){
					empleadoEducacion.setFechafin(null);
				}else{
					Date fechaFinEducacion = formatter.parse(fechaFin);
			        long timeF = fechaFinEducacion.getTime();
				    Timestamp timeFechaFin = new Timestamp(timeF);
				    empleadoEducacion.setFechafin(timeFechaFin);
				}
				
				if(observacion.equals("")){
					empleadoEducacion.setObservacion(null);
				}else{
					empleadoEducacion.setObservacion(observacion);
				}
				
				empleadoEducacion.setIdusuariocrea(user.getCodusuario());
				empleadoEducacion.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				empleadoEducacion = educacionEJB.insertarNuevaEducacion(empleadoEducacion);
				
				if (empleadoEducacion.getIdEmpleadoEducacion() != null && empleadoEducacion.getIdEmpleadoEducacion() != 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoEducacion.getIdEmpleado());
					out.close();
				} else {
					throw new LogicaException("Error al grabar la nueva educación.");
				}
				
			} else {
				throw new LogicaException("Error al grabar la nueva educación.");
			}
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
			
    }
	

	/**
	 * Método para responder a la acción editar la educación del empleado.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException
	 */
	private void empleado_vereditareducacion(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idempleadoeducacion = (String) request.getParameter("idempleadoeducacion");
			
			if (idempleado != null && idempleadoeducacion != null) {
				request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado)));
				request.setAttribute("empleadoeducacion", educacionEJB.obtenerEmpleadoEducacionPorId(Long.valueOf(idempleadoeducacion)));
				request.setAttribute("niveles",educacionEJB.obtenerNivelesDeEducacion());
				request.setAttribute("estados",educacionEJB.obtenerEstadosDeEducacion());
			}
			request.getRequestDispatcher("../pages/educacion/empleadoeducacion_editareducacion.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	

	/**
	 * Método para responder a la acción editar empleado educación.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException,LogicaException
	 */
	private void educacion_editar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException,LogicaException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		log.info("En metodo de servlet.");
		
		try{
			String idempleadoeducacion = request.getParameter("idempleadoeducacion");
			String idEducacionNivel = request.getParameter("idnivelasignado");
			String idEducacionEstado = request.getParameter("idestadosignado");
			String idEmpleado = request.getParameter("idempleado");
			String institucion = request.getParameter("institucion");
			String carrera = request.getParameter("carrera");
			String titulo = request.getParameter("titulo");
			String fechaInicio = request.getParameter("fechaInicioEducacion_editar");
			String fechaFin = request.getParameter("fechaFinEducacion_editar");
			String observacion = request.getParameter("observacion");
				
			idEducacionNivel = idEducacionNivel == null? "" :idEducacionNivel.trim();
			idEducacionEstado = idEducacionEstado == null? "" : idEducacionEstado.trim();
			idEmpleado = idEmpleado == null? "" :idEmpleado.trim();
			institucion = institucion== null? "" :institucion.trim();
			carrera = carrera== null? "" :carrera.trim();
			titulo = titulo== null? "" :titulo.trim();
			fechaInicio = fechaInicio == null? "" :fechaInicio.trim();
			fechaFin = fechaFin == null? "" :fechaFin.trim();
			observacion = observacion == null? "" :observacion.trim();
			idempleadoeducacion = idempleadoeducacion ==null? "" : idempleadoeducacion.trim();
			
			if(idEducacionNivel!=null && !idEducacionNivel.equals("") && idEducacionEstado!=null && !idEducacionEstado.equals("")
				&& idEmpleado!=null && !idEmpleado.equals("")){
				
				EmpleadoEducacion empleadoEducacion = new EmpleadoEducacion();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	            
				Date fechaI = formatter.parse(fechaInicio);
	            long time = fechaI.getTime();
		        Timestamp timeFechaInicio = new Timestamp(time);
				
		        empleadoEducacion.setIdEmpleadoEducacion(Long.valueOf(idempleadoeducacion));
		        empleadoEducacion.setIdEmpleadoEducacion(Long.valueOf(idempleadoeducacion));
		        empleadoEducacion.setIdEducacionNivel(Long.valueOf(idEducacionNivel));
				empleadoEducacion.setIdEducacionEstado(Long.valueOf(idEducacionEstado));
				empleadoEducacion.setIdEmpleado(Long.valueOf(idEmpleado));
				empleadoEducacion.setInstitucion(institucion);
				empleadoEducacion.setCarrera(carrera);
				empleadoEducacion.setTitulo(titulo);
				empleadoEducacion.setFechaInicio(timeFechaInicio);
				
				
				if(fechaFin.equals("")){
					empleadoEducacion.setFechafin(null);
				}else{
					Date fechaFinEducacion = formatter.parse(fechaFin);
			        long timeF = fechaFinEducacion.getTime();
				    Timestamp timeFechaFin = new Timestamp(timeF);
				    empleadoEducacion.setFechafin(timeFechaFin);
				}
				
				if(observacion.equals("")){
					empleadoEducacion.setObservacion(null);
				}else{
					empleadoEducacion.setObservacion(observacion);
				}
				
				empleadoEducacion.setIdusuariomod(user.getCodusuario());
				empleadoEducacion.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				Integer resultado = educacionEJB.editarEmpleadoEducacion(empleadoEducacion);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoEducacion.getIdEmpleado());
					out.close();
				} else {
					throw new LogicaException("Error al editar los datos del empleado.");
				}
			} else {
				throw new LogicaException("Existen valores en blanco y no se puede guardar el registro.");
			}
				
		}catch (LogicaException e) {
			log.info("Error 1: "+e);
			response.sendError(1, e.toString());
		} catch (Exception e) {
			log.info("Error 2: "+e);
			response.sendError(1, e.toString());
		}
		
	}
	

	/**
	 * Método para responder a la acción educacion_deshabilitar.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,LogicaException
	 */
	private void educacion_deshabilitar(HttpServletRequest request,HttpServletResponse response)throws LogicaException, IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idempleadoeducacion = request.getParameter("idempleadoeducacion");
			String idempleado = request.getParameter("idempleado");

			idempleadoeducacion = idempleadoeducacion == null ? "": idempleadoeducacion.trim();

			EmpleadoEducacion empleadoEducacion =  new EmpleadoEducacion();
			
			empleadoEducacion.setIdEmpleadoEducacion(Long.valueOf(idempleadoeducacion));
			empleadoEducacion.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = educacionEJB.deshabilitarEmpleadoEducacion(empleadoEducacion);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
				out.close();
			} else {
				throw new LogicaException("Error al deshabilitar la educación.");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
		
	}
	

	
	/**
	 * Método para habilitar un empleadoEducacion.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws Exception,LogicaException 
	 */
	private void educacion_habilitar(HttpServletRequest request,HttpServletResponse response) throws LogicaException,Exception{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idempleado = request.getParameter("idempleado");
			String idempleadoeducacion = request.getParameter("idempleadoeducacion");
			
			idempleado = idempleado == null ? "" : idempleado.trim();
			idempleadoeducacion = idempleadoeducacion == null ? "" : idempleadoeducacion.trim();
			
			EmpleadoEducacion empleadoEducacion = new EmpleadoEducacion();
			
			empleadoEducacion.setIdEmpleadoEducacion(Long.valueOf(idempleadoeducacion));
			empleadoEducacion.setIdEmpleado(Long.valueOf(idempleado));
			empleadoEducacion.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = educacionEJB.habilitarEmpleadoEducacion(empleadoEducacion);
					
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleadoEducacion.getIdEmpleado());
				out.close();
			} else {
				throw new LogicaException("Error al activar el empleado educacion..");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}
	
}
