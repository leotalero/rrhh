package co.sistemcobro.rrhh.web;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.Inet4Address;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.all.util.Util;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.UsuarioTipoBusquedaEnum;
import co.sistemcobro.rrhh.bean.AfiliacionEntidad;
import co.sistemcobro.rrhh.bean.Area;
import co.sistemcobro.rrhh.bean.Banco;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.ContratoTipo;
import co.sistemcobro.rrhh.bean.Disciplina;
import co.sistemcobro.rrhh.bean.EducacionNivel;
import co.sistemcobro.rrhh.bean.EmpleadoAfiliacion;
import co.sistemcobro.rrhh.bean.EmpleadoBanco;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.EmpleadoDesvinculacion;
import co.sistemcobro.rrhh.bean.EmpleadoEducacion;
import co.sistemcobro.rrhh.bean.EmpleadoIdentificacion;
import co.sistemcobro.rrhh.bean.EmpleadoSalario;
import co.sistemcobro.rrhh.bean.Proceso;
import co.sistemcobro.rrhh.bean.ReporteEmpleado;
import co.sistemcobro.rrhh.bean.ReporteInformacionAdicionalEmpleado;
import co.sistemcobro.rrhh.bean.ReporteIngresosPersonal;
import co.sistemcobro.rrhh.bean.ReporteProcesoDisciplinario;
import co.sistemcobro.rrhh.bean.TipoMoneda;
import co.sistemcobro.rrhh.constante.Constante;
import co.sistemcobro.rrhh.constante.EmpleadoTipoBusquedaEnum;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.DesvinculacionEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.ejb.ProcesoDisciplinarioEJB;
import co.sistemcobro.rrhh.ejb.ReportesEJB;

/**
 * 
 * @author Leonardo talero
 * 
 */
@WebServlet(name = "ReportesServlet", urlPatterns = { "/page/reportes" })
public class ReportesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(ReportesServlet.class);

	// ResourceBundle config =
	// ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);
	ResourceBundle config = ResourceBundle.getBundle(Constante.FILE_CONFIG_RRHH);
	 ResourceBundle configrrhh = ResourceBundle	.getBundle(co.sistemcobro.rrhh.constante.Constante.FILE_CONFIG_RRHH);
		
