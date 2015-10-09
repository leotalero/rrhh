package co.sistemcobro.rrhh.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
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
import co.sistemcobro.all.exception.DatoException;
import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.all.util.Util;
import co.sistemcobro.asistencia.bean.AsistenciaClasificacion;
import co.sistemcobro.asistencia.constante.AsistenciaClasificacionEnum;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.rrhh.bean.Area;
import co.sistemcobro.rrhh.bean.CargoAreaAsignada;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.Evento;
import co.sistemcobro.rrhh.bean.FrecuenciaAsignacion;
import co.sistemcobro.rrhh.bean.Hora;
import co.sistemcobro.rrhh.bean.Horario;
import co.sistemcobro.rrhh.bean.HorarioAsignado;
import co.sistemcobro.rrhh.bean.ReporteAsignacion;
import co.sistemcobro.rrhh.bean.ReporteAsistencia;
import co.sistemcobro.rrhh.bean.ReporteGraficaAsistencia;
import co.sistemcobro.rrhh.constante.FrecuenciasHorariosEnum;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;
import co.sistemcobro.rrhh.ejb.HorarioEJB;
import co.sistemcobro.asistencia.ejb.AsistenciaEJB;

import com.google.gson.Gson;

/**
 * 
 * @author Leonardo talero
 * 
 */
@WebServlet(name = "HorariosServlet", urlPatterns = { "/page/horarios" })
public class HorariosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(HorariosServlet.class);

	private String  basedatosasistencia = "asistencia";
	
	//ResourceBundle config = ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);

	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;
	 
	@EJB
	private HorarioEJB horarioEJB;
	
	@EJB
	private AsistenciaEJB asistenciaEJB;
	
	public HorariosServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("asignar_horario")) {
				asignar_horario(request, response);
			} 
			else if(action.equals("deshabilitar_horarioasignado")){
				deshabilitar_horarioasignado(request, response);
			}else if(action.equals("habilitar_horarioasignado")){
				habilitar_horarioasignado(request, response);
			}
			else if(action.equals("mostrar_calendario")){
				mostrar_calendario(request, response);
			}else if(action.equals("mostrar_evento")){
				mostrar_evento(request, response);
			}
			else if(action.equals("asignacion_horario")){
				asignacion_horario(request, response);
			}
			else if(action.equals("tipofecha")){
				tipofecha(request, response);
			}
			else if(action.equals("vercalendario")){
				vercalendario(request, response);
			}
			else if(action.equals("verhorarioencalendario")){
				verhorarioencalendario(request, response);
			}
			else if(action.equals("empleado_vereditarhorarioasignado")){
				empleado_vereditarhorarioasignado(request, response);
			}
			else if(action.equals("editar_horario_asignado")){
				editar_horario_asignado(request, response);
			}
			else if(action.equals("asignar_horarios_masivo")){
				asignar_horarios_masivo(request, response);
			}
			else if(action.equals("ver_reportes")){
				ver_reportes(request, response);
			}
			else if(action.equals("empleadossinhorarios")){
				empleadossinhorarios(request, response);
			}
			else if(action.equals("deshabilitarhorariosactuales")){
				deshabilitarhorariosactuales(request, response);
			}
			else if(action.equals("empleadosreporteasignacion")){
				empleadosreporteasignacion(request, response);
			}
			else if(action.equals("empleadosreporteasistencia")){
				empleadosreporteasistencia(request, response);
			}
			else if(action.equals("empleadosreportegrafica")){
				empleadosreportegrafica(request, response);
			}
			else if(action.equals("empleadosreportegraficaHeat")){
				empleadosreportegraficaHeat(request, response);
			}
			
			
			
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}



	
	public void asignar_horario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Contrato contrato=new Contrato();
		try {
			HttpSession session = request.getSession(false);
			UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
			
			String idcontrato = request.getParameter("idcontrato");
			String idempleado = request.getParameter("idempleado");
			String idhorario = request.getParameter("idhorario");
			String validezinicio = request.getParameter("validezinicio");
			String validezfin = request.getParameter("validezfin");
			String observaciones = request.getParameter("observaciones");
			
			idcontrato = idcontrato == null ? "" : idcontrato;
			idempleado = idempleado == null ? "" : idempleado;
			idhorario = idhorario == null ? "" : idhorario;
			validezinicio = validezinicio == null ? "" : validezinicio;
	
			
			if(!idcontrato.equals("")){
				contrato=contratoEJB.getContratosporId(Long.valueOf(idcontrato));
				if(!idcontrato.equals("") && !idhorario.equals("") && contrato.getIdempleado()!=0 && !validezinicio.equals("")){
					Long idempleadotemp = contrato.getIdempleado();
					HorarioAsignado horarioasignado=new HorarioAsignado();
					horarioasignado.setIdhorario(Long.valueOf(idhorario));
					Horario horarioseleccionado = horarioEJB.getHorariosporId(Long.valueOf(idhorario));
					horarioasignado.setHorario(horarioseleccionado);
					List<HorarioAsignado> horarios=horarioEJB.getHorariosAsignadosporContratoActivos(contrato.getIdcontrato());
					
					
					
					horarioasignado.setIdempleado(Long.valueOf(idempleadotemp));
					horarioasignado.setIdcontrato(Long.valueOf(idcontrato));
					 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		             Date fechavalidezini=formatter.parse(validezinicio);
		             Time horaentrada = horarioseleccionado.getHoraentrada();
		 			Time horasalida = horarioseleccionado.getHorasalida();
		 			fechavalidezini.setHours(horaentrada.getHours());
		 			fechavalidezini.setMinutes(horaentrada.getMinutes());
		 			fechavalidezini.setSeconds(horaentrada.getSeconds());
		             long time = fechavalidezini.getTime();
			            Timestamp timefechavalidezini= new Timestamp(time);
			            horarioasignado.setValidezinicio(timefechavalidezini);
			            
			            if(validezfin!=null && !validezfin.equals("")){
			            	  Date fechavalidezfin=formatter.parse(validezfin);
			            	  fechavalidezfin.setHours(horasalida.getHours());
			            	  fechavalidezfin.setMinutes(horasalida.getMinutes());
			            	  fechavalidezfin.setSeconds(horasalida.getSeconds());
					           long time1 = fechavalidezfin.getTime();
					           Timestamp timefechavalidezfin= new Timestamp(time1);
					           horarioasignado.setValidezfin(timefechavalidezfin);
			            }else{
		            		Date dte=new Date();
			            	
		            	GregorianCalendar calendarEnd=new GregorianCalendar();
		            	calendarEnd.setTime(dte);
		            	    calendarEnd.set(calendarEnd.MONTH,11);
		            	    calendarEnd.set(calendarEnd.DAY_OF_MONTH,31);

		            	    // returning the last date
		            	    Date endDate=calendarEnd.getTime();
		            	    endDate.setHours(horasalida.getHours());
		            	    endDate.setMinutes(horasalida.getMinutes());
		            	    endDate.setSeconds(horasalida.getSeconds());
		            	    Timestamp findeaño = new Timestamp(endDate.getTime());
		            	    
		            	    horarioasignado.setValidezfin(findeaño);
		            	 
		            }
			         
					horarioasignado.setIdusuariocrea(user.getCodusuario());
					horarioasignado.setEstado(EstadoEnum.ACTIVO.getIndex());
					horarioasignado.setCausahorario(observaciones);
					
					
					for(HorarioAsignado ho:horarios){
						if(ho.getIdhorario()==horarioasignado.getIdhorario()){
							
							//cedulasconhorarios.add(em);
							if (horarioasignado.getValidezinicio().after(ho.getValidezinicio()) && horarioasignado.getValidezinicio().before(ho.getValidezfin())){
								throw new LogicaException("este contrato ya tiene asociado ese horario"
										+ " entre las fechas "+ho.getValidezinicio()+" y "+ ho.getValidezfin());
								
							}
							
						}else{
							
						}
						
						/*if((horarioasignado.getValidezinicio().after(ho.getValidezinicio() ) && horarioasignado.getValidezinicio().before(ho.getValidezfin()))   ||  ((horarioasignado.getValidezfin().after(ho.getValidezinicio() ) && horarioasignado.getValidezfin().before(ho.getValidezfin())))){
							throw new LogicaException("este contrato ya tiene asociado un horario"
									+ " entre las fechas "+ho.getValidezinicio()+" y "+ ho.getValidezfin()+" debe seleccionar una fecha superior a "+ho.getValidezfin() );
						}else{
							
						}*/
						
						
					}
					validarhorarioconotroshorariosactivos(horarioasignado,horarios);
					horarioasignado = horarioEJB.insertarHorarioAsignado(horarioasignado);
					
					if (horarioasignado.getIdhorarioasignado() != null && horarioasignado.getIdhorarioasignado()!= 0) {
						PrintWriter out = response.getWriter();
						out.println(horarioasignado.getIdcontrato());
						out.close();

					} else {
						throw new LogicaException("Error al asignar Horario.");
					}
				}
			}
			
			
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	public void deshabilitar_horarioasignado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idhorarioasignado = request.getParameter("idhorarioasignado");

			idhorarioasignado = idhorarioasignado == null ? "" : idhorarioasignado.trim();

			HorarioAsignado horarioasignado = horarioEJB.getHorariosAsignadosporId(Long.valueOf(idhorarioasignado));
			//contrato.setIdcontrato(Long.valueOf((idcontrato)));
			horarioasignado.setIdusuariomod(user.getCodusuario());
			horarioasignado.setEstado(EstadoEnum.DESHABILITADO.getIndex());
			Integer resultado =	horarioEJB.actualizarEstadoHorarioAsignado(horarioasignado);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(horarioasignado.getIdcontrato());
				out.close();
			} else {
				throw new LogicaException("Error al eliminar el horario.");
			}

		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}
	}

	
	public void habilitar_horarioasignado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idhorarioasignado = request.getParameter("idhorarioasignado");

			idhorarioasignado = idhorarioasignado == null ? "" : idhorarioasignado.trim();

			HorarioAsignado horarioasignado = horarioEJB.getHorariosAsignadosporId(Long.valueOf(idhorarioasignado));
			//contrato.setIdcontrato(Long.valueOf((idcontrato)));
			horarioasignado.setIdusuariomod(user.getCodusuario());
			horarioasignado.setEstado(EstadoEnum.ACTIVO.getIndex());
			List<HorarioAsignado> horarios=horarioEJB.getHorariosAsignadosporContratoActivos(horarioasignado.getIdcontrato());
			
			for(HorarioAsignado ho:horarios){
				if(ho.getIdhorario()==horarioasignado.getIdhorario()){
					
					//cedulasconhorarios.add(em);
					if (horarioasignado.getValidezinicio().after(ho.getValidezinicio()) && horarioasignado.getValidezinicio().before(ho.getValidezfin())){
						throw new LogicaException("este contrato ya tiene asociado ese horario"
								+ " entre las fechas "+ho.getValidezinicio()+" y "+ ho.getValidezfin());
						
					}
					
				}else{
					
				}
				
				
				
				
			}
			validarhorarioconotroshorariosactivos(horarioasignado,horarios);
			
			Integer resultado =	horarioEJB.actualizarEstadoHorarioAsignado(horarioasignado);
			if (resultado > 0) {
				PrintWriter out = response.getWriter();
				out.println(horarioasignado.getIdcontrato());
				out.close();
			} else {
				throw new LogicaException("Error al activar horario.");
			}

		} catch (LogicaException e) {

			response.sendError(1, e.toString());
		} catch (Exception e) {

			response.sendError(1, e.toString());
		}
	}

	
	
