package co.sistemcobro.rrhh.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Inet4Address;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import sun.misc.BASE64Encoder;
import co.sistemcobro.all.constante.EstadoEnum;
import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.all.util.Util;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.hermes.constante.UsuarioTipoBusquedaEnum;
import co.sistemcobro.rrhh.bean.Area;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.EmpleadoDocumentoGenerado;
import co.sistemcobro.rrhh.bean.EmpleadoIdentificacion;
import co.sistemcobro.rrhh.bean.EmpleadoPropiedad;
import co.sistemcobro.rrhh.bean.EmpleadoSalario;
import co.sistemcobro.rrhh.bean.Genero;
import co.sistemcobro.rrhh.bean.IdentificacionTipo;
import co.sistemcobro.rrhh.bean.Prioridad;
import co.sistemcobro.rrhh.bean.Propiedad;
import co.sistemcobro.rrhh.constante.ActualEnum;
import co.sistemcobro.rrhh.constante.EmpleadoTipoBusquedaEnum;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.util.FtpUtilRecursos;

/**
 * 
 * @author Leonardo talero
 * 
 */
@WebServlet(name = "EmpleadoServlet", urlPatterns = { "/page/empleado" })

public class EmpleadoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(EmpleadoServlet.class);
	 ResourceBundle configrrhh = ResourceBundle	.getBundle(co.sistemcobro.rrhh.constante.Constante.FILE_CONFIG_RRHH);
	// ResourceBundle config =
	// ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);

	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;

	public EmpleadoServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("empleado_busqueda")) {
				empleado_principal(request, response);
			} else if (action.equals("empleado_buscar")) {
				empleado_buscar(request, response);
			} else if (action.equals("empleado_nuevo")) {
				empleado_nuevo(request, response);
			} else if (action.equals("cargar_sucursales")) {
				cargar_sucursales(request, response);
			} else if (action.equals("empleado_insertar")) {
				empleado_insertar(request, response);
			} else if (action.equals("empleado_detalle")) {
				detalleEmpleado(request, response);
			} else if (action.equals("empleado_edicion")) {
				empleado_edicion(request, response);
			} else if (action.equals("empleado_editar")) {
				empleado_editar(request, response);
			} else if (action.equals("empleado_deshabilitar")) {
				deshabilitarEmpleado(request, response);
			} else if (action.equals("empleado_activar")) {
				habilitarEmpleado(request, response);
			} else if (action.equals("empleado_propiedades")) {
				empleado_propiedades(request, response);
			} else if (action.equals("propiedad_deshabilitar")) {
				propiedad_deshabilitar(request, response);
			} else if (action.equals("propiedad_habilitar")) {
				propiedad_habilitar(request, response);
			} else if (action.equals("empleado_vernuevapropiedad")) {
				empleado_vernuevapropiedad(request, response);
			} else if (action.equals("empleado_crearpropiedad")) {
				empleado_crearpropiedad(request, response);
			} else if (action.equals("empleado_vereditarpropiedad")) {
				empleado_vereditarpropiedad(request, response);
			} else if (action.equals("empleado_editarpropiedad")) {
				empleado_editarpropiedad(request, response);
			}else if (action.equals("certificados")) {
				certificados(request, response);
			}else if (action.equals("buscar_certificados")) {
				buscar_certificados(request, response);
			}else if (action.equals("abrir_editarfoto")) {
				abrir_editarfoto(request, response);
			}else if (action.equals("buscarTestigos")) {
				buscarTestigos(request, response);
			}else if (action.equals("dashboard")) {
				dashboard(request, response);
			}else if (action.equals("empleadoVerNuevaPropiedadCorrespondencia")) {
				empleadoVerNuevaPropiedadCorrespondencia(request, response);
			}else if (action.equals("empleadoCrearPropiedadCorrespondencia")) {
				empleadoCrearPropiedadCorrespondencia(request, response);
			}else if(action.equals("empleadoNuevaPropiedadCorrespondencia")){
				empleadoNuevaPropiedadCorrespondencia(request, response);
			}
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void empleado_principal(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			request.getRequestDispatcher("../pages/empleado/empleado_busqueda.jsp").forward(request,response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	public void empleado_buscar(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String desde = request.getParameter("from");
			String hasta = request.getParameter("to");
			String nombre = request.getParameter("nombre");
			String numidentificacion = request.getParameter("numidentificacion");
			String usuario = request.getParameter("usuario");
			String codusuario = request.getParameter("codusuario");
			String idaplicacion = request.getParameter("idaplicacion");
			String idgrupo = request.getParameter("idgrupo");
			String idcuenta = request.getParameter("idcuenta");
			String tipobusqueda = request.getParameter("tipobusqueda");

			nombre = nombre == null ? "" : nombre;
			numidentificacion = numidentificacion == null ? "": numidentificacion;
			usuario = usuario == null ? "" : usuario;
			codusuario = codusuario == null ? "" : codusuario;
			idaplicacion = idaplicacion == null ? "" : idaplicacion;
			idgrupo = idgrupo == null ? "" : idgrupo;
			idcuenta = idcuenta == null ? "" : idcuenta;

			tipobusqueda = tipobusqueda == null ? "" : tipobusqueda;
			desde = desde == null ? "" : Util.stringToString(desde.trim(),"dd/MM/yyyy", "yyyyMMdd");
			hasta = hasta == null ? "" : Util.stringToString(hasta.trim(),"dd/MM/yyyy", "yyyyMMdd");

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

			List<EmpleadoBean> empleados = empleadoEJB.buscarEmpleados(desde,hasta, valor, tipobus);
			request.setAttribute("empleados", empleados);
			request.getRequestDispatcher("../pages/empleado/empleado_lista.jsp").forward(request, response);

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	/**
	 * Este metodo busca y carga el listado de empleados (posibles testigos).
	 * */
	public void buscarTestigos(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			
			String idDisciplina = request.getParameter("idDisciplina");
			String idSancion = request.getParameter("idSancion");
			String idContrato= request.getParameter("idContrato");
			String idFalta = request.getParameter("idFalta");
			
			
			logger.info("Entro a buscar testigos. idDisciplina : "+idDisciplina);
			logger.info("Entro a buscar testigos. idSancion : "+idSancion);
			logger.info("Entro a buscar testigos. idContrato : "+idContrato);
			logger.info("Entro a buscar testigos. idFalta : "+idFalta);
			
			String desde = request.getParameter("from");
			String hasta = request.getParameter("to");
			String nombre = request.getParameter("nombre");
			
			logger.info("Nombre : "+nombre);
			
			String numidentificacion = request
					.getParameter("numidentificacion");
			String usuario = request.getParameter("usuario");
			String codusuario = request.getParameter("codusuario");
			String idaplicacion = request.getParameter("idaplicacion");
			String idgrupo = request.getParameter("idgrupo");
			String idcuenta = request.getParameter("idcuenta");
			String tipobusqueda = request.getParameter("tipobusquedausuario");

			logger.info("Tipo busqueda : "+tipobusqueda);
			
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

			List<EmpleadoBean> empleados = empleadoEJB.buscarEmpleados(desde,hasta, valor, tipobus);
			request.setAttribute("empleados", empleados);
			request.setAttribute("idDisciplina", idDisciplina);
			request.setAttribute("idSancion", idSancion);
			request.setAttribute("idContrato", idContrato);
			request.setAttribute("idFalta", idFalta);
			request.getRequestDispatcher("../pages/disciplinario/listaDeTestigos.jsp").forward(request, response);

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	public void empleado_nuevo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			request.setAttribute("tiposidentifiaccion",empleadoEJB.getIdentifiacionTipo());
			request.setAttribute("empresas", empleadoEJB.getEmpresas());
			request.setAttribute("generos", empleadoEJB.getGeneros());
			request.getRequestDispatcher("../pages/empleado/empleado_nuevo.jsp").forward(request, response);
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void cargar_sucursales(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idempresa = request.getParameter("idempresa");
			request.setAttribute("sucursales", empleadoEJB
					.getSucursalesporEmpresa(Long.valueOf(idempresa)));
			request.getRequestDispatcher("../pages/empleado/lista_sucursal.jsp")
					.forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void empleado_insertar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String identificaciontipo = request.getParameter("ididentificaciontipo");
			String numidentificacion = request.getParameter("numidentificacion");
			String ciudadexpedicion = request.getParameter("ciudadexpedicion");
			String fechanacimiento = request.getParameter("fechanacimiento");
			String idgenero = request.getParameter("idgenero");
			String nombres = request.getParameter("nombres");
			String apellidos = request.getParameter("apellidos");
			// String idempresa = request.getParameter("idempresa");
			// String idsucursal = request.getParameter("idsucursal");

			nombres = nombres == null ? "" : nombres.trim();
			apellidos = apellidos == null ? "" : apellidos.trim();
			numidentificacion = numidentificacion == null ? ""
					: numidentificacion.trim();
			identificaciontipo = identificaciontipo == null ? ""
					: identificaciontipo.trim();
			idgenero = idgenero == null ? "" : idgenero.trim();
			// idempresa = idempresa == null ? "" : idempresa.trim();
			// idsucursal = idsucursal == null ? "" : idsucursal.trim();
			fechanacimiento = fechanacimiento == null ? "" : fechanacimiento
					.trim();

			EmpleadoBean empleado = new EmpleadoBean();
			EmpleadoIdentificacion empleadoidentificacion = new EmpleadoIdentificacion();
			empleadoidentificacion.setIdidentificaciontipo(Long
					.valueOf(identificaciontipo));
			empleadoidentificacion.setNumeroidentificacion(numidentificacion);
			empleadoidentificacion.setCiudadexpedicion(ciudadexpedicion);
			empleadoidentificacion.setActual(ActualEnum.ACTUAL.getIndex());
			empleadoidentificacion.setIdusuariocrea(user.getIdusuario());
			empleadoidentificacion.setEstado(EstadoEnum.ACTIVO.getIndex());

			empleado.setEmpleadoidentificacion(empleadoidentificacion);
			Genero genero = new Genero();
			genero.setIdgenero(Long.valueOf(idgenero));
			empleado.setIdgenero(genero.getIdgenero());
			empleado.setGenero(genero);
			empleado.setNombres(nombres);
			empleado.setApellidos(apellidos);

			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date fechanaci = formatter.parse(fechanacimiento);
			long time = fechanaci.getTime();
			Timestamp timefechanaci = new Timestamp(time);

			empleado.setFechanacimiento(timefechanaci);
			empleado.setIdusuariocrea(user.getCodusuario());
			empleado.setEstado(EstadoEnum.ACTIVO.getIndex());

			// if(empleado.getIdentificaciontipo()==empleadoEJB.b){

			// }
			// empleadoEJB.

			Integer resultado = empleadoEJB.insertarEmpleado(empleado);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleado.getIdempleado());
				out.close();

			} else {
				throw new LogicaException(
						"Error al grabar los datos del nuevo usuario.");
			}
			// else {
			// throw new
			// LogicaException("El campo Clave debe conincidir con el campo Clave (repetir)");
			// }

		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}

	}

	public void detalleEmpleado(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		String fotourlencode=null;
		
		try {

			String idempleado = request.getParameter("idempleado");
			idempleado = idempleado == null ? "" : idempleado.trim();
			Long idempleadotemp;
			
			if ("".equals(idempleado)) {
				throw new NullPointerException("IDempleado requerido");
			} else {
				idempleadotemp = Long.valueOf(idempleado);
			}
			EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(idempleadotemp);

			if (null != empleado) {
				
			 	//imagen = Constante.ROOT_FILE_TEMPORARY + File.separator +"imagenprueba_"+idempleado+".jpg";
				  
				for(int i=0;i<=3;i++){//intenta 3 veces la conexion
					
					if(FtpUtilRecursos.checkconexion()){
						 String rutaftp="imagen/foto";
						 if(empleado.getFotonombre()!=null){
							
							 byte[] foto = null;
							try {
								logger.error("antes de verificar");
								foto = FtpUtilRecursos.downloadFTP(empleado.getFotonombre(), rutaftp);
							} catch (Exception e) {
								logger.error("Error por foto : "+e.toString(), e.fillInStackTrace());
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							
					   			if (foto!=null) {///sube doc
					   			 //FileOutputStream fileOuputStream =new FileOutputStream(fileimagen); 
							   	  //  fileOuputStream.write(foto);
							   	  //  fileOuputStream.close();
							   	    
							   	 BASE64Encoder encoder = new BASE64Encoder();
								 
						           fotourlencode = encoder.encode(foto);
						          fotourlencode="data:image/jpeg;base64,"+fotourlencode;
					   	    
					   	    
							 }else{
								 
							 }
						 }else{
							 
						 }
						
			   	    
			   	    
			   	    
				   			break;
				   				
			   			}else{
			   				throw new LogicaException("Error recibiendo archivo de FTP");
			   			}
					}
	   			
				}
				
				
				
				
				List<Contrato> contratos = contratoEJB.getContratosporIdEmpleado(empleado.getIdempleado());
				request.setAttribute("contratos", contratos);
				
				
				
//				request.setAttribute("salarios", contratoEJB.obtenerEmpleadoSalario());
				// EmpleadoIdentificacion empleadoidentificacion =
				// empleadoEJB.getEmpleadoIdentificacionActual(empleado.getIdempleado());

				// usuario.setIdentificaciontipo(tipoidentificacion);
				// List<UsuarioAplicacionBean> usuarioaplicaciones =
				// usuarioEJB.getUsuarioAplicacionPorIdusuario(usuario.getIdusuario());
				// List<UsuarioCuenta> usuariocuentas =
				// usuarioEJB.getUsuarioCuentasPorIdusuario(usuario.getIdusuario());
				// DirectivaContrasena directivacontrasena =
				// usuarioEJB.getDirectivaContrasenaPorIdusuario(usuario.getIdusuario());

				// request.setAttribute("directivacontrasena",
				// directivacontrasena);
				// request.setAttribute("usuarioaplicaciones",
				// usuarioaplicaciones);
				// request.setAttribute("usuariocuentas", usuariocuentas);
				Long ultimocontratoid=Long.valueOf(0);
				if(contratos!=null && contratos.size()>0){
					 ultimocontratoid = contratos.get(0).getIdcontrato();
					//request.setAttribute("ultimocontratoid", ultimocontratoid);
				}
				request.setAttribute("ultimocontratoid", ultimocontratoid);
				request.setAttribute("fotourlencode", fotourlencode);
				request.setAttribute("empleado", empleado);
				request.getRequestDispatcher("../pages/empleado/empleado_detalle.jsp").forward(request,
					response);
			

			

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void empleado_edicion(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			String idempleado = request.getParameter("idempleado");
			idempleado = idempleado == null ? "" : idempleado.trim();
			Long idempleado_tmp;
			if ("".equals(idempleado)) {
				throw new NullPointerException("IDUSUARIO requerido");
			} else {
				idempleado_tmp = Long.valueOf(idempleado);
			}

			EmpleadoBean empleado = empleadoEJB
					.buscarEmpleadosporId(idempleado_tmp);
			if (null != empleado) {

				// List<UsuarioAplicacionBean> usuarioaplicaciones =
				// usuarioEJB.getUsuarioAplicacionPorIdusuario(usuario.getIdusuario());
				// List<UsuarioCuenta> usuariocuentas =
				// usuarioEJB.getUsuarioCuentasPorIdusuario(usuario.getIdusuario());

				// request.setAttribute("usuarioaplicaciones",
				// usuarioaplicaciones);
				// request.setAttribute("usuariocuentas", usuariocuentas);
			}
			request.setAttribute("generos", empleadoEJB.getGeneros());
			request.setAttribute("empleado", empleado);
			request.setAttribute("tiposidentificacion",
					empleadoEJB.getIdentifiacionTipo());
			request.setAttribute("picture", "${ctx}/imagen/camera.png");
			// request.setAttribute("aplicaciones",
			// usuarioEJB.getAplicaciones(new String[] {
			// EstadoEnum.ACTIVO.getIndexString() }));
			// request.setAttribute("cuentas", usuarioEJB.getCuentas(new
			// String[] { EstadoEnum.ACTIVO.getIndexString() }));
			// request.setAttribute("sucursales", usuarioEJB.getSucursales(new
			// String[] { EstadoEnum.ACTIVO.getIndexString() }));
			// request.setAttribute("directivacontrasenas",
			// usuarioEJB.getDirectivaContrasenas(new Integer[] {
			// EstadoEnum.ACTIVO.getIndex() }));
			request.getRequestDispatcher(
					"../pages/empleado/empleado_editar.jsp").forward(request,
					response);

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void empleado_editar(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado = request.getParameter("idempleado");
			String identificaciontipo = request
					.getParameter("ididentificaciontipo");
			String numidentificacion = request
					.getParameter("numidentificacion");
			String ciudadexpedicion = request.getParameter("ciudadexpedicion");
			String fechanacimiento = request.getParameter("fechanacimiento");
			String idgenero = request.getParameter("idgenero");
			String nombres = request.getParameter("nombres");
			String apellidos = request.getParameter("apellidos");

			identificaciontipo = identificaciontipo == null ? ""
					: identificaciontipo.trim();
			numidentificacion = numidentificacion == null ? ""
					: numidentificacion.trim();
			ciudadexpedicion = ciudadexpedicion == null ? "" : ciudadexpedicion
					.trim();
			fechanacimiento = fechanacimiento == null ? "" : fechanacimiento
					.trim();
			idgenero = idgenero == null ? "" : idgenero.trim();
			nombres = nombres == null ? "" : nombres.trim();
			apellidos = apellidos == null ? "" : apellidos.trim();
			numidentificacion = numidentificacion == null ? ""
					: numidentificacion.trim();

			EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long
					.valueOf(idempleado));
			// identificacion tipo

			IdentificacionTipo identificaciontipoobjeto = empleadoEJB
					.getIdentificacionTipoporid(Long
							.valueOf(identificaciontipo));
			empleado.setIdentificaciontipo(identificaciontipoobjeto);
			// empleado identificacion
			EmpleadoIdentificacion empleadoidentificacion = empleado
					.getEmpleadoidentificacion();
			empleadoidentificacion.setNumeroidentificacion(numidentificacion);
			empleadoidentificacion.setIdidentificaciontipo(Long
					.valueOf(identificaciontipo));
			empleadoidentificacion.setCiudadexpedicion(ciudadexpedicion);
			empleado.setEmpleadoidentificacion(empleadoidentificacion);
			empleadoidentificacion.setIdusuariomod(user.getCodusuario());
			// genero
			Genero genero = empleado.getGenero();

			genero.setIdgenero(Long.valueOf(idgenero));
			empleado.setIdgenero(Long.valueOf(idgenero));

			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date fechanaci = formatter.parse(fechanacimiento);
			long time = fechanaci.getTime();
			Timestamp timefechanaci = new Timestamp(time);
			empleado.setFechanacimiento(timefechanaci);
			empleado.setGenero(genero);
			empleado.setNombres(nombres);
			empleado.setApellidos(apellidos);
			empleado.setEstado(EstadoEnum.ACTIVO.getIndex());
			empleado.setIdusuariomod(user.getCodusuario());

			Integer resultado = empleadoEJB.actualizaEmpleado(empleado);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleado.getIdempleado());
				out.close();

			} else {
				throw new LogicaException(
						"Error al grabar los datos del nuevo usuario.");
			}

		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}

	}

	public void deshabilitarEmpleado(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado = request.getParameter("idempleado");

			idempleado = idempleado == null ? "" : idempleado.trim();

			EmpleadoBean empleado = new EmpleadoBean();
			empleado.setIdempleado(Long.valueOf((idempleado)));
			empleado.setIdusuariomod(user.getCodusuario());

			Integer resultado = empleadoEJB
					.deshabilitarEstadoEmpleado(empleado);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleado.getIdempleado());
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

	public void habilitarEmpleado(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado = request.getParameter("idempleado");

			idempleado = idempleado == null ? "" : idempleado.trim();

			EmpleadoBean empleado = new EmpleadoBean();
			empleado.setIdempleado(Long.valueOf((idempleado)));
			empleado.setIdusuariomod(user.getCodusuario());

			Integer resultado = empleadoEJB.habilitarEstadoEmpleado(empleado);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(empleado.getIdempleado());
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

	public void empleado_propiedades(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = (String) request.getParameter("idempleado");

			if (idempleado != null) {
				List<EmpleadoPropiedad> empleadopropiedades = empleadoEJB.getEmpeladoPropiedadesporidEmpleado(Long.valueOf(idempleado));
				request.setAttribute("empleadopropiedades", empleadopropiedades);
			}
			
			EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
			
			request.setAttribute("empleado", empleado);
			List<Propiedad> propiedades = empleadoEJB.getPropiedades();
			request.setAttribute("propiedades", propiedades);
			request.getRequestDispatcher("../pages/empleado/empleado_propiedades.jsp").forward(request, response);
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	public void propiedad_deshabilitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idempleadopropiedad = request
					.getParameter("idempleadopropiedad");
			String idempleado = request.getParameter("idempleado");

			idempleadopropiedad = idempleadopropiedad == null ? ""
					: idempleadopropiedad.trim();

			EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();
			empleadopropiedad.setIdempleadopropiedad(Long
					.valueOf((idempleadopropiedad)));
			empleadopropiedad.setIdusuariomod(user.getCodusuario());

			Integer resultado = empleadoEJB
					.deshabilitarEmpleadoPropiedad(empleadopropiedad);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
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

	public void propiedad_habilitar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		//He didn't work.
		//
		try {
			String idempleadopropiedad = request.getParameter("idempleadopropiedad");
			String idempleado = request.getParameter("idempleado");

			idempleadopropiedad = idempleadopropiedad == null ? "": idempleadopropiedad.trim();

			EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();
			empleadopropiedad.setIdempleadopropiedad(Long.valueOf((idempleadopropiedad)));
			empleadopropiedad.setIdusuariomod(user.getCodusuario());

			Integer resultado = empleadoEJB.habilitarEmpleadoPropiedad(empleadopropiedad);
			
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(Long.valueOf(idempleado));
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

	public void empleado_vernuevapropiedad(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idpropiedad = (String) request.getParameter("idpropiedad");

			if (idpropiedad != null) {

				Propiedad propiedad = empleadoEJB.getPropiedadesporId(Long
						.valueOf(idpropiedad));

				request.setAttribute("propiedad", propiedad);
				List<Prioridad> prioridades = empleadoEJB.getPrioridades();
				request.setAttribute("prioridades", prioridades);
			}
			if (idempleado != null) {
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long
						.valueOf(idempleado));
				request.setAttribute("empleado", empleado);
			}

			List<Prioridad> prioridades = empleadoEJB.getPrioridades();
			request.setAttribute("prioridades", prioridades);
			List<Propiedad> propiedades = empleadoEJB.getPropiedades();
			request.setAttribute("propiedades", propiedades);
			request.getRequestDispatcher("../pages/empleado/empleado_nuevapropiedad.jsp").forward(
					request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
	/**
	 *  Este metodo permite mostrar la ventana para crear una nueva propiedad de correspondencia.
	 *  @param HttpServletRequest request.
	 *  @param HttpServletResponse response.
	 */
	public void empleadoVerNuevaPropiedadCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idContrato = (String) request.getParameter("idContrato");

			if (idempleado != null) {
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleado", empleado);
			}

			List<Prioridad> prioridades = empleadoEJB.getPrioridades();
			List<Propiedad> propiedades = empleadoEJB.getPropiedadesDeCorrespondencia();
			
			String action = "?action=empleadoCrearPropiedadCorrespondencia&idContrato="+idContrato+"";
			
			request.setAttribute("prioridades", prioridades);
			request.setAttribute("propiedades", propiedades);
			request.setAttribute("idContrato", idContrato);
			request.setAttribute("accion", action);
			
			request.setAttribute("accionRealizar", "1");
			
			request.getRequestDispatcher("../pages/empleado/empleado_nuevapropiedadCorrespondencia.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	

	/**
	 * Este metodo permite la creación de una nueva propiedad de correspondencia.
	 *  @param HttpServletRequest request.
	 *  @param HttpServletResponse response.
	 */
	public void empleadoNuevaPropiedadCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idContrato = (String) request.getParameter("idContrato");

			if (idempleado != null) {
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleado", empleado);
			}

			List<Prioridad> prioridades = empleadoEJB.getPrioridades();
			List<Propiedad> propiedades = empleadoEJB.getPropiedadesDeCorrespondencia();
			
			String action = "?action=empleadoCrearPropiedadCorrespondencia&idContrato="+idContrato+"";
			
			request.setAttribute("prioridades", prioridades);
			request.setAttribute("propiedades", propiedades);
			request.setAttribute("idContrato", idContrato);
			request.setAttribute("accion", action);
			
			request.setAttribute("accionRealizar", "2");
			
			request.getRequestDispatcher("../pages/empleado/empleado_nuevapropiedadCorrespondencia.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	

	public void empleado_crearpropiedad(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idtipopropiedad = request.getParameter("idtipopropiedad");
			String dato = request.getParameter("dato");
			String idprioridad = request.getParameter("idprioridad");
			String idempleado = request.getParameter("idempleado");
			String observacion = request.getParameter("observacion");

			idtipopropiedad = idtipopropiedad == null ? "" : idtipopropiedad
					.trim();
			dato = dato == null ? "" : dato.trim();
			idprioridad = idprioridad == null ? "" : idprioridad.trim();
			

			if (idtipopropiedad != null && idempleado != null
					&& idtipopropiedad != null) {
				EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();

				empleadopropiedad.setIdpropiedad(Long.valueOf(idtipopropiedad));
				empleadopropiedad.setIdempleado(Long.valueOf(idempleado));
				empleadopropiedad.setDato(dato);
				empleadopropiedad.setObservacion(observacion);
				empleadopropiedad.setIdprioridad(Long.valueOf(idprioridad));

				empleadopropiedad.setIdusuariocrea(user.getCodusuario());
				empleadopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());


				EmpleadoPropiedad resultado = empleadoEJB
						.insertarEmpleadoPropiedad(empleadopropiedad);
				if (resultado != null
						&& resultado.getIdempleadopropiedad() != 0) {
					PrintWriter out = response.getWriter();
					out.println(empleadopropiedad.getIdempleado());
					out.close();

				} else {
					throw new LogicaException(
							"Error al grabar los datos de la nueva propiedad.");
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
	 * Crear la nueva propiedad de correspondencia ya sea correo o direccion.
	 */
	public void empleadoCrearPropiedadCorrespondencia(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		logger.info("En empleadoCrearPropiedadCorrespondencia().");
		
		try {
			logger.info("Entro al try.");
			String idtipopropiedad = request.getParameter("idtipopropiedadCorrespondencia");
			String dato = request.getParameter("datoCorrespondencia");
			String idprioridad = request.getParameter("idprioridadCorrespondencia");
			String idempleado = request.getParameter("idempleado");
			String observacion = request.getParameter("observacionCorrespondencia");

			String getHiddenValue = request.getParameter("idContrato");
			
			Long idContrato = Long.valueOf(getHiddenValue);
			
			logger.info("IDCONTRATO = "+idContrato);
			logger.info("idTipoPropiedad = "+idtipopropiedad);
			logger.info("dato = "+dato);
			logger.info("idPrioridad = "+idprioridad);
			logger.info("idEmpleado = "+idempleado);
			logger.info("observacion = "+observacion);
			
			idtipopropiedad = idtipopropiedad == null ? "" : idtipopropiedad.trim();
			dato = dato == null ? "" : dato.trim();
			idprioridad = idprioridad == null ? "" : idprioridad.trim();
			
			if (idtipopropiedad != null && idempleado != null && idtipopropiedad != null) {
			    
				EmpleadoPropiedad empleadopropiedad = new EmpleadoPropiedad();

				empleadopropiedad.setIdpropiedad(Long.valueOf(idtipopropiedad));
				empleadopropiedad.setIdempleado(Long.valueOf(idempleado));
				empleadopropiedad.setDato(dato);
				empleadopropiedad.setObservacion(observacion);
				empleadopropiedad.setIdprioridad(Long.valueOf(idprioridad));

				empleadopropiedad.setIdusuariocrea(user.getCodusuario());
				empleadopropiedad.setEstado(EstadoEnum.ACTIVO.getIndex());


				EmpleadoPropiedad resultado = empleadoEJB.insertarEmpleadoPropiedad(empleadopropiedad);
				
				if (resultado != null && resultado.getIdempleadopropiedad() != 0) {
					logger.info("resultado != null && resultado.getIdempleadopropiedad() != 0");
					PrintWriter out = response.getWriter();
					logger.info("Antes del out.println(idContrato); idContrato="+idContrato);
					out.println(idContrato);
					out.close();
				} else {
					throw new LogicaException(
							"Error al grabar los datos de la nueva propiedad.");
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
	
	
	public void empleado_vereditarpropiedad(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = (String) request.getParameter("idempleado");
			String idempleadopropiedad = (String) request.getParameter("idempleadopropiedad");
			String idContrato = request.getParameter("idContrato");
			
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

//			if(idContrato!=null){
//				request.setAttribute("idContrato", idContrato);
//				request.getRequestDispatcher("../pages/desvinculacion/verEditarPropiedadCorrespondencia.jsp.jsp").forward(request, response);
//			}else{
				request.getRequestDispatcher("../pages/empleado/empleado_editarpropiedad.jsp").forward(request, response);
//			}
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	public void empleado_editarpropiedad(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {
			String idtipopropiedad = request.getParameter("idtipopropiedad");
			String dato = request.getParameter("dato");
			String idprioridad = request.getParameter("idprioridad");
			String idempleado = request.getParameter("idempleado");
			String idempleadopropiedad = request.getParameter("idempleadopropiedad");
			String observacion = request.getParameter("observacion");

			idtipopropiedad = idtipopropiedad == null ? "" : idtipopropiedad.trim();
			dato = dato == null ? "" : dato.trim();
			idprioridad = idprioridad == null ? "" : idprioridad.trim();
			

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
					out.println(empleadopropiedad.getIdempleado());
					out.close();

				} else {
					throw new LogicaException(
							"Error al editar los datos de la nueva propiedad.");
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
	
	
	public void certificados(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		try {

			String idempleado = request.getParameter("idempleado");
		 EmpleadoBean empleados = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
		 List<EmpleadoDocumentoGenerado> certificados = empleadoEJB.buscarCertificadosGeneradosporEmpleado(Long.valueOf(idempleado));
		 
			request.setAttribute("empleado", empleados);
			
			List<Contrato> contratos = contratoEJB.getContratosporIdEmpleado(empleados.getIdempleado());
			String mensaje="No tiene:";
			if(contratos.size()>0){
				Contrato ultimocontrato = contratos.get(0);
				EmpleadoSalario ultimosalario = contratoEJB.obtenerEmpleadoSalarioPorIdContrato(ultimocontrato.getIdcontrato());
				if(ultimocontrato.getNumerocontrato()==null || ultimocontrato.getNumerocontrato().equals("") ){
					mensaje+=" número de contrato.";
				}if(ultimocontrato.getIdcontratotipo()==null || ultimocontrato.getIdcontratotipo()==0 ){
					mensaje+=" tipo de contrato.";
				}if(ultimosalario==null || ultimosalario.getIdempleadosalario()==null){
					mensaje+=" salario asignado.";
				}
			if(ultimocontrato.getIdcargo()==null){
					mensaje+=" cargo asignado.";
				}
				
			}
			
			
			//request.setAttribute("certificados", certificados);
			request.setAttribute("mensaje", mensaje);
			request.getRequestDispatcher("../pages/empleado/empleado_certificados.jsp").forward(request, response);
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}



	public void buscar_certificados(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado = request.getParameter("idempleado");
			List<EmpleadoDocumentoGenerado> certificados = empleadoEJB.buscarCertificadosGeneradosporEmpleado(Long.valueOf(idempleado));
			 
	
			request.setAttribute("certificados", certificados);
			request.getRequestDispatcher("../pages/certificado/certificado_laboral_generados_lista.jsp")
					.forward(request, response);

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}


	}

	
	public void abrir_editarfoto(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = request.getParameter("idempleado");
			 EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleado", empleado);
			request.getRequestDispatcher("../pages/empleado/empleado_foto.jsp").forward(request,response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	public void dashboard(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = request.getParameter("idempleado");
			 EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
			
			//List<Area> areas = contratoEJB.getAreas();
			//request.setAttribute("areas", areas);
			//request.setAttribute("estadoActivo", "ACTIVO");
			//request.setAttribute("estadoDeshabilitado", "DESHABILITADO");
			TableauServlet ts = new TableauServlet();
			// final String user = "SISTEMCOBRO"+"\\"+"dtroncoso";
			 //final String user ="appsg";
			final String user=configrrhh.getString("rrhh.tableau.userG");
			final String wgserver=configrrhh.getString("rrhh.tableau.server");
			 //String wgserver1 = "172.16.1.63:8081";
			//  wgserver = "bi.sistemcobro.com:8081";
			 // wgserver = "www.sistemcobro.com/tableau/";
			String iplocal=Inet4Address.getLocalHost().getHostAddress();
			String ticket= ts.getTrustedTicket(wgserver, user, iplocal);
			//String ticket1= ts.getTrustedTicket(wgserver1, user, iplocal);
			String parametros="numeroidentificacionP=";
			parametros+=empleado.getEmpleadoidentificacion().getNumeroidentificacion();
			request.setAttribute("ticket", ticket);
			 request.setAttribute("server", wgserver);
			request.setAttribute("parametros", parametros);
			request.getRequestDispatcher("../pages/empleado/dashboardindividual.jsp").forward(
					request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
