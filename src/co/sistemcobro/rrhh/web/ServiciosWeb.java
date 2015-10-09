package co.sistemcobro.rrhh.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.ResourceBundle;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.octo.captcha.module.servlet.image.SimpleImageCaptchaServlet;

import co.sistemcobro.all.constante.EstadoEnum;
import co.sistemcobro.all.exception.DirectivaContrasenaException;
import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.all.exception.SessionException;
import co.sistemcobro.hermes.bean.AplicacionBean;
import co.sistemcobro.hermes.bean.IdentificacionTipo;
import co.sistemcobro.hermes.bean.PreguntasSeguraBean;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.bean.UsuarioPreguntaSeguraBean;
import co.sistemcobro.hermes.constante.AplicacionEnum;
import co.sistemcobro.hermes.constante.ClaveCambioEnum;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.hermes.ejb.UsuarioEJB;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;

/**
 * 
 * @author Leonardo Talero
 * 
 */
@WebServlet(name = "ServiciosWebServlet", urlPatterns = { "/portal/serviciosweb" })
public class ServiciosWeb extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(ServiciosWeb.class);

	//ResourceBundle config = ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);
	@EJB
	private EmpleadoEJB empleadoEJB;

	
	@EJB
	private UsuarioEJB usuarioEJB;
	
	
	public ServiciosWeb() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("empleado_by_usuario_win")) {
				empleado_by_usuario_win(request, response);
			} else if (action.equals("login")) {
				login(request, response);
			}
			
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}



	
	public void empleado_by_usuario_win(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String usuariowin = (String)request.getParameter("usuariowin");			
			EmpleadoBean empleado = null;
			List<EmpleadoBean> empleados=new ArrayList<EmpleadoBean>();
			if(usuariowin!=null){
			
				 empleados = empleadoEJB.buscarEmpleadosporUsuarioWindows(usuariowin);
				if(empleados.size()>0){
					empleado=empleados.get(0);
				}else{
					
				}
				
			}
			
			
			//request.setAttribute("empleado", empleado);
			///List<Result> results = someDAO.list();
			String json = new Gson().toJson(empleados);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		
			} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String usuario= (String)request.getParameter("nombredeusuario");
			String pass= (String)request.getParameter("clave");
			UsuarioBean usuariobean = null;
			//List<EmpleadoBean> empleados=new ArrayList<EmpleadoBean>();
			if(usuario!=null && pass!=null){
			
				UsuarioBean activo = usuarioEJB.isUsuario(usuario, pass);
				if(activo!=null){
					usuariobean=activo;
				}else{
					
				}
				
			}else {
				
			}
			
			
			
			
			//request.setAttribute("empleado", empleado);
			///List<Result> results = someDAO.list();
			String json = new Gson().toJson(usuariobean);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		
			} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