public void mostrar_calendario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String idcontrato = request.getParameter("idcontrato");
			request.setAttribute("idcontrato", idcontrato);
			request.getRequestDispatcher("../pages/horarios/horario_nuevo.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
public void mostrar_evento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
	try {
		String idcontrato = request.getParameter("idcontrato");
		if(idcontrato!=null){
			List<HorarioAsignado> horariosasignados=horarioEJB.getHorariosAsignadosporContrato(Long.valueOf( idcontrato));
			//	request.setAttribute("horariosasignados", horariosasignados);
				List<Evento> l = new ArrayList<Evento>();
				int i=0;
				Date date=null,datefin=null;
				for(HorarioAsignado x:horariosasignados){
					
					
						    GregorianCalendar start =new  GregorianCalendar();
							    Timestamp Validezinicio = x.getValidezinicio();
							     date = new Date(Validezinicio.getTime());
							    Time horaentrada = x.getHorario().getHoraentrada();
							    date.setHours(horaentrada.getHours());
							    date.setMinutes(horaentrada.getMinutes());
							    date.setSeconds(horaentrada.getSeconds());
							    
					            start.setTime(date);
					            
					           // start.add(Calendar.MINUTE, 60);
					            String endDatestart = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
					            endDatestart = endDatestart.replace(" ", "T");
					            
					            String  endDateend = null;
					            Timestamp Validezfin=null;
					         	 GregorianCalendar end = new GregorianCalendar();
					         	 
					            if(x.getValidezfin()==null){
					            	// Calendar calendarEnd=GregorianCalendar.getInstance();
					            	Date dte=new Date();
					            	
					            	GregorianCalendar calendarEnd=new GregorianCalendar();
					            	calendarEnd.setTime(dte);
					            	    calendarEnd.set(calendarEnd.MONTH,11);
					            	    calendarEnd.set(calendarEnd.DAY_OF_MONTH,31);
		
					            	    // returning the last date
					            	    Date endDate=calendarEnd.getTime();
					            	    Timestamp findeaño = new Timestamp(endDate.getTime());
					            	    
					            	x.setValidezfin(findeaño);
					            	  end = new GregorianCalendar();
									     Validezfin = x.getValidezfin();
									   datefin = new Date(Validezfin.getTime());
									    Time horasalida = x.getHorario().getHorasalida();
									    datefin.setHours(horasalida.getHours());
									    datefin.setMinutes(horasalida.getMinutes());
									    datefin.setSeconds(horasalida.getSeconds());
									    
							            end.setTime(datefin);
							            
							           // start.add(Calendar.MINUTE, 60);
							            endDateend = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(datefin);
							            endDateend = endDateend.replace(" ", "T");
					            	
					            }else{
					            	
					            	
					            	  end =new  GregorianCalendar();
									     Validezfin = x.getValidezfin();
									    datefin = new Date(Validezfin.getTime());
									    Time horasalida = x.getHorario().getHorasalida();
									    datefin.setHours(horasalida.getHours());
									    datefin.setMinutes(horasalida.getMinutes());
									    datefin.setSeconds(horasalida.getSeconds());
									    
							            end.setTime(datefin);
							            
							           // start.add(Calendar.MINUTE, 60);
							            endDateend = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(datefin);
							            endDateend = endDateend.replace(" ", "T");
							            
				                     	
					            }
					           
					            
							Evento evento = new Evento();
							evento.setId(i);
							evento.setTitle(x.getHorario().getNombrehorario()+" [ "+x.getHorario().getHoraentrada()+"-"+x.getHorario().getHorasalida()+"]");
							evento.setStart(endDatestart+"-05:00");
							EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(x.getIdempleado());
							x.setHorario(horarioEJB.getHorariosporId(x.getIdhorario()));
							evento.setDescription("empleado:"+empleado.getNombres()+""+empleado.getApellidos()+" - identificacion: "+empleado.getEmpleadoidentificacion().getNumeroidentificacion()+" - "
									+ " Horario:"+x.getHorario().getNombrehorario()+"["+x.getHorario().getHoraentrada()+"-"+x.getHorario().getHorasalida()+"]-[frecuencia:"+x.getFrecuenciaasignacion().getNombrefrecuencia()+"]"
									+"- [Validez Inicial: "+x.getValidezinicio()+" Validez Final: "+x.getValidezfin()+"]");
							evento.setEnd(endDateend+"-05:00");
							if(x.getEstado()==EstadoEnum.DESHABILITADO.getIndex()){
								evento.setColor("#AE3B50");
							}
							
							
							int dias = Util.diferenciaEnDias(start, end);
							int dia=0;
							
							 int tempfrec = x.getHorario().getIdfrecuenciaasignacion().intValue();
							 List<Integer> diadelasemana = diadelasemana(tempfrec);
							 List<HashMap<String, Object>> data = Util.diferenciaEnDiasconFrecuencia(start, end,diadelasemana,tempfrec);
							 HashMap<String, Object> firsthashmap=null;
							 GregorianCalendar primerafecha=null;
							 Date primerafechatemp=null;
							 Integer dianumero =null;
							 GregorianCalendar fecha=null;
							 if(data.size()!=0){
								firsthashmap = data.get(0);
								  primerafecha = (GregorianCalendar) firsthashmap.get("fecha");
								 primerafechatemp=primerafecha.getTime();
								 dianumero = (Integer) firsthashmap.get("dia");
								
								 fecha = primerafecha;
							}
							
							 
							//for(int j=0;j<=data.size();j++){
								int j=1;
							for(HashMap<String, Object> p:data){
								fecha=(GregorianCalendar)p.get("fecha");
								 Date fechaevento = fecha.getTime();
								 Date fechaeventosalida =null;
							
								 if( x.getHorario().getIdfrecuenciaasignacion()>=11){//si es nocturno
										
										long m = datefin.getTime();
										long k = date.getTime();
										Time m1 = new Time(m);
										Time k1 = new Time(k);
										Date temp = fecha.getTime();
										temp.setDate(fecha.getTime().getDate()+1);
										temp.setHours(m1.getHours());
										temp.setMinutes(m1.getMinutes());
										temp.setSeconds(m1.getSeconds());
										
										 fechaeventosalida =temp;
									
									}else{
										 fechaeventosalida =fecha.getTime();
										 fechaeventosalida.setHours( x.getHorario().getHorasalida().getHours());
										 fechaeventosalida.setMinutes( x.getHorario().getHorasalida().getMinutes());
										 fechaeventosalida.setSeconds( x.getHorario().getHorasalida().getSeconds());
										   
									}
								
								 
								 
								 //fechaeventosalida =fecha.getTime(); ;
								 
								 String formatoini = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(fechaevento);
						            String fechaparaeventoinicio = formatoini.replace(" ", "T");
						           
						          String formatofin = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(fechaeventosalida);
						            String fechaparaeventofin = formatofin.replace(" ", "T");
						        
						          
						            
								Evento event=new Evento();
								event.setId(j);
								
								event.setStart(fechaparaeventoinicio+"-05:00");
								event.setEnd(fechaparaeventofin+"-05:00");
								event.setTitle(evento.getTitle());
								event.setDescription(evento.getDescription());
								if(x.getEstado()==EstadoEnum.DESHABILITADO.getIndex()){
									event.setColor("#AE3B50");
								}		
										l.add(event);
								// fecha.add(Calendar.DAY_OF_YEAR, 1);
										j++;
							}
							i++;
							
						
				}
				
		         
			
				 
			/*	Evento d = new Evento();
				 d.setId(6);
				 d.setStart("2015-02-14T10:30:00-05:00");
				 d.setEnd("2015-02-14T16:30:00-05:00");
				
				 d.setTitle("Task in Progress2");
				
				 l.add(d);*/
		            
				 response.setContentType("application/json");
				 response.setCharacterEncoding("UTF-8");
				 PrintWriter out = response.getWriter();
				 String objeto = new Gson().toJson(l);
				 out.write(objeto);
				
		}
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}



public void asignacion_horario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
		List<Hora> horas=new  ArrayList<Hora>();
		
		horas=obtenerhoras();
		
		List<Horario> horarios = horarioEJB.getHorarios();
		List<FrecuenciaAsignacion> frecuencias = horarioEJB.getFrecuenciasignacion();
		
		request.setAttribute("horas", horas);
		request.setAttribute("horarios", horarios);
		request.setAttribute("frecuencias", frecuencias);
		
		request.getRequestDispatcher("../pages/horarios/horario_asignacion.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


private List<Hora> obtenerhoras(){
	List<Hora> horas=new ArrayList<Hora>();
	Hora hora=new Hora();
	
	Time time=new Time(0,0,0);
	for(int i=0;i<48;i++){
		hora=new Hora();
		hora.setHoratime(time);
		hora.setHorastring(time.toString());
		horas.add(hora);
		time.getMinutes();
		time.setMinutes(time.getMinutes()+30);
		
	}
	
	return horas;
	
}

public void tipofecha(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
		String idtipofecha = request.getParameter("idtipofecha");

		if(idtipofecha.equals("1")){
			//frecuencias
			horarioEJB.getHorarios();
			List<FrecuenciaAsignacion> frecuencias = horarioEJB.getFrecuenciasignacion();
			request.setAttribute("frecuencias", frecuencias);
			request.getRequestDispatcher("../pages/horarios/horario_rango.jsp").forward(request, response);
		}else if(idtipofecha.equals("2")){
			request.getRequestDispatcher("../pages/horarios/horario_fechas_especificas.jsp").forward(request, response);
		}
	
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void verhorarioencalendario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
	try {
		String horariohoraentrada = request.getParameter("idhoraentrada");
		String horariohorasalida = request.getParameter("idhorasalida");
		String idfrecuencia = request.getParameter("idfrecuencia");
		String fechainicio = request.getParameter("fechainicio");
		String fechafin = request.getParameter("fechafin");
		String fechasespecificas = request.getParameter("fechasespecificas");
		String nombrehorario = request.getParameter("nombrehorario");
		
		HorarioAsignado horarioasignado=new HorarioAsignado();
		Horario horarioobjeto=new Horario();
		
		Time horain = Time.valueOf(horariohoraentrada);
		Time horaout = Time.valueOf(horariohorasalida);
		horarioobjeto.setHoraentrada(horain);
		horarioobjeto.setHorasalida(horaout);
		horarioobjeto.setIdfrecuenciaasignacion(Long.valueOf(idfrecuencia));
		
		horarioasignado.setHorario(horarioobjeto);
		
			Date fechavalidezini=formatter.parse(fechainicio);
         	long time = fechavalidezini.getTime();
            Timestamp timefechavalidezini= new Timestamp(time);
            horarioasignado.setValidezinicio(timefechavalidezini);
            Date fechavalidezfin=formatter.parse(fechainicio);
            long timefin = fechavalidezfin.getTime();
            Timestamp timefechavalidezfin= new Timestamp(time);
            horarioasignado.setValidezfin(timefechavalidezfin);
   	
		
		List<Evento> l=new ArrayList<Evento>();
		
			
			
		    GregorianCalendar start =new  GregorianCalendar();
		    Timestamp Validezinicio = horarioasignado.getValidezinicio();
		    Date date = new Date(Validezinicio.getTime());
		    Time horaentrada = horarioasignado.getHorario().getHoraentrada();
		    date.setHours(horaentrada.getHours());
		    date.setMinutes(horaentrada.getMinutes());
		    date.setSeconds(horaentrada.getSeconds());
		    
            start.setTime(date);
            
           // start.add(Calendar.MINUTE, 60);
            String endDatestart = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
            endDatestart = endDatestart.replace(" ", "T");
            
            String  endDateend = null;
            Timestamp Validezfin=null;
         	 GregorianCalendar end = new GregorianCalendar();
         	 
            if(horarioasignado.getValidezfin()==null){
            	// Calendar calendarEnd=GregorianCalendar.getInstance();
            	Date dte=new Date();
            	
            	GregorianCalendar calendarEnd=new GregorianCalendar();
            	calendarEnd.setTime(dte);
            	    calendarEnd.set(calendarEnd.MONTH,11);
            	    calendarEnd.set(calendarEnd.DAY_OF_MONTH,31);

            	    // returning the last date
            	    Date endDate=calendarEnd.getTime();
            	    Timestamp findeaño = new Timestamp(endDate.getTime());
            	    
            	    horarioasignado.setValidezfin(findeaño);
            	  end = new GregorianCalendar();
				     Validezfin = horarioasignado.getValidezfin();
				    Date datefin = new Date(Validezfin.getTime());
				    Time horasalida =horarioasignado.getHorario().getHorasalida();
				    datefin.setHours(horasalida.getHours());
				    datefin.setMinutes(horasalida.getMinutes());
				    datefin.setSeconds(horasalida.getSeconds());
				    
		            end.setTime(datefin);
		            
		           // start.add(Calendar.MINUTE, 60);
		            endDateend = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(datefin);
		            endDateend = endDateend.replace(" ", "T");
            	
            }else{
            	
            	
            	  end =new  GregorianCalendar();
				     Validezfin = horarioasignado.getValidezfin();
				    Date datefin = new Date(Validezfin.getTime());
				    Time horasalida = horarioasignado.getHorario().getHorasalida();
				    datefin.setHours(horasalida.getHours());
				    datefin.setMinutes(horasalida.getMinutes());
				    datefin.setSeconds(horasalida.getSeconds());
				    
		            end.setTime(datefin);
		            
		           // start.add(Calendar.MINUTE, 60);
		            endDateend = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(datefin);
		            endDateend = endDateend.replace(" ", "T");
		            
                 	
            }
           
            
		Evento evento = new Evento();
		evento.setId(1);
		evento.setTitle(horarioasignado.getHorario().getNombrehorario()+" [ "+horarioasignado.getHorario().getHoraentrada()+"-"+horarioasignado.getHorario().getHorasalida()+"]");
		evento.setStart(endDatestart+"-05:00");
		EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(horarioasignado.getIdempleado());
		
		evento.setDescription("empleado:"+empleado.getNombres()+""+empleado.getApellidos()+" identificacion:"+empleado.getEmpleadoidentificacion().getNumeroidentificacion());
		
		evento.setEnd(endDateend+"-05:00");
		
		
		int dias = Util.diferenciaEnDias(start, end);
		GregorianCalendar fecha = start;
		for(int j=0;j<=dias;j++){
			
			
			 Date fechaevento = fecha.getTime();
			 Date fechaeventosalida = fecha.getTime();
			 fechaeventosalida.setHours( horarioasignado.getHorario().getHorasalida().getHours());
			 fechaeventosalida.setMinutes( horarioasignado.getHorario().getHorasalida().getMinutes());
			 fechaeventosalida.setSeconds( horarioasignado.getHorario().getHorasalida().getSeconds());
			    
			 String formatoini = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(fechaevento);
	            String fechaparaeventoinicio = formatoini.replace(" ", "T");
	           
	          String formatofin = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(fechaeventosalida);
	            String fechaparaeventofin = formatofin.replace(" ", "T");
	        
	          
	            
			Evento event=new Evento();
			event.setId(j);
			
			event.setStart(fechaparaeventoinicio+"-05:00");
			event.setEnd(fechaparaeventofin+"-05:00");
			event.setTitle(evento.getTitle());
			event.setDescription(evento.getDescription());
			
			l.add(event);
			 fecha.add(Calendar.DAY_OF_MONTH, 1);
		}
		
		

		 response.setContentType("application/json");
		 response.setCharacterEncoding("UTF-8");
		 PrintWriter out = response.getWriter();
		 String objeto = new Gson().toJson(l);
		 out.write(objeto);
		
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}

public void vercalendario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		String horariohoraentrada = request.getParameter("idhoraentrada");
		String horariohorasalida = request.getParameter("idhorasalida");
		String idfrecuencia = request.getParameter("idfrecuencia");
		String fechainicio = request.getParameter("fechainicio");
		String fechafin = request.getParameter("fechafin");
		String fechasespecificas = request.getParameter("fechasespecificas");
		String nombrehorario = request.getParameter("nombrehorario");
		
		
		request.setAttribute("horariohoraentrada", horariohoraentrada);
		request.setAttribute("horariohorasalida", horariohorasalida);
		request.setAttribute("idfrecuencia", idfrecuencia);
		request.setAttribute("fechainicio", fechainicio);
		request.setAttribute("fechafin", fechafin);
		request.setAttribute("fechasespecificas", fechasespecificas);
		request.setAttribute("nombrehorario", nombrehorario);
		
		request.getRequestDispatcher("../pages/horarios/horario_calendario.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	private List<Integer> diadelasemana(int frecuencia){
		List<Integer> dia=new ArrayList<Integer>();
		if(frecuencia==FrecuenciasHorariosEnum.LUNES.getIndex() || frecuencia==FrecuenciasHorariosEnum.LUNES_NOCTURNO.getIndex()){
			dia.add(2);
		}else if(frecuencia==FrecuenciasHorariosEnum.MARTES.getIndex() || frecuencia==FrecuenciasHorariosEnum.MARTES_NOCTURNO.getIndex() ){
			dia.add(3);
		}
		else if(frecuencia==FrecuenciasHorariosEnum.MIERCOLES.getIndex() || frecuencia==FrecuenciasHorariosEnum.MIERCOLES_NOCTURNO.getIndex() ){
			dia.add(4);
		}
		else if(frecuencia==FrecuenciasHorariosEnum.JUEVES.getIndex() || frecuencia==FrecuenciasHorariosEnum.JUEVES_NOCTURNO.getIndex() ){
			dia.add(5);
		}
		else if(frecuencia==FrecuenciasHorariosEnum.VIERNES.getIndex() || frecuencia==FrecuenciasHorariosEnum.VIERNES_NOCTURNO.getIndex() ){
			dia.add(6);
		}else if(frecuencia==FrecuenciasHorariosEnum.SABADO.getIndex() || frecuencia==FrecuenciasHorariosEnum.SABADO_NOCTURNO.getIndex() ){
			dia.add(7);
		}
		else if(frecuencia==FrecuenciasHorariosEnum.DOMINGO.getIndex() || frecuencia==FrecuenciasHorariosEnum.DOMINGO_NOCTURNO.getIndex() ){
			dia.add(1);
		}else if(frecuencia==FrecuenciasHorariosEnum.LUNES_VIERNES.getIndex() || frecuencia==FrecuenciasHorariosEnum.LUNES_VIERNES_NOCTURNO.getIndex() ){
			dia.add(2);dia.add(3);dia.add(4);dia.add(5);dia.add(6);
			
		}
		else if(frecuencia==FrecuenciasHorariosEnum.lUNES_SABADO.getIndex() || frecuencia==FrecuenciasHorariosEnum.LUNES_SABADO_NOCTURNO.getIndex() ){
			dia.add(2);dia.add(3);dia.add(4);dia.add(5);dia.add(6);dia.add(7);
			
		}
		else if(frecuencia==FrecuenciasHorariosEnum.FIN_DE_SEMANA.getIndex() || frecuencia==FrecuenciasHorariosEnum.FIN_DE_SEMANA_NOCTURNO.getIndex() ){
			dia.add(7);	dia.add(1);
			
		}
		
		return dia;
		
	}
	
	
public void empleado_vereditarhorarioasignado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String idhorarioasignado = request.getParameter("idhorarioasignado");
			String idcontrato = request.getParameter("idcontrato");
			 HorarioAsignado horarioasignado = horarioEJB.getHorariosAsignadosporId(Long.valueOf(idhorarioasignado));
			List<Horario> horarios = horarioEJB.getHorarios();
			Contrato contrato = contratoEJB.getContratosporId(Long.valueOf(idcontrato));
			request.setAttribute("horarioasignado", horarioasignado);
			request.setAttribute("horarios", horarios);
			request.setAttribute("contrato", contrato);
			
			
			request.getRequestDispatcher("../pages/horarios/horario_asignacion_editar.jsp").forward(request, response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
public void editar_horario_asignado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	HttpSession session = request.getSession(false);
	UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
	 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	try {
		String idcontrato = request.getParameter("idcontrato");
		String idhorarioasignado = request.getParameter("idhorarioasignado");
		String idhorario = request.getParameter("idhorario");
		String validezinicio = request.getParameter("validezinicioeditar");
		String validezfin = request.getParameter("validezfineditar");
		String observaciones = request.getParameter("observaciones");
		
		
	if(idcontrato!=null && idhorario!=null && idhorarioasignado!=null){
		
		HorarioAsignado horarioasignado=new HorarioAsignado();
		horarioasignado=horarioEJB.getHorariosAsignadosporId(Long.valueOf(idhorarioasignado));
		Horario horario = horarioEJB.getHorariosporId(Long.valueOf(idhorario));
		horarioasignado.setHorario(horario);
		horarioasignado.setIdhorario(Long.valueOf(idhorario));
		
		List<HorarioAsignado> horarios=horarioEJB.getHorariosAsignadosporContratoActivos(Long.valueOf(idcontrato));
		
		
			Date fechavalidezini=formatter.parse(validezinicio);
			Time horaentrada = horario.getHoraentrada();
			Time horasalida =horario.getHorasalida();
			fechavalidezini.setHours(horaentrada.getHours());
			fechavalidezini.setMinutes(horaentrada.getMinutes());
			fechavalidezini.setSeconds(horaentrada.getSeconds());
	     	long time = fechavalidezini.getTime();
	        
	     	Timestamp timefechavalidezini= new Timestamp(time);
	        
	        
	   horarioasignado.setValidezinicio(timefechavalidezini);
	   if(validezfin!=null && !validezfin.equals("")){
     	  Date fechavalidezfin=formatter.parse(validezfin);
     	 fechavalidezfin.setHours(horasalida.getHours());
     	fechavalidezfin.setMinutes(horasalida.getMinutes());
     	fechavalidezfin.setSeconds(horasalida.getSeconds());
	           long time1 = fechavalidezfin.getTime();
	           Timestamp timefechavalidezfin= new Timestamp(time1);
	           horarioasignado.setValidezfin(timefechavalidezfin);
     }else{
 		Date dte=new Date();
    	
 	GregorianCalendar calendarEnd=new GregorianCalendar();
 	calendarEnd.setTime(dte);
 	    calendarEnd.set(calendarEnd.MONTH,11);
 	    calendarEnd.set(calendarEnd.DAY_OF_MONTH,31);

 	    // returning the last date
 	    Date endDate=calendarEnd.getTime();
 	    Timestamp findeaño = new Timestamp(endDate.getTime());
 	    
 	    horarioasignado.setValidezfin(findeaño);
 	 
 }
	
	   horarioasignado.setCausahorario(observaciones);
		horarioasignado.setIdusuariomod(user.getCodusuario());
		horarioasignado.setEstado(EstadoEnum.ACTIVO.getIndex());
		
		
		
		validarhorarioconotroshorariosactivos(horarioasignado,horarios);
		
		Integer resultado = horarioEJB.EditarHorarioAsignado(horarioasignado);
				if (resultado >0) {
			PrintWriter out = response.getWriter();
			out.println(horarioasignado.getIdcontrato());
			out.close();

		} else {
			throw new LogicaException("Error al editar los datos de la nueva propiedad.");
		}
	}else{
		throw new LogicaException("Existen valores en blanco y no se puede guardar el registro");
	}
		
			
		// else {
		//	throw new LogicaException("El campo Clave debe conincidir con el campo Clave (repetir)");
		//}

	} catch (LogicaException e) {

		response.sendError(1, e.toString());
	} catch (Exception e) {

		response.sendError(1, e.toString());
	}
}


private void validarhorarioconotroshorariosactivos(HorarioAsignado horarioasignado, List<HorarioAsignado> horarios) throws LogicaException, ParseException, DatoException {
	
/////////////////////////////////validacion de horario para no overlap
GregorianCalendar startasignado=new GregorianCalendar();
Date startdateasignado= new Date(horarioasignado.getValidezinicio().getTime());
startasignado.setTime(startdateasignado);
GregorianCalendar endasignado=new GregorianCalendar();
Date enddateasignado= new Date(horarioasignado.getValidezfin().getTime());
endasignado.setTime(enddateasignado);

int tempfrecasignado = horarioasignado.getHorario().getIdfrecuenciaasignacion().intValue();
List<Integer> diadelasemanaasignado = diadelasemana(tempfrecasignado);
List<HashMap<String, Object>> dataasignado = Util.diferenciaEnDiasconFrecuencia(startasignado, endasignado,diadelasemanaasignado,tempfrecasignado);




for(HorarioAsignado ho:horarios){
			if(ho.getIdhorarioasignado().equals(horarioasignado.getIdhorarioasignado())){
			
			}else{
			if(ho.getIdhorario()==horarioasignado.getIdhorario()){
			
			/*//cedulasconhorarios.add(em);
			if (horarioasignado.getValidezinicio().after(ho.getValidezinicio()) && horarioasignado.getValidezinicio().before(ho.getValidezfin())){
			throw new LogicaException("este contrato ya tiene asociado ese horario"
			+ " entre las fechas "+ho.getValidezinicio()+" y "+ ho.getValidezfin());
			
			}*/
			
			}else{
			
			}

		Contrato contrato = contratoEJB.getContratosporId(ho.getIdcontrato());
		EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(contrato.getIdempleado());	
	GregorianCalendar start=new GregorianCalendar();
	Date startdate= new Date(ho.getValidezinicio().getTime());
	start.setTime(startdate);
	GregorianCalendar end=new GregorianCalendar();
	Date enddate= new Date(ho.getValidezfin().getTime());
	end.setTime(enddate);
	
	int tempfrec = ho.getHorario().getIdfrecuenciaasignacion().intValue();
	List<Integer> diadelasemana = diadelasemana(tempfrec);
	List<HashMap<String, Object>> data = Util.diferenciaEnDiasconFrecuencia(start, end,diadelasemana,tempfrec);
	
					for(HashMap<String, Object> diadehorario:data){
				HashMap<String, Object> horariofechas=new HashMap<String, Object>();
				GregorianCalendar fecha = (GregorianCalendar)diadehorario.get("fecha");
				Date fechadat =fecha.getTime();
				GregorianCalendar fechafin = (GregorianCalendar)diadehorario.get("fechafin");
				Date fechafindat = fechafin.getTime();
				for(HashMap<String, Object> diaasignado:dataasignado){
						HashMap<String, Object> horariofechasasignadas=new HashMap<String, Object>();
						GregorianCalendar fechaasignada = (GregorianCalendar)diaasignado.get("fecha");
						Date fechaasignadadat =fechaasignada.getTime();
						GregorianCalendar fechafinasignada = (GregorianCalendar)diaasignado.get("fechafin");
						Date fechafinasignadadat = fechafinasignada.getTime();
									if(fechaasignada.after(fechafin)){
									
									break;
									}else{
									
											if((fechaasignada.getTime().after(fecha.getTime())||fechaasignada.getTime().equals(fecha.getTime())) && fechaasignada.getTime().before(fechafin.getTime()) ){
												
									//	if((fechaasignada.getTime().after(fecha.getTime()) && fechaasignada.getTime().before(fechafin.getTime())) ){
											
											throw new LogicaException("Este contrato del empleado con identificación numero:"+empleado.getEmpleadoidentificacion().getNumeroidentificacion() +" ya tiene asociado un horario"
														+ " en las fechas "+Util.dateToString(fecha.getTime(), "dd/MM/yyyy HH:mm") +" y "+ Util.dateToString(fechafin.getTime(),"dd/MM/yyyy HH:mm")+" debe seleccionar un rango de dias diferente o un horario diferente");
											}else{
												
											}
											if((fechafinasignada.getTime().after(fecha.getTime())||fechafinasignada.getTime().equals(fecha.getTime())) && fechafinasignada.getTime().before(fechafin.getTime()) ){
												throw new LogicaException("Este contrato del empleado con identificación numero:"+empleado.getEmpleadoidentificacion().getNumeroidentificacion() +" ya tiene asociado un horario"
														+ " en las fechas "+Util.dateToString(fecha.getTime(), "dd/MM/yyyy HH:mm")+" y "+ Util.dateToString(fechafin.getTime(),"dd/MM/yyyy HH:mm")+" debe seleccionar un rango de dias diferente o un horario diferente");
											}else{
												
											}
											
											if((fecha.getTime().after(fechaasignada.getTime() ) && fecha.getTime().before(fechafinasignada.getTime())) ){
												throw new LogicaException("Este contrato del empleado con identificación numero:"+empleado.getEmpleadoidentificacion().getNumeroidentificacion() +" ya tiene asociado un horario"
														+ " en las fechas "+Util.dateToString(fecha.getTime(), "dd/MM/yyyy HH:mm")+" y "+ Util.dateToString(fechafin.getTime(),"dd/MM/yyyy HH:mm")+" debe seleccionar un rango de dias diferente o un horario diferente");
											}else{
												
											}
											if((fechafin.getTime().after(fechaasignada.getTime() ) && fechafin.getTime().before(fechafinasignada.getTime())) ){
												throw new LogicaException("Este contrato del empleado con identificación numero:"+empleado.getEmpleadoidentificacion().getNumeroidentificacion() +" ya tiene asociado un horario"
														+ " en las fechas "+Util.dateToString(fecha.getTime(), "dd/MM/yyyy HH:mm")+" y "+ Util.dateToString(fechafin.getTime(),"dd/MM/yyyy HH:mm")+" debe seleccionar un rango de dias diferente o un horario diferente");
											}else{
												
											}
									
									}
						}
				
				
				
				
				
				
				}

}


}


/////////////////////////fin validacion/
}

public void asignar_horarios_masivo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	Horario horario=new Horario();
	try {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		//String idcontrato = request.getParameter("idcontrato");
		//String idempleado = request.getParameter("idempleado");
		String idhorario = request.getParameter("idhorario");
		String validezinicio = request.getParameter("validezinicioAsignacion");
		String validezfin = request.getParameter("validezfinAsignacion");
		String observaciones = request.getParameter("observaciones");
		String cedulas=request.getParameter("cedulas");
		String[] cedulasindividuales; 
		if(cedulas!=null){
			cedulasindividuales = cedulas.split("\\s*,\\s*");
			idhorario = idhorario == null ? "" : idhorario;
			cedulas = cedulas == null ? "" : cedulas;
			idhorario = idhorario == null ? "" : idhorario;
			validezinicio = validezinicio == null ? "" : validezinicio;

			List<Contrato> contratos=new ArrayList<Contrato>();
			if(!idhorario.equals("")){
				horario=horarioEJB.getHorariosporId(Long.valueOf(idhorario));
				List<EmpleadoBean> empleados=new ArrayList<EmpleadoBean>();
				List<EmpleadoBean> empleadosfinales=new ArrayList<EmpleadoBean>();
				Contrato contrato;
				List<HorarioAsignado> horariosasignados=new  ArrayList<HorarioAsignado>();
				for(String cedula:cedulasindividuales){  //nusca empleados por cedulas
					empleados= empleadoEJB.buscarEmpleadospornumeroidentificacionActivo(cedula);
					if(empleados.size()==0){
						throw new LogicaException("documento de identificación número ." +cedula+ " no se encuentra en la aplicacion RRHH");
					}else{
						for(EmpleadoBean e:empleados){
							empleadosfinales.add(e);
						}
					}
					
					
				}	
					for(EmpleadoBean em:empleadosfinales){  
							contrato= contratoEJB.getUltimoContratosporIdEmpleado(em.getIdempleado());//busca contratos
							
							if(contrato!=null && contrato.getIdcontrato()!=null){
								
							
							List<HorarioAsignado> horarios = horarioEJB.getHorariosAsignadosporContratoActivos(contrato.getIdcontrato());
							
							//////////////inserta horrio asignado al contrato
							Long idempleadotemp = contrato.getIdempleado();
							HorarioAsignado horarioasignado=new HorarioAsignado();
							horarioasignado.setIdhorario(Long.valueOf(idhorario));
							Horario horarioseleccionado = horarioEJB.getHorariosporId(Long.valueOf(idhorario));
							horarioasignado.setHorario(horarioseleccionado);
							Time horaentrada = horarioseleccionado.getHoraentrada();
							Time horasalida = horarioseleccionado.getHorasalida();
							horarioasignado.setIdempleado(Long.valueOf(idempleadotemp));
							horarioasignado.setIdcontrato(Long.valueOf(contrato.getIdcontrato()));
							 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				             Date fechavalidezini=formatter.parse(validezinicio);
				             fechavalidezini.setHours(horaentrada.getHours());
				             fechavalidezini.setMinutes(horaentrada.getMinutes());
				             fechavalidezini.setSeconds(horaentrada.getSeconds());
				             long time = fechavalidezini.getTime();
					            Timestamp timefechavalidezini= new Timestamp(time);
					            horarioasignado.setValidezinicio(timefechavalidezini);
					            
					            if(validezfin!=null && !validezfin.equals("")){
					            	  Date fechavalidezfin=formatter.parse(validezfin);
					            	  fechavalidezfin.setHours(horasalida.getHours());
					            	  fechavalidezfin.setMinutes(horasalida.getMinutes());
					            	  fechavalidezfin.setSeconds(horasalida.getSeconds());
							           long time1 = fechavalidezfin.getTime();
							           Timestamp timefechavalidezfin= new Timestamp(time1);
							           horarioasignado.setValidezfin(timefechavalidezfin);
					            }else{
					            		Date dte=new Date();
					            	
					            	GregorianCalendar calendarEnd=new GregorianCalendar();
					            	calendarEnd.setTime(dte);
					            	    calendarEnd.set(calendarEnd.MONTH,11);
					            	    calendarEnd.set(calendarEnd.DAY_OF_MONTH,31);
		
					            	    // returning the last date
					            	    Date endDate=calendarEnd.getTime();
					            	    endDate.setHours(horasalida.getHours());
					            	    endDate.setMinutes(horasalida.getMinutes());
					            	    endDate.setSeconds(horasalida.getSeconds());
					            	    Timestamp findeaño = new Timestamp(endDate.getTime());
					            	    
					            	    horarioasignado.setValidezfin(findeaño);
					            	 
					            }
					         
							horarioasignado.setIdusuariocrea(user.getCodusuario());
							horarioasignado.setIdusuariomod(user.getCodusuario());
							horarioasignado.setEstado(EstadoEnum.ACTIVO.getIndex());
							horarioasignado.setCausahorario(observaciones);
						
							for(HorarioAsignado ho:horarios){
								if(ho.getIdhorario()==horarioasignado.getIdhorario()){
									
									//cedulasconhorarios.add(em);
									if (horarioasignado.getValidezinicio().after(ho.getValidezinicio()) && horarioasignado.getValidezinicio().before(ho.getValidezfin())){
										throw new LogicaException("el documento número " +em.getEmpleadoidentificacion().getNumeroidentificacion()+ " ya tiene asociado ese horario"
												+ " entre las fechas "+ho.getValidezinicio()+" y "+ ho.getValidezfin());
										
									}
									
								}else{
									
								}
									
							}
							validarhorarioconotroshorariosactivos(horarioasignado,horarios);
							horariosasignados.add(horarioasignado);
							
							
							contratos.add(contrato);
						}else{
							throw new LogicaException("el documento número " +em.getEmpleadoidentificacion().getNumeroidentificacion()+ " no tiene contrato activo");
							
						}
					}
					
				
					
					horariosasignados = horarioEJB.insertarHorariosAsignados(horariosasignados);
					
					if (horariosasignados.get(0).getIdhorarioasignado() != null && horariosasignados.get(horariosasignados.size()-1).getIdhorarioasignado()!= 0) {
						PrintWriter out = response.getWriter();
						out.println("Se asignaron "+horariosasignados.size()+" horarios correctamente");
						out.close();

					} else {
						throw new LogicaException("Error al asignar Horario.");
					}
				
				
				
				
				
				
				
				
			
			}
		
		}
		
		
		
	
		
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void deshabilitarhorariosactuales(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	Horario horario=new Horario();
	try {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		
		//String idcontrato = request.getParameter("idcontrato");
		//String idempleado = request.getParameter("idempleado");
		String idhorario = request.getParameter("idhorario");
		String validezinicio = request.getParameter("validezinicio");
		String validezfin = request.getParameter("validezfin");
		String observaciones = request.getParameter("observaciones");
		String cedulas=request.getParameter("cedulas");
		String[] cedulasindividuales; 
		Integer resu=0;
		if(cedulas!=null){
			cedulasindividuales = cedulas.split("\\s*,\\s*");
			idhorario = idhorario == null ? "" : idhorario;
			cedulas = cedulas == null ? "" : cedulas;
			idhorario = idhorario == null ? "" : idhorario;
			validezinicio = validezinicio == null ? "" : validezinicio;

			List<Contrato> contratos=new ArrayList<Contrato>();
			
				//horario=horarioEJB.getHorariosporId(Long.valueOf(idhorario));
				List<EmpleadoBean> empleados=new ArrayList<EmpleadoBean>();
				List<EmpleadoBean> empleadosfinales=new ArrayList<EmpleadoBean>();
				Contrato contrato;
				List<HorarioAsignado> horariosasignados=new  ArrayList<HorarioAsignado>();
				for(String cedula:cedulasindividuales){  //nusca empleados por cedulas
					empleados= empleadoEJB.buscarEmpleadospornumeroidentificacion(cedula);
					if(empleados.size()==0){
						throw new LogicaException("documento de identificación número ." +cedula+ " no se encuentra en la aplicacion RRHH");
					}else{
						for(EmpleadoBean e:empleados){
							empleadosfinales.add(e);
						}
					}
					
					
				}	
					for(EmpleadoBean em:empleadosfinales){  
							contrato= contratoEJB.getUltimoContratosporIdEmpleado(em.getIdempleado());//busca contratos
							
							if(contrato!=null && contrato.getIdcontrato()!=null){
								
							
							List<HorarioAsignado> horarios = horarioEJB.getHorariosAsignadosporContratoActivos(contrato.getIdcontrato());
							if(horarios.size()>0){
								resu = horarioEJB.deshabilitarHorarioAsignadoMasivo(horarios);
								
								if (resu>0) {
									//PrintWriter out = response.getWriter();
									//out.println("Se deshabilitaron los horarios correctamente");
									//out.close();

								} else {
									throw new LogicaException("Error al deshabilitar horario.");
								}
							
								
							}else{
								throw new LogicaException("El número de cedula no tiene horarios activos");
							}
							
						
						
						}else{
							throw new LogicaException("el documento número " +em.getEmpleadoidentificacion().getNumeroidentificacion()+ " no tiene contrato activo");
							
						}
					}
					
				
					
					
				
				
				
				
				
				
				
					if (resu>0) {
						PrintWriter out = response.getWriter();
						out.println("Se deshabilitaron los horarios correctamente");
						out.close();

					} else {
						throw new LogicaException("Error al deshabilitar horario.");
					}
			
		
		}else{
			throw new LogicaException("Por favor ingrese cedulas para deshabilitar horarios.");
		}
		
		
		
	
		
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}
public void ver_reportes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	HttpSession session = request.getSession(false);
	UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
	try {
		
		//String idcontrato = request.getParameter("idcontrato");
		//request.setAttribute("idcontrato", idcontrato);
		List<Area> areas = contratoEJB.getAreas();
		List<Area> areasasignada =new ArrayList<Area>();
		if(user.getUsuarioaplicacion().getGrupo().getIdgrupo()==215 || user.getUsuarioaplicacion().getGrupo().getIdgrupo()==216){
			List<EmpleadoBean> empleado = empleadoEJB.buscarEmpleadosporCodigoIdentificacion(user.getCodigoidentificacion());
			if(empleado.size()>0){
				Contrato contrato = contratoEJB.getUltimoContratosporIdEmpleado(empleado.get(0).getIdempleado());
				if(contrato!=null){
					List<CargoAreaAsignada> areasamostrar = contratoEJB.getCargoAreasAsignadas(contrato.getIdcargo(), contrato.getIdareaasignada());
					if(areasamostrar.size()>0){
						request.setAttribute("areas", areasamostrar);
					}else{
						areasasignada=contratoEJB.getAreasporId(contrato.getIdareaasignada());

						request.setAttribute("areas", areasasignada);
					}
					
				}
					
				
				
			}else{
				throw new LogicaException("No se encuentra el empleado con ese codigo de identificación.");
			}
			
			
			
			
		}else{
			request.setAttribute("areas", areas);
		}
		
		
		request.getRequestDispatcher("../pages/horarios/horario_reportes.jsp").forward(request, response);
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void empleadossinhorarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
	String fechahasta = request.getParameter("fechahasta");
	String fechadesde = request.getParameter("fechadesde");
	//String idareaRsinhorario = request.getParameter("idareaRsinhorario");
	String[] idareas = request.getParameterValues("idareaRsinhorario");
	String[] val = idareas[0].split("\\s*,\\s*");
	List<String> areas=new ArrayList<String>();
for(String idarea:val){
		if(!idarea.equals("null")){
			if(!idarea.equals("") ){
				areas.add(idarea);
			}
			
		}else{
			throw new LogicaException("Debe seleccionar un Area.");
		}
		 
  }
		if(fechahasta!=null && fechadesde!=null){
			//String fechadesde="";
		List<EmpleadoBean> empleados = empleadoEJB.buscarEmpleadosSinHorario(fechahasta,fechadesde,areas);
		for(EmpleadoBean x:empleados){
		 Contrato contrato = contratoEJB.getUltimoContratosporIdEmpleado(x.getIdempleado());
		 x.setUltimocontrato(contrato);
		
		 //contrato
		}
		request.setAttribute("empleados", empleados);
		request.getRequestDispatcher("../pages/horarios/horario_lista_empleadosinhorario.jsp").forward(request, response);
			
			
		}else{
			throw new LogicaException("Debe seleccionar una fecha para el reporte.");
		}
			
		
		
		} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}

	












//////////////////////////////////////////////funciones//////////////////////////////////////////
private List<HashMap<String, Object>> retornafechasdehorario(HorarioAsignado ho,Contrato contrato) throws LogicaException{
	//Botones botones =new Botones();
	Date date=null;
	int flag=0;
	
	 List<HashMap<String, Object>> datahorariofechas=new ArrayList<HashMap<String,Object>>();
	if(ho!=null && ho.getValidezinicio()!=null && ho.getValidezfin()!=null){
			//if (dateservidor.after(ho.getValidezinicio()) && dateservidor.before(ho.getValidezfin())){
			//si esta en el rango de dias	para el horario
				GregorianCalendar start =new  GregorianCalendar();
			    Timestamp Validezinicio = ho.getValidezinicio();
			     date = new Date(Validezinicio.getTime());
			    Time horaentrada = ho.getHorario().getHoraentrada();
			    date.setHours(horaentrada.getHours());
			    date.setMinutes(horaentrada.getMinutes());
			    date.setSeconds(horaentrada.getSeconds());
			    
	            start.setTime(date);
	            
	            GregorianCalendar end;
				Timestamp Validezfin;
				Date datefin;
				//si tiene fecha finalizacion
										if(ho.getValidezfin()==null){
							            	// Calendar calendarEnd=GregorianCalendar.getInstance();
							            	Date dte=new Date();
							            	
							            	GregorianCalendar calendarEnd=new GregorianCalendar();
							            	calendarEnd.setTime(dte);
							            	    calendarEnd.set(calendarEnd.MONTH,11);
							            	    calendarEnd.set(calendarEnd.DAY_OF_MONTH,31);
				
							            	    // returning the last date
							            	    Date endDate=calendarEnd.getTime();
							            	    Timestamp findeaño = new Timestamp(endDate.getTime());
							            	    
							            	ho.setValidezfin(findeaño);
							            	  end = new GregorianCalendar();
											     Validezfin = ho.getValidezfin();
											   datefin = new Date(Validezfin.getTime());
											    Time horasalida = ho.getHorario().getHorasalida();
											    datefin.setHours(horasalida.getHours());
											    datefin.setMinutes(horasalida.getMinutes());
											    datefin.setSeconds(horasalida.getSeconds());
											    
									            end.setTime(datefin);
									            
									          
							            	
							            }else{
							            	
							            	
							            	  end =new  GregorianCalendar();
											     Validezfin = ho.getValidezfin();
											    datefin = new Date(Validezfin.getTime());
											    Time horasalida = ho.getHorario().getHorasalida();
											    datefin.setHours(horasalida.getHours());
											    datefin.setMinutes(horasalida.getMinutes());
											    datefin.setSeconds(horasalida.getSeconds());
											    
									            end.setTime(datefin);
									            
									          
									          
									            
						                     	
							            }
							            
							            
	            
	            
				int dias = Util.diferenciaEnDias(start, end);
				int dia=0;
				
				 int tempfrec = ho.getHorario().getIdfrecuenciaasignacion().intValue();
				 List<Integer> diadelasemana = diadelasemana(tempfrec);
				 //data tiene la informacion de los dias incluidos en el horario
				 List<HashMap<String, Object>> data = Util.diferenciaEnDiasconFrecuencia(start, end,diadelasemana,tempfrec);
				 Date fechaeventoentrada = null;
				 Date fechaeventosalida =null;
				
				for(HashMap<String, Object> datainfo:data){
					 HashMap<String, Object> horariofechas=new HashMap<String, Object>();
					GregorianCalendar fecha = (GregorianCalendar)datainfo.get("fecha");
					
					 fechaeventoentrada = fecha.getTime();
					
				
				
					 
					 if( ho.getHorario().getIdfrecuenciaasignacion()>=11){//si es nocturno
							
							long m = datefin.getTime();
							long k = date.getTime();
							Time m1 = new Time(m);
							Time k1 = new Time(k);
							Date temp = fecha.getTime();
							temp.setDate(fecha.getTime().getDate()+1);
							temp.setHours(m1.getHours());
							temp.setMinutes(m1.getMinutes());
							temp.setSeconds(m1.getSeconds());
							
							 fechaeventosalida =temp;
						
						}else{
							 fechaeventosalida =fecha.getTime();
							 fechaeventosalida.setHours( ho.getHorario().getHorasalida().getHours());
							 fechaeventosalida.setMinutes( ho.getHorario().getHorasalida().getMinutes());
							 fechaeventosalida.setSeconds( ho.getHorario().getHorasalida().getSeconds());
							   
						}
					 
				 
					horariofechas.put("fechaeventoentrada", fechaeventoentrada);
					horariofechas.put("fechaeventosalida", fechaeventosalida) ;
					 datahorariofechas.add(horariofechas);
				}//termina for hash map data
				
			
		
		
			
	}
	return datahorariofechas;
}


public void empleadosreporteasistencia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
		//String idareaRasistencia = request.getParameter("idareaRasistencia");
	String fechadesde = request.getParameter("desde");
	String fechahasta = request.getParameter("hasta");
	
		String[] idareas = request.getParameterValues("idareaRasistencia");
		String[] val = idareas[0].split("\\s*,\\s*");
		List<String> areas=new ArrayList<String>();
	for(String idarea:val){
		if(!idarea.equals("null")){
			if(!idarea.equals("") ){
				areas.add(idarea);
			}
			
		}else{
			throw new LogicaException("Debe seleccionar un Area.");
		}
			 
      }
	
		if(fechadesde!=null && fechahasta!=null){
		
		
		List<ReporteAsistencia> reporteaasistencia = horarioEJB.Reporteasistencia(fechadesde,fechahasta,basedatosasistencia,areas );
		
		request.setAttribute("reporteaasistencias", reporteaasistencia);
		
		request.getSession().setAttribute("reporteaasistencia", reporteaasistencia);
		request.getSession().setAttribute("areas", areas);
		request.getRequestDispatcher("../pages/horarios/horario_lista_reporteasistencia.jsp").forward(request, response);
			
			
		}else{
			throw new LogicaException("Debe seleccionar rango de fechas para el reporte.");
		}
			
		
		
		} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}
public void empleadosreporteasignacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
	String fechadesde = request.getParameter("desde");
	String fechahasta = request.getParameter("hasta");
	String[] idareas = request.getParameterValues("idareaRAsignacion");
	String[] val = idareas[0].split("\\s*,\\s*");
	List<String> areas=new ArrayList<String>();
			for(String idarea:val){
				if(!idarea.equals("null")){
					if(!idarea.equals("") ){
						areas.add(idarea);
					}
					
				}else{
					throw new LogicaException("Debe seleccionar un Area.");
				}
					 
			  }
		if(fechadesde!=null && fechahasta!=null){
			GregorianCalendar desde=new GregorianCalendar();
			GregorianCalendar hasta=new GregorianCalendar();
			desde.setTime(Util.stringToDate(fechadesde, "dd/MM/yyyy"));
			hasta.setTime(Util.stringToDate(fechahasta, "dd/MM/yyyy"));
			hasta.add(Calendar.DAY_OF_YEAR,1);
			Date desdet = desde.getTime();
			Date hastat = hasta.getTime();
			int intervalo = 0;
			String intervalofechas="";
			List<Timestamp> frequencias = new ArrayList<Timestamp>();
			if(desdet.equals(hastat)){
				frequencias.add(new Timestamp(desdet.getTime()));
			}
			while (desdet.before(hastat)) {
				
				frequencias.add(new Timestamp(desdet.getTime()));
				intervalo++;
				desdet=Util.addDays(new Timestamp(desdet.getTime()), 1);
				
				
			}
			String formato = "dd/MM/yyyy";
			
		 List<ReporteAsignacion> reporteasignaciones = horarioEJB.Reporteasignacion(fechadesde,fechahasta,areas);
		request.setAttribute("reporteasignaciones", reporteasignaciones);
		request.setAttribute("frequencias", frequencias);
		request.setAttribute("formato", formato);
		
		request.getRequestDispatcher("../pages/horarios/horario_lista_reporteasignacion.jsp").forward(request, response);
			
			
		}else{
			throw new LogicaException("Debe seleccionar rango de fechas para el reporte.");
		}
			
		
		
		} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}
