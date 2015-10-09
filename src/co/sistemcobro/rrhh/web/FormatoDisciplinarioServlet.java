package co.sistemcobro.rrhh.web;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.rrhh.bean.Formato;
import co.sistemcobro.rrhh.ejb.ProcesoDisciplinarioEJB;
import co.sistemcobro.rrhh.util.FtpUtilCliente;

/**
 * Servlet implementation class FormatoDisciplinario
 * 
 * @author jpuentes
 */
@WebServlet(name = "FormatoDisciplinarioServlet", urlPatterns = { "/page/formato" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 20, maxRequestSize = 1024 * 1024 * 20)
public class FormatoDisciplinarioServlet extends HttpServlet {

	Logger log = Logger.getLogger(FormatoDisciplinarioServlet.class);

	private static final long serialVersionUID = 1L;

	private final String RUTA = "formatos_disciplinarios";
	
	@EJB
	ProcesoDisciplinarioEJB procesoDisciplinarioEJB;

	/**
	 * Construtor.
	 */
	public FormatoDisciplinarioServlet() {
		super();
	}

	/**
	 * Método get.
	 * 
	 * @param HttpServletRequest
	 *            . La petición.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("action");

		if (accion.equals("descargarFormato")) {
			descargarFormato(request, response);
		}

	}

	/**
	 * Método para gestionar la descarga de los formatos de una falta.
	 * 
	 * @param HttpServletRequest
	 *            . La peticion.
	 * @param HttpServletResponse
	 *            . La respuesta.
	 * @throws IOException
	 */
	private void descargarFormato(HttpServletRequest request,HttpServletResponse response) throws IOException {
		try {
			HttpSession session = request.getSession(false);
			@SuppressWarnings("unused")
			UsuarioBean usuarioActivo = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);

			String idFormato = request.getParameter("idFormato");

			if ("".equals(idFormato) || idFormato == null) {
				throw new NullPointerException("Requerido un formato.");
			}

			Formato formatoADescargar = procesoDisciplinarioEJB
					.obtenerFormatoId(Long.valueOf(idFormato));

			byte[] bytes = FtpUtilCliente.downloadFTP(formatoADescargar.getRutaformato(), this.RUTA);
			
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			
			String nombreFormato = formatoADescargar.getNombreformato();
			
			response.setHeader("Content-disposition", "attachment; filename=\""+ nombreFormato + "\"");
			
			ouputStream.write(bytes);
			ouputStream.close();

		} catch (Exception e) {
			log.error("Atrapó la exception : ", e);
			response.sendError(1, e.getMessage());
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
