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
import co.sistemcobro.all.util.Util;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.ContratoTipo;
import co.sistemcobro.rrhh.bean.EmpleadoSalario;
import co.sistemcobro.rrhh.bean.Horario;
import co.sistemcobro.rrhh.bean.HorarioAsignado;
import co.sistemcobro.rrhh.bean.TipoMoneda;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.ejb.HorarioEJB;

/**
 * 
 * @author Leonardo talero
 * 
 */

@WebServlet(name = "ContratoServlet", urlPatterns = { "/page/contrato" })
public class ContratoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(ContratoServlet.class);

	// ResourceBundle config =
	// ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);

	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;
	@EJB
	private HorarioEJB horarioEJB;

	public ContratoServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("crear_contrato")) {
				crear_contrato(request, response);
			} else if (action.equals("cargar_sucursales")) {
				cargar_sucursales(request, response);
			} else if (action.equals("cargar_cargos")) {
				cargar_cargos(request, response);
			} else if (action.equals("ver_editar_contrato")) {
				ver_editar_contrato(request, response);
			} else if (action.equals("contrato_insertar")) {
				contrato_insertar(request, response);
			} else if (action.equals("contrato_editar")) {
				contrato_editar(request, response);
			} else if (action.equals("contrato_deshabilitar")) {
				contrato_deshabilitar(request, response);
			} else if (action.equals("contrato_habilitar")) {
				contrato_habilitar(request, response);
			} else if (action.equals("ver_editar_horario")) {
				ver_editar_horario(request, response);
			}else if(action.equals("ver_editar_salario")){
				ver_editar_salario(request, response);
			}else if(action.equals("contratosalario_editar")){
				contratosalario_editar(request, response);
			}

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void crear_contrato(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String idempleado = request.getParameter("idempleado");
			request.setAttribute("empleado",
					empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado)));
			request.setAttribute("empresas", contratoEJB.getEmpresas());
			request.setAttribute("areas", contratoEJB.getAreas());
			request.setAttribute("tiposcontratos",contratoEJB.obtenerTiposDeContrato());
			request.setAttribute("tiposmoneda",contratoEJB.obtenerTiposDeMoneda());

			request.getRequestDispatcher("../pages/contrato/contrato_nuevo.jsp")
					.forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	public void cargar_sucursales(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idempresa = request.getParameter("idempresa");
			String idcontrato = request.getParameter("idcontrato");
			if (idcontrato != null && !idcontrato.equals("undefined")) {
				request.setAttribute("contrato",
						contratoEJB.getContratosporId(Long.valueOf(idcontrato)));
			}
			request.setAttribute("sucursales", contratoEJB
					.getSucursalesporEmpresa(Long.valueOf(idempresa)));
			request.getRequestDispatcher("../pages/empleado/lista_sucursal.jsp")
					.forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void cargar_cargos(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String idarea = request.getParameter("idarea");
			request.setAttribute("cargos",
					contratoEJB.getCargosporArea(Long.valueOf(idarea)));
			String idcontrato = request.getParameter("idcontrato");
			if (idcontrato != null && !idcontrato.equals("undefined")) {
				request.setAttribute("contrato",
						contratoEJB.getContratosporId(Long.valueOf(idcontrato)));
			}

			request.getRequestDispatcher("../pages/contrato/lista_cargos.jsp")
					.forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void ver_editar_contrato(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String idcontrato = request.getParameter("idcontrato");
			
			Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
			List<Horario> horarios = horarioEJB.getHorarios();
			List<ContratoTipo> tiposDeContrato = contratoEJB.obtenerTiposDeContrato();
			List<HorarioAsignado> horariosasignados = horarioEJB.getHorariosAsignadosporContrato(Long.valueOf(idcontrato));
			List<HorarioAsignado> horariosactivos = horarioEJB.getHorariosAsignadosporContratoActivos(Long.valueOf(idcontrato));
			
			List<TipoMoneda> listaTiposDeMoneda = contratoEJB.obtenerTiposDeMoneda();
//			EmpleadoSalario empleadoSalario  = contratoEJB.obtenerEmpleadoSalarioPorIdContrato(Long.valueOf(idcontrato));
			
			for(ContratoTipo c : tiposDeContrato){
				logger.info("datos : "+c.getIdcontratotipo()+" - "+c.getNombrecontratotipo());
			}
			
			logger.info("Tipo de contrato : "+contrato.getContratotipo().getIdcontratotipo());
			
			request.setAttribute("contrato", contrato);
			request.setAttribute("idContratoTipo", contrato.getContratotipo().getIdcontratotipo());
			request.setAttribute("tiposcontrato", tiposDeContrato);
			request.setAttribute("empresas", contratoEJB.getEmpresas());
			request.setAttribute("sucursales", contratoEJB.getSucursalesporEmpresa(contrato.getIdempresa()));
			request.setAttribute("areas", contratoEJB.getAreas());
			request.setAttribute("cargos",contratoEJB.getCargosporArea(contrato.getIdarea()));
			request.setAttribute("motivos", contratoEJB.getMotivos());
			request.setAttribute("idempleado", contrato.getIdempleado());
			request.setAttribute("horarios", horarios);
			request.setAttribute("horariosasignados", horariosasignados);
			
			
			//Novedad. 28/04/2015
			request.setAttribute("tiposmoneda", listaTiposDeMoneda);
//			request.setAttribute("empleadosalario",contratoEJB.obtenerEmpleadoSalarioPorIdContrato(Long.valueOf(idcontrato)));
			
			
			if (horariosactivos.size() > 0
					&& horariosactivos.get(0).getValidezfin() != null) {
				if (horariosactivos.get(0).getValidezfin().after(new Date())) {
					Date dat = new Date(horariosactivos.get(0).getValidezfin()
							.getTime());
					String a = Util.dateToString(dat, "dd/MM/yyyy");
					request.setAttribute("ultimohorariovalido",
							horariosactivos.get(0));
					request.setAttribute("fechamin", a);
				} else {
					Date dat = new Date();
					String a = Util.dateToString(dat, "dd/MM/yyyy");
					Timestamp t = new Timestamp(dat.getTime());
					HorarioAsignado horariotemp = new HorarioAsignado();
					horariotemp.setValidezfin(t);
					request.setAttribute("ultimohorariovalido", horariotemp);
					request.setAttribute("fechamin", a);
				}

			}
			request.getRequestDispatcher(
					"../pages/contrato/contrato_editar.jsp").forward(request,
					response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void ver_editar_horario(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try {
			String idcontrato = request.getParameter("idcontrato");
			// String idempleado = request.getParameter("idempleado");
			Contrato contrato = contratoEJB.getContratosporId(Long
					.valueOf(idcontrato));
			request.setAttribute("contrato", contrato);
			request.setAttribute("empresas", contratoEJB.getEmpresas());
			request.setAttribute("sucursales", contratoEJB
					.getSucursalesporEmpresa(contrato.getIdempresa()));
			request.setAttribute("areas", contratoEJB.getAreas());
			request.setAttribute("cargos",
					contratoEJB.getCargosporArea(contrato.getIdarea()));
			request.setAttribute("motivos", contratoEJB.getMotivos());
			request.setAttribute("idempleado", contrato.getIdempleado());
			List<Horario> horarios = horarioEJB.getHorarios();
			request.setAttribute("horarios", horarios);
			List<HorarioAsignado> horariosasignados = horarioEJB
					.getHorariosAsignadosporContrato(Long.valueOf(idcontrato));
			request.setAttribute("horariosasignados", horariosasignados);
			List<HorarioAsignado> horariosactivos = horarioEJB
					.getHorariosAsignadosporContratoActivos(Long
							.valueOf(idcontrato));
			if (horariosactivos.size() > 0) {
				if (horariosactivos.get(0).getValidezfin().after(new Date())) {
					Date dat = new Date(horariosactivos.get(0).getValidezfin()
							.getTime());
					String a = Util.dateToString(dat, "dd/MM/yyyy");
					request.setAttribute("ultimohorariovalido",
							horariosactivos.get(0));
					request.setAttribute("fechamin", a);
				} else {
					Date dat = new Date();
					String a = Util.dateToString(dat, "dd/MM/yyyy");
					Timestamp t = new Timestamp(dat.getTime());
					HorarioAsignado horariotemp = new HorarioAsignado();
					horariotemp.setValidezfin(t);
					request.setAttribute("ultimohorariovalido", horariotemp);
					request.setAttribute("fechamin", a);
				}

			}
			request.getRequestDispatcher(
					"../pages/contrato/contrato_horarios.jsp").forward(request,
					response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
//	ver_editar_salario(request, response);
	
	public void ver_editar_salario(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String idcontrato = request.getParameter("idcontrato");
			String idempleado = request.getParameter("idempleado");
			
			EmpleadoSalario empleadoSalario = contratoEJB.obtenerEmpleadoSalarioPorIdContrato(Long.valueOf(idcontrato));
			List<TipoMoneda> tiposDeMoneda = contratoEJB.obtenerTiposDeMoneda();
			
//			if(empleadoSalario!=null){
//				request.setAttribute("contratosalario", empleadoSalario);
//			}
			
			request.setAttribute("contratosalario", empleadoSalario);
			request.setAttribute("tiposmoneda", tiposDeMoneda);
			request.setAttribute("idempleado", idempleado);
			request.setAttribute("idcontrato", idcontrato);
			
			request.getRequestDispatcher("../pages/contrato/contrato_salario.jsp").forward(request,response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}
	
	
	

	public void contrato_insertar(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);

		try {
			String idempleado = request.getParameter("idempleado");
			String idempresa = request.getParameter("idempresa");
			String idsucursal = request.getParameter("idsucursal");
			String idarea = request.getParameter("idarea");
			String idareaasignada = request.getParameter("idareaasignada");
			String idcargo = request.getParameter("idcargo");
			String idmotivoretiro = request.getParameter("idmotivoretiro");
			String numerocontrato = request.getParameter("numerocontrato");
			String fechafirma = request.getParameter("fechafirma");
			String fechainicio = request.getParameter("fechainicio");
			String fechafin = request.getParameter("fechafin");
			// String idempresa = request.getParameter("idempresa");
			// String idsucursal = request.getParameter("idsucursal");

			String idTipoContrato = request.getParameter("idtipocontrato");
			
			String idTipoMoneda = request.getParameter("idtipomoneda");
			String sueldoUno = request.getParameter("sueldoactualuno");
			String sueldoDos = request.getParameter("sueldoactualdos");
			String sueldoTres = request.getParameter("sueldoactualtres");


			idempleado = idempleado == null ? "" : idempleado.trim();
			idempresa = idempresa == null ? "" : idempresa.trim();
			idsucursal = idsucursal == null ? "" : idsucursal.trim();
			idarea = idarea == null ? "" : idarea.trim();
			idareaasignada = idareaasignada == null ? "" : idareaasignada.trim();
			idcargo = idcargo == null ? "" : idcargo.trim();
			idmotivoretiro = idmotivoretiro == null ? "" : idmotivoretiro.trim();
			numerocontrato = numerocontrato == null ? "" : numerocontrato.trim();
			fechafirma = fechafirma == null ? "" : fechafirma.trim();
			fechainicio = fechainicio == null ? "" : fechainicio.trim();
			fechafin = fechafin == null ? "" : fechafin.trim();

			idTipoContrato = idTipoContrato == null ? "" : idTipoContrato.trim();

			idTipoMoneda = idTipoMoneda == null? "" :idTipoMoneda.trim();
			sueldoUno = sueldoUno == null ? "" : sueldoUno.trim();
			sueldoDos = sueldoDos == null ? "" : sueldoDos.trim();
			sueldoTres = sueldoTres == null ? "" : sueldoTres.trim();

			
			
			if (!idempleado.equals("") && !idareaasignada.equals("") && !idTipoMoneda.equals("")) {

				Contrato contrato = new Contrato();
//				EmpleadoSalario empleadoSalario  =new EmpleadoSalario();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				
				
				Date fechafir = formatter.parse(fechafirma);
				long time = fechafir.getTime();
				Timestamp timefechafirma = new Timestamp(time);

				Date fechaini = formatter.parse(fechainicio);
				long time1 = fechaini.getTime();
				Timestamp timefechaini = new Timestamp(time1);

				contrato.setIdempleado(Long.valueOf(idempleado));
				contrato.setIdempresa(Long.valueOf(idempresa));
				contrato.setIdsucursal(Long.valueOf(idsucursal));
				contrato.setIdarea(Long.valueOf(idarea));
				contrato.setIdareaasignada(Long.valueOf(idareaasignada));
				contrato.setIdcargo(Long.valueOf(idcargo));
				contrato.setIdusuariocrea(user.getCodusuario());
				contrato.setEstado(EstadoEnum.ACTIVO.getIndex());

				contrato.setIdcontratotipo(Long.valueOf(idTipoContrato));
				
//				contrato.setSalario(sueldoUno);

				if (idmotivoretiro != null && !idmotivoretiro.equals("")) {
					contrato.setIdretiromotivo(Long.valueOf(idmotivoretiro));
				}
				contrato.setNumerocontrato(numerocontrato);
				contrato.setFechafirma(timefechafirma);
				contrato.setFechainicio(timefechaini);

				if (fechafin != null && !fechafin.equals("")) {
					Date fechafi = formatter.parse(fechafin);
					long time2 = fechafi.getTime();
					Timestamp timefechafi = new Timestamp(time2);
					contrato.setFechafin(timefechafi);
				}

				//set empleado_salario
				
				
				contrato = contratoEJB.insertarContrato(contrato);
				
				if (contrato.getIdcontrato() != null && contrato.getIdcontrato() != 0) {
					EmpleadoSalario empleadoSalario  =new EmpleadoSalario();
					
					empleadoSalario.setIdcontrato(contrato.getIdcontrato());
					empleadoSalario.setIdtipomoneda(Long.valueOf(idTipoMoneda));
					empleadoSalario.setSalario(sueldoUno);
					empleadoSalario.setIdusuariocrea(user.getCodusuario());
					empleadoSalario.setEstado(EstadoEnum.ACTIVO.getIndex());
					
					empleadoSalario = contratoEJB.insertarEmpleadoSalario(empleadoSalario);
					
					if(empleadoSalario.getIdempleadosalario()!=null && empleadoSalario.getIdempleadosalario()!=0){
						PrintWriter out = response.getWriter();
						out.println(contrato.getIdempleado());
						out.close();
					}else{
						response.sendError(1,"Ocurrio un error al insertar el salario.");
					}
					
				} else {
					throw new LogicaException("Error al grabar el nuevo contrato.");
				}

			}else{
				response.sendError(1,"Existen campos vacios.");
			}

			// else {
			// throw new
			// LogicaException("El campo Clave debe conincidir con el campo Clave (repetir)");
			// }

		} catch (LogicaException e) {
			logger.info("Error : "+e);
			response.sendError(1, e.toString());
		} catch (Exception e) {
			logger.info("Error 2 : "+e);
			response.sendError(1, e.toString());
		}

	}

	public void contrato_editar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);

		try {
			String idcontrato = request.getParameter("idcontrato");
			String idempleado = request.getParameter("idempleado");
			String idempresa = request.getParameter("idempresa");
			String idsucursal = request.getParameter("idsucursal");
			String idarea = request.getParameter("idarea");
			String idareaasignada = request.getParameter("idareaasignadaeditar");
			String idcargo = request.getParameter("idcargo");

			String idmotivoretiro = request.getParameter("idmotivoretiro");
			String numerocontrato = request.getParameter("numerocontrato");
			String fechafirma = request.getParameter("fechafirma");
			String fechainicio = request.getParameter("fechainicio");
			String fechafin = request.getParameter("fechafin");
			// String idempresa = request.getParameter("idempresa");
			// String idsucursal = request.getParameter("idsucursal");

			
			//Para editar empleadoSalario.
//			String idTipoMoneda = request.getParameter("idtipomoneda");
//			String salario = request.getParameter("sueldoactualuno");
			
//			logger.info("Salario = "+salario);
			
			
			String idTipoContrato = request.getParameter("idtipocontratoasignado");

			idempleado = idempleado == null ? "" : idempleado.trim();
			idempresa = idempresa == null ? "" : idempresa.trim();
			idsucursal = idsucursal == null ? "" : idsucursal.trim();
			idarea = idarea == null ? "" : idarea.trim();
			idcargo = idcargo == null ? "" : idcargo.trim();
			idmotivoretiro = idmotivoretiro == null ? "" : idmotivoretiro.trim();
			numerocontrato = numerocontrato == null ? "" : numerocontrato.trim();
			fechafirma = fechafirma == null ? "" : fechafirma.trim();
			fechainicio = fechainicio == null ? "" : fechainicio.trim();
			fechafin = fechafin == null ? "" : fechafin.trim();
//			salario = salario == null ? "" : salario.trim();
//			idTipoMoneda = idTipoMoneda == null ? "" : idTipoMoneda.trim();
			idTipoContrato = idTipoContrato == null ? "" : idTipoContrato.trim();
			
//			if(salario.equals("")){
//				salario = request.getParameter("salarioOculto");
//			}

			if (idempleado != null && !idempleado.equals("") && !idarea.equals("") && !idcargo.equals("") && !idareaasignada.equals("")) {
				
				Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
//				EmpleadoSalario empleadoSalario = contratoEJB.obtenerEmpleadoSalarioPorIdContrato(Long.valueOf(idcontrato));
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				Date fechafir = formatter.parse(fechafirma);
				long time = fechafir.getTime();
				Timestamp timefechafirma = new Timestamp(time);

				Date fechaini = formatter.parse(fechainicio);
				long time1 = fechaini.getTime();
				Timestamp timefechaini = new Timestamp(time1);

				contrato.setFechainicio(timefechaini);
				contrato.setIdempleado(Long.valueOf(idempleado));
				contrato.setIdempresa(Long.valueOf(idempresa));
				contrato.setIdsucursal(Long.valueOf(idsucursal));
				contrato.setIdarea(Long.valueOf(idarea));
				contrato.setIdareaasignada(Long.valueOf(idareaasignada));
				contrato.setIdcargo(Long.valueOf(idcargo));
				contrato.setIdusuariocrea(user.getCodusuario());
				// contrato.setEstado(EstadoEnum.ACTIVO.getIndex());

				if (idmotivoretiro != null && !idmotivoretiro.equals("")) {
					contrato.setIdretiromotivo(Long.valueOf(idmotivoretiro));
				}
//				else{
//					contrato.setIdretiromotivo(null);
//				}
				
				contrato.setNumerocontrato(numerocontrato);
				contrato.setFechafirma(timefechafirma);
				contrato.setFechainicio(timefechaini);

//				contrato.setSalario(salario);
				contrato.setIdcontratotipo(Long.valueOf(idTipoContrato));

				contrato.setIdusuariomod(user.getCodusuario());
				contrato.setEstado(EstadoEnum.ACTIVO.getIndex());

				if (fechafin != null && !fechafin.equals("")) {
					Date fechafi = formatter.parse(fechafin);
					long time2 = fechafi.getTime();
					Timestamp timefechafi = new Timestamp(time2);
					contrato.setFechafin(timefechafi);
				} else {
					contrato.setFechafin(null);
				}

//				empleadoSalario.setIdcontrato(Long.valueOf(idcontrato));
//				empleadoSalario.setIdtipomoneda(Long.valueOf(idTipoMoneda));
//				empleadoSalario.setSalario(salario);
				
				//Actualizaciones.
				Integer resultado = contratoEJB.actualizaContrato(contrato);
				if (resultado > 0) {
//					Integer resultadoUpdate = contratoEJB.actualizarEmpleadoSalario(empleadoSalario);
//					if(resultadoUpdate > 0){
						PrintWriter out = response.getWriter();
						out.println(contrato.getIdempleado());
						out.close();
//					}else{
//						response.sendError(1,"Ocurrio un error al actualizar el salario del empleado.");
//					}
					
				} else {
					throw new LogicaException(
							"Error al grabar el nuevo contrato.");
				}
			} else {
				throw new LogicaException(
						"Debe ingresar los valores en los campos requeridos");
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

	public void contrato_deshabilitar(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idcontrato = request.getParameter("idcontrato");

			idcontrato = idcontrato == null ? "" : idcontrato.trim();

			Contrato contrato = contratoEJB.getContratosporId(Long
					.valueOf(idcontrato));

		
			
			if(contrato.getIdcontratotipo()==null ){
				throw new LogicaException("El contrato no tiene tipo de contrato.");
			}
			if(contrato.getFechafin()==null ){
				throw new LogicaException("El contrato no tiene fecha final de contrato.");
			}
			if(contrato.getIdretiromotivo()==null ){
				throw new LogicaException("El contrato no tiene motivo de retiro.");
			}
				
			
			contrato.setIdusuariomod(user.getCodusuario());

			Integer resultado = contratoEJB
					.deshabilitarEstadoContrato(contrato);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(contrato.getIdempleado());
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

	public void contrato_habilitar(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session
				.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idcontrato = request.getParameter("idcontrato");

			idcontrato = idcontrato == null ? "" : idcontrato.trim();

			Contrato contrato = contratoEJB.getContratosporId(Long
					.valueOf(idcontrato));
			// contrato.setIdcontrato(Long.valueOf((idcontrato)));
			contrato.setIdusuariomod(user.getCodusuario());

			Integer resultado = contratoEJB.habilitarEstadoContrato(contrato);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(contrato.getIdempleado());
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

	
	
//	contratosalario_editar(request, response);
	public void contratosalario_editar(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);

		try {
			
//			logger.info("DATOS QUE LLEGAN:");
			
			String idMonedaTipo = request.getParameter("idtipomoneda_editar");
			String salario = request.getParameter("sueldoactualuno_editar");
			String idContratoSalario = request.getParameter("idcontratosalario_editar");
			String idEmpleado = request.getParameter("idempleado_editar");		
			String idContrato = request.getParameter("idcontrato_editar");	
						
			idMonedaTipo = idMonedaTipo == null ? "" : idMonedaTipo.trim();
			salario = salario == null ? "" : salario.trim();
			idContratoSalario = idContratoSalario == null ? "" : idContratoSalario.trim();
			idEmpleado = idEmpleado == null ? "" : idEmpleado.trim();
			idContrato = idContrato == null ? "" : idContrato.trim();
			
			
//			logger.info("idMonedaTipo "+idMonedaTipo);
//			logger.info("salario "+salario);
//			logger.info("idContratoSalario "+idContratoSalario);
//			logger.info("idEmpleado "+idEmpleado);
//			logger.info("idContrato "+idContrato);
			
			EmpleadoSalario empleadoSalario =null;
			
			if(!idContrato.equals("") && idContrato!=null){
				empleadoSalario = contratoEJB.obtenerEmpleadoSalarioPorIdContrato(Long.valueOf(idContrato));
			}
			
			
			
			if(empleadoSalario==null){ //insertar
				logger.info("No tiene salario todavia, toca insertar.");
				EmpleadoSalario empleadoSalarioNuevo = new EmpleadoSalario();
				
				empleadoSalarioNuevo.setIdcontrato(Long.valueOf(idContrato));
				empleadoSalarioNuevo.setIdtipomoneda(Long.valueOf(idMonedaTipo));
				empleadoSalarioNuevo.setSalario(salario);
				empleadoSalarioNuevo.setIdusuariocrea(user.getCodusuario());
				empleadoSalarioNuevo.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				empleadoSalarioNuevo = contratoEJB.insertarEmpleadoSalario(empleadoSalarioNuevo);
				
				if(empleadoSalarioNuevo.getIdempleadosalario()!=null && empleadoSalarioNuevo.getIdempleadosalario()!=0){
					PrintWriter out = response.getWriter();
					out.println(Long.valueOf(idEmpleado));
					out.close();
				}else {
					throw new LogicaException("Error al grabar el nuevo contrato Salario.");
				}
			}else{//Editar.
				logger.info("Ya tiene salario, toca editrar el registro.");
				empleadoSalario.setIdcontrato(Long.valueOf(idContrato));
				empleadoSalario.setIdtipomoneda(Long.valueOf(idMonedaTipo));
				empleadoSalario.setSalario(salario);
				empleadoSalario.setIdusuariomod(user.getCodusuario());
				empleadoSalario.setEstado(EstadoEnum.ACTIVO.getIndex());
				
				Integer resultado = contratoEJB.actualizarEmpleadoSalario(empleadoSalario);
				
				if(resultado>0){
					PrintWriter out = response.getWriter();
					out.println(Long.valueOf(idEmpleado));
					out.close();
				}else {
					throw new LogicaException("Error al grabar el nuevo contrato Salario.");
				}
			}
				
		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}

	}
	
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	

}