public void empleadosreportegrafica(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
		List<ReporteAsistencia> reporteaasistencia = new ArrayList<ReporteAsistencia>();
		reporteaasistencia=(List<ReporteAsistencia>) request.getSession().getAttribute("reporteaasistencia");
		
		List<String> areas = (List<String>) request.getSession().getAttribute("areas");
		
		request.setAttribute("reporteaasistencia", reporteaasistencia);
		
		if(reporteaasistencia!=null && reporteaasistencia.size()>0){
			String fechadesde = reporteaasistencia.get(0).getFechadesde();
			String fechahasta = reporteaasistencia.get(0).getFechahasta();
			GregorianCalendar desde=new GregorianCalendar();
			GregorianCalendar hasta=new GregorianCalendar();
			desde.setTime(Util.stringToDate(fechadesde, "dd/MM/yyyy"));
			hasta.setTime(Util.stringToDate(fechahasta, "dd/MM/yyyy"));
			int dias = Util.diferenciaEnDias(desde, hasta);
		String fechas="";
			
			String series="{";
			Long temp = null ;
			int sumanalistastarde = 0,sumanalistasatiempo=0,sumanalistasatiempotol=0,sumanalistasfaltas=0;
			List<AsistenciaClasificacion> clasificaciones=asistenciaEJB.getAllClasificacion();
			
			
			List<ReporteGraficaAsistencia> grafica = horarioEJB.ReporteGraficaAsistencia( basedatosasistencia,fechadesde,fechahasta,clasificaciones,areas);
				

			String tarde=" type: 'column', name:'Tarde', data:[";
			String atiempo=" type: 'column', name:'A tiempo', data:[";
			String falta=" type: 'column', name:'Falta', data:[";
			String atimpoconflex=" type: 'column', name:'A tiempo con Flex', data:[";
			String pie="type: 'pie',   name: '% Asistencia',   data: [";
			
			String pietarde="{   name: 'Tarde', color: '"+clasificaciones.get(0).getColor() +"', y:";
			String pieatiempo="{ name:'A tiempo', color: '"+clasificaciones.get(1).getColor() +"', y:";
			String piefalta="{ name:'Falta', color: '"+clasificaciones.get(2).getColor() +"', y:";
			String pieatimpoconflex="{  name:'A timpo Flex:', color: '"+clasificaciones.get(3).getColor() +"', y:";

            int val=0,intpietarde=0,intpieatiempo=0,intpiefalta=0,intpieatimpoconflex=0;
			String fechas1="";
			int total=0;
			for(ReporteGraficaAsistencia x:grafica){
			
				
				String coma1 = ",";
				if(val==grafica.size()-1){
					fechas1=fechas1+"'"+x.getFecha()+"'"; 
				}else{
					fechas1=fechas1+"'"+x.getFecha()+"'"+coma1; 
				}
				
				String coma=",";
				
				if(val==grafica.size()-1){
					tarde+=x.getTarde()+"] ,  color: '"+clasificaciones.get(0).getColor() +"'";
					atiempo+=x.getAtiempo()+"], color: '"+clasificaciones.get(1).getColor() +"'";
					falta+=x.getFalta()+"], color: '"+clasificaciones.get(2).getColor() +"' ";
					atimpoconflex+=x.getAtiempoconflex()+"]  ,  color: '"+clasificaciones.get(3).getColor() +"'";
				}else{
				tarde+=x.getTarde()+coma;
				atiempo+=x.getAtiempo()+coma;
				falta+=x.getFalta()+coma;
				atimpoconflex+=x.getAtiempoconflex()+coma;
				
				}
				intpietarde+=x.getTarde();
				intpieatiempo+=x.getAtiempo();
				intpiefalta+=x.getFalta();
				intpieatimpoconflex+=x.getAtiempoconflex();
				total+=x.getTarde()+x.getAtiempo()+x.getFalta()+x.getAtiempoconflex();
				val++;
			}
			Double t = 0.0;
			Double at=0.0;
			Double f=0.0;
			Double atf=0.0;
				if(total!=0){
					 t = (double)((double) (intpietarde*100)/total);
					 at=(double)((double) (intpieatiempo*100)/total);
					 f=(double)((double) (intpiefalta*100)/total);
					 atf =(double) ((double)(intpieatimpoconflex*100)/total);
				}
		
			pietarde+=t+"}";
			
			pieatiempo+=at+"}";
			
			piefalta+=f+"}";
		
			pieatimpoconflex+=atf+"}";
			
			//pie+=pietarde+","+pieatiempo+","+piefalta+","+pieatimpoconflex+"], ";
			pie+=pietarde+","+pieatiempo+","+pieatimpoconflex+"], ";
			pie+="center: [100, 80],   size: 100,  showInLegend: false, dataLabels: {enabled: true  }";
			
				//series+=tarde+" },{ "+atiempo+" },{ "+falta+" },{ "+atimpoconflex+" },{ "+ pie +  " }";
				series+=tarde+" },{ "+atiempo+" },{ "+atimpoconflex+" },{ "+ pie +  " }";
				
				
				
			
			request.setAttribute("fechas", fechas1);
			request.setAttribute("series", series);
			request.getRequestDispatcher("../pages/horarios/heatgraph.jsp").forward(request, response);
		}else{
			
		}
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}


