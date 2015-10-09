package co.sistemcobro.rrhh.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import co.sistemcobro.all.constante.EstadoEnum;
import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.all.util.Archivo;
import co.sistemcobro.all.util.Validar;
import co.sistemcobro.rrhh.util.FtpUtilCliente;
import co.sistemcobro.rrhh.util.Mail;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.ContratoProceso;
import co.sistemcobro.rrhh.bean.ContratoProcesoPropiedad;
import co.sistemcobro.rrhh.bean.ContratoRespuesta;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.EmpleadoIdentificacion;
import co.sistemcobro.rrhh.bean.EmpleadoPropiedad;
import co.sistemcobro.rrhh.bean.EstadoDesvinculacion;
import co.sistemcobro.rrhh.bean.Opcion;
import co.sistemcobro.rrhh.bean.Pregunta;
import co.sistemcobro.rrhh.bean.Prioridad;
import co.sistemcobro.rrhh.bean.Proceso;
import co.sistemcobro.rrhh.bean.ProcesoEstado;
import co.sistemcobro.rrhh.bean.ProcesoPropiedad;
import co.sistemcobro.rrhh.bean.Propiedad;
import co.sistemcobro.rrhh.bean.Respuesta;
import co.sistemcobro.rrhh.constante.CuestionariosEnum;
import co.sistemcobro.rrhh.constante.EstadoDesvinculacionEnum;
import co.sistemcobro.rrhh.constante.PreguntaTipoEnum;
import co.sistemcobro.rrhh.constante.ProcesoEstadoEnum;
import co.sistemcobro.rrhh.constante.ProcesosEnum;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.DesvinculacionEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.ejb.HorarioEJB;

/**
 * 
 * @author Leonardo talero
 * 
 */
@WebServlet(name = "DesvinculacionServlet", urlPatterns = { "/page/desvinculacion" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 20, maxRequestSize = 1024 * 1024 * 20)
public class DesvinculacionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(DesvinculacionServlet.class);
	
	//Desarrollo - pruebas
//	private final long ID_PROPIEDAD_CORREO_CORRESPONDENCIA = 14;
//	private final long ID_PROPIEDAD_DIRECCION_CORRESPONDENCIA = 15;
	
	//Producción.
	private final long ID_PROPIEDAD_CORREO_CORRESPONDENCIA = 18;
	private final long ID_PROPIEDAD_DIRECCION_CORRESPONDENCIA = 19;
	
	private final long ID_PRIORIDAD_DATOS_CORRESPONDENCIA = 1;
	
	//ResourceBundle config = ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);

	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;
	@EJB
	private HorarioEJB horarioEJB;
	@EJB
	private DesvinculacionEJB desvinculacionEJB;
	 
	public DesvinculacionServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("ver_desvinculacion")) {
				ver_desvinculacion(request, response);
			}else if (action.equals("ver_editar_Desvinculacion")) {
				ver_editar_Desvinculacion(request, response);
			}else if (action.equals("guardar_Desvinculacion")) {
				 guardar_Desvinculacion(request, response);
			}else if (action.equals(ProcesosEnum.Entrega_de_Activos.toString().replace("_", " "))) {
				 ver_detalle_activos(request, response);
			}else if (action.equals("desvinculacion_vernuevapropiedad")) {
				 desvinculacion_vernuevapropiedad(request, response);
			}else if (action.equals("activos_guardar_propiedad")) {
				 activos_guardar_propiedad(request, response);
			}else if (action.equals("Guardarcontrato_proceso")) {
				Guardarcontrato_proceso(request, response);
			}else if (action.equals("propiedad_deshabilitar")) {
				propiedad_deshabilitar(request, response);
			}else if (action.equals("propiedad_habilitar")) {
				propiedad_habilitar(request, response);
			}else if (action.equals(ProcesosEnum.Usuarios_deshabilitados.toString().replace("_", " "))) {
				 ver_detalle_Usuarios(request, response);
			}else if (action.equals(ProcesosEnum.Cargue_de_Archivos.toString().replace("_", " "))) {
				 ver_detalle_Archivos(request, response);
			}else if (action.equals("archivos_guardar_propiedad")) {
				archivos_guardar_propiedad(request, response);
			}else if (action.equals("verArchivo")) {
				verArchivo(request, response);
			}else if (action.equals("ver_editar")) {
				desvinculacion_vereditarpropiedad(request, response);
			}else if (action.equals("desvinculacion_editarpropiedad")) {
				desvinculacion_editarpropiedad(request, response);
			}else if (action.equals("ver_enviar_correo")) {
				ver_enviar_correo(request, response);
			}else if (action.equals("enviar_correo")) {
				enviar_correo(request, response);
			}else if(action.equals("editarPropiedadeCorrespondencia")){
				editarPropiedadeCorrespondencia(request, response);
			}else if(action.equals("empleado_editarpropiedadCorrespondencia")){
				empleado_editarpropiedadCorrespondencia(request,response);
			}else if(action.equals("verEditarPropiedadCorrespondencia")){
				verEditarPropiedadCorrespondencia(request,response);
			}else if(action.equals("deshabilitarPropiedadCorrespondencia")){
				deshabilitarPropiedadCorrespondencia(request,response);
			}else if(action.equals("habilitarPropiedadCorrespondencia")){
				habilitarPropiedadCorrespondencia(request, response);
			}
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	private void deshabilitarPropiedadCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idempleadopropiedad = request.getParameter("idempleadopropiedad");
			String idContrato = request.getParameter("idcontrato");

