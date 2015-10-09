package co.sistemcobro.rrhh.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.Disciplina;
import co.sistemcobro.rrhh.bean.DisciplinaArchivo;
import co.sistemcobro.rrhh.bean.DisciplinaArchivoTipo;
import co.sistemcobro.rrhh.bean.DisciplinaEstado;
import co.sistemcobro.rrhh.bean.DisciplinaHistorial;
import co.sistemcobro.rrhh.bean.DisciplinaTestigo;
import co.sistemcobro.rrhh.bean.Falta;
import co.sistemcobro.rrhh.bean.Formato;
import co.sistemcobro.rrhh.bean.Sancion;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.ProcesoDisciplinarioEJB;
import co.sistemcobro.rrhh.util.FtpUtilCliente;

/**
 * Servlet para gestionar la información de los procesos disciplinarios de los empleados.
 * 
 * @author jpuentes
 */
@WebServlet(name = "ProcesoDisciplinario", urlPatterns = { "/page/disciplinario" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 20, maxRequestSize = 1024 * 1024 * 20)
public class ProcesoDisciplinarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private Logger log = Logger.getLogger(ProcesoDisciplinarioServlet.class);
	
	private final Long CREADO = (long)1;
	private final String DOCX = ".docx";
	private final String RUTA_ARCHIVOS = "archivos_disciplinarios";
	private final String RUTA_FORMATOS = "formatos_disciplinarios";
	
	@EJB
	ProcesoDisciplinarioEJB procesoDisciplinarioEJB;

	@EJB
	ContratoEJB contratoEJB;

	/**
	 * Constructor.
	 */
	public ProcesoDisciplinarioServlet() {
		super();
	}

	/**
	 * Método para responder y servir a las peticiones sobre procesos
	 * disciplinarios.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("action");

		if (accion.equals("verProcesoDisciplinario")) {
			verProcesoDisciplinarioPorIdContrato(request, response);
		} else if (accion.equals("crearProcesoDisciplinario")) {
			crearProcesoDisciplinario(request, response);
		} else if (accion.equals("cargarFaltasPorTipoDeFalta")) {
			cargarFaltasPorTipoDeFalta(request, response);
		} else if(accion.equals("cargarFaltasPorIdTipoDeFalta")){
			cargarFaltasPorIdTipoDeFalta(request, response);
		} else if (accion.equals("cargarDatosDeRecurrencia")) {
			cargarDatosDeRecurrencia(request, response);
		} else if (accion.equals("cargarDatosDeSancion")) {
			cargarDatosDeSancion(request, response);
		} else if (accion.equals("cargarDatosDeProcedimiento")) {
			cargarDatosDeProcedimiento(request, response);
		} else if (accion.equals("cargarDatosDeTestigos")) {
			cargarDatosDeTestigos(request, response);
		} else if (accion.equals("cargarFormatosDeFalta")) {
			cargarFormatosDeFalta(request, response);
		} else if (accion.equals("descargarFormato")) {
			descargarFormato(request, response);
		} else if (accion.equals("insertarProcesoDisciplinario")) {
			insertarProcesoDisciplinario(request, response);
		} else if (accion.equals("detalleProcesoDisciplinario")) {
			verDetalleProcesoDisciplinario(request, response);
		} else if(accion.equals("detalleProcesoDisciplinarioDesdeHistorial")){
			detalleProcesoDisciplinarioDesdeHistorial(request, response);
		} else if (accion.equals("eliminarDisciplina")) {
			desactivarDisciplina(request, response);
		} else if (accion.equals("activarDisciplina")) {
			activarDisciplina(request, response);
		}else if (accion.equals("descargarArchivo")) {
			descargarArchivo(request, response);
		}else if (accion.equals("verEditarProceso")) {
			verEditarProceso(request, response);
		}else if (accion.equals("insertarDisciplinaHistorial")) {
			insertarDisciplinaHistorial(request, response);
		}else if (accion.equals("verAdicionTestigo")) {
			verAdicionTestigo(request, response);
		}else if (accion.equals("insertarUnTestigo")) {
			insertarTestigo(request, response);
		}
	}

	/**
	 * Método para responder y servir a las peticion de ver el PROCESO
	 * DISCIPLINARIO que tiene un CONTRATO.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void verProcesoDisciplinarioPorIdContrato(HttpServletRequest request, HttpServletResponse response)throws IOException {
		try {
			String idContrato = request.getParameter("idcontrato");

			if (idContrato != null) {
				
				List<Disciplina> listaProcesosDisciplinarios = procesoDisciplinarioEJB.obtenerProcesoDisciplinarioPorIdContrato(Long.valueOf(idContrato));
				listaProcesosDisciplinarios = procesoDisciplinarioEJB.setearUltimoEstadoDeLProceso(listaProcesosDisciplinarios);
				
				Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idContrato));

				request.setAttribute("listaDisciplina",listaProcesosDisciplinarios);
				request.setAttribute("contrato", contrato);
			}
			request.getRequestDispatcher("../pages/disciplinario/contrato_historico_disciplinario.jsp").forward(request, response);
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de CREAR UN PROCESO
	 * DISCIPLINARIO asociado a un CONTRATO.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void crearProcesoDisciplinario(HttpServletRequest request,HttpServletResponse response) throws IOException {
		try {
			request.setAttribute("idcontrato",request.getParameter("idcontrato"));
			request.setAttribute("listaTiposFalta",procesoDisciplinarioEJB.obtenerTiposDeFaltas());
			request.setAttribute("listaFaltas",procesoDisciplinarioEJB.ObtenerTodasLasFaltas());
			request.setAttribute("listaTiposArchivos",procesoDisciplinarioEJB.obtenerListaDisciplinaArchivoTipo());
			request.getRequestDispatcher("../pages/disciplinario/nuevoProcesoDisciplinario.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de CARGAR LAS FALTAS POR
	 * TIPO DE FALTA y por IDCONTRATO. El idcontrato se usa para la inserción.
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
			
//			HttpSession session = request.getSession(false);
//			UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
//			Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
			
			String idFaltaTipo = request.getParameter("idFaltaTipo");
			String idContrato = request.getParameter("idContrato");
			
			List<Falta> listaDeFaltas = procesoDisciplinarioEJB.obtenerFaltasPorTipoFalta(Long.valueOf(idFaltaTipo));

			request.setAttribute("faltas", listaDeFaltas);
			request.setAttribute("idContrato", idContrato);

			request.getRequestDispatcher("../pages/disciplinario/listaFaltas.jsp").forward(request,response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de CARGAR LAS FALTAS POR
	 * TIPO DE FALTA.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarFaltasPorIdTipoDeFalta(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try {
			String idFaltaTipo = request.getParameter("idFaltaTipo");

			if(idFaltaTipo!=null){
				List<Falta> listaDeFaltas = procesoDisciplinarioEJB.obtenerFaltasPorTipoFalta(Long.valueOf(idFaltaTipo));
				request.setAttribute("faltas", listaDeFaltas);
				request.getRequestDispatcher("../pages/admin/listaDeFaltas.jsp").forward(request,response);
			}else{
				response.sendError(1,"Debe existir un id de tipo de falta.");
			}
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Método para responder y servir a las peticion de CARGAR LOS DATOS DE
	 * SANCION SEGUN LA FALTA.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarDatosDeRecurrencia(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idFalta = request.getParameter("idFalta");
			String idContrato = request.getParameter("idContrato");

			Integer recurrencia = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato));
			
			request.setAttribute("recurrencia",getRecurrenciaEnPalabras(recurrencia));
			request.setAttribute("recurrenciaEnNumero",recurrencia+1);
			
			request.getRequestDispatcher("../pages/disciplinario/datosDeRecurrencia.jsp").forward(
					request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de CARGAR LOS DATOS DE
	 * SANCION SEGUN LA FALTA.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarDatosDeSancion(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			
			HttpSession session = request.getSession(false);
			UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			Integer idGrupo = user.getUsuarioaplicacion().getIdgrupo();
			
			String idFalta = request.getParameter("idFalta");
			String idContrato = request.getParameter("idContrato");
			
			Integer recurrencia = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato));
			// Lo siguiente se hace porque se busca la sancion de la vez a la que rompe la norma.
            // Por ejemplo: Si recurrencia es 0 significa que será la primera vez, entonces consultamos la
			// sancion que se aplica cuando la recurrencia es 1 (Primera vez)
			recurrencia = recurrencia + 1; 
			
			Sancion sancionAplicada = null;
			
			if(idGrupo==216){//Analista Junior RRHH / Interno
				sancionAplicada = procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFaltaRecurrenciaYIdGrupo(Long.valueOf(idFalta), recurrencia, idGrupo);
			}else if(idGrupo==215){ //215 - Analista Senior RRHH / Interno
				Integer idGrupoUno = 215; 
				Integer idGrupoDos = 216; //Analista Junior RRHH / Interno
				sancionAplicada = procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFaltaRecurrenciaYIdGrupo(Long.valueOf(idFalta), recurrencia, idGrupoUno,idGrupoDos);	
			}else if(idGrupo==214 || idGrupo==213 || idGrupo==212){//212 - Vicepresidente RRHH / Interno 213 - Gerente RRHH / Interno 214 - Director RRHH / Interno
				//No importa el grupo, puede ver la sanción.
				sancionAplicada=procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFalta(Long.valueOf(idFalta), recurrencia);
			}
			//sancionAplicada = procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFaltaRecurrenciaYIdGrupo(Long.valueOf(idFalta), recurrencia, idGrupo);
			request.setAttribute("sancion", sancionAplicada);

			request.getRequestDispatcher("../pages/disciplinario/datosDeSancion.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de cargar el PROCEDIMIENTO
	 * segun la falta.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarDatosDeProcedimiento(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession(false);
			UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			Integer idGrupo = user.getUsuarioaplicacion().getIdgrupo();
			
			String idFalta = request.getParameter("idFalta");
			String idContrato = request.getParameter("idContrato");
			
			Integer recurrencia = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato));
			
			//Lo siguiente se hace porque se busca la sancion de la vez a la que rompe la norma.
            // Por ejemplo: Si recurrencia es 0 significa que será la primera vez, entonces consultamos la
			// sancion que se aplica cuando la recurrencia es 1 (Primera vez)
			recurrencia = recurrencia + 1; 
			
			Sancion sancionAplicada = null;
			
			if(idGrupo==216){//Analista Junior RRHH / Interno
				
				sancionAplicada = procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFaltaRecurrenciaYIdGrupo(Long.valueOf(idFalta), recurrencia, idGrupo);
				
			}else if(idGrupo==215){ //215 - Analista Senior RRHH / Interno
				Integer idGrupoUno = 215; 
				Integer idGrupoDos = 216; //Analista Junior RRHH / Interno
				sancionAplicada = procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFaltaRecurrenciaYIdGrupo(Long.valueOf(idFalta), recurrencia, idGrupoUno,idGrupoDos);	
				
			}else if(idGrupo==214 || idGrupo==213 || idGrupo==212){//212 - Vicepresidente RRHH / Interno 213 - Gerente RRHH / Interno 214 - Director RRHH / Interno
				//No importa el grupo, puede ver la sanción.
				sancionAplicada=procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFalta(Long.valueOf(idFalta), recurrencia);
			}
			//request.setAttribute("sancion", procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFalta(Long.valueOf(idFalta),recurrencia));
			
			request.setAttribute("sancion", sancionAplicada);
			request.getRequestDispatcher("../pages/disciplinario/datosDeProcedimiento.jsp").forward(
					request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de cargar datos de testigos
	 * segun la falta.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarDatosDeTestigos(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// String idFalta = request.getParameter("idFalta");
			// request.setAttribute("sancion",
			// procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFalta(Long.valueOf(idFalta)));
			request.setAttribute("nombre", "Datos de testigos.");
			request.getRequestDispatcher(
					"../pages/disciplinario/datosTestigos.jsp").forward(
					request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para responder y servir a las peticion de cargar los fotmatos
	 * disponibles según la falta.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void cargarFormatosDeFalta(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idFalta = request.getParameter("idFalta");
			String idContrato = request.getParameter("idContrato");
			
			Integer recurrencia = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato));
			
			//Lo siguiente se hace porque se busca los formatos de la sancion de la vez a la que rompe la norma.
            // Por ejemplo: Si recurrencia es 0 significa que será la primera vez, entonces consultamos los formatosde la 
			// sancion que se aplica cuando la recurrencia es 1 (Primera vez)
			recurrencia = recurrencia + 1; 
			
//			request.setAttribute("listaFormatos", procesoDisciplinarioEJB.obtenerListaDeFormatosPorIdFalta(Long.valueOf(idFalta)));
			request.setAttribute("listaFormatos", procesoDisciplinarioEJB.obtenerListaDeFormatosPorIdFaltaYRecurrencia(Long.valueOf(idFalta),recurrencia));
			request.getRequestDispatcher("../pages/disciplinario/listaDeFormatos.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para gestionar la descarga de los formatos de cada sanción.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void descargarFormato(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String idFormato = request.getParameter("idFormato");
			
		    idFormato = idFormato == null ? "" : idFormato.trim();
		        
		    if ("".equals(idFormato)) {
		       throw new NullPointerException("Se requiere un id de formato.");
		    }
		    
		    Formato formatoDescargar = procesoDisciplinarioEJB.obtenerFormatoId(Long.valueOf(idFormato));
		    
		    byte[] bytes = FtpUtilCliente.downloadFTP(formatoDescargar.getRutaformato(),RUTA_FORMATOS);
		    
		    response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
		    response.setContentLength(bytes.length);
			ServletOutputStream  ouputStream= response.getOutputStream();
			
			String nombreArchivo = formatoDescargar.getNombreformato();
				
			response.setHeader("Content-disposition", "attachment; filename=\"" + nombreArchivo+DOCX + "\"");
			ouputStream.write(bytes);
			ouputStream.close();
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}

	/**
	 * Método para gestionar la descarga de los archivos asociados a un proceso.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void descargarArchivo(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String idDisciplinaArchivo = request.getParameter("idDisciplinaArchivo");
			
			idDisciplinaArchivo = idDisciplinaArchivo == null ? "" : idDisciplinaArchivo.trim();
		        
		    if ("".equals(idDisciplinaArchivo)) {
		       throw new NullPointerException("Se requiere un id de disciplina_archivo.");
		    }
		    
		    DisciplinaArchivo archivoDescargar = procesoDisciplinarioEJB.obtenerDisciplinaArchivoPorId(Long.valueOf(idDisciplinaArchivo));
		    
		    byte[] bytes = FtpUtilCliente.downloadFTP(archivoDescargar.getRutaarchivo(),RUTA_ARCHIVOS);
		    
		    response.setContentType("application/octet-stream");
		    response.setContentLength(bytes.length);
			ServletOutputStream  ouputStream= response.getOutputStream();
			
			String nombreArchivo = archivoDescargar.getNombrearchivo();
				
			response.setHeader("Content-disposition", "attachment; filename=\"" + nombreArchivo + "\"");
			ouputStream.write(bytes);
			ouputStream.close();
			
		} catch (Exception e) {
			log.info("Error al descargar el archivo: e"+e);
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Método para insertar un nuevo proceso disciplinario.
	 * 
	 * @param HttpServletRequest
	 *            la petición.
	 * @param HttpServletResponse
	 *            la respuesta.
	 */
	private void insertarProcesoDisciplinario(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
//		Long IDEMPLEADOTEMPORAL = Long.valueOf(1);
		List<DatoArchivo> listaArchivos = new ArrayList<DatoArchivo>();
		
		try {
			
			String idContrato = Archivo.getParameter(request.getPart("idcontrato"));
			String idFalta = Archivo.getParameter(request.getPart("idFaltaAsignada"));
			String observacionUno = Archivo.getParameter(request.getPart("observacionUno"));
			String recurrenciaNumero = Archivo.getParameter(request.getPart("recurrenciaNumero"));
			String creadorProceso = Archivo.getParameter(request.getPart("creador"));
			
			String datoDePrueba = Archivo.getParameter(request.getPart("datoDePrueba"));
			
			String idSancion = Archivo.getParameter(request.getPart("idSancion"));
			
			
			log.info("IdContrato es = "+idContrato);
			log.info("IdFalta es = "+idFalta);
			log.info("IdSancion es = "+idSancion);
			log.info("Recurrencia número es = "+recurrenciaNumero);
			log.info("Dato de prueba es = "+datoDePrueba);
			
						
			Part partUno = request.getPart("archivoUno");
			Part partDos = request.getPart("archivoDos");
			Part partTres = request.getPart("archivoTres");
			Part partCuatro = request.getPart("archivoCuatro");
			Part partCinco = request.getPart("archivoCinco");
			Part partSeis = request.getPart("archivoSeis");

//			String observacionDos = request.getParameter("observacionDos");

			idContrato = idContrato == null ? "" : idContrato.trim();
			idFalta = idFalta == null ? "" : idFalta.trim();
			observacionUno = observacionUno == null ? "" : observacionUno.trim();
//			observacionDos = observacionDos == null ? "" : observacionDos.trim();
			recurrenciaNumero = recurrenciaNumero == null ? "" : recurrenciaNumero.trim();
			creadorProceso = creadorProceso == null ? "" : creadorProceso.trim();
			idSancion = idSancion == null ? "" : idSancion.trim();
			
			// Si los archivos son diferentes de null entonces, adicioanr a la
			// lista.
			if (isNullPart(partUno)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partUno);
				String idArchivoTipoUno = Archivo.getParameter(request.getPart("idtipoarchivoUno"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoUno));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partDos)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partDos);
				String idArchivoTipoDos = Archivo.getParameter(request.getPart("idtipoarchivoDos"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoDos));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partTres)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partTres);
				String idArchivoTipoTres = Archivo.getParameter(request.getPart("idtipoarchivoTres"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoTres));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partCuatro)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partCuatro);
				String idArchivoTipoCuatro = Archivo.getParameter(request.getPart("idtipoarchivoCuatro"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoCuatro));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partCinco)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partCinco);
				String idArchivoTipoCinco = Archivo.getParameter(request.getPart("idtipoarchivoCinco"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoCinco));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partSeis)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partSeis);
				String idArchivoTipoSeis = Archivo.getParameter(request.getPart("idtipoarchivoSeis"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoSeis));
				listaArchivos.add(archivo);
			}

			if (idContrato != null && !idContrato.equals("") && idFalta != null && !idFalta.equals("")) {

				Integer a = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato))+1;