public void empleadosreportegraficaHeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	try {
		
		List<ReporteAsistencia> reporteaasistencia = new ArrayList<ReporteAsistencia>();
		reporteaasistencia=(List<ReporteAsistencia>) request.getSession().getAttribute("reporteaasistencia");
		 request.getSession().removeAttribute("reporteaasistencia");
		List<String> areas = (List<String>) request.getSession().getAttribute("areas");
		
		request.setAttribute("reporteaasistencia", reporteaasistencia);
		
		if(reporteaasistencia!=null){
			String fechadesde = reporteaasistencia.get(0).getFechadesde();
			String fechahasta = reporteaasistencia.get(0).getFechahasta();
			GregorianCalendar desde=new GregorianCalendar();
			GregorianCalendar hasta=new GregorianCalendar();
			desde.setTime(Util.stringToDate(fechadesde, "dd/MM/yyyy"));
			hasta.setTime(Util.stringToDate(fechahasta, "dd/MM/yyyy"));
			int dias = Util.diferenciaEnDias(desde, hasta);
		String fechas="";
			
			String series="{";
			Long temp = null ;
			int sumanalistastarde = 0,sumanalistasatiempo=0,sumanalistasatiempotol=0,sumanalistasfaltas=0;
			List<AsistenciaClasificacion> clasificaciones=asistenciaEJB.getAllClasificacion();
			
			
			List<ReporteGraficaAsistencia> grafica = horarioEJB.ReporteGraficaAsistencia( basedatosasistencia,fechadesde,fechahasta,clasificaciones,areas);
				

			String tarde=" type: 'column', name:'Tarde', data:[";
			String atiempo=" type: 'column', name:'A tiempo', data:[";
			String falta=" type: 'column', name:'Falta', data:[";
			String atimpoconflex=" type: 'column', name:'A tiempo con Flex', data:[";
			String pie="type: 'pie',   name: '% Asistencia',   data: [";
			
			String pietarde="{   name: 'Tarde', color: '"+clasificaciones.get(0).getColor() +"', y:";
			String pieatiempo="{ name:'A tiempo', color: '"+clasificaciones.get(1).getColor() +"', y:";
			String piefalta="{ name:'Falta', color: '"+clasificaciones.get(2).getColor() +"', y:";
			String pieatimpoconflex="{  name:'A timpo Flex:', color: '"+clasificaciones.get(3).getColor() +"', y:";

            int val=0,intpietarde=0,intpieatiempo=0,intpiefalta=0,intpieatimpoconflex=0;
			String fechas1="";
			int total=0;
			for(ReporteGraficaAsistencia x:grafica){
			
				
				String coma1 = ",";
				if(val==grafica.size()-1){
					fechas1=fechas1+"'"+x.getFecha()+"'"; 
				}else{
					fechas1=fechas1+"'"+x.getFecha()+"'"+coma1; 
				}
				
				String coma=",";
				
				if(val==grafica.size()-1){
					tarde+=x.getTarde()+"] ,  color: '"+clasificaciones.get(0).getColor() +"'";
					atiempo+=x.getAtiempo()+"], color: '"+clasificaciones.get(1).getColor() +"'";
					falta+=x.getFalta()+"], color: '"+clasificaciones.get(2).getColor() +"' ";
					atimpoconflex+=x.getAtiempoconflex()+"]  ,  color: '"+clasificaciones.get(3).getColor() +"'";
				}else{
				tarde+=x.getTarde()+coma;
				atiempo+=x.getAtiempo()+coma;
				falta+=x.getFalta()+coma;
				atimpoconflex+=x.getAtiempoconflex()+coma;
				
				}
				intpietarde+=x.getTarde();
				intpieatiempo+=x.getAtiempo();
				intpiefalta+=x.getFalta();
				intpieatimpoconflex+=x.getAtiempoconflex();
				total+=x.getTarde()+x.getAtiempo()+x.getFalta()+x.getAtiempoconflex();
				val++;
			}
			Double t = 0.0;
			Double at=0.0;
			Double f=0.0;
			Double atf=0.0;
				if(total!=0){
					 t = (double)((double) (intpietarde*100)/total);
					 at=(double)((double) (intpieatiempo*100)/total);
					 f=(double)((double) (intpiefalta*100)/total);
					 atf =(double) ((double)(intpieatimpoconflex*100)/total);
				}
		
			pietarde+=t+"}";
			
			pieatiempo+=at+"}";
			
			piefalta+=f+"}";
		
			pieatimpoconflex+=atf+"}";
			
			//pie+=pietarde+","+pieatiempo+","+piefalta+","+pieatimpoconflex+"], ";
			pie+=pietarde+","+pieatiempo+","+pieatimpoconflex+"], ";
			pie+="center: [100, 80],   size: 100,  showInLegend: false, dataLabels: {enabled: true  }";
			
			//	series+=tarde+" },{ "+atiempo+" },{ "+falta+" },{ "+atimpoconflex+" },{ "+ pie +  " }";
			series+=tarde+" },{ "+atiempo+" },{ "+atimpoconflex+" },{ "+ pie +  " }";
				
				
				
			
			request.setAttribute("fechas", fechas1);
			request.setAttribute("series", series);
			request.getRequestDispatcher("../pages/horarios/heatsquaregraph.jsp").forward(request, response);
		}
		
	} catch (Exception e) {
		logger.error(e.toString(), e.fillInStackTrace());
		response.sendError(1, e.getMessage());
	}

}

}