//			logger.info("idContrato vale = "+idContrato);
			
			idempleadopropiedad = idempleadopropiedad == null ? "": idempleadopropiedad.trim();

			EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();
			
			empleadopropiedad.setIdempleadopropiedad(Long.valueOf((idempleadopropiedad)));
			empleadopropiedad.setIdusuariomod(user.getCodusuario());

			Integer resultado = empleadoEJB.deshabilitarEmpleadoPropiedad(empleadopropiedad);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idContrato));
				out.close();
			} else {
				throw new LogicaException("Error al eliminar la propiedad.");
			}

		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}
	}
	
	/**
	 * Permite habilitar un registro de la relación empleado_propiedad.
	 * @throws IOException 
	 * */
	private void habilitarPropiedadCorrespondencia(HttpServletRequest request, HttpServletResponse response) throws IOException{		
			HttpSession session = request.getSession(false);
			UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			
			try {
				String idempleadopropiedad = request.getParameter("idempleadopropiedad");
				String idContrato = request.getParameter("idContrato");

				logger.info("IdContrato = "+idContrato);
				
				idempleadopropiedad = idempleadopropiedad == null ? "": idempleadopropiedad.trim();

				EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();
				empleadopropiedad.setIdempleadopropiedad(Long.valueOf((idempleadopropiedad)));
				empleadopropiedad.setIdusuariomod(user.getCodusuario());

				Integer resultado = empleadoEJB.habilitarEmpleadoPropiedad(empleadopropiedad);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(Long.valueOf(idContrato));
					out.close();
				} else {
					throw new LogicaException("Error al eliminar la propiedad.");
				}

			} catch (LogicaException e) {
				response.sendError(1, e.toString());
			} catch (Exception e) {
				response.sendError(1, e.toString());
			}
		
	}
	
	/**
	 * Permite editar los datos de un registro de la relación empleado_propiedad.
	 * */
	public void editarPropiedadeCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idempleadopropiedad = (String) request.getParameter("idempleadopropiedad");
			
			if (idempleado != null && idempleadopropiedad != null) {
				
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleado", empleado);
				
				EmpleadoPropiedad empleadopropiedad = empleadoEJB.getEmpeladoPropiedadesporid(Long.valueOf(idempleadopropiedad));

				request.setAttribute("empleadopropiedad", empleadopropiedad);
				List<Prioridad> prioridades = empleadoEJB.getPrioridades();
				request.setAttribute("prioridades", prioridades);
			}

			List<Propiedad> propiedades = empleadoEJB.getPropiedades();
			request.setAttribute("propiedades", propiedades);
			request.getRequestDispatcher("../pages/desvinculacion/verEditarPropiedadCorrespondencia.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	/**
	 * Permite editar una propiedad del empleado respecto a la desvinculación.
	 */
	public void empleado_editarpropiedadCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idtipopropiedad = request.getParameter("idtipopropiedadCorrespondencia");
			String dato = request.getParameter("datoCorrespondencia");
			String idprioridad = request.getParameter("idprioridadCorrespondencia");
			String idempleado = request.getParameter("idempleado");
			String idempleadopropiedad = request.getParameter("idempleadopropiedad");
			String observacion = request.getParameter("observacionCorrespondencia");
			String idContrato = request.getParameter("idContrato");
			
			idtipopropiedad = idtipopropiedad == null ? "" : idtipopropiedad.trim();
			dato = dato == null ? "" : dato.trim();
			idprioridad = idprioridad == null ? "" : idprioridad.trim();
			idContrato = idContrato == null ? "" : idContrato.trim();
			
			if (idtipopropiedad != null && idempleado != null && idtipopropiedad != null) {
				EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();

				empleadopropiedad.setIdempleadopropiedad(Long.valueOf(idempleadopropiedad));
				empleadopropiedad.setIdpropiedad(Long.valueOf(idtipopropiedad));
				empleadopropiedad.setIdempleado(Long.valueOf(idempleado));
				empleadopropiedad.setDato(dato);
				empleadopropiedad.setObservacion(observacion);
				empleadopropiedad.setIdprioridad(Long.valueOf(idprioridad));
				
				empleadopropiedad.setIdusuariomod(user.getCodusuario());
				empleadopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				Integer resultado = empleadoEJB.editarEmpleadoPropiedad(empleadopropiedad);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(idContrato);
					out.close();
				} else {
					throw new LogicaException("Error al editar los datos de la nueva propiedad.");
				}
			} else {
				throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
			}
		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}
	}
	

	private void verEditarPropiedadCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			String idempleado = (String) request.getParameter("idEmpleado");
			String idempleadopropiedad = (String) request.getParameter("idEmpleadoPropiedad");
			String idContrato = request.getParameter("idContrato");
			
			if (idempleado != null && idempleadopropiedad != null && idContrato!=null) {
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				EmpleadoPropiedad empleadopropiedad = empleadoEJB.getEmpeladoPropiedadesporid(Long.valueOf(idempleadopropiedad));
				List<Prioridad> prioridades = empleadoEJB.getPrioridades();
				
				request.setAttribute("empleado", empleado);
				request.setAttribute("empleadopropiedad", empleadopropiedad);
				request.setAttribute("prioridades", prioridades);
				request.setAttribute("idContrato", idContrato);
			}

//			List<Propiedad> propiedades = empleadoEJB.getPropiedades();
			List<Propiedad> propiedades = empleadoEJB.getPropiedadesDeCorrespondencia();
			request.setAttribute("propiedades", propiedades);

			request.getRequestDispatcher("../pages/desvinculacion/editarPropiedadCorrespondencia.jsp").forward(request, response);

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
	public void ver_desvinculacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String idcontrato = request.getParameter("idcontrato");
			Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));

			//----------------------------------------------------------------
			Long idEmpleado =  contrato.getIdempleado();
			
			if (idEmpleado != null) {
				Boolean tieneCorrespondencia;
				List<EmpleadoPropiedad> empleadopropiedades = empleadoEJB.obtenerPropiedadesDeCorrespondencia(Long.valueOf(idEmpleado));
				
				if(empleadopropiedades.size()>0){
					tieneCorrespondencia=true;
				}else{
					tieneCorrespondencia=false;
				}
				request.setAttribute("tieneCorrespondencia", tieneCorrespondencia);
				request.setAttribute("empleadopropiedades", empleadopropiedades);
			}
			
			EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idEmpleado));
			
			request.setAttribute("empleado", empleado);
			List<Propiedad> propiedades = empleadoEJB.getPropiedades();
			request.setAttribute("propiedades", propiedades);
			//----------------------------------------------------------------
			
			request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
			request.setAttribute("contrato", contrato);
			request.setAttribute("idContrato", idcontrato);
			
			List<Pregunta> preguntas=new ArrayList<Pregunta>();
			
			EstadoDesvinculacion estadodesvinculacion = null;
			
			if(contrato.getIdestadodesvinculacion()!=null && contrato.getIdestadodesvinculacion()!=0 ){
			  estadodesvinculacion = desvinculacionEJB.getAllEstadosDesvinculacionbyId(contrato.getIdestadodesvinculacion());
			}
			
			List<ContratoRespuesta> contratorespuestas = desvinculacionEJB.getRespuestasporContratoTodasPreguntas(contrato.getIdcontrato());
			
			
			preguntas=desvinculacionEJB.getPreguntasporIdCuestionarioTodas(Long.valueOf(CuestionariosEnum.DESVINCULACION.getIndex()));
			
			for(Pregunta x:preguntas){
				x.setOpciones(desvinculacionEJB.getOpcionesporPregunta(x.getIdpregunta()));
			}
		
			List<ContratoProceso> contratoprocesos = desvinculacionEJB.getAllContratoProcesoporContrato(contrato.getIdcontrato());
			
			List<Proceso> procesos = desvinculacionEJB.getAllProcesos();
			request.setAttribute("procesos", procesos);
			request.setAttribute("preguntas", preguntas);
			request.setAttribute("contratorespuestas", contratorespuestas);
			request.setAttribute("contratoprocesos", contratoprocesos);
			request.setAttribute("estadodesvinculacion", estadodesvinculacion);
			
			request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_encuesta.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