//				Long idSancionn = procesoDisciplinarioEJB.obtenerSancionPorIdFalta(Long.valueOf(idFalta)).getIdsancion();
				Long idSancionn = procesoDisciplinarioEJB.obtenerSancionDeFaltaPorIdFalta(Long.valueOf(idFalta), a).getIdsancion();
				
				log.info("Idsancionn  es= "+idSancionn);
				
				
				
				Disciplina nuevoProcesoDisciplinario = new Disciplina();
				
//				nuevoProcesoDisciplinario.setIdsancion(Long.valueOf(idSancion));
				nuevoProcesoDisciplinario.setIdsancion(idSancionn);
				nuevoProcesoDisciplinario.setIdcontrato(Long.valueOf(idContrato));
				nuevoProcesoDisciplinario.setIdusuariocrea(user.getCodusuario());
				nuevoProcesoDisciplinario.setEstado(EstadoEnum.ACTIVO.getIndex());
				nuevoProcesoDisciplinario.setRecurrenciaPorFalta(getRecurrenciaDetalle(procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato))+1));
				
				log.info("Va a insertar nuevaDisciplina.");
				
				nuevoProcesoDisciplinario = procesoDisciplinarioEJB.insertarNuevaDisciplina(nuevoProcesoDisciplinario); // OK.
				
				log.info("Debio insertar la nuevaDisciplina.");
				
				if (nuevoProcesoDisciplinario.getIddisciplina() != null && nuevoProcesoDisciplinario.getIddisciplina() != 0) {
//					
						// Insertar en disciplina historial						
						DisciplinaHistorial disciplinaHistorial = new DisciplinaHistorial();

						disciplinaHistorial.setIddisciplina(nuevoProcesoDisciplinario.getIddisciplina());
						disciplinaHistorial.setIddisciplinaestado(this.CREADO);
						disciplinaHistorial.setObservacion(observacionUno);
						disciplinaHistorial.setCreadorProceso(creadorProceso);
						disciplinaHistorial.setIdusuariocrea(user.getCodusuario());
						disciplinaHistorial.setEstado(EstadoEnum.ACTIVO.getIndex());
						
						log.info("Va a insertar la disciplina hsitorial.");
						
						disciplinaHistorial = procesoDisciplinarioEJB.insertarDisciplinaHistorial(disciplinaHistorial);
						
						log.info("debio insertar la disciplina hsitorial.");
						
						if (disciplinaHistorial.getIddisciplinahistorial() != null && disciplinaHistorial.getIddisciplinahistorial() != 0) {
							
							//Insercion de archivos.
							if (!listaArchivos.isEmpty()) {
								
								Long idDisciplinaHistorial = disciplinaHistorial.getIddisciplinahistorial();
								DisciplinaArchivo archivo = null;
								byte[] bytes = null;
										
								for(DatoArchivo dato : listaArchivos){
									Part parte = dato.getPart();
									InputStream flujo = parte.getInputStream();
									bytes = new byte[flujo.available()];
									flujo.read(bytes);
									String nombreCompletoArchivo = Archivo.getFullName(parte);
									
									if(!nombreCompletoArchivo.equals("")|| !nombreCompletoArchivo.equals(null)){
										
										archivo = new DisciplinaArchivo();
										archivo.setIddisciplinaarchivotipo(dato.getIdDisciplinaArchivoTipo());
										archivo.setIddisciplinahistorial(idDisciplinaHistorial);
										archivo.setNombrearchivo(nombreCompletoArchivo);
										archivo.setTamanio(Long.valueOf(0));
										archivo.setRutaarchivo(nombreCompletoArchivo);
										archivo.setIdusuariocrea(user.getCodusuario());
										archivo.setEstado(EstadoEnum.DESHABILITADO.getIndex());
										
										DisciplinaArchivo resultado = procesoDisciplinarioEJB.insertarDisciplinaArchivo(archivo);
										
										InputStream flujoArchivo = parte.getInputStream();
										flujoArchivo.read(bytes);
										
										String nombreArchivoCargarAFTP = Constante.ROOT_FILE_TEMPORARY + File.separator + "historial_"+resultado.getIddisciplinaarchivo()+"_"+"contrato_"+idContrato+"_"+nombreCompletoArchivo;
										
										File archivoListo = new File(nombreArchivoCargarAFTP);
										FileOutputStream flujoSalida = new FileOutputStream(archivoListo);
										flujoSalida.write(bytes);
										flujoArchivo.close();
										flujoSalida.close();
										
										if (FtpUtilCliente.uploadFTP(archivoListo,RUTA_ARCHIVOS)) {
											
											resultado.setRutaarchivo(archivoListo.getName());
								   			resultado.setIdusuariomod(user.getCodusuario());
								   			resultado.setTamanio(archivoListo.length());
								   			resultado.setEstado(EstadoEnum.ACTIVO.getIndex());
								   			
								   			resultado = procesoDisciplinarioEJB.actualizarRutaArchivoCargado(resultado);
								   			
								   			if(resultado!=null && resultado.getIddisciplinaarchivo()!=0){
								   				log.info("Inserto con archivos.");
								   				PrintWriter salida = response.getWriter();
									   			salida.println(nuevoProcesoDisciplinario.getIdcontrato());
									   			salida.close();
								   			}else{
								   				throw new LogicaException("Error al guardar el registro");
								   			}
										}else{
								   			log.info("Error enviando archivo en FTP");
								   			throw new LogicaException("Error enviando archivo en FTP");
								   		}
									}else{
										throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
									}
									
								}
								
							}else{
								log.info("Inserto sin archivos.");
				   				PrintWriter salida = response.getWriter();
					   			salida.println(nuevoProcesoDisciplinario.getIdcontrato());
					   			salida.close();
							}
						}else {
							throw new LogicaException("Error al grabar el historial de disciplina");
						}
				} else {
					throw new LogicaException("Error al grabar la nueva afiliación.");
				}

			} else {
				log.info("Exiten parametros con valores nulos.");
				throw new LogicaException("Error al grabar el nuevo proceso disciplinario.");
			}
		} catch (Exception e) {
			log.info("Exception al crear el proceso disciplinario = " + e);
			response.sendError(1, e.toString());
		}

	}

	/**
	 * Método para mostrar el detalle de un  proceso disciplinario específico.
	 * 
	 * @param HttpServletRequest.la petición.
	 * @param HttpServletResponse. la respuesta.
	 * @throws IOException 
	 */
	private void verDetalleProcesoDisciplinario(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			String idDisciplina = request.getParameter("idDisciplina");
			String idSancion = request.getParameter("idSancion");
//			String idContrato = request.getParameter("idContrato");
//			String idFalta = request.getParameter("idFalta");
			
			Long idDisciplinaTemporal;
			Long idSancionTemporal;
			
			idDisciplina = idDisciplina == null ? "" : idDisciplina.trim();
			idSancion = idSancion == null ? "" : idSancion.trim();
			
			if ("".equals(idDisciplina)) {
				throw new NullPointerException("Se requiere un idDisciplina");
			} else {
				idDisciplinaTemporal = Long.valueOf(idDisciplina);
			}
			
			if ("".equals(idSancion)) {
				throw new NullPointerException("Se requiere un idSancion");
			} else {
				idSancionTemporal = Long.valueOf(idSancion);
			}
			
			Disciplina detalleDisciplina = procesoDisciplinarioEJB.obtenerDetalleProcesoDisciplinario(idDisciplinaTemporal);
			
//			Integer recurrecia = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato));
			
			List<Formato> listaFormatos = procesoDisciplinarioEJB.obtenerFormatosPorIdSancion(idSancionTemporal);
			
			List<DisciplinaTestigo> listaTestigos = procesoDisciplinarioEJB.obtenerListaDisciplinaTestigo(idDisciplinaTemporal);
			
			listaTestigos = procesoDisciplinarioEJB.setearEmpleadosComoTestigos(listaTestigos);
			
			List<DisciplinaArchivo> listaArchivos = procesoDisciplinarioEJB.obtenerListaArchivosPorIdDisciplina(idDisciplinaTemporal);
			
			List<DisciplinaHistorial> disciplinaHistorial = procesoDisciplinarioEJB.obtenerDisciplinaHistorialPorIdDisciplina(idDisciplinaTemporal);
			
			disciplinaHistorial = procesoDisciplinarioEJB.setearArchivosAsociadosACadaHhistorial(disciplinaHistorial);
						
			DisciplinaEstado estadoActual = procesoDisciplinarioEJB.obtenerUltimoEstadoDisciplinaHistorial(Long.valueOf(idDisciplina));
			
			Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
			Long idEstadoActual = estadoActual.getIddisciplinaestado();
			
			List<DisciplinaArchivoTipo> listaTiposArchivos = procesoDisciplinarioEJB.obtenerListaDisciplinaArchivoTipo();
			List<DisciplinaEstado> listaEstados = procesoDisciplinarioEJB.obtenerListaEstadosPorGrupoYEstadoActual(idDeGrupo,idEstadoActual);
			
			request.setAttribute("disciplinaEstado", estadoActual);
			request.setAttribute("idDisciplina", idDisciplina);
			request.setAttribute("listaEstados",listaEstados);
			request.setAttribute("listaTiposArchivos",listaTiposArchivos);
								  
			
			request.setAttribute("idDisciplina", idDisciplina);
			request.setAttribute("estado",procesoDisciplinarioEJB.obtenerUltimoEstadoDisciplinaHistorial(idDisciplinaTemporal).getEstadodisciplina());
			request.setAttribute("detalleDisciplina", detalleDisciplina);
			request.setAttribute("recurrencia",detalleDisciplina.getRecurrenciaPorFalta());
			request.setAttribute("listaFormatos", listaFormatos);
			request.setAttribute("listaTestigos", listaTestigos);
			request.setAttribute("listaArchivos", listaArchivos);
			request.setAttribute("disciplinaHistorial",disciplinaHistorial);
			
			request.getRequestDispatcher("../pages/disciplinario/detalleProcesoDisciplinario.jsp").forward(request,response);
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}	
	}
	
		
	/**
	 * Método para mostrar el detalle de un  proceso disciplinario específico desde el historial.
	 * 
	 * @param HttpServletRequest.la petición.
	 * @param HttpServletResponse. la respuesta.
	 * @throws IOException 
	 */
	private void detalleProcesoDisciplinarioDesdeHistorial(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try{
			String idDisciplina = request.getParameter("idDisciplina");
			String idSancion = request.getParameter("idSancion");
			String arregloIdAreas[] = request.getParameterValues("listaIdAreas");
			
			List<String> listaIdAreas = new ArrayList<String>();
			
			for (String idArea : arregloIdAreas) {
				if (!idArea.equals("null")) {
					if (!idArea.equals("")) {
						listaIdAreas.add(idArea);
					}
				} else {
					throw new LogicaException("Debe seleccionar una área.");
				}
			}
			
			Long idDisciplinaTemporal;
			Long idSancionTemporal;
			
			idDisciplina = idDisciplina == null ? "" : idDisciplina.trim();
			idSancion = idSancion == null ? "" : idSancion.trim();
			
			if ("".equals(idDisciplina)) {
				throw new NullPointerException("Se requiere un idDisciplina");
			} else {
				idDisciplinaTemporal = Long.valueOf(idDisciplina);
			}
			
			if ("".equals(idSancion)) {
				throw new NullPointerException("Se requiere un idSancion");
			} else {
				idSancionTemporal = Long.valueOf(idSancion);
			}
			
			Disciplina detalleDisciplina = procesoDisciplinarioEJB.obtenerDetalleProcesoDisciplinario(idDisciplinaTemporal);
			
//			Integer recurrecia = procesoDisciplinarioEJB.obtenerRecurrenciaDeFaltaPorContrato(Long.valueOf(idFalta), Long.valueOf(idContrato));
			
			List<Formato> listaFormatos = procesoDisciplinarioEJB.obtenerFormatosPorIdSancion(idSancionTemporal);
			
			List<DisciplinaTestigo> listaTestigos = procesoDisciplinarioEJB.obtenerListaDisciplinaTestigo(idDisciplinaTemporal);
			
			listaTestigos = procesoDisciplinarioEJB.setearEmpleadosComoTestigos(listaTestigos);
			
			List<DisciplinaArchivo> listaArchivos = procesoDisciplinarioEJB.obtenerListaArchivosPorIdDisciplina(idDisciplinaTemporal);
			
			List<DisciplinaHistorial> disciplinaHistorial = procesoDisciplinarioEJB.obtenerDisciplinaHistorialPorIdDisciplina(idDisciplinaTemporal);
			
			disciplinaHistorial = procesoDisciplinarioEJB.setearArchivosAsociadosACadaHhistorial(disciplinaHistorial);
						
			DisciplinaEstado estadoActual = procesoDisciplinarioEJB.obtenerUltimoEstadoDisciplinaHistorial(Long.valueOf(idDisciplina));
			
			Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
			Long idEstadoActual = estadoActual.getIddisciplinaestado();
			
			List<DisciplinaArchivoTipo> listaTiposArchivos = procesoDisciplinarioEJB.obtenerListaDisciplinaArchivoTipo();
			List<DisciplinaEstado> listaEstados = procesoDisciplinarioEJB.obtenerListaEstadosPorGrupoYEstadoActual(idDeGrupo,idEstadoActual);
			
			request.setAttribute("disciplinaEstado", estadoActual);
			request.setAttribute("idDisciplina", idDisciplina);
			request.setAttribute("listaEstados",listaEstados);
			request.setAttribute("listaTiposArchivos",listaTiposArchivos);
			
			request.setAttribute("listaIdAreas",listaIdAreas);
			
			request.setAttribute("idDisciplina", idDisciplina);
			request.setAttribute("estado",procesoDisciplinarioEJB.obtenerUltimoEstadoDisciplinaHistorial(idDisciplinaTemporal).getEstadodisciplina());
			request.setAttribute("detalleDisciplina", detalleDisciplina);
			request.setAttribute("recurrencia",detalleDisciplina.getRecurrenciaPorFalta());
			request.setAttribute("listaFormatos", listaFormatos);
			request.setAttribute("listaTestigos", listaTestigos);
			request.setAttribute("listaArchivos", listaArchivos);
			request.setAttribute("disciplinaHistorial",disciplinaHistorial);
			
			request.getRequestDispatcher("../pages/reportes/detalleProcesoDisciplinarioDesdeHistorial.jsp").forward(request,response);
			
		} catch (Exception e) {
			log.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}	
	}
	
	
	/**
	 * Método para cambiar el estado a ELIMINADO a la relacion rrhh.Disciplina.
	 * @param HttpServletRequest.la petición.
	 * @param HttpServletResponse. la respuesta.
	 * @throws IOException 
	 */
	private void desactivarDisciplina(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idDisciplina = request.getParameter("idDisciplina");
			String idContrato = request.getParameter("idContrato");

			idDisciplina = idDisciplina == null ? "": idDisciplina.trim();
			idContrato = idContrato == null ? "": idContrato.trim();

			Disciplina disciplinaDesactivar = new Disciplina();
			disciplinaDesactivar.setIddisciplina(Long.valueOf(idDisciplina));
			disciplinaDesactivar.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = procesoDisciplinarioEJB.desactivarDisciplina(disciplinaDesactivar);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idContrato));
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
	 * Método para cambiar el estado a HABILITADO a la relacion rrhh.Disciplina.
	 * @param HttpServletRequest.la petición.
	 * @param HttpServletResponse. la respuesta.
	 * @throws IOException 
	 */
	private void activarDisciplina(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idDisciplina = request.getParameter("idDisciplina");
			String idContrato = request.getParameter("idContrato");

			idDisciplina = idDisciplina == null ? "": idDisciplina.trim();
			idContrato = idContrato == null ? "": idContrato.trim();

			Disciplina disciplinaDesactivar = new Disciplina();
			disciplinaDesactivar.setIddisciplina(Long.valueOf(idDisciplina));
			disciplinaDesactivar.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = procesoDisciplinarioEJB.activarDisciplina(disciplinaDesactivar);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idContrato));
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
	 * Método para responder a la acción editar empleado afiliacion
	 * @param  HttpServletRequest la petición.
	 * @param HttpServletResponse la respuesta.
	 * @throws IOException,ServletException
	 */
	private void verEditarProceso(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		try {
			
			HttpSession session = request.getSession(false);
			UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			
			String idDisciplina = request.getParameter("idDisciplina");
			
			if (idDisciplina != null) {
				
				DisciplinaEstado estadoActual = procesoDisciplinarioEJB.obtenerUltimoEstadoDisciplinaHistorial(Long.valueOf(idDisciplina));
				
				Integer idDeGrupo = user.getUsuarioaplicacion().getIdgrupo();
				Long idEstadoActual = estadoActual.getIddisciplinaestado();
				
				List<DisciplinaArchivoTipo> listaTiposArchivos = procesoDisciplinarioEJB.obtenerListaDisciplinaArchivoTipo();
				List<DisciplinaEstado> listaEstados = procesoDisciplinarioEJB.obtenerListaEstadosPorGrupoYEstadoActual(idDeGrupo,idEstadoActual);
				
				request.setAttribute("disciplinaEstado", estadoActual);
				request.setAttribute("idDisciplina", idDisciplina);
				request.setAttribute("listaEstados",listaEstados);
				request.setAttribute("listaTiposArchivos",listaTiposArchivos);
			}
			
			request.getRequestDispatcher("../pages/disciplinario/editarProcesoDisciplinario.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Método para insertar un nuevo historial de disciplina al editar el estado de un proceso disciplinario.
	 * 
	 * @param HttpServletRequest
	 *            la petición.
	 * @param HttpServletResponse
	 *            la respuesta.
	 */
	private void insertarDisciplinaHistorial(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		List<DatoArchivo> listaArchivos = new ArrayList<DatoArchivo>();
		
		try {
			
			String idContrato = Archivo.getParameter(request.getPart("idContrato"));
			String idDisciplina = Archivo.getParameter(request.getPart("idDisciplina"));
			String idEstadoSeleccionado =  Archivo.getParameter(request.getPart("idEstadoSeleccionado"));
			String comentarioRevision = Archivo.getParameter(request.getPart("comentarioRevision"));
			String usuarioCreador = Archivo.getParameter(request.getPart("usuarioCreador"));
			
			Part partUno = request.getPart("archivoUnoDetalle");
			Part partDos = request.getPart("archivoDosDetalle");
			Part partTres = request.getPart("archivoTresDetalle");
			Part partCuatro = request.getPart("archivoCuatroDetalle");
			Part partCinco = request.getPart("archivoCincoDetalle");
			Part partSeis = request.getPart("archivoSeisDetalle");

			idContrato = idContrato == null ? "" : idContrato.trim();
			idDisciplina = idDisciplina == null ? "" : idDisciplina.trim();
			idEstadoSeleccionado = idEstadoSeleccionado == null ? "" : idEstadoSeleccionado.trim();
			comentarioRevision = comentarioRevision == null ? "" : comentarioRevision.trim();
			usuarioCreador = usuarioCreador == null ? "" : usuarioCreador.trim();
						
			// Si los archivos son diferentes de null entonces, adicioanr a la lista.
		
			if (isNullPart(partUno)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partUno);
				String idArchivoTipoUno = Archivo.getParameter(request.getPart("idtipoarchivoUno"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoUno));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partDos)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partDos);
				String idArchivoTipoDos = Archivo.getParameter(request.getPart("idtipoarchivoDos"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoDos));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partTres)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partTres);
				String idArchivoTipoTres = Archivo.getParameter(request.getPart("idtipoarchivoTres"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoTres));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partCuatro)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partCuatro);
				String idArchivoTipoCuatro = Archivo.getParameter(request.getPart("idtipoarchivoCuatro"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoCuatro));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partCinco)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partCinco);
				String idArchivoTipoCinco = Archivo.getParameter(request.getPart("idtipoarchivoCinco"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoCinco));
				listaArchivos.add(archivo);
			}
			if (isNullPart(partSeis)==false) {
				DatoArchivo archivo = new DatoArchivo();
				archivo.setPart(partSeis);
				String idArchivoTipoSeis = Archivo.getParameter(request.getPart("idtipoarchivoSeis"));
				archivo.setIdDisciplinaArchivoTipo(Long.valueOf(idArchivoTipoSeis));
				listaArchivos.add(archivo);
			}

			if (idContrato != null && !idContrato.equals("") && idDisciplina != null && !idDisciplina.equals("")) {
				
				DisciplinaHistorial disciplinaHistorial =  new DisciplinaHistorial();
				disciplinaHistorial.setIddisciplina(Long.valueOf(idDisciplina));
				disciplinaHistorial.setIddisciplinaestado(Long.valueOf(idEstadoSeleccionado));
				disciplinaHistorial.setObservacion(comentarioRevision);
				disciplinaHistorial.setIdusuariocrea(user.getCodusuario());
				disciplinaHistorial.setEstado(EstadoEnum.ACTIVO.getIndex());
				disciplinaHistorial.setCreadorProceso(usuarioCreador);
				
				disciplinaHistorial = procesoDisciplinarioEJB.insertarNuevoDisciplinaHistorial(disciplinaHistorial); 
				
				if (disciplinaHistorial.getIddisciplinahistorial() != null && disciplinaHistorial.getIddisciplinahistorial() != 0) {
					
					//Inserción de archivos.
					if (!listaArchivos.isEmpty()) {
						
						Long idDisciplinaHistorial = disciplinaHistorial.getIddisciplinahistorial();
						DisciplinaArchivo archivo = null;
						byte[] bytes = null;
								
						for(DatoArchivo dato : listaArchivos){
							Part parte = dato.getPart();
							InputStream flujo = parte.getInputStream();
							bytes = new byte[flujo.available()];
							flujo.read(bytes);
							String nombreCompletoArchivo = Archivo.getFullName(parte);
							
							if(!nombreCompletoArchivo.equals("")|| !nombreCompletoArchivo.equals(null)){
								
								archivo = new DisciplinaArchivo();
								archivo.setIddisciplinaarchivotipo(dato.getIdDisciplinaArchivoTipo());
								archivo.setIddisciplinahistorial(idDisciplinaHistorial);
								archivo.setNombrearchivo(nombreCompletoArchivo);
								archivo.setTamanio(Long.valueOf(0));
								archivo.setRutaarchivo(nombreCompletoArchivo);
								archivo.setIdusuariocrea(user.getCodusuario());
								archivo.setEstado(EstadoEnum.DESHABILITADO.getIndex());
								
								DisciplinaArchivo resultado = procesoDisciplinarioEJB.insertarDisciplinaArchivo(archivo);
								
								InputStream flujoArchivo = parte.getInputStream();
								flujoArchivo.read(bytes);
								
								String nombreArchivoCargarAFTP = Constante.ROOT_FILE_TEMPORARY + File.separator + "historial_"+resultado.getIddisciplinaarchivo()+"_"+"contrato_"+idContrato+"_"+nombreCompletoArchivo;
								
								File archivoListo = new File(nombreArchivoCargarAFTP);
								FileOutputStream flujoSalida = new FileOutputStream(archivoListo);
								flujoSalida.write(bytes);
								flujoArchivo.close();
								flujoSalida.close();
								
								if (FtpUtilCliente.uploadFTP(archivoListo,RUTA_ARCHIVOS)) {
									
									resultado.setRutaarchivo(archivoListo.getName());
						   			resultado.setIdusuariomod(user.getCodusuario());
						   			resultado.setTamanio(archivoListo.length());
						   			resultado.setEstado(EstadoEnum.ACTIVO.getIndex());
						   			
						   			resultado = procesoDisciplinarioEJB.actualizarRutaArchivoCargado(resultado);
						   			
						   			if(resultado.getIddisciplinaarchivo()!=null && resultado.getIddisciplinaarchivo()!=0){
						   				PrintWriter salida = response.getWriter();
							   			salida.println(Long.valueOf(idContrato));
							   			salida.close();
						   			}else{
						   				throw new LogicaException("Error al guardar el registro");
						   			}
								}else{
						   			log.info("Error enviando archivo en FTP");
						   			throw new LogicaException("Error enviando archivo en FTP");
						   		}
							}else{
								throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
							}
						}
						
					}else{
						log.info("NO hay archivos para subir,");
					}
					
				}else{
					throw new LogicaException("Error al grabar el historial de disciplina");
				}
				
			} else {
				throw new LogicaException("Error al grabar el nuevo proceso disciplinario.");
			}
		} catch (Exception e) {
			log.info("Exception al crear el proceso disciplinario = " + e);
			response.sendError(1, e.toString());
		}

	}
	
	
	/**
	 * Método para mostrar la ventana de busqueda de los testigos.
	 * 
	 * @param HttpServletRequest
	 *            la petición.
	 * @param HttpServletResponse
	 *            la respuesta.
	 */
	private void verAdicionTestigo(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String idDisciplina = request.getParameter("idDisciplina");
			String idSancion = request.getParameter("idSancion");
			String idContrato = request.getParameter("idContrato");
			String idFalta = request.getParameter("idFalta");
			
			if (idDisciplina != null) {
				request.setAttribute("idDisciplinas", idDisciplina);
				request.setAttribute("idSancions", idSancion);
				request.setAttribute("idContratos", idContrato);
				request.setAttribute("idFaltas", idFalta);
			}
			
			request.getRequestDispatcher("../pages/disciplinario/buscarTestigo.jsp").forward(request, response);
			
		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
		
	}
	
	
	
	/**
	 * Insertar un nuevo testigo del proceso.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException 
	 * 
	 */
	private void insertarTestigo(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idEmpleado = request.getParameter("idEmpleado");
			String idDisciplina = request.getParameter("idDisciplina");
			
			idEmpleado = idEmpleado == null ? "" : idEmpleado.trim();
			idDisciplina = idDisciplina == null ? "" : idDisciplina.trim();
			
			if(idEmpleado!=null && idEmpleado!="" && idDisciplina!=null && idDisciplina!=""){
				
				if(procesoDisciplinarioEJB.empleadoEsTestigo(Long.valueOf(idEmpleado), Long.valueOf(idDisciplina))){
					throw new LogicaException("El empleado ya es testigo de este proceso.");
				}else{
				
					DisciplinaTestigo disciplinaTestigo =  new DisciplinaTestigo();
					
					disciplinaTestigo.setIddisciplina(Long.valueOf(idDisciplina));
					disciplinaTestigo.setIdempleado(Long.valueOf(idEmpleado));
					disciplinaTestigo.setIdusuariocrea(user.getCodusuario());
					disciplinaTestigo.setEstado(EstadoEnum.ACTIVO.getIndex());
										
					disciplinaTestigo = procesoDisciplinarioEJB.insertarDisciplinaTestigo(disciplinaTestigo);
										
					if(disciplinaTestigo.getIddisciplinatestigo()!=null && disciplinaTestigo.getIddisciplinatestigo()!=0){
						PrintWriter salida = response.getWriter();
			   			salida.println(Long.valueOf(disciplinaTestigo.getIddisciplina()));
			   			salida.close();
					}else{
						throw new LogicaException("Error al guardar el testigo.");
					}
				}
			}else{
				throw new LogicaException("Error al grabar el nuevo testigo.");
			}
		}catch(Exception e ){
			log.info("Exception al crear el proceso disciplinario = " + e);
			response.sendError(1, e.toString());
		}
		
	}
	
	/**
	 * Método para saber si objeto Part es nulo o no.
	 * 
	 * @param Part
	 *            .
	 * @return boolean.
	 */
	private boolean isNullPart(Part part) {
		if(part.getSize()>0){
			return false;
		}else{
			return true;
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
	private String getRecurrenciaEnPalabras(Integer numeroVeces) {
		String respuesta = "";

		switch (numeroVeces) {
		case 0:
			respuesta = "Primera vez";
			break;
		case 1:
			respuesta = "Segunda vez";
			break;
		case 2:
			respuesta = "Tercera vez";
			break;
		case 3:
			respuesta = "Cuarta vez";
			break;
		case 4:
			respuesta = "Quinta vez";
			break;
		case 5:
			respuesta = "Sexta vez";
			break;
		case 6:
			respuesta = "Septima vez";
			break;
		case 7:
			respuesta = "Octava  vez";
			break;
		case 8:
			respuesta = "Novena  vez";
			break;
		case 9:
			respuesta = "Decima  vez";
			break;
		case 10:
			respuesta = "Onceava  vez";
			break;
		default:
			respuesta = "";
			break;
		}
		return respuesta;
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
			respuesta = "Primera vez";
			break;
		case 2:
			respuesta = "Segunda vez";
			break;
		case 3:
			respuesta = "Tercera vez";
			break;
		case 4:
			respuesta = "Cuarta vez";
			break;
		case 5:
			respuesta = "Quinta vez";
			break;
		case 6:
			respuesta = "Sexta vez";
			break;
		case 7:
			respuesta = "Septima vez";
			break;
		case 8:
			respuesta = "Octava  vez";
			break;
		case 9:
			respuesta = "Novena  vez";
			break;
		case 10:
			respuesta = "Decima  vez";
			break;
		case 11:
			respuesta = "Onceava  vez";
			break;
		default:
			respuesta = "";
			break;
		}
		return respuesta;
	}

	
	private class DatoArchivo {
		private Part part;
		private Long idDisciplinaArchivoTipo;

		public Part getPart() {
			return part;
		}

		public void setPart(Part part) {
			this.part = part;
		}

		public Long getIdDisciplinaArchivoTipo() {
			return idDisciplinaArchivoTipo;
		}

		public void setIdDisciplinaArchivoTipo(Long idDisciplinaArchivoTipo) {
			this.idDisciplinaArchivoTipo = idDisciplinaArchivoTipo;
		}

	}

	/**
	 * Método para responder y servir a las peticiones sobre procesos
	 * disciplinarios. Este método llama a doPost.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
