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
import co.sistemcobro.rrhh.bean.EmpleadoFamilia;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.ejb.FamiliaEJB;

/**
 * Servlet para gestionar la peticiones sobre la información de los familiares de los empleados.
 * @author jpuentes
 */
@WebServlet(name = "FamiliaServlet", urlPatterns = { "/page/familia" })
public class FamiliaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	Logger log = Logger.getLogger(FamiliaServlet.class);
	
	@EJB
	FamiliaEJB familiaEJB;
	
	@EJB
	EmpleadoEJB empleadoEJB;
	
    /**
     * Constructor.
     */
    public FamiliaServlet() {
        super();
    }

	/**
	 * Método get.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * Método Post.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("action");
		accion = accion==null? "" : accion;
		try{
			if(accion.equals("familia_propiedades")){
				familiaPropiedades(request,response);
			}else if(accion.equals("crear_familiar")){
				crear_familiar(request,response);
			}else if(accion.equals("familia_insertar")){
				familia_insertar(request,response);
			}else if(accion.equals("empleado_vereditarfamilia")){
				empleado_vereditarfamilia(request,response);
			}else if(accion.equals("familia_editar")){
				familia_editar(request,response);
			}else if(accion.equals("familia_deshabilitar")){
				familia_deshabilitar(request,response);
			}else if(accion.equals("empleadofamilia_habilitar")){
				familia_habilitar(request, response);
			}
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para mostrar las propiedades de la familia del empleado.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException 
	 */
	private void familiaPropiedades(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		try{
			
			String idEmpleado = (String) request.getParameter("idempleado");
			
			if (idEmpleado != null) {
				List<EmpleadoFamilia> listaFamiliaEmpleado = familiaEJB.obtenerFamiliaDeEmpleadoPorIdEmpleado(Long.valueOf(idEmpleado));
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idEmpleado));
				request.setAttribute("empleadofamilia", listaFamiliaEmpleado);
				request.setAttribute("empleado", empleado);
				request.getRequestDispatcher("../pages/familia/empleado_familia.jsp").forward(request, response);
			}else{
				log.info("id empleado es null o vacio.");
			}
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Responder a la accion de crear un familiar.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException 
	 */
	public void crear_familiar(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			
			request.setAttribute("idempleado",request.getParameter("idempleado"));
			request.setAttribute("parentescos",familiaEJB.obtenerListaParentescos());
			request.setAttribute("generos",familiaEJB.obtenerListaGeneros());
			request.setAttribute("tiposIdentificacion",familiaEJB.obtenerListaTiposIdentificacion());
			request.getRequestDispatcher("../pages/familia/familia_nueva.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Método para insertar la relación empleado_familia
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 */
	private void familia_insertar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			String idparentescoasignado = request.getParameter("idparentescoasignado"); 
			String idempleado = request.getParameter("idempleado");
			String idgeneroasignado = request.getParameter("idgeneroasignado");
			String idtipodocumentoasignado = request.getParameter("idtipodocumentoasignado");
			String numerodocumento = request.getParameter("numerodocumento");
			String nombre = request.getParameter("nombre");
			String apellido = request.getParameter("apellido");
			String fechaNacimiento = request.getParameter("fechaNacimiento");
			String observacion = request.getParameter("observacion");
		
			idparentescoasignado = idparentescoasignado ==null?"":idparentescoasignado.trim();
			idempleado = idempleado == null? "" :idempleado.trim();
			idgeneroasignado = idgeneroasignado == null? "" : idgeneroasignado.trim();
			idtipodocumentoasignado = idtipodocumentoasignado == null? "" :idtipodocumentoasignado.trim();
			numerodocumento = numerodocumento== null? "" :numerodocumento.trim();
			nombre = nombre== null? "" :nombre.trim();
			apellido = apellido== null? "" :apellido.trim();
			fechaNacimiento = fechaNacimiento == null? "" :fechaNacimiento.trim();
			observacion = observacion == null? "" :observacion.trim();
			
			if(idempleado!=null && !idempleado.equals("") && 
				idgeneroasignado!=null &&  !idgeneroasignado.equals("") && 
				idtipodocumentoasignado!=null && !idtipodocumentoasignado.equals("") &&
				idparentescoasignado!=null && !idparentescoasignado.equals("")){
								
				EmpleadoFamilia empleadoFamilia =  new EmpleadoFamilia();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				
	            Date fechaDeNacimiento = formatter.parse(fechaNacimiento);
	            long time = fechaDeNacimiento.getTime();
		        Timestamp timeFechaNacimiento = new Timestamp(time);
				
				empleadoFamilia.setIdParentesco(Long.valueOf(idparentescoasignado));
				empleadoFamilia.setIdempleado(Long.valueOf(idempleado));
				empleadoFamilia.setIdGenero(Long.valueOf(idgeneroasignado));
				empleadoFamilia.setIdidentificaciontipo(Long.valueOf(idtipodocumentoasignado));
				empleadoFamilia.setNumeroIdentificacion(numerodocumento);
				empleadoFamilia.setNombrefamilia(nombre);
				empleadoFamilia.setApellidoFamilia(apellido);
				empleadoFamilia.setFechaNacimiento(timeFechaNacimiento);
				
				
				if(observacion.equals("")){
					empleadoFamilia.setObservacion(null);
				}else{
					empleadoFamilia.setObservacion(observacion);
				}
				
				empleadoFamilia.setIdusuariocrea(user.getCodusuario());
				empleadoFamilia.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				empleadoFamilia = familiaEJB.insertarNuevoEmpleadoFamilia(empleadoFamilia);
				
				if (empleadoFamilia.getIdEmpleadoFamilia() != null && empleadoFamilia.getIdEmpleadoFamilia() != 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoFamilia.getIdempleado());
					out.close();
				} else {
					throw new LogicaException("Error al grabar el nuevo familiar.");
				}
				
			} else {
				throw new LogicaException("Error al grabar el nuevo familiar.");
			}
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
			
    }
	
	/**
	 * Método para responder a la acción editar un familiar del empleado.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException
	 */
	private void empleado_vereditarfamilia(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idempleadofamilia= (String) request.getParameter("idempleadofamilia");
			
			if (idempleado != null && idempleadofamilia != null) {
				request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado)));
				request.setAttribute("empleadofamilia", familiaEJB.consultarEmpleadoFamiliaPorId(Long.valueOf(idempleadofamilia)));
				
				log.info("Fecha nacimiento = "+familiaEJB.consultarEmpleadoFamiliaPorId(Long.valueOf(idempleadofamilia)).getFechaNacimiento());
				
				request.setAttribute("parentescos",familiaEJB.obtenerListaParentescos());
				request.setAttribute("generos",familiaEJB.obtenerListaGeneros());
				request.setAttribute("tiposIdentificacion",familiaEJB.obtenerListaTiposIdentificacion());
			}
			request.getRequestDispatcher("../pages/familia/empleadofamilia_editarfamilia.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	

	/**
	 * Método para responder a la acción editar empleado_familia.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException,LogicaException
	 */
	private void familia_editar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException,LogicaException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			String idempleadofamilia = request.getParameter("idempleadofamilia");
			String idparentescoasignado = request.getParameter("idparentescoasignado");
			String idgeneroasignado = request.getParameter("idgeneroasignado");
			String idempleado = request.getParameter("idempleado");
			String idtipodocumentoasignado = request.getParameter("idtipodocumentoasignado");
			String numerodocumento = request.getParameter("numerodocumento");
			String nombre = request.getParameter("nombre");
			String apellido = request.getParameter("apellido");
			String fechaNacimiento = request.getParameter("fechaNacimiento");
			String observacion = request.getParameter("observacion");
			
			idempleadofamilia = idempleadofamilia == null? "" :idempleadofamilia.trim();
			idparentescoasignado = idparentescoasignado == null? "" : idparentescoasignado.trim();
			idgeneroasignado = idgeneroasignado == null? "" :idgeneroasignado.trim();
			idempleado = idempleado== null? "" :idempleado.trim();
			idtipodocumentoasignado = idtipodocumentoasignado== null? "" :idtipodocumentoasignado.trim();
			numerodocumento = numerodocumento== null? "" :numerodocumento.trim();
			nombre = nombre == null? "" :nombre.trim();
			apellido = apellido == null? "" :apellido.trim();
			fechaNacimiento = fechaNacimiento ==null? "" : fechaNacimiento.trim();
			observacion = observacion == null? "" :observacion.trim();
			
			if(idempleadofamilia!=null && !idempleadofamilia.equals("") && 
				idparentescoasignado!=null && !idparentescoasignado.equals("")&& 
				idgeneroasignado!=null && !idgeneroasignado.equals("") &&
				idempleado!=null && !idempleado.equals("") &&
				idtipodocumentoasignado!=null && !idtipodocumentoasignado.equals("")){
				
				EmpleadoFamilia empleadoFamilia = new EmpleadoFamilia();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	            
				Date fechaNac = formatter.parse(fechaNacimiento);
	            long time = fechaNac.getTime();
		        Timestamp timeFechaNacimiento = new Timestamp(time);
				
		        empleadoFamilia.setIdEmpleadoFamilia(Long.valueOf(idempleadofamilia));
		        empleadoFamilia.setIdParentesco(Long.valueOf(idparentescoasignado));
		        empleadoFamilia.setIdGenero(Long.valueOf(idgeneroasignado));
		        empleadoFamilia.setIdempleado(Long.valueOf(idempleado));
		        empleadoFamilia.setIdidentificaciontipo(Long.valueOf(idtipodocumentoasignado));
		        empleadoFamilia.setNumeroIdentificacion(numerodocumento);
		        empleadoFamilia.setNombrefamilia(nombre);
		        empleadoFamilia.setApellidoFamilia(apellido);
		        empleadoFamilia.setFechaNacimiento(timeFechaNacimiento);
		        
				if(observacion.equals("")){
					empleadoFamilia.setObservacion(null);
				}else{
					empleadoFamilia.setObservacion(observacion);
				}
				
				empleadoFamilia.setIdusuariomod(user.getCodusuario());
				empleadoFamilia.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				Integer resultado = familiaEJB.editarEmpleadoFamilia(empleadoFamilia);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadoFamilia.getIdempleado());
					out.close();
				} else {
					throw new LogicaException("Error al editar los datos del familiar.");
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
	 * Método para deshabilitar un familiar a un empleado.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,LogicaException.
	 */
	private void familia_deshabilitar(HttpServletRequest request,HttpServletResponse response)throws LogicaException, IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			
		try {
			String idempleadofamilia = request.getParameter("idempleadofamilia");
			String idempleado = request.getParameter("idempleado");
			
			idempleadofamilia = idempleadofamilia == null ? "": idempleadofamilia.trim();

			EmpleadoFamilia empleadoFamilia =  new EmpleadoFamilia();
			empleadoFamilia.setIdEmpleadoFamilia(Long.valueOf(idempleadofamilia));
			empleadoFamilia.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = familiaEJB.deshabilitarEmpleadoFamilia(empleadoFamilia);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
				out.close();
			} else {
				throw new LogicaException("Error al deshabilitar el familiar.");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
		
	}
	
	
	/**
	 * Método para habilitar un familiar a un empleado.
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,LogicaException.
	 */
	private void familia_habilitar(HttpServletRequest request,HttpServletResponse response)throws LogicaException, IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			
		try {
			String idempleadofamilia = request.getParameter("idempleadofamilia");
			String idempleado = request.getParameter("idempleado");
			
			idempleadofamilia = idempleadofamilia == null ? "": idempleadofamilia.trim();

			EmpleadoFamilia empleadoFamilia =  new EmpleadoFamilia();
			empleadoFamilia.setIdEmpleadoFamilia(Long.valueOf(idempleadofamilia));
			empleadoFamilia.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = familiaEJB.habilitarEmpleadoFamilia(empleadoFamilia);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
				out.close();
			} else {
				throw new LogicaException("Error al habilitar el familiar.");
			}

		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
		
	}
}