public void ver_editar_Desvinculacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			List<EstadoDesvinculacion> estadosdesvinculacion=new ArrayList<EstadoDesvinculacion>();
			List<Pregunta> preguntas=new ArrayList<Pregunta>();
			
			String idcontrato = request.getParameter("idcontrato");
			Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
			
			Long idEmpleado =  contrato.getIdempleado();
			logger.info("idEmpelado = "+idEmpleado);
			logger.info("IdContrato = "+contrato.getIdcontrato());
			
			////////////////////////////////////////////////////// TODO: Implentación de la pregunta de correo y direccion.
			
			if (idEmpleado != null) {
				List<EmpleadoPropiedad> empleadopropiedades = empleadoEJB.obtenerPropiedadesDeCorrespondencia(Long.valueOf(idEmpleado));
//				List<EmpleadoPropiedad> empleadopropiedades = empleadoEJB.getEmpeladoPropiedadesporidEmpleado(Long.valueOf(idEmpleado));
				
				logger.info("Tamaño de empleadoPropiedades : "+empleadopropiedades.size());
				request.setAttribute("empleadopropiedades", empleadopropiedades);
			}
			
			EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idEmpleado));
			
			request.setAttribute("empleado", empleado);
			List<Propiedad> propiedades = empleadoEJB.getPropiedades();
			request.setAttribute("propiedades", propiedades);
			request.setAttribute("idcontrato", idcontrato);
			
			////////////////////////////////////////////////////// TODO: Fin
			
			
			preguntas=desvinculacionEJB.getPreguntasporIdCuestionarioActivas(Long.valueOf(CuestionariosEnum.DESVINCULACION.getIndex()));
			List<ContratoRespuesta> contratorespuestas = desvinculacionEJB.getRespuestasporContratoPreguntaActiva(contrato.getIdcontrato());
			estadosdesvinculacion=desvinculacionEJB.getAllEstadosDesvinculacion();
			
			for(Pregunta pregunta:preguntas){
				pregunta.setOpciones(desvinculacionEJB.getOpcionesporPreguntaActivo(pregunta.getIdpregunta()));
			}
			
			request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
			request.setAttribute("contrato", contrato);
			request.setAttribute("estadosdesvinculacion", estadosdesvinculacion);
			request.setAttribute("preguntas", preguntas);
			request.setAttribute("contratorespuestas", contratorespuestas);
			
			request.setAttribute("accionRealizar", "2");
			
			
			//Para mostrar u ocultar el formulario de correspondencia al responder la encuesta.
			if(contratorespuestas.size()>0){
				request.setAttribute("editar", 0);
			}else{
				request.setAttribute("editar", 1);
			}
			
			request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_encuesta_editar.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	/**
	 * Este método registra y/o guardar cambios de la encuesta. si es nueva encuesta o la esta editando.
	 * 
	 * */
	public void guardar_Desvinculacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);

		try {
			List<Pregunta> preguntas = new ArrayList<Pregunta>();

			String idcontrato = request.getParameter("idcontrato");

			String correoCorrespondencia = request
					.getParameter("correoCorrespondencia");
			String direccionCorrespondencia = request
					.getParameter("direccionCorrespondencia");

			if (correoCorrespondencia == null) {
				logger.info("Correo es null.");
			}
			if (direccionCorrespondencia == null) {
				logger.info("Direccion es null.");
			}

			if (correoCorrespondencia == "") {
				logger.info("Correo es vacia.");
			}
			if (direccionCorrespondencia == "") {
				logger.info("Direccion es vacia.");
			}

			Contrato contrato = contratoEJB.getContratosporId(Long
					.valueOf(idcontrato));

			request.setAttribute("empleado",
					empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
			request.setAttribute("contrato", contrato);

			preguntas = desvinculacionEJB
					.getPreguntasporIdCuestionarioActivas(Long
							.valueOf(CuestionariosEnum.DESVINCULACION
									.getIndex()));

			for (Pregunta x : preguntas) {

				x.setOpciones(desvinculacionEJB.getOpcionesporPreguntaActivo(x
						.getIdpregunta()));
			}

			if (idcontrato != null) {
				Respuesta respuestaobjeto = new Respuesta();
				Respuesta respuestaobjetoporopcion = new Respuesta();
				List<Respuesta> respuestas = new ArrayList<Respuesta>();
				String idestadodesvinculacion = request
						.getParameter("idestadodesvinculacion");

				for (Pregunta x : preguntas) {

					String respuesta = null;
					respuestaobjeto = new Respuesta();

					if (x.getIdpreguntatipo() == PreguntaTipoEnum.OBSERVACIONES
							.getIndex()) { // si son observaciones o respuestas
											// de texto
						boolean flagalgunvalor = false;
						respuesta = request.getParameter("respupreguntaeditar"
								+ x.getIdpregunta());
						if (respuesta != null && !respuesta.equals("")) {
							respuestaobjeto.setTexto(respuesta);
							respuestaobjeto.setIdcuestionario(x
									.getIdcuestionario());
							respuestaobjeto.setIdpregunta(x.getIdpregunta());
							respuestaobjeto.setIdusuariocrea(user
									.getCodusuario());
							respuestaobjeto.setIdusuariomod(user
									.getCodusuario());
							respuestaobjeto.setEstado(EstadoEnum.ACTIVO
									.getIndex());
							respuestas.add(respuestaobjeto);
							flagalgunvalor = true;
						}
						if (x.getObligatorio() == 1) { // si es obligatoria

							if (flagalgunvalor) {

							} else {
								throw new LogicaException(
										"Debe escribir una respuesta"
												+ " para la pregunta ["
												+ x.getPregunta() + "]");
							}
						}

					} else if (x.getIdpreguntatipo() == PreguntaTipoEnum.OPCIONES_MULTIPLES
							.getIndex()) { // si son respuesa multiples

						boolean flagalgunvalor = false;
						for (Opcion opcion : x.getOpciones()) {
							respuestaobjetoporopcion = new Respuesta();
							respuesta = request.getParameter("opcioneditar"
									+ opcion.getIdopcion());
							if (respuesta != null) {
								respuestaobjetoporopcion.setIdopcion(Long
										.valueOf(respuesta));
								respuestaobjetoporopcion.setIdcuestionario(x
										.getIdcuestionario());
								respuestaobjetoporopcion.setIdpregunta(x
										.getIdpregunta());
								respuestaobjetoporopcion.setIdusuariocrea(user
										.getCodusuario());
								respuestaobjetoporopcion.setIdusuariomod(user
										.getCodusuario());
								respuestaobjetoporopcion
										.setEstado(EstadoEnum.ACTIVO.getIndex());
								respuestas.add(respuestaobjetoporopcion);
								flagalgunvalor = true;
							}

						}
						if (x.getObligatorio() == 1) { // si es obligatoria

							if (flagalgunvalor) {

							} else {
								throw new LogicaException(
										"Debe seleccionar al menos una respuesta"
												+ " para la pregunta  ["
												+ x.getPregunta() + "]");
							}
						}
						// respuesta =
						// request.getParameter"opcioneditar"+x.getIdpregunta());

					}

				}

				logger.info("Va a obtener contratoRespuestas..");
				List<ContratoRespuesta> contratorespuestas = desvinculacionEJB.getRespuestasporContratoPreguntaActiva(contrato.getIdcontrato());
				logger.info("Obtuvo contratoRespuestas..");
				
				Integer resultado = desvinculacionEJB.deshabilitarRespuestasDesvinculacion(contratorespuestas);
				
				List<ContratoRespuesta> resultadoactualizar = desvinculacionEJB.insertarRespuestasDesvinculacion(respuestas,contrato.getIdcontrato());

				if (Integer.valueOf(idestadodesvinculacion) == EstadoDesvinculacionEnum.PROCEDER_RETIRO.getIndex()) {
					contrato.setIdestadodesvinculacion(Long.valueOf(idestadodesvinculacion));
					
					Integer a = contratoEJB.actualizaContrato(contrato);
					
					List<ContratoProceso> contrato_proceso = desvinculacionEJB.getAllContratoProcesoporContrato(contrato.getIdcontrato());
					
					List<ContratoProceso> cont_proceso;
					
					if (contrato_proceso != null && contrato_proceso.size() > 0) {
						List<Proceso> procesos = desvinculacionEJB
								.getAllProcesos();
						List<ContratoProceso> contratoprocesos = new ArrayList<ContratoProceso>();

						ContratoProceso contratoproceso = new ContratoProceso();

						int flag = 0;
						for (Proceso p : procesos) {
							for (ContratoProceso cp : contrato_proceso) {
								Long idp = p.getIdproceso();
								Long idcp = cp.getIdproceso();
								if (idp == idcp) {
									flag = 0;
									break;
								} else {
									flag = 1;
								}
							}
							if (flag == 1) {

								contratoproceso.setIdcontrato(contrato
										.getIdcontrato());
								contratoproceso.setIdproceso(p.getIdproceso());
								contratoproceso
										.setIdprocesoestado(ProcesoEstadoEnum.EN_PROCESO
												.getIndex());
								contratoproceso.setIdusuariocrea(user
										.getCodusuario());
								contratoproceso.setEstado(EstadoEnum.ACTIVO
										.getIndex());
								contratoproceso.setPorcentaje(0);// valor
																	// inicial
																	// de
																	// porcentaje
								contratoprocesos.add(contratoproceso);
							}

						}

						cont_proceso = desvinculacionEJB
								.insertarContratoProceso(contratoprocesos);
						request.setAttribute("procesos", procesos);
					} else {

						List<Proceso> procesos = desvinculacionEJB
								.getAllProcesos();
						List<ContratoProceso> contratoprocesos = new ArrayList<ContratoProceso>();
						ContratoProceso contratoproceso;
						for (Proceso p : procesos) {
							contratoproceso = new ContratoProceso();
							contratoproceso.setIdcontrato(contrato
									.getIdcontrato());
							contratoproceso.setIdproceso(p.getIdproceso());
							contratoproceso
									.setIdprocesoestado(ProcesoEstadoEnum.EN_PROCESO
											.getIndex());
							contratoproceso.setIdusuariocrea(user
									.getCodusuario());
							contratoproceso.setEstado(EstadoEnum.ACTIVO
									.getIndex());
							contratoproceso.setPorcentaje(0);// valor inicial de
																// porcentaje
							contratoprocesos.add(contratoproceso);
						}

						cont_proceso = desvinculacionEJB
								.insertarContratoProceso(contratoprocesos);
						request.setAttribute("procesos", procesos);
					}

				} else if (Long.valueOf(idestadodesvinculacion) == EstadoDesvinculacionEnum.RETENER
						.getIndex()) {

					contrato.setIdestadodesvinculacion(Long
							.valueOf(idestadodesvinculacion));

					contratoEJB.actualizaContrato(contrato);

					List<Proceso> procesos = desvinculacionEJB.getAllProcesos();
					List<ContratoProceso> contratoprocesos = new ArrayList<ContratoProceso>();
					ContratoProceso contratoproceso;
					for (Proceso p : procesos) {
						contratoproceso = new ContratoProceso();
						contratoproceso.setIdcontrato(contrato.getIdcontrato());
						contratoproceso.setIdproceso(p.getIdproceso());
						contratoproceso
								.setIdprocesoestado(ProcesoEstadoEnum.EN_PROCESO
										.getIndex());
						contratoproceso.setIdusuariocrea(user.getCodusuario());
						contratoproceso.setEstado(EstadoEnum.ACTIVO.getIndex());
						contratoproceso.setPorcentaje(0);// valor inicial de
															// porcentaje
						contratoprocesos.add(contratoproceso);
					}

					List<ContratoProceso> cont_proceso = desvinculacionEJB
							.insertarContratoProceso(contratoprocesos);

				}

				logger.info("Va a declarar el ok.");
				
				boolean ok;
				// Si esto se cumple entonces,Esta editando la encuesta.
				if (correoCorrespondencia==null && direccionCorrespondencia == null) {
					ok = true;
				} else {
					ok = insertarDatosCorrespondenciaAlDesvincular(request,
							response);
				}

				if (resultadoactualizar != null && resultadoactualizar.size() > 0 && ok) {					
					PrintWriter out = response.getWriter();
					out.println(contrato.getIdcontrato());
					out.close();

				} else {
					if (ok == false) {
						throw new LogicaException(
								"Error al crear los datos de correspondencia, Intente editarlos o crearlos Nuevamente.");
					} else {
						throw new LogicaException(
								"Error al editar los datos de la nueva propiedad.");
					}

				}

			} else {
				throw new LogicaException(
						"Existen valores en blanco y no se puede guardar el registro");
			}

		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}
	}

	/**
	 * Este metodo registra los datos de correspondencia al realizar la encuesta de desvinculación.
	 * @param HttpServletRequest request
	 * @param HttpServletResponse response
	 * @throws IOException 
	 * 
	 * */
	private boolean insertarDatosCorrespondenciaAlDesvincular(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);

		boolean todoBien = false;
		EmpleadoPropiedad empleadopropiedadCorreo = new EmpleadoPropiedad();
		EmpleadoPropiedad empleadopropiedadDireccion = new EmpleadoPropiedad();
		
		try {
			String idContrato = request.getParameter("idcontrato");
			String correoCorrespondencia = request.getParameter("correoCorrespondencia");
			String direccionCorrespondencia = request.getParameter("direccionCorrespondencia");
			String observacionCorrespondencia = request.getParameter("observacionCorrespondencia");

			idContrato = idContrato == null ? "" : idContrato.trim();
			correoCorrespondencia = correoCorrespondencia == null ? "" : correoCorrespondencia.trim();
			direccionCorrespondencia = direccionCorrespondencia == null ? "" : direccionCorrespondencia.trim();
			observacionCorrespondencia = observacionCorrespondencia == null ? "" : observacionCorrespondencia.trim();
			
			Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idContrato));

			// Configurar correo de correspondencia
			empleadopropiedadCorreo.setIdpropiedad(this.ID_PROPIEDAD_CORREO_CORRESPONDENCIA);
			empleadopropiedadCorreo.setIdempleado(contrato.getIdempleado());
			empleadopropiedadCorreo.setDato(correoCorrespondencia);
			empleadopropiedadCorreo.setObservacion(observacionCorrespondencia);
			empleadopropiedadCorreo.setIdprioridad(this.ID_PRIORIDAD_DATOS_CORRESPONDENCIA);
			empleadopropiedadCorreo.setIdusuariocrea(user.getCodusuario());
			empleadopropiedadCorreo.setEstado(EstadoEnum.ACTIVO.getIndex());

			// Configurar direccion de correspondencia
			empleadopropiedadDireccion.setIdpropiedad(this.ID_PROPIEDAD_DIRECCION_CORRESPONDENCIA);
			empleadopropiedadDireccion.setIdempleado(contrato.getIdempleado());
			empleadopropiedadDireccion.setDato(direccionCorrespondencia);
			empleadopropiedadDireccion.setObservacion(observacionCorrespondencia);
			empleadopropiedadDireccion.setIdprioridad(this.ID_PRIORIDAD_DATOS_CORRESPONDENCIA);
			empleadopropiedadDireccion.setIdusuariocrea(user.getCodusuario());
			empleadopropiedadDireccion.setEstado(EstadoEnum.ACTIVO.getIndex());			
			
			//Inserciones.
			EmpleadoPropiedad resultadoCorreo = empleadoEJB.insertarEmpleadoPropiedad(empleadopropiedadCorreo);
			EmpleadoPropiedad resultadoDireccion = empleadoEJB.insertarEmpleadoPropiedad(empleadopropiedadDireccion);
			
			if(resultadoCorreo.getIdempleadopropiedad()!=null && resultadoCorreo.getIdempleadopropiedad()>0
			    && resultadoDireccion.getIdempleadopropiedad()!=null && resultadoDireccion.getIdempleadopropiedad()>0){
				todoBien=true;
			}else{
				todoBien=false;
			}
			
		} catch (LogicaException e) {
			logger.info("Ocurrio un error al intentar registrar las propiedades de correspondencia. LogicaException e = "+e);
			return false;
		} catch (Exception e) {
			logger.info("Ocurrio un error al intentar registrar las propiedades de correspondencia. Exception e = "+e);
			return false;
		}
		return todoBien;
	}

	