//	private String temp_file_global = config.getString("app.file.temporal.global");

	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;

	@EJB
	private ReportesEJB reportesEJB;
	
	@EJB
	private DesvinculacionEJB desvinculacionEJB;

	@EJB
	private ProcesoDisciplinarioEJB procesoDisciplinarioEJB;

	public ReportesServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		
		try {
			if (action.equals("reportes_principal")) {
				reportes_principal(request, response);
			} else if (action.equals("empleadosreportecontrato")) {
				empleadosreportecontrato(request, response);
			} else if (action.equals("empleadosreportehistorico")) {
				empleadosreportehistorico(request, response);
			} else if (action.equals("empleadosreportedesvinculacion")) {
				empleadosreportedesvinculacion(request, response);
			} else if(action.equals("reporteInformacionAdicional")){
				generarReporteInfoAdicionalDeEmpleados(request, response);
			} else if(action.equals("reporteProcesoDisciplinario")){
				generarReporteProcesoDisciplinario(request, response);
			} else if(action.equals("reporteHistoricoDisciplinarioDesdeHistorial")){
				reporteHistoricoDisciplinarioDesdeHistorial(request, response);
			} else if(action.equals("mostrarHistoricoDisciplinario")){
				mostrarHistoricoDisciplinario(request, response);
			} else if(action.equals("reporteHistoricoDisciplinario")){
				verHistoricoDisciplinario(request, response);
			} else if(action.equals("reporteIngresoPersonal")){
				reporteIngresoPersonal(request, response);
			}
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void reportes_principal(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			List<Area> areas = contratoEJB.getAreas();
			request.setAttribute("areas", areas);
			request.setAttribute("estadoActivo", "ACTIVO");
			request.setAttribute("estadoDeshabilitado", "DESHABILITADO");
			TableauServlet ts = new TableauServlet();
			// final String user = "SISTEMCOBRO"+"\\"+"dtroncoso";
			final String user=configrrhh.getString("rrhh.tableau.userG");
			final String wgserver=configrrhh.getString("rrhh.tableau.server");
			 String iplocal=Inet4Address.getLocalHost().getHostAddress();
			//String ticket= ts.getTrustedTicket(wgserver, user, iplocal);
			//String parametros="Cola=Soporte,Desarrollo";
			//request.setAttribute("ticket", ticket);
			// request.setAttribute("server", wgserver);
			// request.setAttribute("parametros", parametros);
			request.getRequestDispatcher("../pages/reportes/reportes_principal.jsp").forward(
					request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	/**
	 * 
	 * */
	private void mostrarHistoricoDisciplinario(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try {
			
			HttpSession session = request.getSession(false);
			UsuarioBean user = (UsuarioBean) session.getAttribute("usuario");
			
			if(user!=null){
				logger.info("Usuario es diferenete de null !!");
			}
			
			String numeroIdentificion = user.getNumidentificacion();
			
			logger.info("numeroIdentificion = "+numeroIdentificion);
			
			EmpleadoIdentificacion empleadoIdentificacion = reportesEJB.obtenerEmpleadoIdentificacionPorNumeroIdentificacion(numeroIdentificion);
			
			if(empleadoIdentificacion==null){
				logger.info("empleadoIdentificacion==null");
			}
			
			Contrato contrato = reportesEJB.getUltimoContratosporIdEmpleado(empleadoIdentificacion.getIdempleado());
			
			if(contrato==null){
				logger.info("contrato==null");
			}
			
			List<Area> areas = reportesEJB.obtenerAreasACargoPoridCargo(contrato);
			
			if(areas.size()>0){
				request.setAttribute("areas", areas);
			}else{
				request.setAttribute("areas", null);
			}
			request.getRequestDispatcher("../pages/reportes/historicoDisciplinario.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Este método permite generar el reporte de historico disciplinario de todos los empleados de Sistemcobro.
	 */
	private void verHistoricoDisciplinario(HttpServletRequest request, HttpServletResponse response)throws IOException {
		try {
			
			String idAreas[] = request.getParameterValues("idAreaSeleccionada");
			List<String> listaIdAreas = new ArrayList<String>();
			
			String desde = request.getParameter("fechaFiltroDesde");
			String hasta = request.getParameter("fechaFiltroHasta");
			
			desde = desde == null ? "" : Util.stringToString(desde.trim(),"dd/MM/yyyy", "yyyyMMdd");
			hasta = hasta == null ? "" : Util.stringToString(hasta.trim(),"dd/MM/yyyy", "yyyyMMdd");
			
			if(listaIdAreas.size()>0){
				logger.info("Tamaño de la lista de id areas = "+listaIdAreas.size());
			}
			
			for (String idArea : idAreas) {
				if (!idArea.equals("null")) {
					if (!idArea.equals("")) {
						listaIdAreas.add(idArea);
					}
				} else {
					throw new LogicaException("Debe seleccionar una área.");
				}
			}
			
			List<Disciplina> listaProcesosDisciplinarios = null;
			
			if(desde!=null && !desde.equals("") && hasta!=null && !hasta.equals("")){
				listaProcesosDisciplinarios= procesoDisciplinarioEJB.obtenerHistoricoDisciplinarioPorArea(listaIdAreas,desde,hasta);
			}else{
				listaProcesosDisciplinarios = procesoDisciplinarioEJB.obtenerHistoricoDisciplinarioPorArea(listaIdAreas);
			}
			
			listaProcesosDisciplinarios = procesoDisciplinarioEJB.setearUltimoEstadoDeLProceso(listaProcesosDisciplinarios);
			
			request.setAttribute("listaDisciplina",listaProcesosDisciplinarios);
			request.setAttribute("listaIdAreas",listaIdAreas);
			
			request.getRequestDispatcher("../pages/reportes/historicoDisciplinarioPorAreas.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Este método permite generar el reporte de los ingresos de personal.
	 * @throws IOException 
	 * */
	private void reporteIngresoPersonal(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try {
			
			List<ReporteIngresosPersonal> reporteIngresosPersonal = new ArrayList<ReporteIngresosPersonal>();
			String fechaActual = Util.dateToString(new Date(), "yyyyMMddHHmmss");
			String desde = request.getParameter("fechaIngresoDesde");
			String hasta = request.getParameter("fechaIngresoHasta");
			
			desde = desde == null ? "" : Util.stringToString(desde.trim(),"dd/MM/yyyy", "yyyyMMdd");
			hasta = hasta == null ? "" : Util.stringToString(hasta.trim(),"dd/MM/yyyy", "yyyyMMdd");
			
			reporteIngresosPersonal = reportesEJB.obtenerIngresosDePersonalPorFecha(desde,hasta);
						
			byte[] bytesDeArchivo = escribirReporteIngresosDePersonal(reporteIngresosPersonal,request,response);
			
			ServletOutputStream out = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition","attachment; filename=ReporteIngresosDePersonal_" + fechaActual + ".xls");
			out.write(bytesDeArchivo);
			out.flush();
			out.close();
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
		
	/**
	 * 
	 */
	private void reporteHistoricoDisciplinarioDesdeHistorial(HttpServletRequest request, HttpServletResponse response)throws IOException {
		try {
			String idAreas[] = request.getParameter("idAreaSeleccionada").split(",");
			List<String> listaIdAreas = new ArrayList<String>();
			
			if(listaIdAreas.size()>0){
				logger.info("Tamaño de la lista de id areas = "+listaIdAreas.size());
			}
			
			for (String idArea : idAreas) {
				if (!idArea.equals("null")) {
					if (!idArea.equals("")) {
						listaIdAreas.add(idArea);
					}
				} else {
					throw new LogicaException("Debe seleccionar una área.");
				}
			}
			logger.info("Antes de consultar la BD.");
			List<Disciplina> listaProcesosDisciplinarios = procesoDisciplinarioEJB.obtenerHistoricoDisciplinarioPorArea(listaIdAreas);
			logger.info("Despues de consultar la BD.");
			listaProcesosDisciplinarios = procesoDisciplinarioEJB.setearUltimoEstadoDeLProceso(listaProcesosDisciplinarios);
			
			request.setAttribute("listaDisciplina",listaProcesosDisciplinarios);
			request.setAttribute("listaIdAreas",listaIdAreas);
			logger.info("Antes de disparar el jsp.");
			request.getRequestDispatcher("../pages/reportes/historicoDisciplinarioPorAreas.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	public void empleadosreportecontrato(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {

			String[] estado = request.getParameterValues("idestadoREmpleadoContra");
			
			List<String> estados = new ArrayList<String>();
			List<ReporteEmpleado> reporteempleados = new ArrayList<ReporteEmpleado>();
			String fechaActual = Util.dateToString(new Date(), "yyyyMMddHHmmss");
						
			for (String idestado : estado) {
				if (!idestado.equals("null")) {
					if (!idestado.equals("")) {
						estados.add(idestado);
					}

				} else {
					throw new LogicaException("Debe seleccionar un Estado.");
				}

			}
			
			List<EmpleadoBean> empleados = empleadoEJB.getEmpleados(estados);
			
			// Setea los datos del ultimo contrato.
			reporteempleados = contratoEJB.getcontratoultimoempleadoporoEmpleados(empleados);

			// Setea los datos del banco y cuenta bancaria mas vigente.
			reporteempleados = contratoEJB.getUltimoBancoPorEmpleado(reporteempleados);

			// Setea los datos de afiliacion a salud.
			reporteempleados = contratoEJB.getUltimaAfiliacionEps(reporteempleados);

			// Setea los datos de afiliacion a cesantias.
			reporteempleados = contratoEJB.getUltimaAfiliacionCesantias(reporteempleados);

			// Setea los datos de afiliacion a pensión.
			reporteempleados = contratoEJB.getUltimaAfiliacionPension(reporteempleados);

			// Setea los datos de afiliacion a caja de compensación.
			reporteempleados = contratoEJB.getUltimaAfiliacionCajaDeCompensacion(reporteempleados);
			
			//Setea los datos del máximo nivel educativo alcanzado por el empleado.
			reporteempleados = contratoEJB.getMaximoNivelEducacionAlcanzado(reporteempleados);

			//Setea los datos de los salarios de cada contrato.
			reporteempleados = contratoEJB.getSalariosDeContratos(reporteempleados);
			
			byte[] archivoxlsbyte = escribirReporteExcel(reporteempleados,request, response);

			ServletOutputStream out = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition","attachment; filename=ReporteEmpleadoContrato_" + fechaActual + ".xls");
			out.write(archivoxlsbyte);
			out.flush();
			out.close();

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}


	/**
	 * Este método permite generar el reporte en excel de la informacion adicional(Propiedades,Afiliaciones,Cuentas Bancarias,Familia,Educacion) de los empleados.
	 * @param HttpServletRequest. La petición.
	 * @return HttpServletResponse. La respuesta.
	 * @author jpuentes
	 */
	public void generarReporteInfoAdicionalDeEmpleados(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {

			String[] estado = request.getParameterValues("idEstadoReporteEmpleadoInfoAdicional");
			List<String> listaEstados = new ArrayList<String>();
			List<ReporteInformacionAdicionalEmpleado> reporteInfoAdicional = new ArrayList<ReporteInformacionAdicionalEmpleado>();
			String fechaActual = Util.dateToString(new Date(), "yyyyMMddHHmmss");
			
			for (String idestado : estado) {
				if (!idestado.equals("null")) {
					if (!idestado.equals("")) {
						listaEstados.add(idestado);
					}
				} else {
					throw new LogicaException("Debe seleccionar un Estado.");
				}
			}
			
			//Obtenemos todos los empleados.
			List<EmpleadoBean> empleados = empleadoEJB.getEmpleados(listaEstados);
			
			//Le seteamos los bancos que tienen los anteriores empleados.
			reporteInfoAdicional = contratoEJB.obtenerBancosDeEmpleados(empleados);
			
			byte[] bytesDeArchivo = escribirReporteInformacionAdicional(reporteInfoAdicional,empleados, request, response);

			ServletOutputStream out = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition","attachment; filename=ReporteEmpleadoInformacionAdicional_" + fechaActual + ".xls");
			out.write(bytesDeArchivo);
			out.flush();
			out.close();

		} catch (Exception e) {
			logger.info("Error en reporte : "+e);
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	/**
	 * Este método permite generar el reporte en excel de los procesos disciplinarios de los empleados en su último contrato.
	 * @param HttpServletRequest. La petición.
	 * @return HttpServletResponse. La respuesta.
	 * @author jpuentes
	 */
	public void generarReporteProcesoDisciplinario(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {

			String[] estado = request.getParameterValues("idEstadoReporteProcesoDisciplinario");
			
			List<String> estados = new ArrayList<String>();
			List<ReporteEmpleado> reporteempleados = new ArrayList<ReporteEmpleado>();
			String fechaActual = Util.dateToString(new Date(), "yyyyMMddHHmmss");
						
			for (String idestado : estado) {
				if (!idestado.equals("null")) {
					if (!idestado.equals("")) {
						estados.add(idestado);
					}
				} else {
					throw new LogicaException("Debe seleccionar un Estado.");
				}

			}
			
			List<EmpleadoBean> empleados = empleadoEJB.getEmpleados(estados);
			
			// Setea los datos del ultimo contrato.
			reporteempleados = contratoEJB.getcontratoultimoempleadoporoEmpleados(empleados);
			
			byte[] archivoxlsbyte = escribirReporteProcesosDisciplinarios(reporteempleados,request, response);

			ServletOutputStream out = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition","attachment; filename=ReporteDisciplinario_" + fechaActual + ".xls");
			out.write(archivoxlsbyte);
			out.flush();
			out.close();

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
	
	public void empleadosreportehistorico(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {

			String[] estado = request
					.getParameterValues("idestadoREmpleadoHistorico");
			// String[] val = estado[0].split("\\s*,\\s*");
			List<String> estados = new ArrayList<String>();
			for (String idestado : estado) {
				if (!idestado.equals("null")) {
					if (!idestado.equals("")) {
						estados.add(idestado);
					}

				} else {
					throw new LogicaException("Debe seleccionar un Estado.");
				}

			}
			// request.setAttribute("estadoActivo",
			// EstadoEnum.ACTIVO.toString());
			// request.setAttribute("estadoDeshabilitaado",
			// EstadoEnum.DESHABILITADO.toString());
			List<EmpleadoBean> empleados = empleadoEJB.getEmpleados(estados);
//			ReporteEmpleado reporteempleado = new ReporteEmpleado();
			List<ReporteEmpleado> reporteempleados = new ArrayList<ReporteEmpleado>();
			reporteempleados = contratoEJB
					.getcontratosempleadoporoEmpleados(empleados);

			byte[] archivoxlsbyte = escribirReporteExcel(reporteempleados,
					request, response);
			String a = Util.dateToString(new Date(), "yyyyMMddHHmmss");
			ServletOutputStream out = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition",
					"attachment; filename=ReporteEmpleadoHistorico_" + a
							+ ".xls");
			out.write(archivoxlsbyte);
			out.flush();
			out.close();

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	public byte[] escribirReporteExcel(List<ReporteEmpleado> reporteempleados,HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
		
		FileOutputStream archivo;
		byte[] respu = null;
		
		try {

			HSSFWorkbook libro = new HSSFWorkbook();
			HSSFSheet hoja = libro.createSheet();
			List<String> encabezado = new ArrayList<String>();
			
			// Estilos Encabezado Fila
			HSSFFont fuenteEncabezado = libro.createFont();
			fuenteEncabezado.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFCellStyle estiloEncabezado = libro.createCellStyle();
			estiloEncabezado.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			estiloEncabezado.setFont(fuenteEncabezado);
			estiloEncabezado.setWrapText(false);
			estiloEncabezado.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
			estiloEncabezado.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			estiloEncabezado.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);

			int numFila = 0;
			HSSFRow filaHead = hoja.createRow(numFila);

			//Empleado
			encabezado.add("Estado empleado");
			encabezado.add("Tipo documento");
			encabezado.add("Número de identificación");
			encabezado.add("Ciudad Expedición");
			encabezado.add("Código del empleado");
			encabezado.add("Género");
			encabezado.add("Nombres");
			encabezado.add("Apellidos");
			encabezado.add("Fecha de nacimiento");

			//Contrato
			encabezado.add("Idcontrato");
			encabezado.add("Número contrato");
			encabezado.add("Tipo De Contrato");
			encabezado.add("fechafirma");
			encabezado.add("fechainicio");
			encabezado.add("fechafin");
			encabezado.add("Cargo");
			encabezado.add("Motivo del Retiro");
			encabezado.add("Estado contrato");
			
			//Salario
			/**
			 * Mostramos el salario para algunos grupos.
			 * Grupos:
			 * 212 - Vicepresidente RRHH / Interno
			 * 213 - Gerente RRHH / Interno
			 * 214 - Director RRHH / Interno
			 */
			if(idDeGrupo==212 || idDeGrupo==213 || idDeGrupo==214){
				encabezado.add("Salario : Moneda");
				encabezado.add("Salario : Monto");
			}
			
			//Ubicacion
			encabezado.add("Empresa");
			encabezado.add("Sucursal");
			encabezado.add("Área");
			encabezado.add("Área asignada");
			
			// Cuentas bancarias.
			encabezado.add("Banco");
			encabezado.add("Número Cuenta");
			
			//Afiliaciones
			encabezado.add("Última Afiliación EPS");
			encabezado.add("Última Afiliación EPS: Fecha Inicio");
			encabezado.add("Última Afiliación Cesantias");
			encabezado.add("Última Afiliación Cesantias: Fecha Inicio");
			encabezado.add("Última Afiliación Pensión");
			encabezado.add("Última Afiliación Pensión : Fecha Inicio");
			encabezado.add("Última Afiliación Caja Compensación");
			encabezado.add("Última Afiliación Caja CompCompensación : Fecha Inicio");
			
			//Educacion
			encabezado.add("Educación: Nivel");
			encabezado.add("Educación: Institución");
			encabezado.add("Educación: Título");
			encabezado.add("Educación: Fecha Inicio");
			encabezado.add("Educación: Fecha Fin");
			encabezado.add("Educación: Estado");
			
			
			
			int j = 0;
			for (String titulo : encabezado) {
				hoja.autoSizeColumn(j);
				hoja.setColumnWidth(j, 4000);
				HSSFCell celda = filaHead.createCell(j);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				j++;
			}
			/*
			 * hoja.setColumnWidth(0, 6700); //NombrePersona
			 * hoja.setColumnWidth(1, 6700); //Nombre
			 * 
			 * hoja.setColumnWidth(2, 4700); //Direccion hoja.setColumnWidth(3,
			 * 4700); //Telefono hoja.setColumnWidth(4, 10500); //Concecutivo
			 * hoja.setColumnWidth(5, 9500); //Ciudad hoja.setColumnWidth(6,
			 * 9500); //Asunto hoja.setColumnWidth(7, 7000); //Observacion
			 */

			numFila++;
			List<ReporteEmpleado> reporteList = reporteempleados;

			for (ReporteEmpleado reporte : reporteList) {
				HSSFRow fila = hoja.createRow(numFila);

				fillCellsReporte(reporte, fila, libro,user);
				hoja.autoSizeColumn((short) (numFila));
				numFila++;
			}

			String ruta = Constante.ROOT_FILE_TEMPORARY + File.separator
					+ "Reporte.xls";

			archivo = new FileOutputStream(ruta);
			libro.write(archivo);
			archivo.close();

			// Descarga del archivo
			File file = new File(ruta);
			if (!file.exists()) {

				throw new LogicaException("no se encuentra el archivo");

			} else {

				ByteArrayOutputStream baos = new ByteArrayOutputStream();

				FileInputStream inputStream = new FileInputStream(file);

				try {
					int c;
					while ((c = inputStream.read()) != -1) {
						baos.write(c);
					}
				} finally {
					if (inputStream != null)
						inputStream.close();

					baos.flush();
					baos.close();
				}

				respu = baos.toByteArray();

			}

		} catch (FileNotFoundException e) {

			e.printStackTrace();
			System.out.println("FileNotFoundException");
		} catch (IOException e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());

		}

		return respu;
	}

	
	/**
	 * Este metodo genera y escribe el reporte excel de informacion adicional de los empleados.
	 * @author jpuentes
	 * */
	public byte[] escribirReporteInformacionAdicional(List<ReporteInformacionAdicionalEmpleado> reporteInfoAdicionalEmpleados,List<EmpleadoBean> empleados,HttpServletRequest request, HttpServletResponse response) throws IOException {

		FileOutputStream archivo;
		byte[] respu = null;
		
		try {

			HSSFWorkbook libro = new HSSFWorkbook();
			
			HSSFSheet hojaCero = libro.createSheet();//Propiedades
			HSSFSheet hojaUno = libro.createSheet();//Cuentas
			HSSFSheet hojaDos = libro.createSheet();//Afiliacioines
			HSSFSheet hojaTres = libro.createSheet();//Educacion
			HSSFSheet hojaCuatro = libro.createSheet();//Familia
			HSSFSheet hojaCinco = libro.createSheet();//Documentos
			
			libro.setSheetName(libro.getSheetIndex(hojaCero), "Propiedades");
			libro.setSheetName(libro.getSheetIndex(hojaUno), "Cuentas Bancarias");
			libro.setSheetName(libro.getSheetIndex(hojaDos), "Afiliaciones");
			libro.setSheetName(libro.getSheetIndex(hojaTres), "Educación");
			libro.setSheetName(libro.getSheetIndex(hojaCuatro), "Familia");
			libro.setSheetName(libro.getSheetIndex(hojaCinco), "Documentos");
			
			List<String> encabezadoHojaCero = new ArrayList<String>();
			List<String> encabezado = new ArrayList<String>();
			List<String> encabezadoHojaDos = new ArrayList<String>();
			List<String> encabezadoHojaTres = new ArrayList<String>();
			List<String> encabezadoHojaCuatro = new ArrayList<String>();
			List<String> encabezadoHojaCinco = new ArrayList<String>();
			
			// Estilos Encabezado Fila
			HSSFFont fuenteEncabezado = libro.createFont();
			fuenteEncabezado.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFCellStyle estiloEncabezado = libro.createCellStyle();
			estiloEncabezado.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			estiloEncabezado.setFont(fuenteEncabezado);
			estiloEncabezado.setWrapText(false);
			estiloEncabezado.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
			estiloEncabezado.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			estiloEncabezado.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
//			---------------------------------------------------------------
//			Definición de estilos.
			HSSFCellStyle estilo = libro.createCellStyle();
			estilo.setWrapText(false);
			estilo.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
	
			HSSFCellStyle estiloFormato = libro.createCellStyle();
			estiloFormato.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
			HSSFDataFormat format = libro.createDataFormat();
			estiloFormato.setDataFormat(format.getFormat("#,##0"));
			
			int numFilaCero = 0;
			int numFila = 0;
			int numFilaHojaDos = 0;
			int numFilaHojatres = 0;
			int numFilaHojaCuatro = 0;
			int numFilaHojaCinco = 0;
			
			HSSFRow filaHeadCero = hojaCero.createRow(numFilaCero);
			HSSFRow filaHead = hojaUno.createRow(numFila);
			HSSFRow filaHeadDos = hojaDos.createRow(numFilaHojaDos);
			HSSFRow filaHeadTres = hojaTres.createRow(numFilaHojatres);
			HSSFRow filaHeadCuatro = hojaCuatro.createRow(numFilaHojaCuatro);
			HSSFRow filaHeadCinco = hojaCinco.createRow(numFilaHojaCinco);
			
			//Definicion de encabezados.
			//Hoja cEro: Propiedades
			encabezadoHojaCero.add("Estado Empleado");
			encabezadoHojaCero.add("Código Empleado");
			encabezadoHojaCero.add("Tipo Documento");
			encabezadoHojaCero.add("Número Identificación");
			encabezadoHojaCero.add("Nombres");
			encabezadoHojaCero.add("Apellidos");
			encabezadoHojaCero.add("Género");
			encabezadoHojaCero.add("Fecha Nacimiento");
			encabezadoHojaCero.add("Propiedad");
			encabezadoHojaCero.add("Prioridad");
			encabezadoHojaCero.add("Dato");
			encabezadoHojaCero.add("User Crea");
			encabezadoHojaCero.add("Fecha Crea");
			encabezadoHojaCero.add("User Mod");
			encabezadoHojaCero.add("Fecha mod");
			
			//Hoja uno: Cuentas Bancarias.
			encabezado.add("Estado Empleado");
			encabezado.add("Código Empleado");
			encabezado.add("Tipo Documento");
			encabezado.add("Número Identificación");
			encabezado.add("Nombres");
			encabezado.add("Apellidos");
			encabezado.add("Género");
			encabezado.add("Fecha Nacimiento");
			encabezado.add("Estado Cuenta Bancaria");
			encabezado.add("Banco");
			encabezado.add("Número Cuenta");
			encabezado.add("Vigente Desde");
			encabezado.add("User Crea");
			encabezado.add("Fecha Crea");
			encabezado.add("User Mod");
			encabezado.add("Fecha mod");
			
			//hoja Dos: Afiliaciones.
			encabezadoHojaDos.add("Estado Empleado");
			encabezadoHojaDos.add("Código Empleado");
			encabezadoHojaDos.add("Tipo Documento");
			encabezadoHojaDos.add("Número Identificación");
			encabezadoHojaDos.add("Nombres");
			encabezadoHojaDos.add("Apellidos");
			encabezadoHojaDos.add("Género");
			encabezadoHojaDos.add("Fecha Nacimiento");
			encabezadoHojaDos.add("Estado Afiliación");
			encabezadoHojaDos.add("Tipo Afiliación");
			encabezadoHojaDos.add("Entidad");
			encabezadoHojaDos.add("Fecha Inicio");
			encabezadoHojaDos.add("Fecha Fin");
			encabezadoHojaDos.add("User Crea");
			encabezadoHojaDos.add("Fecha Crea");
			encabezadoHojaDos.add("User Mod");
			encabezadoHojaDos.add("Fecha mod");
			
			//hoja tres: Educacion.
			encabezadoHojaTres.add("Estado Empleado");
			encabezadoHojaTres.add("Código Empleado");
			encabezadoHojaTres.add("Tipo Documento");
			encabezadoHojaTres.add("Número Identificación");
			encabezadoHojaTres.add("Nombres");
			encabezadoHojaTres.add("Apellidos");
			encabezadoHojaTres.add("Género");
			encabezadoHojaTres.add("Fecha Nacimiento");
			encabezadoHojaTres.add("Estado Educación");
			encabezadoHojaTres.add("Nivel");
			encabezadoHojaTres.add("Institución");
			encabezadoHojaTres.add("Título");
			encabezadoHojaTres.add("Carrera");
			encabezadoHojaTres.add("Fecha Inicio");
			encabezadoHojaTres.add("Fecha Fin");
			encabezadoHojaTres.add("Estado Nivel");
			encabezadoHojaTres.add("User Crea");
			encabezadoHojaTres.add("Fecha Crea");
			encabezadoHojaTres.add("User Mod");
			encabezadoHojaTres.add("Fecha mod");
			
			//hoja Cuatro: Familia.
			encabezadoHojaCuatro.add("Estado Empleado");
			encabezadoHojaCuatro.add("Código Empleado");
			encabezadoHojaCuatro.add("Tipo Documento");
			encabezadoHojaCuatro.add("Número Identificación");
			encabezadoHojaCuatro.add("Nombres");
			encabezadoHojaCuatro.add("Apellidos");
			encabezadoHojaCuatro.add("Género");
			encabezadoHojaCuatro.add("Fecha Nacimiento");
			encabezadoHojaCuatro.add("Estado Familia");
			encabezadoHojaCuatro.add("Parentesco");
			encabezadoHojaCuatro.add("Género");
			encabezadoHojaCuatro.add("Tipo Identificación");
			encabezadoHojaCuatro.add("Número Documento");
			encabezadoHojaCuatro.add("Nombre");
			encabezadoHojaCuatro.add("Apellidos");
			encabezadoHojaCuatro.add("Fecha Nacimiento familiar");			
			encabezadoHojaCuatro.add("User Crea");
			encabezadoHojaCuatro.add("Fecha Crea");
			encabezadoHojaCuatro.add("User Mod");
			encabezadoHojaCuatro.add("Fecha mod");
			
			//hoja Cinco: Documentos.
			encabezadoHojaCinco.add("Estado Empleado");
			encabezadoHojaCinco.add("Código Empleado");
			encabezadoHojaCinco.add("Tipo Documento");
			encabezadoHojaCinco.add("Número Identificación");
			encabezadoHojaCinco.add("Nombres");
			encabezadoHojaCinco.add("Apellidos");
			encabezadoHojaCinco.add("Género");
			encabezadoHojaCinco.add("Fecha Nacimiento");
			encabezadoHojaCinco.add("Estado Documento");
			encabezadoHojaCinco.add("Tipo Documento");
			encabezadoHojaCinco.add("Nombre Documento");
			encabezadoHojaCinco.add("User Crea");
			encabezadoHojaCinco.add("Fecha Crea");
			encabezadoHojaCinco.add("User Mod");
			encabezadoHojaCinco.add("Fecha mod");
			
			
			//Poner titulos Hoja Cero
			int jcero = 0;
			for (String titulo : encabezadoHojaCero) {
				hojaCero.autoSizeColumn(jcero);
				hojaCero.setColumnWidth(jcero, 4000);
				HSSFCell celda = filaHeadCero.createCell(jcero);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jcero++;
			}
			
			
			//Poner titulos Hoja Uno
			int j = 0;
			for (String titulo : encabezado) {
				hojaUno.autoSizeColumn(j);
				hojaUno.setColumnWidth(j, 4000);
				HSSFCell celda = filaHead.createCell(j);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				j++;
			}
			
			
			//Poner titulos Hoja dos
			int jdos = 0;
			for (String titulo : encabezadoHojaDos) {
				hojaDos.autoSizeColumn(jdos);
				hojaDos.setColumnWidth(jdos, 4000);
				HSSFCell celda = filaHeadDos.createCell(jdos);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jdos++;
			}
			
			//Poner titulos Hoja tres
			int jtres = 0;
			for (String titulo : encabezadoHojaTres) {
				hojaTres.autoSizeColumn(jtres);
				hojaTres.setColumnWidth(jtres, 4000);
				HSSFCell celda = filaHeadTres.createCell(jtres);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jtres++;
			}
			
			//Poner titulos Hoja cuatro
			int jcuatro = 0;
			for (String titulo : encabezadoHojaCuatro) {
				hojaCuatro.autoSizeColumn(jcuatro);
				hojaCuatro.setColumnWidth(jcuatro, 4000);
				HSSFCell celda = filaHeadCuatro.createCell(jcuatro);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jcuatro++;
			}
			
			//Poner titulos Hoja cinco
			int jcinco = 0;
			for (String titulo : encabezadoHojaCinco) {
				hojaCinco.autoSizeColumn(jcinco);
				hojaCinco.setColumnWidth(jcinco, 4000);
				HSSFCell celda = filaHeadCinco.createCell(jcinco);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jcinco++;
			}
			
			//Escribir hoja cero
			List<ReporteInformacionAdicionalEmpleado> propiedades = contratoEJB.obtenerPropiedadesDeEmpleados(empleados);
			numFilaCero++;
			for (ReporteInformacionAdicionalEmpleado reporte : propiedades) {
				HSSFRow fila = hojaCero.createRow(numFilaCero);
				escribirCeldasReporteInfoAdicionalHojaCero(reporte, fila, libro,estilo,estiloFormato);
				hojaCero.autoSizeColumn((short) (numFilaCero));
				numFilaCero++;
			}
			
			//Escribir hoja uno
			numFila++;
			for (ReporteInformacionAdicionalEmpleado reporte : reporteInfoAdicionalEmpleados) {
				HSSFRow fila = hojaUno.createRow(numFila);
				escribirCeldasReporteInfoAdicional(reporte, fila, libro);
				hojaUno.autoSizeColumn((short) (numFila));
				numFila++;
			}
			
			
			// Escribir la hoja dos
			List<ReporteInformacionAdicionalEmpleado> datosAfiliaciones = contratoEJB.obtenerTodasLasAfiliacionesDeEmpelados(empleados);
			
			numFilaHojaDos++;
			for (ReporteInformacionAdicionalEmpleado reporte : datosAfiliaciones) {
				HSSFRow fila = hojaDos.createRow(numFilaHojaDos);
				escribirCeldasReporteInfoAdicionalHojaDos(reporte, fila, libro,estilo,estiloFormato);
				hojaDos.autoSizeColumn((short) (numFilaHojaDos));
				numFilaHojaDos++;
			}


			// Escribir la hoja tres
			List<ReporteInformacionAdicionalEmpleado> datosEducacion = contratoEJB.obtenerEducacionDeEmpleados(empleados);
			numFilaHojatres++;			
			for (ReporteInformacionAdicionalEmpleado reporte : datosEducacion) {
				HSSFRow fila = hojaTres.createRow(numFilaHojatres);
				escribirCeldasReporteInfoAdicionalHojaTres(reporte, fila, libro,estilo,estiloFormato);
				hojaTres.autoSizeColumn((short) (numFilaHojatres));
				numFilaHojatres++;
			}			
			
			// Escribir la hoja cuatro
			List<ReporteInformacionAdicionalEmpleado> datosFamilia = contratoEJB.obtenerFamiliaDeEmpleados(empleados);
			numFilaHojaCuatro++;			
			for (ReporteInformacionAdicionalEmpleado reporte : datosFamilia) {
				HSSFRow fila = hojaCuatro.createRow(numFilaHojaCuatro);
				escribirCeldasReporteInfoAdicionalHojaCuatro(reporte, fila, libro,estilo,estiloFormato);
				hojaCuatro.autoSizeColumn((short) (numFilaHojaCuatro));
				numFilaHojaCuatro++;
			}						
						
			// Escribir la hoja cinco
			List<ReporteInformacionAdicionalEmpleado> datosDocumentos = contratoEJB.obtenerDocumentosDeEmpleados(empleados);
			numFilaHojaCinco++;			
			for (ReporteInformacionAdicionalEmpleado reporte : datosDocumentos) {
				HSSFRow fila = hojaCinco.createRow(numFilaHojaCinco);
				escribirCeldasReporteInfoAdicionalHojaCinco(reporte, fila, libro,estilo,estiloFormato);
				hojaCinco.autoSizeColumn((short) (numFilaHojaCinco));
				numFilaHojaCinco++;
			}				
			
			
			String ruta = Constante.ROOT_FILE_TEMPORARY + File.separator
					+ "Reporte.xls";

			
			archivo = new FileOutputStream(ruta);
			libro.write(archivo);
			archivo.close();
			
			// Descarga del archivo
			File file = new File(ruta);
			if (!file.exists()) {

				throw new LogicaException("no se encuentra el archivo");

			} else {

				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				FileInputStream inputStream = new FileInputStream(file);

				try {
					int c;
					while ((c = inputStream.read()) != -1) {
						baos.write(c);
					}
				} finally {
					if (inputStream != null)
						inputStream.close();

					baos.flush();
					baos.close();
				}

				respu = baos.toByteArray();

			}

		} catch (FileNotFoundException e) {

			e.printStackTrace();
			System.out.println("FileNotFoundException");
		} catch (IOException e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());

		}
		return respu;
	}
	
	
	/**
	 * LLena las filas con la información.
	 * 
	 * @param ReporteEmpleado. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void fillCellsReporte(ReporteEmpleado reporte, HSSFRow fila,HSSFWorkbook libro,UsuarioBean user) throws ParseException {
		
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
		
		int i = 0;
		HSSFCellStyle estilo = libro.createCellStyle();
		estilo.setWrapText(false);
		estilo.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		estilo.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		estilo.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		estilo.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);

		HSSFCellStyle estiloFormato = libro.createCellStyle();
		estiloFormato.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		estiloFormato.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		estiloFormato.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		estiloFormato.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		HSSFDataFormat format = libro.createDataFormat();
		estiloFormato.setDataFormat(format.getFormat("#,##0"));

		// estado
		HSSFCell celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String estado = (reporte.getEmpleado().getEstado().toString());
		String estadon = "";
		if (estado.equals("2")) {
			estadon = "ACTIVO";
		} else if (estado.equals("3")) {
			estadon = "DESHABILITADO";
		}
		celda.setCellValue(estadon);		
		
		// tipoidentificacion
		i++;
		 celda = fila.createCell(i);
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String tipoid = (String) (reporte.getEmpleado().getIdentificaciontipo()
				.getTipo() != null ? reporte.getEmpleado()
				.getIdentificaciontipo().getTipo() : "");
		celda.setCellValue(tipoid);

		// numeroidentifiacion
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String numeroid = (String) (reporte.getEmpleado()
				.getEmpleadoidentificacion().getNumeroidentificacion() != null ? reporte
				.getEmpleado().getEmpleadoidentificacion()
				.getNumeroidentificacion()
				: "");
		celda.setCellValue(numeroid);

		// ciudad
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String ciudad = (String) (reporte.getEmpleado()
				.getEmpleadoidentificacion().getCiudadexpedicion() != null ? reporte
				.getEmpleado().getEmpleadoidentificacion()
				.getCiudadexpedicion()
				: "");
		celda.setCellValue(ciudad);

		// codigo
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String codigo = (String) (reporte.getEmpleado().getCodempleado() != null ? reporte
				.getEmpleado().getCodempleado() : "");
		celda.setCellValue(codigo);

		// genero
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String genero = (String) (reporte.getEmpleado().getGenero()
				.getNombregenero() != null ? reporte.getEmpleado().getGenero()
				.getNombregenero() : "");
		celda.setCellValue(genero);

		// nombres
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String nombre = (String) (reporte.getEmpleado().getNombres() != null ? reporte
				.getEmpleado().getNombres() : "");
		celda.setCellValue(nombre);

		// apellido
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String apellido = (String) (reporte.getEmpleado().getApellidos() != null ? reporte
				.getEmpleado().getApellidos() : "");
		celda.setCellValue(apellido);

		// fechanacimiento
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String fechanacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
		if(fechanacimiento!=""){
			celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechanacimiento)));
		}else{
			celda.setCellValue("");
		}
		//celda.setCellValue(fechanacimiento);

		

		// id contrato
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String contrato = (reporte.getContrato().getIdcontrato() != null ? reporte
				.getContrato().getIdcontrato() : "").toString();
		celda.setCellValue(contrato);

		// numerocontrato
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String numerocontrato = (String) (reporte.getContrato()
				.getNumerocontrato() != null ? reporte.getContrato()
				.getNumerocontrato() : "");
		celda.setCellValue(numerocontrato);

		//Tipo de contrato
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		
		ContratoTipo tipoDeContrato = reporte.getContrato().getContratotipo();
		
		if (tipoDeContrato != null) {
			String tipoContrato = tipoDeContrato.getNombrecontratotipo();
			if (tipoContrato != null) {
				celda.setCellValue(tipoContrato);
			}
		} else {
			celda.setCellValue("");
		}		
		
		// fechafirma
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String fechafirma = Util.timestampToString((reporte.getContrato().getFechafirma()), "dd/MM/yyyy");
		if(fechafirma!=""){
			celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechafirma)));
		}else{
			celda.setCellValue("");
		}
		//celda.setCellValue(fechafirma);

		// fechainicio
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String fechainicio = Util.timestampToString((reporte.getContrato().getFechainicio()), "dd/MM/yyyy");
		if(fechainicio!=""){
			celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechainicio)));
		}else{
			celda.setCellValue("");
		}
//		celda.setCellValue(fechainicio);

		// fefchafin
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String fefchafin = Util.timestampToString((reporte.getContrato().getFechafin()), "dd/MM/yyyy");
		if(fefchafin!=""){
			celda.setCellValue(formatoFecha.format(formatoFecha.parse(fefchafin)));
		}else{
			celda.setCellValue("");
		}
//		celda.setCellValue(fefchafin);
		
		// cargo
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String cargo = (String) (reporte.getContrato().getCargo()
				.getNombrecargo() != null ? reporte.getContrato().getCargo()
				.getNombrecargo() : "");
		celda.setCellValue(cargo);

		// motivo
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String motivo = (String) (reporte.getContrato().getRetiromotivo()
				.getNombremotivo() != null ? reporte.getContrato()
				.getRetiromotivo().getNombremotivo() : "");
		celda.setCellValue(motivo);

		// estado
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String estadocon = (reporte.getContrato().getEstado().toString());
		String estadoconn = "";
		if (estadocon.equals("2")) {
			estadoconn = "ACTIVO";
		} else if (estadocon.equals("3")) {
			estadoconn = "DESHABILITADO";
		}
		celda.setCellValue(estadoconn);
		
		//Salario
		/**
		 * Mostramos el salario para algunos grupos.
		 * Grupos:
		 * 212 - Vicepresidente RRHH / Interno
		 * 213 - Gerente RRHH / Interno
		 * 214 - Director RRHH / Interno
		 */
		if(idDeGrupo==212 || idDeGrupo==213 || idDeGrupo==214){
			//Moneda
			i++;
			celda = fila.createCell(i);
			celda.setCellStyle(estilo);
			
			TipoMoneda tipoDeMoneda = reporte.getTipoDemoneda();
			
			if (tipoDeMoneda != null) {
				String moneda = tipoDeMoneda.getNombretipomoneda();
				if ( moneda != null) {
					celda.setCellValue(moneda);
				}
			} else {
				celda.setCellValue("");
			}
			
			//Monto
			i++;
			celda = fila.createCell(i);
			celda.setCellStyle(estilo);
			
			EmpleadoSalario empleadoSalario = reporte.getEmpleadoSalario();
			
			if (empleadoSalario != null) {
				String montoSalarial = empleadoSalario.getSalario();
				if ( montoSalarial != null) {
					celda.setCellValue(montoSalarial);
				}
			} else {
				celda.setCellValue("");
			}
		}
		

		// empresa
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String empresa = (String) (reporte.getContrato().getEmpresa()
				.getNombreempresa() != null ? reporte.getContrato()
				.getEmpresa().getNombreempresa() : "");
		celda.setCellValue(empresa);

		// sucursal
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String sucursal = (String) (reporte.getContrato().getSucursal()
				.getNombresucursal() != null ? reporte.getContrato()
				.getSucursal().getNombresucursal() : "");
		celda.setCellValue(sucursal);

		// area
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String area = (String) (reporte.getContrato().getArea().getNombrearea() != null ? reporte
				.getContrato().getArea().getNombrearea()
				: "");
		celda.setCellValue(area);
		// area asiganda
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		String areaasignada = (String) (reporte.getContrato().getAreaasignada()
				.getNombrearea() != null ? reporte.getContrato()
				.getAreaasignada().getNombrearea() : "");
		celda.setCellValue(areaasignada);
		
		

		// Banco
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);

		Banco banco = reporte.getBanco();

		if (banco != null) {
			String nombreBanco = (String) banco.getNombrebanco();
			if (banco.equals("") || banco == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(nombreBanco);
			}
		} else {
			celda.setCellValue("");
		}

		// Número de cuenta bancaria.
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoBanco empleadoBanco = reporte.getEmpleadoBanco();

		if (empleadoBanco != null) {
			String numeroCuenta = (String) empleadoBanco.getNumerocuenta();
			if (numeroCuenta.equals("") || numeroCuenta == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(numeroCuenta);
			}
		} else {
			celda.setCellValue("");
		}

		// Afiliación SALUD
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		AfiliacionEntidad afiliacionEntidadSalud = reporte
				.getAfiliacionEntidadSalud();

		if (afiliacionEntidadSalud != null) {
			String nombreEntidadSalud = afiliacionEntidadSalud.getNombreentidad();
			if (nombreEntidadSalud.equals("") || nombreEntidadSalud == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(nombreEntidadSalud);
			}
		} else {
			celda.setCellValue("");
		}

//		Fecha de inicio afiliacion salud
		
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoAfiliacion empleadoAfiliacionSalud = reporte.getEmpleadoAfiliacionSalud();

		if (empleadoAfiliacionSalud != null) {
			String fechaInicioAfiliacionSalud = Util.timestampToString((empleadoAfiliacionSalud.getFechainicio()),"dd/MM/yyyy");
			
			if (fechaInicioAfiliacionSalud.equals("") || fechaInicioAfiliacionSalud == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicioAfiliacionSalud)));
			}
		} else {
			celda.setCellValue("");
		}
		
		
		
		// Afiliación CESANTIAS
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		AfiliacionEntidad afiliacionEntidadCesantias = reporte.getAfiliacionEntidadCesantias();

		if (afiliacionEntidadCesantias != null) {
			String nombreEntidadCesantias = afiliacionEntidadCesantias
					.getNombreentidad();
			if (nombreEntidadCesantias.equals("") || nombreEntidadCesantias == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(nombreEntidadCesantias);
			}
		} else {
			celda.setCellValue("");
		}
		
		
		//Fecha de inicio - Afiliacion cesantias.
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoAfiliacion empleadoAfiliacionCesantias = reporte.getEmpleadoAfiliacionCesantias();

		if (empleadoAfiliacionCesantias != null) {
			String fechaInicioAfiliacionCesantias = Util.timestampToString((empleadoAfiliacionCesantias.getFechainicio()),"dd/MM/yyyy");
			
			if (fechaInicioAfiliacionCesantias.equals("") || fechaInicioAfiliacionCesantias == null) {
				celda.setCellValue("");
			} else {
//				celda.setCellValue(fechaInicioAfiliacionCesantias);
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicioAfiliacionCesantias)));
			}
		} else {
			celda.setCellValue("");
		}
		
		// Afiliación PENSION
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		AfiliacionEntidad afiliacionEntidadPension = reporte.getAfiliacionEntidadPension();

		if (afiliacionEntidadPension != null) {
			String nombreEntidadPension = afiliacionEntidadPension.getNombreentidad();
			if (nombreEntidadPension.equals("") || nombreEntidadPension == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(nombreEntidadPension);
			}
		} else {
			celda.setCellValue("");
		}
		
		//Fecha de inicio - Afiliacion PENSION.
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoAfiliacion empleadoAfiliacionPension = reporte.getEmpleadoAfiliacionPension();

		if (empleadoAfiliacionPension != null) {
			String fechaInicioAfiliacionPension = Util.timestampToString((empleadoAfiliacionPension.getFechainicio()),"dd/MM/yyyy");
			
			if (fechaInicioAfiliacionPension.equals("") || fechaInicioAfiliacionPension == null) {
				celda.setCellValue("");
			} else {
//				celda.setCellValue(fechaInicioAfiliacionPension);
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicioAfiliacionPension)));
			}
		} else {
			celda.setCellValue("");
		}		
		
		
		
		// Afiliación Caja de compensación.
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		AfiliacionEntidad afiliacionEntidadCajaCompensacion = reporte.getAfiliacionEntidadCajaCompensacion();

		if (afiliacionEntidadCajaCompensacion != null) {
			String nombreEntidadCajaCompensacion = afiliacionEntidadPension.getNombreentidad();
			if (nombreEntidadCajaCompensacion.equals("") || nombreEntidadCajaCompensacion == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(nombreEntidadCajaCompensacion);
			}
		} else {
			celda.setCellValue("");
		}
		
		//Fecha de inicio - Afiliación caja de compensación.
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoAfiliacion empleadoAfiliacionCaja= reporte.getEmpleadoAfiliacionCajaCompensacion();

		if (empleadoAfiliacionCaja != null) {
			String fechaInicioAfiliacionCaja = Util.timestampToString((empleadoAfiliacionCaja.getFechainicio()),"dd/MM/yyyy");
			if (fechaInicioAfiliacionCaja.equals("") || fechaInicioAfiliacionCaja == null) {
				celda.setCellValue("");
			} else {
//				celda.setCellValue(fechaInicioAfiliacionCaja);
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicioAfiliacionCaja)));
			}
		} else {
			celda.setCellValue("");
		}
		
		
		// Nivel Edcucativo
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EducacionNivel educacionNivel = reporte.getEducacionNivel();
		
		if (educacionNivel != null) {
			String nivel = educacionNivel.getNombreEducacionNivel();
			
			if (nivel.equals("") || nivel == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(nivel);
			}
		} else {
			celda.setCellValue("");
		}
		
		// Institución Educativa
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoEducacion empleadoEducacion = reporte.getEmpleadoEducacion();
				
		if (empleadoEducacion != null) {
			String institucion = empleadoEducacion.getInstitucion();					
			if (institucion.equals("") || institucion == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(institucion);
			}
		} else {
			celda.setCellValue("");
		}
		
		// Titulo
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoEducacion empleadoEducacionTitulo = reporte.getEmpleadoEducacion();
				
		if (empleadoEducacionTitulo != null) {
			String titulo = empleadoEducacionTitulo.getTitulo();				
			if (titulo.equals("") || titulo == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(titulo);
			}
		} else {
			celda.setCellValue("");
		}
		
		//Educación : Fecha Inicio 
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoEducacion empleadoEducacionFechaInicio = reporte.getEmpleadoEducacion();
				
		if (empleadoEducacionFechaInicio != null) {
			
			String fechaInicio = Util.timestampToString((empleadoEducacionFechaInicio.getFechaInicio()),"dd/MM/yyyy");	
			
			if (fechaInicio.equals("") || fechaInicio == null) {
				celda.setCellValue("");
			} else {
				celda.setCellValue(fechaInicio);
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicio)));
			}
		} else {
			celda.setCellValue("");
		}
		
		//Fecha Fin
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoEducacion empleadoEducacionFechaFin = reporte.getEmpleadoEducacion();
				
		if (empleadoEducacionFechaFin != null) {
			String fechaFin = Util.timestampToString((empleadoEducacionFechaInicio.getFechafin()),"dd/MM/yyyy");
			if (fechaFin.equals("") || fechaFin == null) {
				celda.setCellValue("");
			} else {
//				celda.setCellValue(fechaFin);
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaFin)));
			}
		} else {
			celda.setCellValue("");
		}
		
		//Estado Educacion
		i++;
		celda = fila.createCell(i);
		celda.setCellStyle(estilo);
		EmpleadoEducacion empleadoEducacionEstado = reporte.getEmpleadoEducacion();
		
		
		if (empleadoEducacionEstado != null) {
			String estadoEducacion = ""+empleadoEducacionEstado.getIdEducacionEstado();
			if ( estadoEducacion != null) {
				if(Integer.parseInt(estadoEducacion)==1){
					celda.setCellValue("CULMINADO");
				}else{
					celda.setCellValue("INCOMPLETO");
				}
			}
		} else {
			celda.setCellValue("");
		}
		
		
		
	}

	
	public void empleadosreportedesvinculacion(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String desde = request.getParameter("Dfrom");
			String hasta = request.getParameter("Dto");
			String nombre = request.getParameter("Dnombre");
			String numidentificacion = request.getParameter("Dnumidentificacion");
			String usuario = request.getParameter("Dusuario");
			String codusuario = request.getParameter("codusuario");
			String idaplicacion = request.getParameter("idaplicacion");
			String idgrupo = request.getParameter("idgrupo");
			String idcuenta = request.getParameter("idcuenta");
			String tipobusqueda = request.getParameter("Dtipobusqueda");

			nombre = nombre == null ? "" : nombre;
			numidentificacion = numidentificacion == null ? ""
					: numidentificacion;
			usuario = usuario == null ? "" : usuario;
			codusuario = codusuario == null ? "" : codusuario;
			idaplicacion = idaplicacion == null ? "" : idaplicacion;
			idgrupo = idgrupo == null ? "" : idgrupo;
			idcuenta = idcuenta == null ? "" : idcuenta;

			tipobusqueda = tipobusqueda == null ? "" : tipobusqueda;
			desde = desde == null ? "" : Util.stringToString(desde.trim(),
					"dd/MM/yyyy", "yyyyMMdd");
			hasta = hasta == null ? "" : Util.stringToString(hasta.trim(),
					"dd/MM/yyyy", "yyyyMMdd");

			UsuarioTipoBusquedaEnum tipobus = UsuarioTipoBusquedaEnum
					.get(Integer.parseInt(tipobusqueda));

			String valor = "";
			if (tipobus.getIndex() == UsuarioTipoBusquedaEnum.FECHA_CREACION
					.getIndex()) {
			} else if (tipobus.getIndex() == EmpleadoTipoBusquedaEnum.NOMBRE
					.getIndex()) {
				valor = nombre;
			} else if (tipobus.getIndex() == EmpleadoTipoBusquedaEnum.NUMIDENTIFICACION
					.getIndex()) {
				valor = numidentificacion;
			}
			List<EmpleadoDesvinculacion> empleados = reportesEJB.buscarEmpleadosdesvinculacion(desde, hasta, valor, tipobus);
			List<Proceso> procesos = desvinculacionEJB.getAllProcesos();
			request.setAttribute("empleados", empleados);
			request.setAttribute("procesos", procesos);
			request.getRequestDispatcher("../pages/reportes/desvinculacion_empleado_lista.jsp").forward(request, response);

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	
	
	/**
	 * LLena las filas con la información. En la hoja cuatro de DOCUMENTOS.
	 * 
	 * @param ReporteInformacionAdicionalEmpleado. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteInfoAdicionalHojaCero(ReporteInformacionAdicionalEmpleado reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		

//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue(fechaNacimiento);
			}
		}catch(Exception e){
//			fechaNacimiento="";
			celda.setCellValue("");
		}
				
//
//		encabezadoHojaCero.add("Propiedad");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String propiedad = reporte.getPropiedad().getNombrepropiedad();
		celda.setCellValue(propiedad);	
		
//		encabezadoHojaCero.add("Prioridad");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String prioridad = reporte.getPrioridad().getNombreprioridad();
		celda.setCellValue(prioridad);	
		
//		encabezadoHojaCero.add("Dato");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String dato = reporte.getEmpleadoPropiedad().getDato();
		celda.setCellValue(dato);
		
//		encabezadoHojaDos.add("User Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userCrea = reporte.getEmpleadoPropiedad().getIdusuariocrea();
		if(userCrea!=null){
			celda.setCellValue(userCrea);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha crea");	
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaCrea = ""; 
		try{	
			fechaCrea = Util.timestampToString((reporte.getEmpleadoPropiedad().getFechacrea()), "dd/MM/yyyy");
			if(fechaCrea!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaCrea)));
			}else{
				celda.setCellValue(fechaCrea);
			}
		}catch(Exception e){
//			fechaCrea="";
			celda.setCellValue("");
		}
		
		
//		encabezado.add("User Mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userMod = reporte.getEmpleadoPropiedad().getIdusuariomod();
		if(userMod!=null){
			celda.setCellValue(userMod);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha mod")
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaMod = ""; 
		try{	
			fechaMod = Util.timestampToString((reporte.getEmpleadoPropiedad().getFechamod()), "dd/MM/yyyy");
			if(fechaMod!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaMod)));
			}else{
				celda.setCellValue(fechaMod);
			}
		}catch(Exception e){
			celda.setCellValue("");
//			fechaMod="";
		}
		
	}
	
	
	/**
	 * LLena las filas con la información.
	 * 
	 * @param ReporteInformacionAdicionalEmpleado. Los datos de BANCOS del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteInfoAdicional(ReporteInformacionAdicionalEmpleado reporte, HSSFRow fila,HSSFWorkbook libro) throws ParseException {

//		CreationHelper createHelper = libro.getCreationHelper();
//		HSSFCellStyle cellStyle = libro.createCellStyle();
//	    cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("d/m/yy"));
		
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		int i = 0;
//		HSSFCellStyle estilo = libro.createCellStyle();
//		estilo.setWrapText(false);
//		estilo.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
//		estilo.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
//		estilo.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
//		estilo.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
//
//		HSSFCellStyle estiloFormato = libro.createCellStyle();
//		estiloFormato.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
//		estiloFormato.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
//		estiloFormato.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
//		estiloFormato.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
//		HSSFDataFormat format = libro.createDataFormat();
//		estiloFormato.setDataFormat(format.getFormat("#,##0"));

		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}

//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue(fechaNacimiento);
			}
		}catch(Exception e){
			celda.setCellValue("");
			
		}
		//celda.setCellValue(fechaNacimiento);
		
//		encabezado.add("Estado Cuenta Bancaria");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoCuenta = reporte.getEmpleadoBanco().getEstado();
		if(estadoCuenta!=null){
			if(estadoCuenta==2){
				celda.setCellValue("ACTIVA");
			}else if(estadoCuenta==3){
				celda.setCellValue("DESHABILITADA");
			}
		}else{
			celda.setCellValue("");
		}
		
		
//		encabezado.add("Banco");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombreBanco = reporte.getBanco().getNombrebanco();
		
		if(nombreBanco!=null && nombreBanco!=""){
			celda.setCellValue(nombreBanco);
		}else{
			celda.setCellValue("");
		}
		
		
		
//		encabezado.add("Número Cuenta");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroCuenta = reporte.getEmpleadoBanco().getNumerocuenta();
		
		if(numeroCuenta!=null && numeroCuenta!=""){
			celda.setCellValue(numeroCuenta);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Vigente Desde");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String vigenteDesde = "";
		try{
			vigenteDesde = Util.timestampToString((reporte.getEmpleadoBanco().getVigentedesde()), "dd/MM/yyyy");
			if(vigenteDesde!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(vigenteDesde)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
//			vigenteDesde = "";	
			celda.setCellValue("");
		}
		
		
//		encabezado.add("User Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userCrea = reporte.getEmpleadoBanco().getIdusuariocrea();
		
		if(userCrea!=null){
			celda.setCellValue(userCrea);
		}else{
			celda.setCellValue("");
		}
		
		
//		encabezado.add("Fecha Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaCrea ="";
		try{
			fechaCrea = Util.timestampToString((reporte.getEmpleadoBanco().getFechacrea()), "dd/MM/yyyy");
			if(fechaCrea!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaCrea)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
//		encabezado.add("User Mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userMod = reporte.getEmpleadoBanco().getIdusuariomod();
		if(userMod!=null){
			celda.setCellValue(userMod);
		}else{
			celda.setCellValue("");
		}
		
		
//		encabezado.add("Fecha mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaMod = ""; 
		try{	
			fechaMod = Util.timestampToString((reporte.getEmpleadoBanco().getFechamod()), "dd/MM/yyyy");
			if(fechaMod!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaMod)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
	}
	
	
	/**
	 * LLena las filas con la información. En la hoja dos de AFILIACIONES.
	 * 
	 * @param ReporteInformacionAdicionalEmpleado. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	
	private void escribirCeldasReporteInfoAdicionalHojaDos(ReporteInformacionAdicionalEmpleado reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

//		CreationHelper createHelper = libro.getCreationHelper();
//		HSSFCellStyle cellStyle = libro.createCellStyle();
//	    cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("d/m/yy"));
		
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		

//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		

//		encabezadoHojaDos.add("Estado Afiliación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoAfiliacion = reporte.getEmpleadoAfiliacion().getEstado();
		if(estadoAfiliacion==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoAfiliacion==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
//		encabezadoHojaDos.add("Tipo Afiliación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoAfiliacion = reporte.getAfiliacionTipo().getTipoafiliacion();
		celda.setCellValue(tipoAfiliacion);	
		
//		encabezadoHojaDos.add("Entidad");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String entidadAfiliacion = reporte.getAfiliacionEntidad().getNombreentidad();
		celda.setCellValue(entidadAfiliacion);	
		
//		encabezadoHojaDos.add("Fecha Inicio");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaInicio="";
		try{
			fechaInicio = Util.timestampToString((reporte.getEmpleadoAfiliacion().getFechainicio()), "dd/MM/yyyy");
			if(fechaInicio!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicio)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
//		encabezadoHojaDos.add("Fecha Fin");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaFin="";
		try{
			fechaFin = Util.timestampToString((reporte.getEmpleadoAfiliacion().getFechafin()), "dd/MM/yyyy");
			if(fechaFin!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaFin)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
//		encabezadoHojaDos.add("User Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userCrea = reporte.getEmpleadoAfiliacion().getIdusuariocrea();
		if(userCrea!=null){
			celda.setCellValue(userCrea);
		}else{
			celda.setCellValue("");
		}
//		encabezado.add("Fecha crea");	
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaCrea = ""; 
		try{	
			fechaCrea = Util.timestampToString((reporte.getEmpleadoAfiliacion().getFechacrea()), "dd/MM/yyyy");
			if(fechaCrea!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaCrea)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
//		encabezado.add("User Mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userMod = reporte.getEmpleadoAfiliacion().getIdusuariomod();
		if(userMod!=null){
			celda.setCellValue(userMod);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha mod")
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaMod = ""; 
		try{	
			fechaMod = Util.timestampToString((reporte.getEmpleadoAfiliacion().getFechamod()), "dd/MM/yyyy");
			if(fechaMod!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaMod)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
	}
	
	/**
	 * LLena las filas con la información. En la hoja tres de EDUCACION.
	 * 
	 * @param ReporteInformacionAdicionalEmpleado. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteInfoAdicionalHojaTres(ReporteInformacionAdicionalEmpleado reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

//		CreationHelper createHelper = libro.getCreationHelper();
//		HSSFCellStyle cellStyle = libro.createCellStyle();
//	    cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("d/m/yy"));
		
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		

//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}

		
//		encabezadoHojaTres.add("Estado Educación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEducacion = reporte.getEmpleadoEducacion().getEstado();
		if(estadoEducacion==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEducacion==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		
		
//		encabezadoHojaTres.add("Nivel");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nivel = reporte.getEducacionNivel().getNombreEducacionNivel();
		celda.setCellValue(nivel);	
		
		
//		encabezadoHojaTres.add("Institución");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String institucion = reporte.getEmpleadoEducacion().getInstitucion();
		celda.setCellValue(institucion);	
		
//		encabezadoHojaTres.add("Título");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String titulo = reporte.getEmpleadoEducacion().getTitulo();
		celda.setCellValue(titulo);
		
		
		
//		encabezadoHojaTres.add("Carrera");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String carrera = reporte.getEmpleadoEducacion().getCarrera();
		celda.setCellValue(carrera);
		
		
		
//		encabezadoHojaTres.add("Fecha Inicio");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaInicio="";
		try{
			fechaInicio = Util.timestampToString((reporte.getEmpleadoEducacion().getFechaInicio()), "dd/MM/yyyy");
			if(fechaInicio!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaInicio)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		

//		encabezadoHojaTres.add("Fecha Fin");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaFin="";
		try{
			fechaFin = Util.timestampToString((reporte.getEmpleadoEducacion().getFechafin()), "dd/MM/yyyy");
			if(fechaFin!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaFin)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
//		encabezadoHojaTres.add("Estado Nivel");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String estadoNivel = reporte.getEducacionNivel().getNombreEducacionNivel();
		celda.setCellValue(estadoNivel);
		
		
		
//		encabezadoHojaDos.add("User Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userCrea = reporte.getEmpleadoEducacion().getIdusuariocrea();
		if(userCrea!=null){
			celda.setCellValue(userCrea);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha crea");	
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaCrea = ""; 
		try{	
			fechaCrea = Util.timestampToString((reporte.getEmpleadoEducacion().getFechacrea()), "dd/MM/yyyy");
			if(fechaCrea!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaCrea)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
//		encabezado.add("User Mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userMod = reporte.getEmpleadoEducacion().getIdusuariomod();
		if(userMod!=null){
			celda.setCellValue(userMod);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha mod")
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaMod = ""; 
		try{	
			fechaMod = Util.timestampToString((reporte.getEmpleadoEducacion().getFechamod()), "dd/MM/yyyy");
			if(fechaMod!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaMod)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
	}
	

	/**
	 * LLena las filas con la información. En la hoja cuatro de FAMILIA.
	 * 
	 * @param ReporteInformacionAdicionalEmpleado. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteInfoAdicionalHojaCuatro(ReporteInformacionAdicionalEmpleado reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		
//		CreationHelper createHelper = libro.getCreationHelper();
//		HSSFCellStyle cellStyle = libro.createCellStyle();
//	    cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("d/m/yy"));
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		

//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}


//		encabezadoHojaCuatro.add("Estado Familia");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoFamilia = reporte.getEmpleadoFamilia().getEstado();
		if(estadoFamilia==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoFamilia==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
//		encabezadoHojaCuatro.add("Parentesco");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String parentescoFamilia = reporte.getParentesco().getNombreparentesco();
		celda.setCellValue(parentescoFamilia);	
		
//		encabezadoHojaCuatro.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String generoFamilia = reporte.getGenero().getNombregenero();
		celda.setCellValue(generoFamilia);	
		
//		encabezadoHojaCuatro.add("Tipo Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoIdentificacionFamilia = reporte.getTipoId().getTipo();
		celda.setCellValue(tipoIdentificacionFamilia);
		
//		encabezadoHojaCuatro.add("Número Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroDocumentoFamilia = reporte.getEmpleadoFamilia().getNumeroIdentificacion();
		celda.setCellValue(numeroDocumentoFamilia);
		
//		encabezadoHojaCuatro.add("Nombre");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombreFamilia = reporte.getEmpleadoFamilia().getNombrefamilia();
		celda.setCellValue(nombreFamilia);
		
//		encabezadoHojaCuatro.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidoFamilia = reporte.getEmpleadoFamilia().getApellidoFamilia();
		celda.setCellValue(apellidoFamilia);
		
//		encabezadoHojaCuatro.add("Fecha Nacimiento familiar");		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimientoFamilia = ""; 
		try{	
			fechaNacimientoFamilia = Util.timestampToString((reporte.getEmpleadoFamilia().getFechaNacimiento()), "dd/MM/yyyy");
			if(fechaNacimientoFamilia!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimientoFamilia)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
//		encabezadoHojaDos.add("User Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userCrea = reporte.getEmpleadoFamilia().getIdusuariocrea();
		if(userCrea!=null){
			celda.setCellValue(userCrea);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha crea");	
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaCrea = ""; 
		try{	
			fechaCrea = Util.timestampToString((reporte.getEmpleadoFamilia().getFechacrea()), "dd/MM/yyyy");
			if(fechaCrea!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaCrea)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
//		encabezado.add("User Mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userMod = reporte.getEmpleadoFamilia().getIdusuariomod();
		if(userMod!=null){
			celda.setCellValue(userMod);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha mod")
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaMod = ""; 
		try{	
			fechaMod = Util.timestampToString((reporte.getEmpleadoFamilia().getFechamod()), "dd/MM/yyyy");
			if(fechaMod!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaMod)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
	}
	
	/**
	 * LLena las filas con la información. En la hoja cuatro de DOCUMENTOS.
	 * 
	 * @param ReporteInformacionAdicionalEmpleado. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteInfoAdicionalHojaCinco(ReporteInformacionAdicionalEmpleado reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {
		
//		CreationHelper createHelper = libro.getCreationHelper();
//		HSSFCellStyle cellStyle = libro.createCellStyle();
//	    cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("d/m/yy"));
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		

//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
		
//		celda.setCellStyle(estilo);
//	    celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
		

//		encabezadoHojaCinco.add("Estado Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleadoDocumento = reporte.getEmpleadoDocumento().getEstado();
		if(estadoEmpleadoDocumento==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleadoDocumento==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		
//		encabezadoHojaCinco.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDeDocumento = reporte.getTipoDocumento().getNombretipodocumento();
		celda.setCellValue(tipoDeDocumento);
		
//		encabezadoHojaCinco.add("Nombre Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombreDeDocumento = reporte.getEmpleadoDocumento().getNombredocumento();
		celda.setCellValue(nombreDeDocumento);
		
//		encabezadoHojaDos.add("User Crea");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userCrea = reporte.getEmpleadoDocumento().getIdusuariocrea();
		if(userCrea!=null){
			celda.setCellValue(userCrea);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha crea");	
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaCrea = ""; 
		try{	
			fechaCrea = Util.timestampToString((reporte.getEmpleadoDocumento().getFechacrea()), "dd/MM/yyyy");
			if(fechaCrea!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaCrea)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
//		encabezado.add("User Mod");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer userMod = reporte.getEmpleadoDocumento().getIdusuariomod();
		if(userMod!=null){
			celda.setCellValue(userMod);
		}else{
			celda.setCellValue("");
		}
		
//		encabezado.add("Fecha mod")
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaMod = ""; 
		try{	
			fechaMod = Util.timestampToString((reporte.getEmpleadoDocumento().getFechamod()), "dd/MM/yyyy");
			if(fechaMod!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaMod)));
			}else{
				celda.setCellValue("");
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
	}
	
	
	/**
	 * Este metodo genera y escribe el reporte excel de informacion adicional de los empleados.
	 * @author jpuentes
	 * */
	public byte[] escribirReporteProcesosDisciplinarios(List<ReporteEmpleado> reporteEmpleados,HttpServletRequest request, HttpServletResponse response) throws IOException {

		FileOutputStream archivo;
		byte[] respu = null;
		
		try {

			HSSFWorkbook libro = new HSSFWorkbook();
			
			HSSFSheet hojaCero = libro.createSheet();//Faltas
			HSSFSheet hojaUno = libro.createSheet();//Ocurrencia de faltas
			HSSFSheet hojaDos = libro.createSheet();//Historial Procesos
			HSSFSheet hojaTres = libro.createSheet();//Historial Procesos
			
			libro.setSheetName(libro.getSheetIndex(hojaCero), "Todas Las Faltas");
			libro.setSheetName(libro.getSheetIndex(hojaUno), "Ocurrencia De Faltas");
			libro.setSheetName(libro.getSheetIndex(hojaDos), "Historial De Procesos");
			libro.setSheetName(libro.getSheetIndex(hojaTres), "Archivos De Revisión");
			
			List<String> encabezadoHojaCero = new ArrayList<String>();
			List<String> encabezadoHojaUno = new ArrayList<String>();
			List<String> encabezadoHojaDos = new ArrayList<String>();
			List<String> encabezadoHojaTres = new ArrayList<String>();
			
			// Estilos Encabezado Fila
			HSSFFont fuenteEncabezado = libro.createFont();
			fuenteEncabezado.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFCellStyle estiloEncabezado = libro.createCellStyle();
			estiloEncabezado.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			estiloEncabezado.setFont(fuenteEncabezado);
			estiloEncabezado.setWrapText(false);
			estiloEncabezado.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
			estiloEncabezado.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			estiloEncabezado.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
//			---------------------------------------------------------------
//			Definición de estilos.
			HSSFCellStyle estilo = libro.createCellStyle();
			estilo.setWrapText(false);
			estilo.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
	
			HSSFCellStyle estiloFormato = libro.createCellStyle();
			estiloFormato.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
			HSSFDataFormat format = libro.createDataFormat();
			estiloFormato.setDataFormat(format.getFormat("#,##0"));

			
			int numFilaCero = 0;
			int numFilaUno = 0;
			int numFilaDos = 0;
			int numFilaTres = 0;
			
			HSSFRow filaHeadCero = hojaCero.createRow(numFilaCero);
			HSSFRow filaHeadUno = hojaUno.createRow(numFilaUno);
			HSSFRow filaHeadDos = hojaDos.createRow(numFilaDos);
			HSSFRow filaHeadTres = hojaTres.createRow(numFilaTres);
			
			//Definicion de encabezados.
			//Hoja Cero: Faltas
			encabezadoHojaCero.add("Estado Empleado");
			encabezadoHojaCero.add("Código Empleado");
			encabezadoHojaCero.add("Tipo Documento");
			encabezadoHojaCero.add("Número Identificación");
			encabezadoHojaCero.add("Nombres");
			encabezadoHojaCero.add("Apellidos");
			encabezadoHojaCero.add("Género");
			encabezadoHojaCero.add("Fecha Nacimiento");
			//Contrato
			encabezadoHojaCero.add("Idcontrato");
			encabezadoHojaCero.add("Número contrato");
			encabezadoHojaCero.add("Tipo De Contrato");
			encabezadoHojaCero.add("fechafirma");
			encabezadoHojaCero.add("fechainicio");
			encabezadoHojaCero.add("fechafin");
			encabezadoHojaCero.add("Cargo");
			encabezadoHojaCero.add("Motivo del Retiro");
			encabezadoHojaCero.add("Estado contrato");
			//Ubicacion
			encabezadoHojaCero.add("Empresa");
			encabezadoHojaCero.add("Sucursal");
			encabezadoHojaCero.add("Área");
			encabezadoHojaCero.add("Área asignada");
			//Falta
			encabezadoHojaCero.add("Fecha Registro de Falta");
			encabezadoHojaCero.add("Tipo de Falta Cometida");
			encabezadoHojaCero.add("Nombre de la Falta");
			encabezadoHojaCero.add("Sanción Aplicada");
			encabezadoHojaCero.add("Procedimiento");
			encabezadoHojaCero.add("Responsable");
			encabezadoHojaCero.add("Recurrencia");
			
			//Hoja Uno: Ocurrencia de faltas
			encabezadoHojaUno.add("Estado Empleado");
			encabezadoHojaUno.add("Código Empleado");
			encabezadoHojaUno.add("Tipo Documento");
			encabezadoHojaUno.add("Número Identificación");
			encabezadoHojaUno.add("Nombres");
			encabezadoHojaUno.add("Apellidos");
			encabezadoHojaUno.add("Género");
			encabezadoHojaUno.add("Fecha Nacimiento");
			//Contrato
			encabezadoHojaUno.add("Idcontrato");
			encabezadoHojaUno.add("Número contrato");
			encabezadoHojaUno.add("Tipo De Contrato");
			encabezadoHojaUno.add("fechafirma");
			encabezadoHojaUno.add("fechainicio");
			encabezadoHojaUno.add("fechafin");
			encabezadoHojaUno.add("Cargo");
			encabezadoHojaUno.add("Motivo del Retiro");
			encabezadoHojaUno.add("Estado contrato");
			//Ubicacion
			encabezadoHojaUno.add("Empresa");
			encabezadoHojaUno.add("Sucursal");
			encabezadoHojaUno.add("Área");
			encabezadoHojaUno.add("Área asignada");
			//Ocurrencia de falta
			encabezadoHojaUno.add("Tipo de Falta Cometida");
			encabezadoHojaUno.add("Nombre de la Falta");
			encabezadoHojaUno.add("Sanción Aplicada");
			encabezadoHojaUno.add("Ocurrencia");
			
			//Hoja Dos: Historial de procesos
			encabezadoHojaDos.add("Estado Empleado");
			encabezadoHojaDos.add("Código Empleado");
			encabezadoHojaDos.add("Tipo Documento");
			encabezadoHojaDos.add("Número Identificación");
			encabezadoHojaDos.add("Nombres");
			encabezadoHojaDos.add("Apellidos");
			encabezadoHojaDos.add("Género");
			encabezadoHojaDos.add("Fecha Nacimiento");
			//Contrato
			encabezadoHojaDos.add("Idcontrato");
			encabezadoHojaDos.add("Número contrato");
			encabezadoHojaDos.add("Tipo De Contrato");
			encabezadoHojaDos.add("fechafirma");
			encabezadoHojaDos.add("fechainicio");
			encabezadoHojaDos.add("fechafin");
			encabezadoHojaDos.add("Cargo");
			encabezadoHojaDos.add("Motivo del Retiro");
			encabezadoHojaDos.add("Estado contrato");
			//Ubicacion
			encabezadoHojaDos.add("Empresa");
			encabezadoHojaDos.add("Sucursal");
			encabezadoHojaDos.add("Área");
			encabezadoHojaDos.add("Área asignada");
			//Falta
			encabezadoHojaDos.add("Tipo de Falta Cometida");
			encabezadoHojaDos.add("Nombre de la Falta");
			encabezadoHojaDos.add("Sanción Aplicada");
			encabezadoHojaDos.add("Procedimiento");
			encabezadoHojaDos.add("Responsable");
			encabezadoHojaDos.add("Fecha de Revisón");
			encabezadoHojaDos.add("Estado Revisión");
			encabezadoHojaDos.add("Revisó");
			encabezadoHojaDos.add("Observación");
			encabezadoHojaDos.add("Recurrencia");
			
			//Hoja Tres: Archivos de revisión.
			encabezadoHojaTres.add("Estado Empleado");
			encabezadoHojaTres.add("Código Empleado");
			encabezadoHojaTres.add("Tipo Documento");
			encabezadoHojaTres.add("Número Identificación");
			encabezadoHojaTres.add("Nombres");
			encabezadoHojaTres.add("Apellidos");
			encabezadoHojaTres.add("Género");
			encabezadoHojaTres.add("Fecha Nacimiento");
			//Contrato
			encabezadoHojaTres.add("Idcontrato");
			encabezadoHojaTres.add("Número contrato");
			encabezadoHojaTres.add("Tipo De Contrato");
			encabezadoHojaTres.add("fechafirma");
			encabezadoHojaTres.add("fechainicio");
			encabezadoHojaTres.add("fechafin");
			encabezadoHojaTres.add("Cargo");
			encabezadoHojaTres.add("Motivo del Retiro");
			encabezadoHojaTres.add("Estado contrato");
			//Ubicación
			encabezadoHojaTres.add("Empresa");
			encabezadoHojaTres.add("Sucursal");
			encabezadoHojaTres.add("Área");
			encabezadoHojaTres.add("Área asignada");
			//Falta
			encabezadoHojaTres.add("Tipo De Falta");
			encabezadoHojaTres.add("Nombre de la Falta");
			encabezadoHojaTres.add("Fecha de Revisón");
			encabezadoHojaTres.add("Estado Revisión");
			encabezadoHojaTres.add("Revisó");
			encabezadoHojaTres.add("Observación");
			encabezadoHojaTres.add("Tipo De Archivo");
			encabezadoHojaTres.add("Nombre De Archivo");
			
			
			//Poner titulos Hoja Cero
			int jcero = 0;
			for (String titulo : encabezadoHojaCero) {
				hojaCero.autoSizeColumn(jcero);
				hojaCero.setColumnWidth(jcero, 4000);
				HSSFCell celda = filaHeadCero.createCell(jcero);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jcero++;
			}
			
			//Poner titulos Hoja Uno
			int juno = 0;
			for (String titulo : encabezadoHojaUno) {
				hojaUno.autoSizeColumn(juno);
				hojaUno.setColumnWidth(juno, 4000);
				HSSFCell celda = filaHeadUno.createCell(juno);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				juno++;
			}
			
			//Poner titulos Hoja Dos
			int jDos = 0;
			for (String titulo : encabezadoHojaDos) {
				hojaDos.autoSizeColumn(jDos);
				hojaDos.setColumnWidth(jDos, 4000);
				HSSFCell celda = filaHeadDos.createCell(jDos);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jDos++;
			}
			
			//Poner titulos Hoja tres
			int jTres = 0;
			for (String titulo : encabezadoHojaTres) {
				hojaTres.autoSizeColumn(jTres);
				hojaTres.setColumnWidth(jTres, 4000);
				HSSFCell celda = filaHeadTres.createCell(jTres);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jTres++;
			}
			
			logger.info("Va a escribir la hoja cero");
			//Escribir hoja cero (Procesos Disciplinarios)
			logger.info("Va a consultar las faltas del contrato.");
			List<ReporteProcesoDisciplinario> procesosDisciplinarios = contratoEJB.obtenerTodasLasFaltasDelContrato(reporteEmpleados);
			logger.info("HA obtenido todas las faltas del contrato.");
			logger.info("Va a iniciar el ciclo for.");
			numFilaCero++;
			for (ReporteProcesoDisciplinario reporte : procesosDisciplinarios) {
				logger.info("dentro del for con numFilaCero = "+numFilaCero);
				HSSFRow fila = hojaCero.createRow(numFilaCero);
				escribirCeldasReporteProcesoDisciplinarioHojaCero(reporte, fila, libro,estilo,estiloFormato);
				hojaCero.autoSizeColumn((short) (numFilaCero));
				numFilaCero++;
				logger.info("|------------------------------------------------------------------------------------|");
			}
			logger.info("Va a escribir la hoja uno");
			//Escribir hoja uno (Ocurrencia de faltas)
			List<ReporteProcesoDisciplinario> ocurrenciaDeFaltas = contratoEJB.obtenerOcurrenciaDeFaltasPorContrato(reporteEmpleados);
			
			numFilaUno++;
			for (ReporteProcesoDisciplinario reporte : ocurrenciaDeFaltas) {
				HSSFRow fila = hojaUno.createRow(numFilaUno);
				escribirCeldasReporteProcesoDisciplinarioHojaUno(reporte, fila, libro,estilo,estiloFormato);
				hojaUno.autoSizeColumn((short) (numFilaUno));
				numFilaUno++;
			}
			logger.info("Va a escribir la hoja dos");
			//Escribir hoja dos (Historial de procesos)
			List<ReporteProcesoDisciplinario> historialDeProcesos = contratoEJB.obtenerHistorialDeProcesosDisciplinarios(reporteEmpleados);
			
			numFilaDos++;
			for (ReporteProcesoDisciplinario reporte : historialDeProcesos) {
				HSSFRow fila = hojaDos.createRow(numFilaDos);
				escribirCeldasReporteProcesoDisciplinarioHojaDos(reporte, fila, libro,estilo,estiloFormato);
				hojaDos.autoSizeColumn((short) (numFilaDos));
				numFilaDos++;
			}
			logger.info("Va a escribir la hoja tres");
			//Escribir hoja tres (Archivos de Revisión)
			List<ReporteProcesoDisciplinario> archivosDeRevision = contratoEJB.obtenerArchivosDeRevision(reporteEmpleados);
			
			numFilaTres++;
			for (ReporteProcesoDisciplinario reporte : archivosDeRevision) {
				HSSFRow fila = hojaTres.createRow(numFilaTres);
				escribirCeldasReporteProcesoDisciplinarioHojaTres(reporte, fila, libro,estilo,estiloFormato);
				hojaTres.autoSizeColumn((short) (numFilaTres));
				numFilaTres++;
			}
			
			String ruta = Constante.ROOT_FILE_TEMPORARY + File.separator
					+ "Reporte.xls";

			
			archivo = new FileOutputStream(ruta);
			libro.write(archivo);
			archivo.close();
			
			// Descarga del archivo
			File file = new File(ruta);
			if (!file.exists()) {

				throw new LogicaException("no se encuentra el archivo");

			} else {

				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				FileInputStream inputStream = new FileInputStream(file);

				try {
					int c;
					while ((c = inputStream.read()) != -1) {
						baos.write(c);
					}
				} finally {
					if (inputStream != null)
						inputStream.close();

					baos.flush();
					baos.close();
				}

				respu = baos.toByteArray();

			}

		} catch (FileNotFoundException e) {

			e.printStackTrace();
			System.out.println("FileNotFoundException");
		} catch (IOException e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());

		}
		return respu;
	}
	
	
	/**
	 * LLena las filas con la información. En la hoja Todas las Faltas
	 * 
	 * @param ReporteProcesoDisciplinario. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteProcesoDisciplinarioHojaCero(ReporteProcesoDisciplinario reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

		logger.info("Entro a escribir las celdas.. escribirCeldasReporteProcesoDisciplinarioHojaCero()");
		
		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
//		logger.info("estado del emple");
//      Estado del empleado.
		celda = fila.createCell(i);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);

//		encabezado.add("Código Empleado");
//		logger.info("codigo del emple");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		celda.getSheet().autoSizeColumn(i);
//		logger.info("tipo identificacion");
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		celda.getSheet().autoSizeColumn(i);
//		logger.info("Número Identificación");
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);
		celda.getSheet().autoSizeColumn(i);
//		logger.info("Nombres");
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);	
		celda.getSheet().autoSizeColumn(i);
		
//		logger.info("Apellidos.-");
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);
		celda.getSheet().autoSizeColumn(i);
//		logger.info("genero.");
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		celda.getSheet().autoSizeColumn(i);
		
//		logger.info("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
//		celda.setCellStyle(cellStyle);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue(fechaNacimiento);
			}
		}catch(Exception e){
//			fechaNacimiento="";
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
	
		// id contrato
		i++;
		celda = fila.createCell(i);
		
		if(reporte.getUltimoContrato()!=null){
			String numerocontrato = (String) (reporte.getUltimoContrato().getNumerocontrato() != null ? reporte.getUltimoContrato().getNumerocontrato() : "");
			celda.setCellValue(numerocontrato);
			celda.getSheet().autoSizeColumn(i);
		}else{
			celda.setCellValue("");
		}
		
				// numerocontrato
				i++;
				celda = fila.createCell(i);
				String numerocontrato = (String) (reporte.getUltimoContrato().getNumerocontrato() != null ? reporte.getUltimoContrato().getNumerocontrato() : "");
				celda.setCellValue(numerocontrato);
				celda.getSheet().autoSizeColumn(i);
				
//				logger.info("Tipo de contrato");
				//Tipo de contrato
				i++;
				celda = fila.createCell(i);
				ContratoTipo tipoDeContrato = reporte.getUltimoContrato().getContratotipo();
				if (tipoDeContrato != null) {
					String tipoContrato = tipoDeContrato.getNombrecontratotipo();
					if (tipoContrato != null) {
						celda.setCellValue(tipoContrato);
					}
				} else {
					celda.setCellValue("");
				}
				celda.getSheet().autoSizeColumn(i);
				
//				logger.info("fecha firma");
				// fechafirma
				i++;
				celda = fila.createCell(i);
				String fechafirma = Util.timestampToString((reporte.getUltimoContrato().getFechafirma()), "dd/MM/yyyy");
				if(fechafirma!=""){
					celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechafirma)));
				}else{
					celda.setCellValue("");
				}
				celda.getSheet().autoSizeColumn(i);

//				logger.info("fecha inciio");				
				// fechainicio
				i++;
				celda = fila.createCell(i);
				String fechainicio = Util.timestampToString((reporte.getUltimoContrato().getFechainicio()), "dd/MM/yyyy");
				if(fechainicio!=""){
					celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechainicio)));
				}else{
					celda.setCellValue("");
				}
				celda.getSheet().autoSizeColumn(i);

//				logger.info("fecha fin");
				// fefchafin
				i++;
				celda = fila.createCell(i);
				String fefchafin = Util.timestampToString((reporte.getUltimoContrato().getFechafin()), "dd/MM/yyyy");
				if(fefchafin!=""){
					celda.setCellValue(formatoFecha.format(formatoFecha.parse(fefchafin)));
				}else{
					celda.setCellValue("");
				}
				celda.getSheet().autoSizeColumn(i);
//				logger.info("cargo");
				// cargo
				i++;
				celda = fila.createCell(i);
				String cargo = (String) (reporte.getUltimoContrato().getCargo().getNombrecargo() != null ? reporte.getUltimoContrato().getCargo().getNombrecargo() : "");
				celda.setCellValue(cargo);
				celda.getSheet().autoSizeColumn(i);

//				logger.info("motivo");
				// motivo
				i++;
				celda = fila.createCell(i);
				String motivo = (String) (reporte.getUltimoContrato().getRetiromotivo()
						.getNombremotivo() != null ? reporte.getUltimoContrato()
						.getRetiromotivo().getNombremotivo() : "");
				celda.setCellValue(motivo);
				celda.getSheet().autoSizeColumn(i);

//				logger.info("estado");
				// estado
				i++;
				celda = fila.createCell(i);
				String estadocon = (reporte.getUltimoContrato().getEstado().toString());
				String estadoconn = "";
				if (estadocon.equals("2")) {
					estadoconn = "ACTIVO";
				} else if (estadocon.equals("3")) {
					estadoconn = "DESHABILITADO";
				}
				celda.setCellValue(estadoconn);
				celda.getSheet().autoSizeColumn(i);
				
//				logger.info("empresa");
				// empresa
				i++;
				celda = fila.createCell(i);
				String empresa = (String) (reporte.getUltimoContrato().getEmpresa()
						.getNombreempresa() != null ? reporte.getUltimoContrato()
						.getEmpresa().getNombreempresa() : "");
				celda.setCellValue(empresa);
				celda.getSheet().autoSizeColumn(i);

//				logger.info("sucursal");
				// sucursal
				i++;
				celda = fila.createCell(i);
				String sucursal = (String) (reporte.getUltimoContrato().getSucursal()
						.getNombresucursal() != null ? reporte.getUltimoContrato()
						.getSucursal().getNombresucursal() : "");
				celda.setCellValue(sucursal);
				celda.getSheet().autoSizeColumn(i);
//				logger.info("area");
				// area
				i++;
				celda = fila.createCell(i);
				String area = (String) (reporte.getUltimoContrato().getArea().getNombrearea() != null ? reporte
						.getUltimoContrato().getArea().getNombrearea()
						: "");
				celda.setCellValue(area);
				celda.getSheet().autoSizeColumn(i);
				// area asiganda
//				logger.info("area asignada");
				i++;
				celda = fila.createCell(i);
				String areaasignada = (String) (reporte.getUltimoContrato().getAreaasignada()
						.getNombrearea() != null ? reporte.getUltimoContrato()
						.getAreaasignada().getNombrearea() : "");
				celda.setCellValue(areaasignada);
				celda.getSheet().autoSizeColumn(i);
				
//*************************************************************
				
//		encabezadoHojaCero.add("Fecha Registro de Falta");
//				logger.info("fecha registro de falta.");
		i++;
		celda = fila.createCell(i);
		String fechaFalta="";
		try{
			fechaFalta = Util.timestampToString((reporte.getDisciplina().getFechacrea()), "dd/MM/yyyy");
			if(fechaFalta!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaFalta)));
			}else{
				celda.setCellValue(fechaFalta);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
//		logger.info("Tipo de Falta Cometida");
//		encabezadoHojaCero.add("Tipo de Falta Cometida");
		i++;
		celda = fila.createCell(i);
		String tipoDeFalta = reporte.getTipoFalta().getNombrefaltatipo();
		celda.setCellValue(tipoDeFalta);
		celda.getSheet().autoSizeColumn(i);
		
//		logger.info("Nombre de la Falta");
//		encabezadoHojaCero.add("Nombre de la Falta");
		i++;
		celda = fila.createCell(i);
		String nombreDeFalta = reporte.getFalta().getFaltanombre();
		celda.setCellValue(nombreDeFalta);
		celda.getSheet().autoSizeColumn(i);
//		logger.info("Sanción Aplicada");
//		encabezadoHojaCero.add("Sanción Aplicada");
		i++;
		celda = fila.createCell(i);
		String sancionAplicada = reporte.getSancion().getNombresancion();
		celda.setCellValue(sancionAplicada);
		celda.getSheet().autoSizeColumn(i);
//		logger.info("Procedimiento");
//		encabezadoHojaCero.add("Procedimiento");
		i++;
		celda = fila.createCell(i);
		String procedimiento = reporte.getSancion().getProcedimiento();
		celda.setCellValue(procedimiento);
		celda.getSheet().autoSizeColumn(i);
		
//		logger.info("Responsable");
//		encabezadoHojaCero.add("Responsable");
		i++;
		celda = fila.createCell(i);
		String responsable = reporte.getSancion().getResponsable();
		celda.setCellValue(responsable);
		celda.getSheet().autoSizeColumn(i);
		
//		logger.info("Recurrencia");
//		encabezadoHojaCero.add("Recurrencia");
		i++;
		celda = fila.createCell(i);
		String recurrencia = reporte.getDisciplina().getRecurrenciaPorFalta();
		celda.setCellValue(recurrencia);
		celda.getSheet().autoSizeColumn(i);
		
	}
	
	
	
	/**
	 * LLena las filas con la información. En la hoja Ocurrencia.
	 * 
	 * @param ReporteProcesoDisciplinario. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteProcesoDisciplinarioHojaUno(ReporteProcesoDisciplinario reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		celda.getSheet().autoSizeColumn(i);
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
		celda.getSheet().autoSizeColumn(i);
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue(fechaNacimiento);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
		//*************************************************************
				// id contrato
						i++;
						celda = fila.createCell(i);
						String contrato = (reporte.getUltimoContrato().getIdcontrato() != null ? reporte.getUltimoContrato().getIdcontrato() : "").toString();
						celda.setCellValue(contrato);

						// numerocontrato
						i++;
						celda = fila.createCell(i);
						String numerocontrato = (String) (reporte.getUltimoContrato().getNumerocontrato() != null ? reporte.getUltimoContrato().getNumerocontrato() : "");
						celda.setCellValue(numerocontrato);
						celda.getSheet().autoSizeColumn(i);

						//Tipo de contrato
						i++;
						celda = fila.createCell(i);
						ContratoTipo tipoDeContrato = reporte.getUltimoContrato().getContratotipo();
						if (tipoDeContrato != null) {
							String tipoContrato = tipoDeContrato.getNombrecontratotipo();
							if (tipoContrato != null) {
								celda.setCellValue(tipoContrato);
							}
						} else {
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);
						
						// fechafirma
						i++;
						celda = fila.createCell(i);
						String fechafirma = Util.timestampToString((reporte.getUltimoContrato().getFechafirma()), "dd/MM/yyyy");
						if(fechafirma!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechafirma)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);

						// fechainicio
						i++;
						celda = fila.createCell(i);
						String fechainicio = Util.timestampToString((reporte.getUltimoContrato().getFechainicio()), "dd/MM/yyyy");
						if(fechainicio!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechainicio)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);

						// fefchafin
						i++;
						celda = fila.createCell(i);
						String fefchafin = Util.timestampToString((reporte.getUltimoContrato().getFechafin()), "dd/MM/yyyy");
						if(fefchafin!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fefchafin)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);
						
						// cargo
						i++;
						celda = fila.createCell(i);
						String cargo = (String) (reporte.getUltimoContrato().getCargo().getNombrecargo() != null ? reporte.getUltimoContrato().getCargo().getNombrecargo() : "");
						celda.setCellValue(cargo);
						celda.getSheet().autoSizeColumn(i);

						// motivo
						i++;
						celda = fila.createCell(i);
						String motivo = (String) (reporte.getUltimoContrato().getRetiromotivo()
								.getNombremotivo() != null ? reporte.getUltimoContrato()
								.getRetiromotivo().getNombremotivo() : "");
						celda.setCellValue(motivo);
						celda.getSheet().autoSizeColumn(i);

						// estado
						i++;
						celda = fila.createCell(i);
						String estadocon = (reporte.getUltimoContrato().getEstado().toString());
						String estadoconn = "";
						if (estadocon.equals("2")) {
							estadoconn = "ACTIVO";
						} else if (estadocon.equals("3")) {
							estadoconn = "DESHABILITADO";
						}
						celda.setCellValue(estadoconn);
						celda.getSheet().autoSizeColumn(i);
						
						// empresa
						i++;
						celda = fila.createCell(i);
						String empresa = (String) (reporte.getUltimoContrato().getEmpresa()
								.getNombreempresa() != null ? reporte.getUltimoContrato()
								.getEmpresa().getNombreempresa() : "");
						celda.setCellValue(empresa);
						celda.getSheet().autoSizeColumn(i);

						// sucursal
						i++;
						celda = fila.createCell(i);
						String sucursal = (String) (reporte.getUltimoContrato().getSucursal()
								.getNombresucursal() != null ? reporte.getUltimoContrato()
								.getSucursal().getNombresucursal() : "");
						celda.setCellValue(sucursal);
						celda.getSheet().autoSizeColumn(i);

						// area
						i++;
						celda = fila.createCell(i);
						String area = (String) (reporte.getUltimoContrato().getArea().getNombrearea() != null ? reporte
								.getUltimoContrato().getArea().getNombrearea()
								: "");
						celda.setCellValue(area);
						celda.getSheet().autoSizeColumn(i);
						// area asiganda
						i++;
						celda = fila.createCell(i);
						String areaasignada = (String) (reporte.getUltimoContrato().getAreaasignada()
								.getNombrearea() != null ? reporte.getUltimoContrato()
								.getAreaasignada().getNombrearea() : "");
						celda.setCellValue(areaasignada);
						celda.getSheet().autoSizeColumn(i);
						
		//*************************************************************
		
//		encabezadoHojaCero.add("Tipo de Falta Cometida");
		i++;
		celda = fila.createCell(i);
		String tipoDeFalta = reporte.getTipoFalta().getNombrefaltatipo();
		celda.setCellValue(tipoDeFalta);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Nombre de la Falta");
		i++;
		celda = fila.createCell(i);
		String nombreDeFalta = reporte.getFalta().getFaltanombre();
		celda.setCellValue(nombreDeFalta);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Sanción Aplicada");
		i++;
		celda = fila.createCell(i);
		String sancionAplicada = reporte.getSancion().getNombresancion();
		celda.setCellValue(sancionAplicada);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Ocurrencia");
		i++;
		String dato = "";
		celda = fila.createCell(i);
		Integer ocurrencia = reporte.getSancion().getRecurrencia();
		if(ocurrencia==1){
			dato = ocurrencia.toString()+" VEZ";
		}else if(ocurrencia>1){
			dato = ocurrencia.toString()+" VECES";
		}
		celda.setCellValue(dato);
		celda.getSheet().autoSizeColumn(i);
	}
	
	
	
	/**
	 * LLena las filas con la información. En la hoja Historial de procesos.
	 * 
	 * @param List. ReporteProcesoDisciplinario. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteProcesoDisciplinarioHojaDos(ReporteProcesoDisciplinario reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Código Empleado");
		
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		celda.getSheet().autoSizeColumn(i);
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
		celda.getSheet().autoSizeColumn(i);
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue(fechaNacimiento);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
		//*************************************************************
				// id contrato
						i++;
						celda = fila.createCell(i);
						String contrato = (reporte.getUltimoContrato().getIdcontrato() != null ? reporte.getUltimoContrato().getIdcontrato() : "").toString();
						celda.setCellValue(contrato);

						// numerocontrato
						i++;
						celda = fila.createCell(i);
						String numerocontrato = (String) (reporte.getUltimoContrato().getNumerocontrato() != null ? reporte.getUltimoContrato().getNumerocontrato() : "");
						celda.setCellValue(numerocontrato);
						celda.getSheet().autoSizeColumn(i);

						//Tipo de contrato
						i++;
						celda = fila.createCell(i);
						ContratoTipo tipoDeContrato = reporte.getUltimoContrato().getContratotipo();
						if (tipoDeContrato != null) {
							String tipoContrato = tipoDeContrato.getNombrecontratotipo();
							if (tipoContrato != null) {
								celda.setCellValue(tipoContrato);
							}
						} else {
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);
						
						// fechafirma
						i++;
						celda = fila.createCell(i);
						String fechafirma = Util.timestampToString((reporte.getUltimoContrato().getFechafirma()), "dd/MM/yyyy");
						if(fechafirma!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechafirma)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);

						// fechainicio
						i++;
						celda = fila.createCell(i);
						String fechainicio = Util.timestampToString((reporte.getUltimoContrato().getFechainicio()), "dd/MM/yyyy");
						if(fechainicio!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechainicio)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);

						// fefchafin
						i++;
						celda = fila.createCell(i);
						String fefchafin = Util.timestampToString((reporte.getUltimoContrato().getFechafin()), "dd/MM/yyyy");
						if(fefchafin!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fefchafin)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);
						
						// cargo
						i++;
						celda = fila.createCell(i);
						String cargo = (String) (reporte.getUltimoContrato().getCargo().getNombrecargo() != null ? reporte.getUltimoContrato().getCargo().getNombrecargo() : "");
						celda.setCellValue(cargo);
						celda.getSheet().autoSizeColumn(i);

						// motivo
						i++;
						celda = fila.createCell(i);
						String motivo = (String) (reporte.getUltimoContrato().getRetiromotivo()
								.getNombremotivo() != null ? reporte.getUltimoContrato()
								.getRetiromotivo().getNombremotivo() : "");
						celda.setCellValue(motivo);
						celda.getSheet().autoSizeColumn(i);

						// estado
						i++;
						celda = fila.createCell(i);
						String estadocon = (reporte.getUltimoContrato().getEstado().toString());
						String estadoconn = "";
						if (estadocon.equals("2")) {
							estadoconn = "ACTIVO";
						} else if (estadocon.equals("3")) {
							estadoconn = "DESHABILITADO";
						}
						celda.setCellValue(estadoconn);
						celda.getSheet().autoSizeColumn(i);
						
						// empresa
						i++;
						celda = fila.createCell(i);
						String empresa = (String) (reporte.getUltimoContrato().getEmpresa()
								.getNombreempresa() != null ? reporte.getUltimoContrato()
								.getEmpresa().getNombreempresa() : "");
						celda.setCellValue(empresa);
						celda.getSheet().autoSizeColumn(i);

						// sucursal
						i++;
						celda = fila.createCell(i);
						String sucursal = (String) (reporte.getUltimoContrato().getSucursal()
								.getNombresucursal() != null ? reporte.getUltimoContrato()
								.getSucursal().getNombresucursal() : "");
						celda.setCellValue(sucursal);
						celda.getSheet().autoSizeColumn(i);

						// area
						i++;
						celda = fila.createCell(i);
						String area = (String) (reporte.getUltimoContrato().getArea().getNombrearea() != null ? reporte
								.getUltimoContrato().getArea().getNombrearea()
								: "");
						celda.setCellValue(area);
						celda.getSheet().autoSizeColumn(i);
						// area asiganda
						i++;
						celda = fila.createCell(i);
						String areaasignada = (String) (reporte.getUltimoContrato().getAreaasignada()
								.getNombrearea() != null ? reporte.getUltimoContrato()
								.getAreaasignada().getNombrearea() : "");
						celda.setCellValue(areaasignada);
						celda.getSheet().autoSizeColumn(i);
						
		//*************************************************************
		
//		encabezadoHojaCero.add("Tipo de Falta Cometida");
		i++;
		celda = fila.createCell(i);
		String tipoDeFalta = reporte.getTipoFalta().getNombrefaltatipo();
		celda.setCellValue(tipoDeFalta);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Nombre de la Falta");
		i++;
		celda = fila.createCell(i);
		String nombreDeFalta = reporte.getFalta().getFaltanombre();
		celda.setCellValue(nombreDeFalta);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Sanción Aplicada");
		i++;
		celda = fila.createCell(i);
		String sancionAplicada = reporte.getSancion().getNombresancion();
		celda.setCellValue(sancionAplicada);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Procedimiento");
		i++;
		celda = fila.createCell(i);
		String procedimiento = reporte.getSancion().getProcedimiento();
		celda.setCellValue(procedimiento);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Responsable");
		i++;
		celda = fila.createCell(i);
		String responsable = reporte.getSancion().getResponsable();
		celda.setCellValue(responsable);
		celda.getSheet().autoSizeColumn(i);
		
//		disciplinaHistorial.setFechacrea(rs.getTimestamp("fecha_revision"));
		i++;
		celda = fila.createCell(i);
		String fechaRevision="";
		try{
			fechaRevision = Util.timestampToString((reporte.getDisciplinaHistorial().getFechacrea()), "dd/MM/yyyy");
			if(fechaRevision!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaRevision)));
			}else{
				celda.setCellValue(fechaRevision);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
//		estadodisciplina
		i++;
		celda = fila.createCell(i);
		String estadoDisciplina = reporte.getEstado().getEstadodisciplina();
		celda.setCellValue(estadoDisciplina);
		celda.getSheet().autoSizeColumn(i);
		

		
//		disciplinaHistorial.setCreadorProceso(rs.getString("datocreador"));
		i++;
		celda = fila.createCell(i);
		String usuarioRevisor = reporte.getDisciplinaHistorial().getCreadorProceso();
		celda.setCellValue(usuarioRevisor);
		celda.getSheet().autoSizeColumn(i);
		
//		disciplinaHistorial.setObservacion(rs.getString("observacion"));
		i++;
		celda = fila.createCell(i);
		String observacion = reporte.getDisciplinaHistorial().getObservacion();
		celda.setCellValue(observacion);
		celda.getSheet().autoSizeColumn(i);
		
		i++;
		celda = fila.createCell(i);
		String recurrencia = reporte.getDisciplina().getRecurrenciaPorFalta();
		celda.setCellValue(recurrencia);
		celda.getSheet().autoSizeColumn(i);
		

	}


	
	/**
	 * LLena las filas con la información. En la hoja Archvios de Revisión.
	 * 
	 * @param List. ReporteProcesoDisciplinario. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteProcesoDisciplinarioHojaTres(ReporteProcesoDisciplinario reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato) throws ParseException {

		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Estado del empleado.
		celda = fila.createCell(i);
		Integer estadoEmpleado = reporte.getEmpleado().getEstado();
		if(estadoEmpleado==2){
			celda.setCellValue("ACTIVO");
		}else if(estadoEmpleado==3){
			celda.setCellValue("DESHABILITADO");
		}else{
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Código Empleado");
		i++;
		celda = fila.createCell(i);
//		celda.setCellStyle(estilo);
		String codigoEmpleado = reporte.getEmpleado().getCodempleado();
		celda.setCellValue(codigoEmpleado);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Tipo Documento");
		i++;
		celda = fila.createCell(i);
		String tipoDocumento = reporte.getEmpleado().getIdentificaciontipo().getTipo();
		celda.setCellValue(tipoDocumento);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Número Identificación");
		i++;
		celda = fila.createCell(i);
		String numeroIdentificacion = reporte.getEmpleado().getEmpleadoidentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroIdentificacion);	
		celda.getSheet().autoSizeColumn(i);
//		encabezado.add("Nombres");
		i++;
		celda = fila.createCell(i);
		String nombre = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombre);		
		celda.getSheet().autoSizeColumn(i);
				
//		encabezado.add("Apellidos");
		i++;
		celda = fila.createCell(i);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);	
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Género");
		i++;
		celda = fila.createCell(i);
		String genero = reporte.getEmpleado().getGenero().getNombregenero();
		celda.setCellValue(genero);	
		celda.getSheet().autoSizeColumn(i);
		
//		encabezado.add("Fecha Nacimiento");
		i++;
		celda = fila.createCell(i);
		String fechaNacimiento="";
		try{
			fechaNacimiento = Util.timestampToString((reporte.getEmpleado().getFechanacimiento()), "dd/MM/yyyy");
			if(fechaNacimiento!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaNacimiento)));
			}else{
				celda.setCellValue(fechaNacimiento);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
		//*************************************************************
				// id contrato
						i++;
						celda = fila.createCell(i);
						String contrato = (reporte.getUltimoContrato().getIdcontrato() != null ? reporte.getUltimoContrato().getIdcontrato() : "").toString();
						celda.setCellValue(contrato);

						// numerocontrato
						i++;
						celda = fila.createCell(i);
						String numerocontrato = (String) (reporte.getUltimoContrato().getNumerocontrato() != null ? reporte.getUltimoContrato().getNumerocontrato() : "");
						celda.setCellValue(numerocontrato);
						celda.getSheet().autoSizeColumn(i);

						//Tipo de contrato
						i++;
						celda = fila.createCell(i);
						ContratoTipo tipoDeContrato = reporte.getUltimoContrato().getContratotipo();
						if (tipoDeContrato != null) {
							String tipoContrato = tipoDeContrato.getNombrecontratotipo();
							if (tipoContrato != null) {
								celda.setCellValue(tipoContrato);
							}
						} else {
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);
						
						// fechafirma
						i++;
						celda = fila.createCell(i);
						String fechafirma = Util.timestampToString((reporte.getUltimoContrato().getFechafirma()), "dd/MM/yyyy");
						if(fechafirma!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechafirma)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);

						// fechainicio
						i++;
						celda = fila.createCell(i);
						String fechainicio = Util.timestampToString((reporte.getUltimoContrato().getFechainicio()), "dd/MM/yyyy");
						if(fechainicio!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechainicio)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);

						// fefchafin
						i++;
						celda = fila.createCell(i);
						String fefchafin = Util.timestampToString((reporte.getUltimoContrato().getFechafin()), "dd/MM/yyyy");
						if(fefchafin!=""){
							celda.setCellValue(formatoFecha.format(formatoFecha.parse(fefchafin)));
						}else{
							celda.setCellValue("");
						}
						celda.getSheet().autoSizeColumn(i);
						
						// cargo
						i++;
						celda = fila.createCell(i);
						String cargo = (String) (reporte.getUltimoContrato().getCargo().getNombrecargo() != null ? reporte.getUltimoContrato().getCargo().getNombrecargo() : "");
						celda.setCellValue(cargo);
						celda.getSheet().autoSizeColumn(i);

						// motivo
						i++;
						celda = fila.createCell(i);
						String motivo = (String) (reporte.getUltimoContrato().getRetiromotivo()
								.getNombremotivo() != null ? reporte.getUltimoContrato()
								.getRetiromotivo().getNombremotivo() : "");
						celda.setCellValue(motivo);
						celda.getSheet().autoSizeColumn(i);

						// estado
						i++;
						celda = fila.createCell(i);
						String estadocon = (reporte.getUltimoContrato().getEstado().toString());
						String estadoconn = "";
						if (estadocon.equals("2")) {
							estadoconn = "ACTIVO";
						} else if (estadocon.equals("3")) {
							estadoconn = "DESHABILITADO";
						}
						celda.setCellValue(estadoconn);
						celda.getSheet().autoSizeColumn(i);
						
						// empresa
						i++;
						celda = fila.createCell(i);
						String empresa = (String) (reporte.getUltimoContrato().getEmpresa()
								.getNombreempresa() != null ? reporte.getUltimoContrato()
								.getEmpresa().getNombreempresa() : "");
						celda.setCellValue(empresa);
						celda.getSheet().autoSizeColumn(i);

						// sucursal
						i++;
						celda = fila.createCell(i);
						String sucursal = (String) (reporte.getUltimoContrato().getSucursal()
								.getNombresucursal() != null ? reporte.getUltimoContrato()
								.getSucursal().getNombresucursal() : "");
						celda.setCellValue(sucursal);
						celda.getSheet().autoSizeColumn(i);

						// area
						i++;
						celda = fila.createCell(i);
						String area = (String) (reporte.getUltimoContrato().getArea().getNombrearea() != null ? reporte
								.getUltimoContrato().getArea().getNombrearea()
								: "");
						celda.setCellValue(area);
						celda.getSheet().autoSizeColumn(i);
						// area asiganda
						i++;
						celda = fila.createCell(i);
						String areaasignada = (String) (reporte.getUltimoContrato().getAreaasignada()
								.getNombrearea() != null ? reporte.getUltimoContrato()
								.getAreaasignada().getNombrearea() : "");
						celda.setCellValue(areaasignada);
						celda.getSheet().autoSizeColumn(i);
						
		//*************************************************************
		
//		encabezadoHojaCero.add("Tipo de Falta Cometida");
		i++;
		celda = fila.createCell(i);
		String tipoDeFalta = reporte.getTipoFalta().getNombrefaltatipo();
		celda.setCellValue(tipoDeFalta);
		celda.getSheet().autoSizeColumn(i);
		
//		encabezadoHojaCero.add("Nombre de la Falta");
		i++;
		celda = fila.createCell(i);
		String nombreDeFalta = reporte.getFalta().getFaltanombre();
		celda.setCellValue(nombreDeFalta);
		celda.getSheet().autoSizeColumn(i);

		
//		disciplinaHistorial.setFechacrea(rs.getTimestamp("fecha_revision"));
		i++;
		celda = fila.createCell(i);
		String fechaRevision="";
		try{
			fechaRevision = Util.timestampToString((reporte.getDisciplinaHistorial().getFechacrea()), "dd/MM/yyyy");
			if(fechaRevision!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaRevision)));
			}else{
				celda.setCellValue(fechaRevision);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		celda.getSheet().autoSizeColumn(i);
		
//		estadodisciplina
		i++;
		celda = fila.createCell(i);
		String estadoDisciplina = reporte.getEstado().getEstadodisciplina();
		celda.setCellValue(estadoDisciplina);
		celda.getSheet().autoSizeColumn(i);
		
//		disciplinaHistorial.setCreadorProceso(rs.getString("datocreador"));
		i++;
		celda = fila.createCell(i);
		String usuarioRevisor = reporte.getDisciplinaHistorial().getCreadorProceso();
		celda.setCellValue(usuarioRevisor);
		celda.getSheet().autoSizeColumn(i);
		
//		disciplinaHistorial.setObservacion(rs.getString("observacion"));
		i++;
		celda = fila.createCell(i);
		String observacion = reporte.getDisciplinaHistorial().getObservacion();
		celda.setCellValue(observacion);
		celda.getSheet().autoSizeColumn(i);
		
//		disciplinaHistorial.setObservacion(rs.getString("Tipo de archivo"));
		i++;
		celda = fila.createCell(i);
		String tipoDeArchivo = reporte.getTipoArchivo().getNombretipoarchivo();
		celda.setCellValue(tipoDeArchivo);
		celda.getSheet().autoSizeColumn(i);
		
//		disciplinaHistorial.setObservacion(rs.getString("Nombre del archivo"));
		i++;
		celda = fila.createCell(i);
		String nombreDeArchivo = reporte.getDisciplinaArchivo().getNombrearchivo();
		celda.setCellValue(nombreDeArchivo);
		celda.getSheet().autoSizeColumn(i);		
		
	}
	
	
	/**
	 * Este metodo genera y escribe el reporte excel de los ingresos de empleados.
	 * @author jpuentes
	 * */
	public byte[] escribirReporteIngresosDePersonal(List<ReporteIngresosPersonal> reporteIngresos,HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
		FileOutputStream archivo;
		byte[] respu = null;
		
		
		try {

			HSSFWorkbook libro = new HSSFWorkbook();
			
			HSSFSheet hojaCero = libro.createSheet();
			
			libro.setSheetName(libro.getSheetIndex(hojaCero), "IngresosDePersonal");
			
			List<String> encabezadoHojaCero = new ArrayList<String>();
			
			// Estilos Encabezado Fila
			HSSFFont fuenteEncabezado = libro.createFont();
			fuenteEncabezado.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFCellStyle estiloEncabezado = libro.createCellStyle();
			estiloEncabezado.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			estiloEncabezado.setFont(fuenteEncabezado);
			estiloEncabezado.setWrapText(false);
			estiloEncabezado.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
//			estiloEncabezado.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
			estiloEncabezado.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			estiloEncabezado.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloEncabezado.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
//			---------------------------------------------------------------
//			Definición de estilos.
			HSSFCellStyle estilo = libro.createCellStyle();
			estilo.setWrapText(false);
			estilo.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estilo.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
	
			HSSFCellStyle estiloFormato = libro.createCellStyle();
			estiloFormato.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
			estiloFormato.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
			HSSFDataFormat format = libro.createDataFormat();
			estiloFormato.setDataFormat(format.getFormat("#,##0"));
			
			int numFilaCero = 0;
			
			HSSFRow filaHeadCero = hojaCero.createRow(numFilaCero);
			
			
			//Definicion de encabezados.
			//Hoja Cero: Ingresos de personal.
			
			encabezadoHojaCero.add("Tipo ID");
			encabezadoHojaCero.add("Número ID");
			encabezadoHojaCero.add("Apellidos");
			encabezadoHojaCero.add("Nombre(s)");
			encabezadoHojaCero.add("Correo");
			encabezadoHojaCero.add("Sucursal");
			encabezadoHojaCero.add("Tipo de Cotizante");
			//encabezadoHojaCero.add("AFP");
			encabezadoHojaCero.add("EPS");
			encabezadoHojaCero.add("Pensión");
			encabezadoHojaCero.add("Cesantias");
			encabezadoHojaCero.add("Caja Compensación");
			encabezadoHojaCero.add("Aporte Opcional ARL");
			encabezadoHojaCero.add("ARL");
			encabezadoHojaCero.add("Tarifa ARL(%)");
			encabezadoHojaCero.add("Aporte Opcional CCF");
			encabezadoHojaCero.add("Fecha Ingreso");
			encabezadoHojaCero.add("Fecha Retiro");
			encabezadoHojaCero.add("Cargo");
			
			if(idDeGrupo==212 || idDeGrupo==213 || idDeGrupo==214){
				encabezadoHojaCero.add("Salario Mensual");
				encabezadoHojaCero.add("Salario Integral");
			}
			
			encabezadoHojaCero.add("Área");
			encabezadoHojaCero.add("Área asiganda");
			encabezadoHojaCero.add("Número de Cuenta");
			encabezadoHojaCero.add("Banco");
			
			//Poner titulos Hoja Cero
			int jcero = 0;
			for (String titulo : encabezadoHojaCero) {
				hojaCero.autoSizeColumn(jcero);
				hojaCero.setColumnWidth(jcero, 4000);
				HSSFCell celda = filaHeadCero.createCell(jcero);
				celda.setCellStyle(estiloEncabezado);
				celda.setCellValue(titulo);
				jcero++;
			}
			
			//Escribir hoja cero
			numFilaCero++;
			for (ReporteIngresosPersonal reporte : reporteIngresos) {
				HSSFRow fila = hojaCero.createRow(numFilaCero);
				escribirCeldasReporteIngresosDePersonal(reporte, fila, libro,estilo,estiloFormato,request);
				hojaCero.autoSizeColumn((short) (numFilaCero));
				numFilaCero++;
			}
			
			logger.info("Despues del ciclo.");
			
			String ruta = Constante.ROOT_FILE_TEMPORARY + File.separator+ "Reporte.xls";

			archivo = new FileOutputStream(ruta);
			libro.write(archivo);
			archivo.close();
			
			// Descarga del archivo
			File file = new File(ruta);
			if (!file.exists()) {

				throw new LogicaException("no se encuentra el archivo");

			} else {

				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				FileInputStream inputStream = new FileInputStream(file);

				try {
					int c;
					while ((c = inputStream.read()) != -1) {
						baos.write(c);
					}
				} finally {
					if (inputStream != null)
						inputStream.close();

					baos.flush();
					baos.close();
				}

				respu = baos.toByteArray();

			}

		} catch (FileNotFoundException e) {

			e.printStackTrace();
			System.out.println("FileNotFoundException");
		} catch (IOException e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());

		}
		return respu;
	}
	
	/**
	 * LLena las filas con la información de los ingresos de personal.
	 * 
	 * @param ReporteIngresosDePersonal. Los datos del reporte.
	 * @param HSSFRow. La fila.
	 * @throws ParseException
	 */
	private void escribirCeldasReporteIngresosDePersonal(ReporteIngresosPersonal reporte, HSSFRow fila,HSSFWorkbook libro,HSSFCellStyle estilo,HSSFCellStyle estiloFormato,HttpServletRequest peticion) throws ParseException {

		SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
		HttpSession session = peticion.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
		
		int i = 0;
		HSSFCell celda = fila.createCell(i);
		
//      Tipo ID
		celda = fila.createCell(i);
		String tipoId = reporte.getIdentificacionTipo().getAbreviatura();
		if(tipoId!=null){
			celda.setCellValue(tipoId);
		}else{
			celda.setCellValue("");
		}
		

//		Número ID
		i++;
		celda = fila.createCell(i);
		String numeroId = reporte.getEmpleadoIdentificacion().getNumeroidentificacion();
		celda.setCellValue(numeroId);
		
		
//		Apellidos
		i++;
		celda = fila.createCell(i);
		String apellidos = reporte.getEmpleado().getApellidos();
		celda.setCellValue(apellidos);
		
		
//		Nombres
		i++;
		celda = fila.createCell(i);
		String nombres = reporte.getEmpleado().getNombres();
		celda.setCellValue(nombres);	
		
//		Correo
		i++;
		celda = fila.createCell(i);
		String correo = reporte.getEmpleadoPropiedad().getDato();
		celda.setCellValue(correo);
		
//		Sucursal
		i++;
		celda = fila.createCell(i);
		String sucursal = reporte.getSucursal().getNombresucursal();
		celda.setCellValue(sucursal);	
		
//		Tipo de Cotizante
		i++;
		celda = fila.createCell(i);
		String tipoCotizante = "";
		celda.setCellValue(tipoCotizante);	
	
		
//		EPS
		i++;
		celda = fila.createCell(i);
		String eps = reporte.getAfiliacionEntidadSalud().getNombreentidad();
		celda.setCellValue(eps);
		
//		Pensiones
		i++;
		celda = fila.createCell(i);
		String pension = reporte.getAfiliacionEntidadPension().getNombreentidad();
		celda.setCellValue(pension);

//		Cesantias
		i++;
		celda = fila.createCell(i);
		String cesantias = reporte.getAfiliacionEntidadCesantias().getNombreentidad();
		celda.setCellValue(cesantias);
		
//		Caja compensación
		i++;
		celda = fila.createCell(i);
		String caja = reporte.getAfiliacionEntidadCajaCompensacion().getNombreentidad();
		celda.setCellValue(caja);
		
//		aporte opcional ARL
		i++;
		celda = fila.createCell(i);
		String aporteOpcionalARL = "";
		celda.setCellValue(aporteOpcionalARL);
		
//		ARL
		i++;
		celda = fila.createCell(i);
		String arl = "";
		celda.setCellValue(arl);
		
//		Tarifa ARL(%)
		i++;
		celda = fila.createCell(i);
		String tarifaArlPorcentaje = "";
		celda.setCellValue(tarifaArlPorcentaje);
		
//		aporte Opcional CCF
		i++;
		celda = fila.createCell(i);
		String aporteOpcionalCCF = "";
		celda.setCellValue(aporteOpcionalCCF);
		
		
//		Fecha Ingreso
		i++;
		celda = fila.createCell(i);
		String fechaIngreso="";
		try{
			fechaIngreso = Util.timestampToString((reporte.getContrato().getFechainicio()), "dd/MM/yyyy");
			if(fechaIngreso!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(fechaIngreso)));
			}else{
				celda.setCellValue(fechaIngreso);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
		
		
//		Fecha Retiro
		i++;
		celda = fila.createCell(i);
		String FechaRetiro="";
		try{
			FechaRetiro = Util.timestampToString((reporte.getContrato().getFechafin()), "dd/MM/yyyy");
			if(FechaRetiro!=""){
				celda.setCellValue(formatoFecha.format(formatoFecha.parse(FechaRetiro)));
			}else{
				celda.setCellValue(FechaRetiro);
			}
		}catch(Exception e){
			celda.setCellValue("");
		}
		
//		Cargo
		i++;
		celda = fila.createCell(i);
		String cargo = reporte.getCargo().getNombrecargo();
		celda.setCellValue(cargo);
		
		//Salario Mensual
		/**
		 * Mostramos el salario para algunos grupos.
		 * Grupos:
		 * 212 - Vicepresidente RRHH / Interno
		 * 213 - Gerente RRHH / Interno
		 * 214 - Director RRHH / Interno
		 */
		if(idDeGrupo==212 || idDeGrupo==213 || idDeGrupo==214){
			i++;
			celda = fila.createCell(i);
			String salarioMensual = reporte.getContrato().getInfosalarial();
			celda.setCellValue(salarioMensual);	
		}
		
		//Salario Integral
		/**
		 * Mostramos el salario para algunos grupos.
		 * Grupos:
		 * 212 - Vicepresidente RRHH / Interno
		 * 213 - Gerente RRHH / Interno
		 * 214 - Director RRHH / Interno
		 */
		if(idDeGrupo==212 || idDeGrupo==213 || idDeGrupo==214){
			i++;
			celda = fila.createCell(i);
			String salarioIntegral = "";
			celda.setCellValue(salarioIntegral);	
		}
		
//		encabezadoHojaCero.add("Área");
		i++;
		celda = fila.createCell(i);
		String area = reporte.getArea().getNombrearea();
		celda.setCellValue(area);
		
//		encabezadoHojaCero.add("Área asiganda");
		i++;
		celda = fila.createCell(i);
		String areaAsignada = reporte.getAreaAsignada().getNombrearea();
		celda.setCellValue(areaAsignada);
		
		
		//Número de Cuenta
		i++;
		celda = fila.createCell(i);
		String numeroDeCuenta = reporte.getEmpleadoBanco().getNumerocuenta();
		celda.setCellValue(numeroDeCuenta);
		
		//Banco
		i++;
		celda = fila.createCell(i);
		String nombreBanco = reporte.getBanco().getNombrebanco();
		celda.setCellValue(nombreBanco);		
	
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
