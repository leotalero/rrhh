package co.sistemcobro.rrhh.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import javax.ejb.EJB;
import javax.servlet.ServletException;
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
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.rrhh.bean.Area;
import co.sistemcobro.rrhh.bean.Cargo;
import co.sistemcobro.rrhh.bean.CargoAreaAsignada;
import co.sistemcobro.rrhh.bean.Falta;
import co.sistemcobro.rrhh.bean.FaltaTipo;
import co.sistemcobro.rrhh.bean.Formato;
import co.sistemcobro.rrhh.bean.Sancion;
import co.sistemcobro.rrhh.bean.SancionFormato;
import co.sistemcobro.rrhh.constante.Constante;
import co.sistemcobro.rrhh.ejb.AdministracionEJB;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.ejb.ProcesoDisciplinarioEJB;
import co.sistemcobro.rrhh.ejb.ReportesEJB;
import co.sistemcobro.rrhh.util.FtpUtilCliente;

/**
 * 
 * @author Leonardo talero
 * 
 */
@WebServlet(name = "AdministracionServlet", urlPatterns = { "/page/administracion"})
public class AdministracionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger log = Logger.getLogger(AdministracionServlet.class);
	
	private final String RUTA_FORMATOS = "formatos_disciplinarios";

	//ResourceBundle config = ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);
	ResourceBundle config = ResourceBundle.getBundle(Constante.FILE_CONFIG_RRHH);
	//private String temp_file_global; = config.getString("app.file.temporal.global");
	
	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;
	@EJB
	private ReportesEJB reportesEJB;
	@EJB
	private AdministracionEJB administracionEJB;
	
	@EJB
	private ProcesoDisciplinarioEJB procesoDisciplinarioEJB;
	
	public AdministracionServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("administracion_principal")) {
				administracion_principal(request, response);
			} else if (action.equals("buscar_areas_asociadas")) {
				buscar_areas_asociadas(request, response);
			} else if (action.equals("area_deshabilitar")) {
				area_deshabilitar(request, response);
			}else if (action.equals("area_habilitar")) {
				area_habilitar(request, response);
			}else if (action.equals("nuevo_asociacion")) {
				nuevo_asociacion(request, response);
			}else if (action.equals("grabar_areas_asociadas")) {
				grabar_areas_asociadas(request, response);
			}else if (action.equals("buscarFaltas")) {
				buscarFaltas(request, response);
			}else if (action.equals("deshabilitarSancion")) {
				deshabilitarSancion(request, response);
			}else if (action.equals("habilitarSancion")) {
				habilitarSancion(request, response);
			}else if (action.equals("nuevaFalta")) {
				nuevaFalta(request, response);
			}else if(action.equals("nuevaSancion")){
				nuevaSancion(request, response);
			}else if(action.equals("insertarFalta")){
				insertarFalta(request, response);
			}else if(action.equals("crearTipoDeFalta")){
				crearTipoDeFalta(request, response);
			}else if(action.equals("insertarTipoDeFalta")){
				insertarTipoDeFalta(request, response);
			}else if(action.equals("nuevoFormato")){
				verCargarNuevoFormato(request, response);
			}else if(action.equals("registrarNuevoFormato")){
				registrarNuevoFormato(request, response);
			}else if(action.equals("buscarFormatos")){
				buscarFormatos(request, response);
			}else if(action.equals("deshabilitarFormato")){
				deshabilitarFormato(request, response);
			}else if(action.equals("habilitarFormato")){
				habilitarFormato(request, response);
			}else if(action.equals("cargarFaltasPorTipoDeFalta")){
				cargarFaltasPorTipoDeFalta(request, response);
			}else if(action.equals("cargarNumeroRecurrencia")){
				cargarNumeroRecurrencia(request, response);
			}else if(action.equals("insertarSancion")){
				insertarSancion(request, response);
			}
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Este método obtiene y carga los datos necesarios para desplegar en la pagina de administración de areas, formatos,faltas,sanciones....
	 * @param HttpServletRequest. Petición
	 * @param HttpServletResponse. Respuesta.
	 * */
	public void administracion_principal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			List<Area> areas = contratoEJB.getAreas();
			List<Cargo> cargos = contratoEJB.getCargos();
			