public void ver_detalle_activos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String idcontrato = request.getParameter("idcontrato");
		String idproceso = request.getParameter("idproceso");
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
		request.setAttribute("contrato", contrato);
		ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporIdContratoyIdproceso(contrato.getIdcontrato(),Long.valueOf(idproceso));
		 List<ContratoProcesoPropiedad> contratoprocesopropiedades = desvinculacionEJB.getAllPropiedadProcesoporContrato(contrato.getIdcontrato(),Long.valueOf(idproceso));
		List<ProcesoEstado> procesoestados = desvinculacionEJB.getAllprocesoEstados();
			 
		request.setAttribute("procesoestados", procesoestados);
		request.setAttribute("contratoproceso", contratoproceso);
		request.setAttribute("contratoprocesopropiedades", contratoprocesopropiedades);
		 
		request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_detalle_activos.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}



public void desvinculacion_vernuevapropiedad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String idcontrato = request.getParameter("idcontrato");
		String idproceso = request.getParameter("idproceso");
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
		request.setAttribute("contrato", contrato);
		ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporIdContratoyIdproceso(contrato.getIdcontrato(),Long.valueOf(idproceso));
		
		request.setAttribute("contratoproceso", contratoproceso);
		//ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporIdContratoyIdproceso(contrato.getIdcontrato(),Long.valueOf(idproceso));
		// List<ContratoProcesoPropiedad> contratoprocesopropiedades = desvinculacionEJB.getAllPropiedadProcesoporContrato(contrato.getIdcontrato());
		//List<ProcesoEstado> procesoestados = desvinculacionEJB.getAllprocesoEstados();
		
		List<ProcesoPropiedad> procesopropiedades = desvinculacionEJB.getAllProcesoPropiedadporIdproceso(Long.parseLong(idproceso));
	
		request.setAttribute("procesopropiedades", procesopropiedades);
		 
		if(Long.valueOf(idproceso)==3){
			request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_nuevapropiedad_archivos.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_nuevapropiedad.jsp").forward(request, response);
		}
	
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void activos_guardar_propiedad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	HttpSession session = request.getSession(false);
UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
try {
	String idcontrato = request.getParameter("idcontrato");
	Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
	request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
	request.setAttribute("contrato", contrato);
	String idprocesopropiedad = request.getParameter("idprocesopropiedad");
	String dato = request.getParameter("dato");
	String observacion = request.getParameter("observacion");
	
	if(idprocesopropiedad!=null &&  dato!=null  ){
		ProcesoPropiedad procesopropiedad = desvinculacionEJB.getProcesoPropiedadporIdprocesopropiedad(Long.valueOf(idprocesopropiedad));

		
		ContratoProcesoPropiedad contratoprocesopropiedad=new ContratoProcesoPropiedad();
		contratoprocesopropiedad.setIdprocesopropiedad(Long.valueOf(idprocesopropiedad));
		contratoprocesopropiedad.setDato(dato);
		contratoprocesopropiedad.setObservacion(observacion);
		contratoprocesopropiedad.setIdcontrato(contrato.getIdcontrato());
		contratoprocesopropiedad.setIdusuariocrea(user.getCodusuario());
		
		contratoprocesopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());
	
		
		ContratoProcesoPropiedad resu = desvinculacionEJB.insertarContratoprocesopropiedad(contratoprocesopropiedad);
		if (resu !=null && resu.getIdcontratoprocesopropiedad()!=null) {
			PrintWriter out = response.getWriter();
			out.println(contrato.getIdcontrato());
			out.close();

			} else {
				throw new LogicaException("Error al editar los datos de la nueva propiedad.");
			}
		
	}
	
	 

		
	
