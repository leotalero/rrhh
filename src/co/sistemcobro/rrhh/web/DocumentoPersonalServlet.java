package co.sistemcobro.rrhh.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.EmpleadoDocumentoPersonal;
import co.sistemcobro.rrhh.bean.EmpleadoIdentificacion;
import co.sistemcobro.rrhh.ejb.DocumentoPersonalEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.util.FtpUtilCliente;

/**
 * Para el manejo de los documentos personales asociados a un empleado.
 * @author jpuentes
 */
@WebServlet(name="DocumentoPersonalServlet", urlPatterns={"/page/documento"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 20, maxRequestSize = 1024 * 1024 * 20)
public class DocumentoPersonalServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    
	private final String RUTA = "empleado_documentos_personales";
	
	Logger logger = Logger.getLogger(DocumentoPersonalServlet.class);
	
	@EJB
	DocumentoPersonalEJB documentoEJB;
	
	@EJB
	EmpleadoEJB empleadoEJB;
	
    /**
     * Constructor.
     */
    public DocumentoPersonalServlet() {
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
	 * Método post.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("action");
		
		if(accion.equals("documento_propiedades")){
			verDocumentosPersonales(request,response);
		}else if(accion.equals("documento_personal_deshabilitar")){
			deshabilitarDocumentoPersonal(request,response);
		}else if(accion.equals("empleado_documento_habilitar")){
			habilitarDocumentoPersonal(request,response);
		}else if(accion.equals("crear_nuevo_documento")){
			crearNuevoDocumento(request,response);
		}else if(accion.equals("guardar_documento_personal")){
			guardarDocumentoPersonal(request,response);
		}else if(accion.equals("verDocumento")){
			verDocumento(request,response);
		}
	}
	
	/**
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException 
	 */
	private void verDocumentosPersonales(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try{
			String idempleado = (String) request.getParameter("idempleado");
			if (idempleado != null) {
				
				List<EmpleadoDocumentoPersonal> empleadoDocumentoPropiedades = documentoEJB.buscarEmpleadoDocumentoPorIdEmpleado(Long.valueOf(idempleado));
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleadodocumentopersonal", empleadoDocumentoPropiedades);
				request.setAttribute("empleado", empleado);
				request.getRequestDispatcher("../pages/documentopersonal/empleado_documento_persona.jsp").forward(request, response);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	/**
	 * Este método permite gestionar la inactivación de un empleadoDocumento.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException 
	 */
	private void deshabilitarDocumentoPersonal(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idEmpleadoDocumento = request.getParameter("idempleadodocumento");
			String idempleado = request.getParameter("idempleado");

			idEmpleadoDocumento = idEmpleadoDocumento == null ? "": idEmpleadoDocumento.trim();
			idempleado = idempleado == null ? "": idempleado.trim();

			EmpleadoDocumentoPersonal empleadoDocumentoPersonal = new EmpleadoDocumentoPersonal();
			empleadoDocumentoPersonal.setIdempleadodocumento(Long.valueOf(idEmpleadoDocumento));
			empleadoDocumentoPersonal.setIdempleado(Long.valueOf(idempleado));
			empleadoDocumentoPersonal.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = documentoEJB.deshabilitarEmpleadoDocumentoPersonal(empleadoDocumentoPersonal);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleadoDocumentoPersonal.getIdempleado());
				out.close();
			} else {
				throw new LogicaException("Error al deshabilitar el documento personal.");
			}
		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}
	
	

	/**
	 * Este método permite gestionar la activación de un empleadoDocumento.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException 
	 */
	private void habilitarDocumentoPersonal(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
				
		try {
			String idEmpleadoDocumento = request.getParameter("idempleadodocumento");
			String idempleado = request.getParameter("idempleado");

			idEmpleadoDocumento = idEmpleadoDocumento == null ? "": idEmpleadoDocumento.trim();
			idempleado = idempleado == null ? "": idempleado.trim();

			EmpleadoDocumentoPersonal empleadoDocumentoPersonal = new EmpleadoDocumentoPersonal();
			empleadoDocumentoPersonal.setIdempleadodocumento(Long.valueOf(idEmpleadoDocumento));
			empleadoDocumentoPersonal.setIdempleado(Long.valueOf(idempleado));
			empleadoDocumentoPersonal.setIdusuariomod(user.getCodusuario());
			
			Integer resultado = documentoEJB.habilitarEmpleadoDocumentoPersonal(empleadoDocumentoPersonal);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleadoDocumentoPersonal.getIdempleado());
				out.close();
			} else {
				throw new LogicaException("Error al deshabilitar el documento personal.");
			}
		} catch (LogicaException e) {
			response.sendError(1, e.toString());
		} catch (Exception e) {
			response.sendError(1, e.toString());
		}
	}

	/**
	 * Este método permite gestionar la carga de un documento de empleado.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException 
	 */
	private void crearNuevoDocumento(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			String idempleado = request.getParameter("idempleado");
						
			request.setAttribute("empleado", empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado)));
			request.setAttribute("tiposdocumento",documentoEJB.obtenerTiposDeDocumentos());
						 
			request.getRequestDispatcher("../pages/documentopersonal/empleado_documento_nuevo.jsp").forward(request, response);

		} catch (Exception e) {
			response.sendError(1, e.getMessage());
		}
	}
	
	
	/**
	 * Cargar el documento porsonal del empleado al servidor FTP de sistemcobro.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException,ServletException.
	 */
	public void guardarDocumentoPersonal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	

		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idEmpleado = Archivo.getParameter(request.getPart("idempleado"));
			String idTipoDocumentoSeleccionado = Archivo.getParameter(request.getPart("idtipodocumento"));
			String observacion= Archivo.getParameter(request.getPart("observacion"));
			
			EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idEmpleado));
			EmpleadoIdentificacion identificacionactual = empleadoEJB.getEmpleadoIdentificacionActual(empleado.getIdempleado());
			
			observacion = observacion == null ? "": observacion.trim();
			
			Part part = request.getPart("archivo");
			
			InputStream is = part.getInputStream();
			int k = is.available();
			byte[] b = new byte[k];
			is.read(b);
			String file = Archivo.getFullName(part);			
			
			if(!file.equals("")|| !file.equals(null)){
				
				if(idTipoDocumentoSeleccionado!=null &&  file!=null ){
					
					if(FtpUtilCliente.checkconexion()){
						EmpleadoDocumentoPersonal empleadoDocumentoPersonal = new EmpleadoDocumentoPersonal();
						
						empleadoDocumentoPersonal.setIdempleado(Long.valueOf(idEmpleado));
						empleadoDocumentoPersonal.setIddocumentotipo(Long.valueOf(idTipoDocumentoSeleccionado));
						empleadoDocumentoPersonal.setNombredocumento(file);
						
						empleadoDocumentoPersonal.setRutadocumento(file);
						empleadoDocumentoPersonal.setObservaciondocumento(observacion);
						empleadoDocumentoPersonal.setIdusuariocrea(user.getCodusuario());
						empleadoDocumentoPersonal.setEstado(EstadoEnum.DESHABILITADO.getIndex());
						
						EmpleadoDocumentoPersonal resultado = documentoEJB.insertarEmpleadoDocumentoPersonal(empleadoDocumentoPersonal);
						
						InputStream ispdf = part.getInputStream();
						ispdf.read(b);
							
						String filepdf = Constante.ROOT_FILE_TEMPORARY + File.separator + resultado.getIdempleadodocumento()+"_"+"cedula_"+identificacionactual.getNumeroidentificacion()+"_"+file;
						
						File archivopdf = new File(filepdf);
						FileOutputStream ospdf = new FileOutputStream(archivopdf);
						ospdf.write(b);
		
						ispdf.close();
						ospdf.close();
						
						logger.warn("Antes de intentar cargar el archivo con el metodo : FtpUtilCliente.uploadFTP(archivopdf,ruta)) ");
				   		
						if (FtpUtilCliente.uploadFTP(archivopdf,RUTA)) {
				   			resultado.setRutadocumento(archivopdf.getName());
				   			resultado.setIdusuariomod(user.getCodusuario());
				   			resultado.setTamaniodocumento(archivopdf.length());
				   			
				   			documentoEJB.activarEmpleadoDocumentoPersonal(resultado);
				   				
					   		if (resultado !=null && resultado.getIdempleadodocumento()!=null) {
					   			PrintWriter out = response.getWriter();
					   			out.println(resultado.getIdempleado());
					   			out.close();
					   			logger.info("Ya debio insertar y cargar el archivo.");
					   		} else {
					   			logger.info("Error al editar los datos de la nueva propiedad.");
					   			throw new LogicaException("Error al editar los datos de la nueva propiedad.");
					   		}
				   		}else{
				   			logger.info("Error enviando archivo en FTP");
				   			throw new LogicaException("Error enviando archivo en FTP");
				   		}
						}else{
							logger.info("Error Conectando al FTP");
							response.sendError(1, "Error Conectando al servidor FTP.");
							throw new LogicaException("Error Conectando al FTP");
						}		
					}else{
						logger.info("Existen valores en blanco y no se puede guardar el registro");
						throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
					}
		    }else{
		    	logger.info("Existen valores en blanco y no se puede guardar el registro");
				throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
			}			
			} catch (LogicaException e) {
				logger.info("LogicaException e = "+e);
				response.sendError(1, e.toString());
			} catch (Exception e) {
				logger.info("Exception e = "+e);
				response.sendError(1, e.toString());
			}
	}
	
	/**
	 * Este método permite descargar y visualizar un documento personal de empleado.
	 * @param HttpServletRequest. La petición.
	 * @param HttpServletResponse. La respuesta.
	 * @throws IOException.
	 * 
	 */
	private void verDocumento(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try {
	    	HttpSession session = request.getSession(false);
	        @SuppressWarnings("unused")
			UsuarioBean usuarioActivo = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);

	         String idEmpleadoDocumentoPersonal = request.getParameter("idempleadodocumentopersonal");
	         idEmpleadoDocumentoPersonal = idEmpleadoDocumentoPersonal == null ? "" : idEmpleadoDocumentoPersonal.trim();
	         
	         if ("".equals(idEmpleadoDocumentoPersonal)) {
	             throw new NullPointerException("Requerido idempleadodocumentopersonal");
	         }
	         
	         EmpleadoDocumentoPersonal empleadoDocumentoPersonal = documentoEJB.obtenerEmpleadoDocumentoPorId(Long.valueOf(idEmpleadoDocumentoPersonal));
	         
	        byte[] bytes =FtpUtilCliente.downloadFTP(empleadoDocumentoPersonal.getRutadocumento(),RUTA);
	        
	     	response.setContentType("application/x-filler");
	        response.setContentLength(bytes.length);
		    ServletOutputStream  ouputStream= response.getOutputStream();
			
			String nombrearchivo = empleadoDocumentoPersonal.getNombredocumento();
			
			response.setHeader("Content-disposition", "attachment; filename=\"" + nombrearchivo + "\"");
			ouputStream.write(bytes);
			ouputStream.close();
	         
	     } catch (Exception e) {
	         logger.error("Atrapó la excepcion en DocumentoPersonalServlet EX: ", e);
	         response.sendError(1, e.getMessage());
	     }
	}
	
}