//          Esto debe aparecer comentado para el war en producción.
			List<FaltaTipo> listaTiposDeFalta = procesoDisciplinarioEJB.obtenerTiposDeFaltas();
			List<Formato> listaDeFormatos = procesoDisciplinarioEJB.obtenerFormatos(); 		

			request.setAttribute("areas", areas);
			request.setAttribute("cargos",cargos);
			
//          Esto debe aparecer comentado para el war en producción.			
			request.setAttribute("listaTiposFalta",listaTiposDeFalta);
			request.setAttribute("listaFormatos",listaDeFormatos);
			
			request.getRequestDispatcher("../pages/admin/admin_principal.jsp").forward(request, response);
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	

	
	public void buscar_areas_asociadas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException, LogicaException {
		
		try {
			
			String[] areasstrig = request.getParameterValues("idareaAsignada");
			String[] cargosstrig = request.getParameterValues("idcargoAsociado");
			
			List<String> areas=new ArrayList<String>();
			List<String> cargos=new ArrayList<String>();
			
			if(areasstrig!=null &&  cargosstrig!=null){
				for(String idarea:areasstrig){
					if(!idarea.equals("null")){
						if(!idarea.equals("") ){
							areas.add(idarea);
						}
					}else{
						throw new LogicaException("Debe seleccionar un area.");
					}
			}
			
		
			for(String idcargo:cargosstrig){
				if(!idcargo.equals("null")){
					if(!idcargo.equals("") ){
						cargos.add(idcargo);
					}	
				}else{
					throw new LogicaException("Debe seleccionar un cargo.");
				}
					 
			}
			
			List<CargoAreaAsignada> areasasignadas = contratoEJB.getCargoAreasAsignadaslistados(cargos, areas);

			request.setAttribute("areas", areasasignadas);
		
			request.getRequestDispatcher("../pages/admin/admin_lista_areasasignadas.jsp").forward(request, response);
	
			}else{
				throw new LogicaException("Debe seleccionar un area.");
		}
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	

	/**
	 * Este metodo retorna el jsp que permite crear un nuevo tipo de falta.
	 * @param HttpServletRequest request.
	 * @param HttpServletResponse response.
	 * */
	private void crearTipoDeFalta(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try {
			request.getRequestDispatcher("../pages/admin/nuevoTipoFalta.jsp").forward(request, response);
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Este método consulta la lista de faltas y sanciones por idfaltatipo.
	 * @param HttpServletRequest request.
	 * @param HttpServletResponse response. 
	 * */
	private void buscarFaltas(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		try{
			String[] idtiposFalta = request.getParameterValues("idTiposFalta");
			
			List<Sancion> listaDeSanciones = procesoDisciplinarioEJB.obtenerSancionesPorTiposDeFalta(idtiposFalta);
			
			request.setAttribute("sanciones", listaDeSanciones);
			
			request.getRequestDispatcher("../pages/admin/listaDeSanciones.jsp").forward(request, response);
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}	
	}
	

	/**
	 * Este método consulta el listado de formatos.
	 * @param HttpServletRequest request.
	 * @param HttpServletResponse response. 
	 * */
	private void buscarFormatos(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		try{
			String[] idFormatosAConsultar = request.getParameterValues("idTiposFormatos");
			
			List<Formato> listaFormatos = procesoDisciplinarioEJB.obtenerFormatosPorIdFormato(idFormatosAConsultar); 
			
			request.setAttribute("listaFormatos", listaFormatos);
			
			request.getRequestDispatcher("../pages/admin/listaFormatos.jsp").forward(request, response);
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}	
	}
	
	
	public void area_deshabilitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			
			String idcargo = request.getParameter("idcargo");

			String idareaasignada = request.getParameter("idareaasignada");
			
			String idareamostrar = request.getParameter("idarea");
			
			if(idcargo!=null && idareaasignada!=null && idareamostrar!=null){
				List<CargoAreaAsignada> cargoarea = contratoEJB.getCargoAreasAsignadasporId(Long.valueOf(idcargo), Long.valueOf(idareaasignada), Long.valueOf(idareamostrar));
				if(cargoarea.size()>0){
					cargoarea.get(0).setIdusuariomod(user.getCodusuario());
					
				
					Integer res = administracionEJB.deshabilitarEstadoArea(cargoarea.get(0));
					if (res > 0) {
						PrintWriter out = response.getWriter();
						out.println(res);
						out.close();

					} else {
						throw new LogicaException("Error al editar el estado.");
					}
				}
				
					
			}
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
	/**
	 * Éste método deshabilita la falta. (Cambia estado a 3 en la B.D.)
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta.
	 * */
	public void deshabilitarSancion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			
			String idSancion = request.getParameter("idSancion");
			String idFalta  = request.getParameter("idFalta");
			
			if(idSancion!=null && idFalta!=null){
				
				Sancion sancion = new Sancion();
				Falta falta = new Falta();
				
				sancion.setIdsancion(Long.valueOf(idSancion));
				sancion.setEstado(EstadoEnum.DESHABILITADO.getIndex());
				sancion.setIdusuariomod(user.getCodusuario());
				
				falta.setIdfalta(Long.valueOf(idFalta));
				falta.setEstado(EstadoEnum.DESHABILITADO.getIndex());
				falta.setIdusuariomod(user.getCodusuario());
				
				Integer resultado = procesoDisciplinarioEJB.deshabilitarSancion(sancion);
				Integer resultadoUno = procesoDisciplinarioEJB.deshabilitarFalta(falta);
				
				if (resultado > 0 && resultadoUno>0) {
					PrintWriter out = response.getWriter();
					out.println(resultado);
					out.close();
				} else {
					throw new LogicaException("Error al editar el estado.");
				}
				
			}else{
				response.sendError(1, "se requiere un id de Falta.");
			}
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	/**
	 * Éste método deshabilita un formato. (Cambia estado a 3 en la B.D.)
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta.
	 * */
	public void deshabilitarFormato(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			
			String idFormato = request.getParameter("idFormato");
			
			if(idFormato!=null){
				
				Formato formato =  new Formato();

				formato.setIdformato(Long.valueOf(idFormato));
				formato.setEstado(EstadoEnum.DESHABILITADO.getIndex());
				formato.setIdusuariomod(user.getCodusuario());
				
				Integer resultado = procesoDisciplinarioEJB.deshabilitarFormato(formato);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(resultado);
					out.close();
				} else {
					throw new LogicaException("Error al editar el estado.");
				}
				
			}else{
				response.sendError(1, "se requiere un id de Formato.");
			}
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
	/**
	 * Éste método habilita un formato. (Cambia estado a 3 en la B.D.)
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta.
	 * */
	public void habilitarFormato(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			
			String idFormato = request.getParameter("idFormato");
			
			if(idFormato!=null){
				
				Formato formato =  new Formato();

				formato.setIdformato(Long.valueOf(idFormato));
				formato.setEstado(EstadoEnum.ACTIVO.getIndex());
				formato.setIdusuariomod(user.getCodusuario());
				
				Integer resultado = procesoDisciplinarioEJB.habilitarFormato(formato);
				
				if (resultado > 0) {
					PrintWriter out = response.getWriter();
					out.println(resultado);
					out.close();
				} else {
					throw new LogicaException("Error al editar el estado.");
				}
				
			}else{
				response.sendError(1, "se requiere un id de Formato.");
			}
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
	
	/**
	 * Éste método deshabilita la falta. (Cambia estado a 3 en la B.D.)
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta.
	 * */
	public void habilitarSancion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			
			String idSancion = request.getParameter("idSancion");
			String idFalta  = request.getParameter("idFalta");
			
			if(idSancion!=null && idFalta!=null){
				
				Sancion sancion = new Sancion();
				Falta falta = new Falta();
				
				sancion.setIdsancion(Long.valueOf(idSancion));
				sancion.setEstado(EstadoEnum.ACTIVO.getIndex());
				sancion.setIdusuariomod(user.getCodusuario());
				
				falta.setIdfalta(Long.valueOf(idFalta));
				falta.setEstado(EstadoEnum.ACTIVO.getIndex());
				falta.setIdusuariomod(user.getCodusuario());
				
				Integer resultado = procesoDisciplinarioEJB.habilitarSancion(sancion);
				Integer resultadoUno = procesoDisciplinarioEJB.habilitarFalta(falta);
				
				if (resultado > 0 && resultadoUno>0) {
					PrintWriter out = response.getWriter();
					out.println(resultado);
					out.close();
				} else {
					throw new LogicaException("Error al editar el estado.");
				}
				
			}else{
				response.sendError(1, "se requiere un id de Falta.");
			}
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	public void area_habilitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			
			String idcargo = request.getParameter("idcargo");
			String idareaasignada = request.getParameter("idareaasignada");
			String idareamostrar = request.getParameter("idarea");
			
			if(idcargo!=null && idareaasignada!=null && idareamostrar!=null){
				
				List<CargoAreaAsignada> cargoarea = contratoEJB.getCargoAreasAsignadasporId(Long.valueOf(idcargo), Long.valueOf(idareaasignada), Long.valueOf(idareamostrar));
				
				if(cargoarea.size()>0){
					cargoarea.get(0).setIdusuariomod(user.getCodusuario());
					Integer res = administracionEJB.habilitarEstadoArea(cargoarea.get(0));
					
					if (res > 0) {
						PrintWriter out = response.getWriter();
						out.println(res);
						out.close();
					} else {
						throw new LogicaException("Error al editar el estado.");
					}
				}
			}
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	
	public void nuevo_asociacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try {
			List<Area> areas = contratoEJB.getAreas();
			List<Cargo> cargos = contratoEJB.getCargos();
			
			request.setAttribute("areas", areas);
			request.setAttribute("cargos",cargos);
			
			request.getRequestDispatcher("../pages/admin/admin_nuevo_areasasignada.jsp").forward(request, response);
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	/**
	 * Cargar los datos necesarios para la creación de una falta o norma.
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta. 
	 * */
	private void nuevaFalta(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try {
			List<FaltaTipo> listaTiposDeFalta = procesoDisciplinarioEJB.obtenerTiposDeFaltas();
			List<Falta> listaDeFaltas = procesoDisciplinarioEJB.ObtenerTodasLasFaltas();
			List<Formato> listaFormatos = procesoDisciplinarioEJB.obtenerFormatos();			
			
			request.setAttribute("tiposFalta", listaTiposDeFalta);
			request.setAttribute("faltas",listaDeFaltas);
			request.setAttribute("formatos",listaFormatos);
			
			request.getRequestDispatcher("../pages/admin/nuevaFaltaSancion.jsp").forward(request, response);
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Cargar los datos necesarios para la creación de una nueva sancion a un falta.
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta. 
	 * */
	private void nuevaSancion(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try {
			List<FaltaTipo> listaTiposDeFalta = procesoDisciplinarioEJB.obtenerTiposDeFaltas();
			List<Falta> listaDeFaltas = procesoDisciplinarioEJB.ObtenerTodasLasFaltas();
			List<Formato> listaFormatos = procesoDisciplinarioEJB.obtenerFormatos();			
			
			request.setAttribute("tiposFaltaSancion", listaTiposDeFalta);
			request.setAttribute("faltasSancion",listaDeFaltas);
			request.setAttribute("formatosSancion",listaFormatos);
			request.setAttribute("formatos",listaFormatos);
			
			
			request.getRequestDispatcher("../pages/admin/nuevaSancion.jsp").forward(request, response);
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 *  
	 */
	public void grabar_areas_asociadas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String[] areasstrig = request.getParameterValues("idareaAsignadaNuevo");
			String[] cargosstrig = request.getParameterValues("idcargoAsociadoNuevo");
			String[] areasmostrarstrig = request.getParameterValues("idareaMostrarNuevo");
			
			List<CargoAreaAsignada> cargosareas=new ArrayList<CargoAreaAsignada>();
			List<String> areas=new ArrayList<String>();
			List<String> cargos=new ArrayList<String>();
			List<String> areasmostrar=new ArrayList<String>();
			
			for(String idarea:areasstrig){
				if(!idarea.equals("null")){
					if(!idarea.equals("") ){
						areas.add(idarea);
					}
				}else{
					throw new LogicaException("Debe seleccionar un area.");
				} 
			}
		
			
			for(String idcargo:cargosstrig){
				if(!idcargo.equals("null")){
					if(!idcargo.equals("") ){
						cargos.add(idcargo);
					}
						
				}else{
					throw new LogicaException("Debe seleccionar un cargo.");
				}	 
			 }
			
			
			for(String idarea:areasmostrarstrig){
				if(!idarea.equals("null")){
					if(!idarea.equals("") ){
						areasmostrar.add(idarea);
					}
					
				}else{
					throw new LogicaException("Debe seleccionar un area.");
				}
				 
			}
			
		 
			int i=0;
			for(String areamostrar:areasmostrar){
				
				CargoAreaAsignada cargoarea = new CargoAreaAsignada();
				
				cargoarea.setIdcargo(Long.valueOf(cargos.get(0)));
				cargoarea.setIdareaasignada(Long.valueOf(areas.get(0)));
				cargoarea.setIdarea(Long.valueOf(areasmostrar.get(i)));
				cargoarea.setIdusuariocrea(user.getCodusuario());
				cargoarea.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				cargosareas.add(cargoarea);
				i++;
			}
		
			Integer resultado = contratoEJB.insertarCargosAreasaMostrar(cargosareas);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(resultado);
				out.close();
			} else {
				throw new LogicaException("Error al grabar los datos del nuevo usuario.");
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
	
	/**
	 * Insertar una nueva Falta o norma.
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta. 
	 * @throws IOException 
	 * */
	private void insertarFalta(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			
			String idTipoFaltaSeleccionada = request.getParameter("idTipoFaltaSeleccionada");
			String faltaIngresada = request.getParameter("falta");
			String sancionIngresada = request.getParameter("sancionDeFalta");
			String idRecurrenciaSeleccionada = request.getParameter("recurrenciaSeleccionada");
			String procedimientoIngresado = request.getParameter("procedimientoDeFalta");
			String responsableSeleccionado = request.getParameter("responsableSeleccionado");
			String[] idsFormatosSeleccionados= request.getParameterValues("nameFormatosSeleccionados");
			
			idTipoFaltaSeleccionada = idTipoFaltaSeleccionada == null? "" :idTipoFaltaSeleccionada.trim();
			faltaIngresada = faltaIngresada == null? "" :faltaIngresada.trim();
			sancionIngresada = sancionIngresada == null? "" :sancionIngresada.trim();
			idRecurrenciaSeleccionada = idRecurrenciaSeleccionada == null? "" :idRecurrenciaSeleccionada.trim();
			procedimientoIngresado = procedimientoIngresado == null? "" :procedimientoIngresado.trim();
			responsableSeleccionado = responsableSeleccionado == null? "" :responsableSeleccionado.trim();
			
			if(idTipoFaltaSeleccionada!=null && !idTipoFaltaSeleccionada.equals("") && idRecurrenciaSeleccionada!=null && !idRecurrenciaSeleccionada.equals("")){
				//Primero: Insertar Falta
				Falta falta = new Falta();
				String nombreid="idfalta";
				String nombreTabla = "rrhh.falta";
				
				//Obtener maximo id +1
				Long idFalta = administracionEJB.obtenerIdMaximoDeTabla(nombreTabla,nombreid) + 1;
				
				falta.setIdfalta(idFalta);
				falta.setIdfaltatipo(Long.valueOf(idTipoFaltaSeleccionada));
				falta.setFaltanombre(faltaIngresada);
				falta.setIdusuariocrea(user.getCodusuario());
				falta.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				//Inserción tabla rrhh.falta
				if(procesoDisciplinarioEJB.insertarNuevaFalta(falta)){
					//Segundo: Insertar Sanción.
					Sancion sancion = new Sancion();
					
					sancion.setIdfalta(idFalta);
					sancion.setNombresancion(sancionIngresada);
					sancion.setRecurrencia(Integer.valueOf(idRecurrenciaSeleccionada));
					sancion.setProcedimiento(procedimientoIngresado);
					sancion.setResponsable(responsableSeleccionado);
					sancion.setIdusuariocrea(user.getCodusuario());
					sancion.setEstado(EstadoEnum.ACTIVO.getIndex());
					
					//INSERTAR LA SANCIÓN.
					
					sancion = procesoDisciplinarioEJB.insertarNuevaSancion(sancion);
					
					if(sancion.getIdsancion()!=null && sancion.getIdsancion()>0){
						
						//Activar el tipo de falta.
						FaltaTipo faltaTipoSeleccionado = procesoDisciplinarioEJB.obtenerFaltaTipoPorId(Long.valueOf(idTipoFaltaSeleccionada));
						
						//Si el estado es eliminado hay que activarlo.
						if(faltaTipoSeleccionado.getEstado() == EstadoEnum.ELIMINADO.getIndex()){
							faltaTipoSeleccionado.setIdusuariomod(user.getCodusuario());
							faltaTipoSeleccionado.setEstado(EstadoEnum.ACTIVO.getIndex());
							if(procesoDisciplinarioEJB.actualizarEstadoFaltaTipo(faltaTipoSeleccionado)>0){
							}else{
								response.sendError(1,"Error al activar el tipo de falta.");
							}
						}
						
						//¿Hay formatos asignados a esta falta?
						int elementosLista = idsFormatosSeleccionados.length;
						int contador = 0;
						
						if(elementosLista>0){
							
							for(String idFormato : idsFormatosSeleccionados){
								
								SancionFormato sancionFormato = new SancionFormato();
								
								sancionFormato.setIdformato(Long.valueOf(idFormato));
								sancionFormato.setIdsancion(sancion.getIdsancion());
								sancionFormato.setIdusuariocrea(user.getCodusuario());
								sancionFormato.setEstado(EstadoEnum.ACTIVO.getIndex());
								
								if(procesoDisciplinarioEJB.insertarSancionFormato(sancionFormato)){
									contador++;
									
									if(contador==elementosLista){
										PrintWriter out = response.getWriter();
										out.println(1);
										out.close();
									}
								}else{
									response.sendError(1,"Error al insertar la nueva Sancion_formato.");
								}
							}
						}else{
							PrintWriter out = response.getWriter();
							out.println(1);
							out.close();
						}
					}else{
						response.sendError(1,"Error al insertar la nueva Sancion.");
					}
				}else{
					response.sendError(1,"Error al insertar la nueva Falta.");
				}
			}else{
				response.sendError(1,"Se requiere un tipo de falta.");
			}
		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}

	
	/**
	 * Este metodo registra un nuevo tipo de falta en la BD.
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta. 
	 * @throws IOException 
	 * */
	private void insertarTipoDeFalta(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			
			String tipoDeFaltaNuevo = request.getParameter("nuevoTipoDeFalta");
			
			if(tipoDeFaltaNuevo!=null && !tipoDeFaltaNuevo.equals("")){
				FaltaTipo tipoFalta = new FaltaTipo();
				Long idFaltaTipo = administracionEJB.obtenerIdMaximoDeTabla("rrhh.falta_tipo", "idfaltatipo")+1;
				
				tipoFalta.setIdfaltatipo(idFaltaTipo);
				tipoFalta.setNombrefaltatipo(tipoDeFaltaNuevo);
				tipoFalta.setIdusuariocrea(user.getCodusuario());
				tipoFalta.setEstado(EstadoEnum.ACTIVO.getIndex());
				boolean inserto = procesoDisciplinarioEJB.insertarTipoDeFalta(tipoFalta);
				
				if(inserto){
					log.info("El tipo de falta se creo correctamente, su id = "+tipoFalta.getIdfaltatipo());
					PrintWriter out = response.getWriter();
					out.println(tipoFalta.getIdfaltatipo());
					out.close();
				}else {
					throw new LogicaException("Error al grabar el nuevo tipo de falta.");
				}
			}else{
				throw new LogicaException("Se requiere un dato a insertar.");
			}
		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}
	
	/**
	 * Este método carga el formulario para la carga de un nuevo formato.
	 * @param HttpServletRequest petición.
	 * @param HttpServletResponse. respuesta. 
	 * @throws IOException 
	 * */
	private void verCargarNuevoFormato(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try {	 
			request.getRequestDispatcher("../pages/admin/nuevoFormato.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Cargar el formato al servidor FTP de sistemcobro.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException,ServletException.
	 */
	private void registrarNuevoFormato(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			
			String nombreDelFormato = Archivo.getParameter(request.getPart("nombreFormato"));
			
			nombreDelFormato = nombreDelFormato == null ? "": nombreDelFormato.trim();
			
			Part part = request.getPart("formato");
			
			InputStream is = part.getInputStream();
			int k = is.available();
			byte[] b = new byte[k];
			is.read(b);
			String file = Archivo.getFullName(part);
			
			
			if(!file.equals("")|| !file.equals(null)){
				
					if(FtpUtilCliente.checkconexion()){
						
						Formato formato = new Formato();
						Long idFormato = administracionEJB.obtenerIdMaximoDeTabla("rrhh.formato","idformato") + 1;
						
						formato.setIdformato(idFormato);
						formato.setNombreformato(nombreDelFormato);
						formato.setRutaformato(nombreDelFormato);
						formato.setIdusuariocrea(user.getCodusuario());
						formato.setEstado(EstadoEnum.DESHABILITADO.getIndex());
						
						boolean resultado = procesoDisciplinarioEJB.insertarNuevoFormato(formato);
						
						if(resultado){
							
							InputStream ispdf = part.getInputStream();
							ispdf.read(b);
								
							String filepdf = Constante.ROOT_FILE_TEMPORARY + File.separator + formato.getIdformato()+"_"+file;
							
							File archivopdf = new File(filepdf);
							FileOutputStream ospdf = new FileOutputStream(archivopdf);
							ospdf.write(b);
			
							ispdf.close();
							ospdf.close();
							
							log.warn("Antes de intentar cargar el formato con el metodo : FtpUtilCliente.uploadFTP(archivopdf,ruta)) ");
					   		
							if (FtpUtilCliente.uploadFTP(archivopdf,RUTA_FORMATOS)) {
								formato.setRutaformato(archivopdf.getName());
								formato.setIdusuariomod(user.getCodusuario());
								formato.setEstado(EstadoEnum.ACTIVO.getIndex());
								
								Formato formatoActualizado= procesoDisciplinarioEJB.activarFormato(formato);
					   				
						   		if (formatoActualizado ==null) {
						   			throw new LogicaException("Error al editar los datos del formato.");
//						   			PrintWriter out = response.getWriter();
//						   			log.info("ID DEL FORMATO INSERTADO = "+formato.getIdformato());
//						   			out.println(formato.getIdformato());
//						   			out.close();
//						   			log.info("Ya debio insertar y cargar el formato.");
//						   			log.info("Se va a llamar a administracion_principal.");
//						   			administracion_principal(request, response);
						   		} 
//						   		else {
//						   			throw new LogicaException("Error al editar los datos del formato.");
//						   		}
					   		}else{
					   			log.info("Error enviando archivo en FTP");
					   			throw new LogicaException("Error enviando formato en FTP");
					   		}
						
					}else{
						log.info("Error Conectando al FTP");
						}
					}else{
							log.info("Error Conectando al FTP");
							response.sendError(1, "Error Conectando al servidor FTP.");
							throw new LogicaException("Error Conectando al FTP");
						}		
					
		    }else{
		    	log.info("Existen valores en blanco y no se puede guardar el registro");
				throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
			}			
			} catch (LogicaException e) {
				log.info("LogicaException e = "+e);
				response.sendError(1, e.toString());
			} catch (Exception e) {
				log.info("Exception e = "+e);
				response.sendError(1, e.toString());
			}
		
	}

	
	
	/**
	 * Método para responder y servir a las peticion de CARGAR LAS FALTAS POR
	 * TIPO DE FALTA
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarFaltasPorTipoDeFalta(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idFaltaTipo = request.getParameter("idFaltaTipo");

			log.info("idFaltaTipo : "+idFaltaTipo);
			
			List<Falta> listaDeFaltas = procesoDisciplinarioEJB.obtenerFaltasPorTipoFalta(Long.valueOf(idFaltaTipo));

			if(listaDeFaltas.size()>0){
				log.info("Hay faltas");
			}
			
			request.setAttribute("faltasParaSancion", listaDeFaltas);

			request.getRequestDispatcher("../pages/admin/listaFaltas.jsp").forward(request,
					response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	

	/**
	 * Método para responder y servir a las peticion de cargar el numero de recurrencia a aplicar en la nueva sancion.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarNumeroRecurrencia(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idFalta = request.getParameter("idFalta");
			
			Integer recurrencia = procesoDisciplinarioEJB.obtenerSiguienteRecurrenciaDeSancion(Long.valueOf(idFalta));
			
			request.setAttribute("SiguienteNumeroRecurrencia",recurrencia);
			request.setAttribute("recurrenciaNumero",getRecurrenciaDetalle(recurrencia));
			request.getRequestDispatcher("../pages/admin/siguienteRecurrencia.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Este método responde a la petición de insertar una nueva sancion a una falta ya existente.
	 * @param HttpServletRequest. La peticion.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException
	 * */
	private void insertarSancion(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			
			String idFaltaSeleccionada = request.getParameter("idFaltaAsignadaEnSancion");
			String NombreSancion = request.getParameter("idSancionDeFalta");
			String recurrenciaNumero = request.getParameter("numeroRecurrenciaSiguiente");
			String procedimiento = request.getParameter("idProcedimientoDeFalta");
			String responsable = request.getParameter("responsableSeleccionadoSancion");
			String[] idFormatosAsociados = request.getParameterValues("nameFormatosSeleccionadosSancion");
			
			idFaltaSeleccionada = idFaltaSeleccionada == null ? "": idFaltaSeleccionada.trim();
			NombreSancion = NombreSancion == null ? "": NombreSancion.trim();
			recurrenciaNumero = recurrenciaNumero == null ? "": recurrenciaNumero.trim();
			procedimiento = procedimiento == null ? "": procedimiento.trim();
			responsable = responsable == null ? "": responsable.trim();
			
			if(idFaltaSeleccionada!=null && !idFaltaSeleccionada.equals("")){
				Sancion sancion = new Sancion();
				
				sancion.setIdfalta(Long.valueOf(idFaltaSeleccionada));
				sancion.setNombresancion(NombreSancion);
				sancion.setRecurrencia(Integer.valueOf(recurrenciaNumero));
				sancion.setProcedimiento(procedimiento);
				sancion.setResponsable(responsable);
				sancion.setIdusuariocrea(user.getCodusuario());
				sancion.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				//INSERTAR LA SANCIÓN.
				sancion = procesoDisciplinarioEJB.insertarNuevaSancion(sancion);
				
				if(sancion.getIdsancion()!=null && sancion.getIdsancion()>0){
					
					//¿Hay formatos asignados a esta falta?
					int elementosLista = idFormatosAsociados.length;
					int contador = 0;
					
					if(elementosLista>0){
						
						for(String idFormato : idFormatosAsociados){
							
							SancionFormato sancionFormato = new SancionFormato();
							
							sancionFormato.setIdformato(Long.valueOf(idFormato));
							sancionFormato.setIdsancion(sancion.getIdsancion());
							sancionFormato.setIdusuariocrea(user.getCodusuario());
							sancionFormato.setEstado(EstadoEnum.ACTIVO.getIndex());
							
							if(procesoDisciplinarioEJB.insertarSancionFormato(sancionFormato)){
								contador++;
								
								if(contador==elementosLista){
									PrintWriter out = response.getWriter();
									out.println(1);
									out.close();
								}
							}else{
								response.sendError(1,"Error al insertar la relacion sancion-formato.");
							}
						}
					}else{
						PrintWriter out = response.getWriter();
						out.println(1);
						out.close();
					}
				}else{
					response.sendError(1,"Error al insertar la nueva Sanción.");
				}
			}else{
				response.sendError(1,"No puede haber campos en blanco.");
			}
		}catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}
	
	/**
	 * Método para reemplazar y convertir el numero de veces que se ha cometido
	 * una falta en letras. Unicamente es valido al momento de crear el proceso.
	 * 
	 * @param Integer
	 *            . numeroVeces
	 * @return String. el numero de veces en palabras.
	 * */
	private String getRecurrenciaDetalle(Integer numeroVeces) {
		String respuesta = "";

		switch (numeroVeces) {
		case 1:
			respuesta = "1 (Primera vez)";
			break;
		case 2:
			respuesta = "2 (Segunda vez)";
			break;
		case 3:
			respuesta = "3 (Tercera vez)";
			break;
		case 4:
			respuesta = "4 (Cuarta vez)";
			break;
		case 5:
			respuesta = "5 (Quinta vez)";
			break;
		case 6:
			respuesta = "6 (Sexta vez)";
			break;
		case 7:
			respuesta = "7 (Septima vez)";
			break;
		case 8:
			respuesta = "8 (Octava vez)";
			break;
		case 9:
			respuesta = "9 (Novena vez)";
			break;
		case 10:
			respuesta = "10 (Decima vez)";
			break;
		case 11:
			respuesta = "11 (Onceava vez)";
			break;
		default:
			respuesta = "";
			break;
		}
		return respuesta;
	}
	
}