else{
	throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
}
	

	} catch (LogicaException e) {
	
		response.sendError(1, e.toString());
	} catch (Exception e) {
	
		response.sendError(1, e.toString());
	}
}


public void Guardarcontrato_proceso(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	HttpSession session = request.getSession(false);
UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
try {
	String idestadoproceso = request.getParameter("idestadoproceso");
	String idcontratoproceso = request.getParameter("idcontratoproceso");
	String porcentajepuesto = request.getParameter("porcentajepuesto");
	

	
	if(idcontratoproceso!=null && idestadoproceso!=null &&  porcentajepuesto!=null){
		
		 ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporId(Long.valueOf(idcontratoproceso));

		
		contratoproceso.setIdprocesoestado(Integer.valueOf(idestadoproceso));
		contratoproceso.setPorcentaje(Integer.valueOf(porcentajepuesto));
		contratoproceso.setIdusuariomod(user.getCodusuario());
		
		
	
		
		ContratoProceso resu = desvinculacionEJB.ActualizarContratoproceso(contratoproceso);
		if (resu !=null && resu.getIdcontratoproceso()!=null) {
			PrintWriter out = response.getWriter();
			out.println(contratoproceso.getIdcontrato());
			out.close();

			} else {
				throw new LogicaException("Error al editar los datos de la nueva propiedad.");
			}
		
	}
	
	 

		
	
	else{
		throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
	}
		
	
	} catch (LogicaException e) {
	
		response.sendError(1, e.toString());
	} catch (Exception e) {
	
		response.sendError(1, e.toString());
	}


}

public void propiedad_deshabilitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	HttpSession session = request.getSession(false);
UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
try {
	String idcontrato = request.getParameter("idcontrato");
	String idcontratoprocesopropiedad = request.getParameter("idcontratoprocesopropiedad");
	
	

	
	if(idcontrato!=null && idcontratoprocesopropiedad!=null ){
	
	
			 ContratoProcesoPropiedad contratoprocesopropiedad = desvinculacionEJB.getPropiedadProcesoporId(Long.valueOf(idcontratoprocesopropiedad));

				
			 contratoprocesopropiedad.setEstado(EstadoEnum.DESHABILITADO.getIndex());
			
			
		
			
			 ContratoProcesoPropiedad resu = desvinculacionEJB.deshabilitarContratoprocesopropiedad(contratoprocesopropiedad);
			if (resu !=null && resu.getIdcontratoprocesopropiedad()!=null) {
				PrintWriter out = response.getWriter();
				out.println(contratoprocesopropiedad.getIdcontrato());
				out.close();

				} else {
					throw new LogicaException("Error al editar los datos de la nueva propiedad.");
				}
			
		
		
		
	}
	
	 

		
	
	else{
		throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
	}
		
	
	} catch (LogicaException e) {
	
		response.sendError(1, e.toString());
	} catch (Exception e) {
	
		response.sendError(1, e.toString());
	}
}


public void propiedad_habilitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	HttpSession session = request.getSession(false);
UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
try {
	String idcontrato = request.getParameter("idcontrato");
	String idcontratoprocesopropiedad = request.getParameter("idcontratoprocesopropiedad");
	
	

	
	if(idcontrato!=null && idcontratoprocesopropiedad!=null ){
		
		 ContratoProcesoPropiedad contratoprocesopropiedad = desvinculacionEJB.getPropiedadProcesoporId(Long.valueOf(idcontratoprocesopropiedad));

		
		 contratoprocesopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());
		
		
	
		
		 ContratoProcesoPropiedad resu = desvinculacionEJB.ActivarContratoprocesopropiedad(contratoprocesopropiedad);
		if (resu !=null && resu.getIdcontratoprocesopropiedad()!=null) {
			PrintWriter out = response.getWriter();
			out.println(contratoprocesopropiedad.getIdcontrato());
			out.close();

			} else {
				throw new LogicaException("Error al editar los datos de la nueva propiedad.");
			}
		
	}
	
	 

		
	
	else{
		throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
	}
		
	
	} catch (LogicaException e) {
	
		response.sendError(1, e.toString());
	} catch (Exception e) {
	
		response.sendError(1, e.toString());
	}
}

public void ver_detalle_Usuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String idcontrato = request.getParameter("idcontrato");
		String idproceso = request.getParameter("idproceso");
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
		request.setAttribute("contrato", contrato);
		ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporIdContratoyIdproceso(contrato.getIdcontrato(),Long.valueOf(idproceso));
		List<ContratoProcesoPropiedad> contratoprocesopropiedades = desvinculacionEJB.getAllPropiedadProcesoporContrato(contrato.getIdcontrato(),Long.valueOf(idproceso));
		
		List<ProcesoEstado> procesoestados = desvinculacionEJB.getAllprocesoEstados();
		 
		request.setAttribute("procesoestados", procesoestados);
		
		request.setAttribute("contratoproceso", contratoproceso);
		request.setAttribute("contratoprocesopropiedades", contratoprocesopropiedades);
		 
		request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_detalle_usuarios.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void ver_detalle_Archivos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String idcontrato = request.getParameter("idcontrato");
		String idproceso = request.getParameter("idproceso");
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
		request.setAttribute("contrato", contrato);
		ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporIdContratoyIdproceso(contrato.getIdcontrato(),Long.valueOf(idproceso));
		List<ContratoProcesoPropiedad> contratoprocesopropiedades = desvinculacionEJB.getAllPropiedadProcesoporContrato(contrato.getIdcontrato(),Long.valueOf(idproceso));
		
		List<ProcesoEstado> procesoestados = desvinculacionEJB.getAllprocesoEstados();
		 
		request.setAttribute("procesoestados", procesoestados);
		
		request.setAttribute("contratoproceso", contratoproceso);
		request.setAttribute("contratoprocesopropiedades", contratoprocesopropiedades);
		 
		request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_detalle_archivos.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void archivos_guardar_propiedad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
	HttpSession session = request.getSession(false);
	UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	
	try {
		String idcontrato= Archivo.getParameter(request.getPart("idcontrato"));
		String idprocesopropiedad= Archivo.getParameter(request.getPart("idprocesopropiedad"));
		String observacion= Archivo.getParameter(request.getPart("observacion"));
		//String idcontrato = request.getParameter("idcontrato");
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado());
		request.setAttribute("empleado", empleado);
		EmpleadoIdentificacion identificacionactual = empleadoEJB.getEmpleadoIdentificacionActual(empleado.getIdempleado());
		request.setAttribute("contrato", contrato);
		//String idprocesopropiedad = request.getParameter("idprocesopropiedad");
		//String observacion = request.getParameter("observacion");
		
		
		
		
		Part part = request.getPart("archivoR");
		
		InputStream is = part.getInputStream();
		int k = is.available();
		byte[] b = new byte[k];
		is.read(b);
		String file = Archivo.getFullName(part);
		if(!file.equals("")|| !file.equals(null)){
			logger.info(" con archivo adjunto ");
			if(idprocesopropiedad!=null &&  file!=null  ){
				ProcesoPropiedad procesopropiedad = desvinculacionEJB.getProcesoPropiedadporIdprocesopropiedad(Long.valueOf(idprocesopropiedad));
	
				if(FtpUtilCliente.checkconexion()){
					
				
				
				
				
				ContratoProcesoPropiedad contratoprocesopropiedad=new ContratoProcesoPropiedad();
				contratoprocesopropiedad.setIdprocesopropiedad(Long.valueOf(idprocesopropiedad));
				contratoprocesopropiedad.setDatoamostrar(file);
				file="contrato_"+contrato.getIdcontrato()+"cedula_"+identificacionactual.getNumeroidentificacion()+"_"+file;
				contratoprocesopropiedad.setDato(file);
				contratoprocesopropiedad.setObservacion(observacion);
				contratoprocesopropiedad.setIdcontrato(contrato.getIdcontrato());
				contratoprocesopropiedad.setIdusuariocrea(user.getCodusuario());
				contratoprocesopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());
				ContratoProcesoPropiedad resu = desvinculacionEJB.insertarContratoprocesopropiedad(contratoprocesopropiedad);
				
						//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
						String ruta = "archivos_desvinculacion";
						InputStream ispdf = part.getInputStream();
						ispdf.read(b);
						
						String filepdf = Constante.ROOT_FILE_TEMPORARY + File.separator + resu.getIdcontratoprocesopropiedad()+"_"+file;
						File archivopdf = new File(filepdf);
						FileOutputStream ospdf = new FileOutputStream(archivopdf);
						ospdf.write(b);
	
						ispdf.close();
						ospdf.close();
						
						logger.warn("antes de enviar archivo ftp ");
						
						for(int i=0;i<=3;i++){//intenta 3 veces la conexion
							
							if(FtpUtilCliente.checkconexion()){
								
							
					   			if (FtpUtilCliente.uploadFTP(archivopdf,ruta)) {///sube doc
					   				logger.warn("conecta ftp y sube archivo ");
					   				String nombre = archivopdf.getName();
					   				resu.setDato(nombre);
					   				resu.setIdusuariomod(user.getCodusuario());
					   				
					   				logger.warn("antes editar registro proiedad ");	
						   			 desvinculacionEJB.ActivarContratoprocesopropiedad(resu);	
						   			 
						   			if (resu !=null && resu.getIdcontratoprocesopropiedad()!=null) {
						   				PrintWriter out = response.getWriter();
						   				out.println(contratoprocesopropiedad.getIdcontrato());
						   				out.close();
			
						   				} else {
						   					throw new LogicaException("Error al editar los datos de la nueva propiedad.");
						   				}
						   			
						   			break;
						   				
					   			}else{
					   				throw new LogicaException("Error enviando archivo en FTP");
					   			}
							}
			   			
						}
			   					
						
				}else{
					throw new LogicaException("Error Conectando al FTP");
				}
						
						
				}else{
					throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
				}
			
		//ContratoProcesoPropiedad resu = desvinculacionEJB.insertarContratoprocesopropiedad(contratoprocesopropiedad);
		/*if (resu !=null && resu.getIdcontratoprocesopropiedad()!=null) {
			PrintWriter out = response.getWriter();
			out.println(contrato.getIdcontrato());
			out.close();

			} else {
				throw new LogicaException("Error al editar los datos de la nueva propiedad.");
			}*/
		
			} 		
			
		else{
			throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
		}
			
		
		} catch (LogicaException e) {
		
			response.sendError(1, e.toString());
		} catch (Exception e) {
		
			response.sendError(1, e.toString());
		}
}


public void verArchivo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
    	HttpSession session = request.getSession(false);
        @SuppressWarnings("unused")
		UsuarioBean usuarioActivo = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);

       
         String idcontratoprocesopropiedad = request.getParameter("idcontratoprocesopropiedad");
         idcontratoprocesopropiedad = idcontratoprocesopropiedad == null ? "" : idcontratoprocesopropiedad.trim();
         //Long idcaso_tmp;
         if ("".equals(idcontratoprocesopropiedad)) {
             throw new NullPointerException("idcontratoprocesopropiedad requerido");
         } else {
             //idcaso_tmp = new Long (iddoc);
         }
          ContratoProcesoPropiedad contratoprocesopropiedad = desvinculacionEJB.getPropiedadProcesoporId(Long.valueOf(idcontratoprocesopropiedad));
          String ruta = "archivos_desvinculacion";
          byte[] bytes =FtpUtilCliente.downloadFTP(contratoprocesopropiedad.getDato(), ruta);
          
  
     	response.setContentType("application/x-filler");
     
 	
		response.setContentLength(bytes.length);
	    ServletOutputStream  ouputStream= response.getOutputStream();
		
		String nombrearchivo = contratoprocesopropiedad.getDatoamostrar();
		response.setHeader("Content-disposition", "attachment; filename=\"" + nombrearchivo + "\"");
		ouputStream.write(bytes);
		ouputStream.close();
         
     } catch (Exception e) {
         logger.error("Atrapó la excepcion en baseDetalle EX: ", e);
         response.sendError(1, e.getMessage());
     }
 }

public void desvinculacion_vereditarpropiedad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String idcontrato = request.getParameter("idcontrato");
		String idcontratoprocesopropiedad = request.getParameter("idcontratoprocesopropiedad");
		String idproceso = request.getParameter("idproceso");
		
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
		request.setAttribute("contrato", contrato);
		 ContratoProcesoPropiedad contratoprocesopropiedad = desvinculacionEJB.getPropiedadProcesoporId(Long.valueOf(idcontratoprocesopropiedad));
		
		request.setAttribute("contratoprocesopropiedad", contratoprocesopropiedad);
		ContratoProceso contratoproceso = desvinculacionEJB.getContratoProcesoporIdContratoyIdproceso(contrato.getIdcontrato(),Long.valueOf(idproceso));
		// List<ContratoProcesoPropiedad> contratoprocesopropiedades = desvinculacionEJB.getAllPropiedadProcesoporContrato(contrato.getIdcontrato());
		//List<ProcesoEstado> procesoestados = desvinculacionEJB.getAllprocesoEstados();
		
		List<ProcesoPropiedad> procesopropiedades = desvinculacionEJB.getAllProcesoPropiedadporIdproceso(Long.parseLong(idproceso));
	
		request.setAttribute("procesopropiedades", procesopropiedades);
		request.setAttribute("contratoproceso", contratoproceso);
		if(Long.valueOf(idcontratoprocesopropiedad)==3){
			request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_nuevapropiedad_archivos.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_editarpropiedad.jsp").forward(request, response);
		}
	
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}

public void desvinculacion_editarpropiedad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	HttpSession session = request.getSession(false);
UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
try {
	String idcontrato = request.getParameter("idcontrato");
	String idcontratoprocesopropiedad = request.getParameter("idcontratoprocesopropiedad");
	Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
	request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
	request.setAttribute("contrato", contrato);
	
	String idprocesopropiedad = request.getParameter("idprocesopropiedad");
	String dato = request.getParameter("dato");
	String observacion = request.getParameter("observacion");
	
	if(idprocesopropiedad!=null &&  dato!=null  ){
	//	ProcesoPropiedad procesopropiedad = desvinculacionEJB.getProcesoPropiedadporIdprocesopropiedad(Long.valueOf(idprocesopropiedad));
		 ContratoProcesoPropiedad contratoprocesopropiedad = desvinculacionEJB.getPropiedadProcesoporId(Long.valueOf(idcontratoprocesopropiedad));

	
		contratoprocesopropiedad.setIdprocesopropiedad(Long.valueOf(idprocesopropiedad));
		contratoprocesopropiedad.setDato(dato);
		contratoprocesopropiedad.setObservacion(observacion);
		contratoprocesopropiedad.setIdcontrato(contrato.getIdcontrato());
		contratoprocesopropiedad.setIdusuariomod(user.getCodusuario());
		
		contratoprocesopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());
	
		
		ContratoProcesoPropiedad resu = desvinculacionEJB.ActualizarContratoprocesoPropiedadcompleto(contratoprocesopropiedad);
		if (resu !=null && resu.getIdcontratoprocesopropiedad()!=null) {
			PrintWriter out = response.getWriter();
			out.println(contrato.getIdcontrato());
			out.close();

			} else {
				throw new LogicaException("Error al editar los datos de la nueva propiedad.");
			}
		
	}
	
	 

		
	
else{
	throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
}
	

	} catch (LogicaException e) {
	
		response.sendError(1, e.toString());
	} catch (Exception e) {
	
		response.sendError(1, e.toString());
	}
}



public void ver_enviar_correo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String idcontrato = request.getParameter("idcontrato");
	
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado()));
		request.setAttribute("contrato", contrato);
	
		request.getRequestDispatcher("../pages/desvinculacion/desvinculacion_enviar_correo.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void enviar_correo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	HttpSession session = request.getSession(false);
	UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
	 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	try {
		String idcontrato = request.getParameter("idcontrato");
		Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
		EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado());
		request.setAttribute("empleado",empleado );
		request.setAttribute("contrato", contrato);
	
		String dato = request.getParameter("para");
	
		
		if(idcontrato!=null &&  dato!=null  ){
			List<String> listadocorreos = new ArrayList<String>();
			
			
			String[] parts = dato.split(";");
			
		
			for(String p:parts){
				boolean a = Validar.isValidEmailAddress(p);
				if(a){
					listadocorreos.add(p);
				}else{
					throw new LogicaException("el correo: "+p+" no es un correo valido");
				}
					
				
			}
			
			
			Mail mail = new Mail();
			
			// listadocorreos.add("leo.20waw@hotmail.com");
			// int idusuariocreahistorico = tickethistorico.getIdusuariocrea();
			// Caso caso=casosEJB.getCasobyId(new Long(idcaso));
		//	UsuarioBean autor = usuarioEJB.getUsuarioPorCodusuario(usuarioactivo.getCodusuario());
			// tickethistorico.setObservacion("planilla "+tickethistorico.getDocumento().getNombrejasper());
			// UsuarioBean autor=usuarioEJB.getUsuario(idusuariocreahistorico);
			

			String mensaje="El resultado de la entrevista de desvinculación de: "+empleado.getNombres()+" "+empleado.getApellidos()+" y número de identificación "
					+ " "+empleado.getEmpleadoidentificacion().getNumeroidentificacion()
					+" fue: ";	
			
			EstadoDesvinculacion estadodevinculacion = desvinculacionEJB.getAllEstadosDesvinculacionbyId(contrato.getIdestadodesvinculacion());
			
			String observacion=""+estadodevinculacion.getNombreestado();
		
			

				

			HashMap<String, Object> data = new HashMap<String, Object>();

			//data.put("autor", autor);
			//data.put("caso", caso);
			//data.put("tickethistorico", tickethistorico);
			data.put("mensaje", mensaje);
			data.put("observacion", observacion);
			if (listadocorreos != null && listadocorreos.size() > 0) {
				mail.enviaMail(listadocorreos, data, request, response);
				PrintWriter out = response.getWriter();
				out.println(contrato.getIdcontrato());
				out.close();
			}
			
			
			
		}
		
		 

			
		
	else{
		throw new LogicaException("Existen valores en blanco y  no se puede enviar el correo");
	}
		

		} catch (LogicaException e) {
		
			response.sendError(1, e.toString());
		} catch (Exception e) {
		
			response.sendError(1, e.toString());
		}
}



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
