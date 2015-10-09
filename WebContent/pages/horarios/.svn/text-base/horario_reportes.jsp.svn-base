<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">


	$(document).ready(function() {
	
		$("#dmMensajeHorario").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("[name=btnBuscarsinHorario]").button();	
		
		$("[name=btnCrearCancelarEditar]").button();

		$("[name=btnBuscarAsistencia]").button();
		$("[name=btnBuscarAsignacion]").button();
		
		$("#fReportesinHorario").validate({
			
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idareaRsinhorario: {
					required: true,
					min:1
				},
				fechaHasta:{
					required: true,
					//date: true
				}
			},
			messages: {
				
				idareaRsinhorario: {
					required: "Seleccione un Area",
					
					
				},
				fechaHasta: {
					required: "Seleccione una fecha ",
					date:"error en formato de fecha"
					//date: true
				}
			}
			
			
		});

	

		$("#fReporteAsistencia").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idareaRasistencia: {
					required: true,
					min:1
				},
				RasistenciafechaDesde:{
					required: true,
					//date: true
				},
				RasistenciafechaHasta:{
					required: true,
					//date: true
				}
			},
			messages: {
				
				idareaRasistencia: {
					required: "Seleccione un Area",
					
					
				},
				RasistenciafechaDesde: {
					required: "Seleccione una fecha ",
					date:"error en formato de fecha"
				},
				RasistenciafechaHasta: {
					required: "Seleccione una fecha ",
					date:"error en formato de fecha"
					
				}
			}
			
			
		});

	
		
		var dates = $("#fechaDesde,#fechaHasta")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			//maxDate : '+0D',
			//minDate : '-0D',
			minyear:'-80Y',
			numberOfMonths : 1,
			 changeMonth: true,
			 changeYear: true,
			//showAnim: 'fold',
			dayNamesMin : [ 'Do', 'Lu', 'Ma',
					'Mi', 'Ju', 'Vi', 'Sa' ],
			monthNames : [ 'Enero', 'Febrero',
					'Marzo', 'Abril', 'Mayo',
					'Junio', 'Julio', 'Agosto',
					'Septiembre', 'Octubre',
					'Noviembre', 'Diciembre' ],
			monthNamesShort : [ 'Ene', 'Feb',
					'Mar', 'Abr', 'May', 'Jun',
					'Jul', 'Ago', 'Sep', 'Oct',
					'Nov', 'Dic' ],
			onSelect : function(selectedDate) {
				var option = this.id == "fechaDesde" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates.not(this).datepicker("option", option, date);
			}
		});
		
		
		var dates1 = $("#RasistenciafechaDesde,#RasistenciafechaHasta")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			//maxDate : '+0D',
			//minDate : '-0D',
			minyear:'-80Y',
			numberOfMonths : 1,
			 changeMonth: true,
			 changeYear: true,
			//showAnim: 'fold',
			dayNamesMin : [ 'Do', 'Lu', 'Ma',
					'Mi', 'Ju', 'Vi', 'Sa' ],
			monthNames : [ 'Enero', 'Febrero',
					'Marzo', 'Abril', 'Mayo',
					'Junio', 'Julio', 'Agosto',
					'Septiembre', 'Octubre',
					'Noviembre', 'Diciembre' ],
			monthNamesShort : [ 'Ene', 'Feb',
					'Mar', 'Abr', 'May', 'Jun',
					'Jul', 'Ago', 'Sep', 'Oct',
					'Nov', 'Dic' ],
			onSelect : function(selectedDate) {
				var option = this.id == "RasistenciafechaDesde" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates1.not(this).datepicker("option", option, date);
			}
		});
		
		
		var dates2 = $("#RasigfechaDesde,#RasigfechaHasta")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			//maxDate : '+0D',
			//minDate : '-0D',
			minyear:'-80Y',
			numberOfMonths : 1,
			 changeMonth: true,
			 changeYear: true,
			//showAnim: 'fold',
			dayNamesMin : [ 'Do', 'Lu', 'Ma',
					'Mi', 'Ju', 'Vi', 'Sa' ],
			monthNames : [ 'Enero', 'Febrero',
					'Marzo', 'Abril', 'Mayo',
					'Junio', 'Julio', 'Agosto',
					'Septiembre', 'Octubre',
					'Noviembre', 'Diciembre' ],
			monthNamesShort : [ 'Ene', 'Feb',
					'Mar', 'Abr', 'May', 'Jun',
					'Jul', 'Ago', 'Sep', 'Oct',
					'Nov', 'Dic' ],
			onSelect : function(selectedDate) {
				var option = this.id == "RasigfechaDesde" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates2.not(this).datepicker("option", option, date);
			}
		});
		
		
		$("#fReporteAsistencia [name=idareaRasistencia]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		    //classes: '',
		    checkAllText: 'Marcar todos',
		   uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
		    selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: true,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});

		
		$("#fReportesinHorario [name=idareaRsinhorario]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		   // classes: '',
		    checkAllText: 'Marcar todos',
		    uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
		   selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: true,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});
		
		$("#fReporteAsignacion [name=idareaRAsignacion]").multiselect({
		    /*header: true,*/
		    height: 175,
		    minWidth: 225,
		   // classes: '',
		    checkAllText: 'Marcar todos',
		    uncheckAllText: 'Desmarcar todos',
		    noneSelectedText: 'Seleccionar Area',
		   selectedText: '# selecionado(s)',
		    selectedList: 1,
		    show: null,
		    hide: null,
		    autoOpen: false,
		    multiple: true,
		    position: {},
		    appendTo: "body",
		   


		}).multiselectfilter({                         
		     label: 'Filtro:&nbsp;',               
		  placeholder: '',
		  autoReset: false
		});
		
	});
	
	
	
	function EditarHorarioAsignado(form) {
		$("[name=btnEditarHorarioAsignado]").attr('disabled',true);;
		//$("[name=btnCrearCancelarContrato]").attr('disabled',true);;
		$("#dmMensajeHorario").dialog("open");
		$("#dmMensajeHorario").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarHorarioAsignado]").attr('disabled',false);
        		$("[name=btnCrearCancelarContrato]").attr('disabled',false);
                $("#dmMensajeHorario").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            	//	alert("ok");
            		$("#dmMensajeHorario").dialog("close");
                	$("#dmEditarHorarioAsignado").dialog("close");
                	visualizarEditarContrato(data);
                } else {
                	//$("[name=btnEditarHorarioAsignado]").attr('disabled',false);
            		//$("[name=btnCrearCancelarContrato]").attr('disabled',false);
                    $("#dmMensajeHorario").html('Error desconocido');					
                }            		 
            }
        });
	}

	
	
	

	
	function validarEntero(valor){ 
    	valor = parseInt(valor);
     	//Compruebo si es un valor numérico 
     	if (isNaN(valor)) { 
           	 //entonces (no es numero) devuelvo el valor cadena vacia 
           	 return false;
     	}else{ 
           	 //En caso contrario (Si era un número) devuelvo el valor 
           	 return true;
     	} 
	}
	


	function busquedaEmpleadosinHorario(){
		var desde=$("#fechaDesde").val();
		var hasta=$("#fechaHasta").val();
		var idarea=$("#idareaRsinhorario").val();
		 if ($("#fReportesinHorario").valid()) {
		$("#dmHorarioBusquedaListado").html(getHTMLLoaging30());
		$("#Grafica").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=empleadossinhorarios&fechahasta="+hasta+"&fechadesde="+desde+"&idareaRsinhorario="+idarea,
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
                $("#dmHorarioBusquedaListado").dialog("close");
	        },
            success: function(data) {		
            	
               	$("#dmHorarioBusquedaListado").html(data);   
               	$("#Grafica").html("<span class='msgWarning1'>Grafico en contrucción</span>"); 
            }
        });
		
		 }else{
			 
		 }
	}

	
	
	function busquedaReporteAsistencia(){
		var desde=$("#RasistenciafechaDesde").val();
		var hasta=$("#RasistenciafechaHasta").val();
		var idarea=$("#idareaRasistencia").val();
		
		 if ($("#fReporteAsistencia").valid()) {
		$("#dmHorarioBusquedaListado").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=empleadosreporteasistencia&desde="+desde+"&hasta="+hasta+"&idareaRasistencia="+idarea,
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {		    
            	
               	$("#dmHorarioBusquedaListado").html(data);  
               	MostrarGrafico();
               //	MostrarGraficoHeat();
            }
        });
		 }else{
			 
		 }
	}
	
	
	function busquedaAsignacion(){
		var desde=$("#RasigfechaDesde").val();
		var hasta=$("#RasigfechaHasta").val();
		var idarea=$("#idareaRAsignacion").val();
		
		$("#Grafica").html(getHTMLLoaging30());
		$("#dmHorarioBusquedaListado").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=empleadosreporteasignacion&desde="+desde+"&hasta="+hasta+"&idareaRAsignacion="+idarea,
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {		                    	                    	
               	$("#dmHorarioBusquedaListado").html(data);    
            	$("#Grafica").html("<span class='msgWarning1'>Grafico en contrucción</span>"); 
            }
        });
		
	}
	

	function MostrarGrafico(){
		
		
		
		$("#Grafica").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=empleadosreportegrafica",
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {	
            	//alert("regresa");
               	$("#Grafica").html(data);     
            }
        });
		
	}
function MostrarGraficoHeat(){
		
		
		
		$("#GraficaHeat").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=empleadosreportegraficaHeat",
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {	
            	//alert("regresa");
               	$("#GraficaHeat").html(data);     
            }
        });
		
	}
	
	
</script>
<div align="left">

<input type="hidden" name="action" value=""/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idhorarioasignado" value="${horarioasignado.idhorarioasignado}"/>

<br/>
<form name="fReportesinHorario" id="fReportesinHorario" action="${ctx}/page/horarios" method="post">
<fieldset><legend class="e6">Reporte de empleados sin horario</legend>

	<table border="0" width="100%" class="caja">
	<col style="width:30%"/>
	<col/>
	
	
	
	<tr>
	<th>Area:</th>
	<th>Fecha  desde:</th>
	<th>Fecha hasta:</th>
	
	<th>Generar</th>
	
	
	</tr>
	<tbody>
	<tr>
	<td>
	<select name="idareaRsinhorario"  id="idareaRsinhorario"   multiple="multiple" size="5">
			
			<c:forEach items="${areas}" var="area" varStatus="loop">
			<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
			</c:forEach>
			</select>
			
	</td>
	<td>
	<input type="text" name="fechaDesde" id="fechaDesde" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
	</td>
	<td>
	<input type="text" name="fechaHasta" id="fechaHasta" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
	</td>
	
	<td align="center"><button type="button" onclick="busquedaEmpleadosinHorario();" id="btnBuscarsinHorario" name="btnBuscarsinHorario">Buscar</button> </td>
	
	</tr>
	
	</tbody>
	
	
	
	
	</table>



</fieldset>
</form>
<br/>
<br/>

<form name="fReporteAsistencia" id="fReporteAsistencia" action="${ctx}/page/horarios" method="post">
<fieldset><legend class="e6">Reporte de Asistencia</legend>
<table border="0" width="100%" class="caja">
<col style="width:30%"/>
<col/>



<tr>
<th>Area:</th>
<th>Fecha desde:</th>
<th>Fecha hasta:</th>
<th>Generar</th>


</tr>
<tbody>
<tr>
<td>
<select name="idareaRasistencia"  id="idareaRasistencia"   multiple="multiple" size="5">
		
		<c:forEach items="${areas}" var="area" varStatus="loop">
		<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
		</c:forEach>
		</select>
		
</td>
<td>
<input type="text" name="RasistenciafechaDesde" id="RasistenciafechaDesde" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>

<td>
<input type="text" name="RasistenciafechaHasta" id="RasistenciafechaHasta" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>

<td align="center"><button type="button" onclick="busquedaReporteAsistencia();" id="btnBuscarAsistencia" name="btnBuscarAsistencia">Buscar</button> </td>

</tr>

</tbody>




</table>



</fieldset>
</form>
<br/>
<br/>
<form name="fReporteAsignacion" id="fReporteAsignacion" action="${ctx}/page/horarios" method="post">
<fieldset><legend class="e6">Reporte de asignacion</legend>
<table border="0" width="100%" class="caja">
<col style="width:30%"/>
<col/>



<tr>
<th>Area:</th>
<th>Fecha desde:</th>
<th>Fecha hasta:</th>
<th>Generar</th>


</tr>
<tbody>
<tr>
<td>
<select name="idareaRAsignacion"  id="idareaRAsignacion"   multiple="multiple" size="5">
		
		<c:forEach items="${areas}" var="area" varStatus="loop">
		<option  value="${area.idarea}"><c:out value="${area.nombrearea}"/></option>
		</c:forEach>
		</select>
		
</td>
<td>
<input type="text" name="RasigfechaDesde" id="RasigfechaDesde" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>

<td>
<input type="text" name="RasigfechaHasta" id="RasigfechaHasta" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>

<td align="center"><button type="button" onclick="busquedaAsignacion();" id="btnBuscarAsignacion" name="btnBuscarAsignacion">Buscar</button> </td>

</tr>

</tbody>




</table>



</fieldset>
</form>

<!-- <div id="dmEditarContrato" title="Editar Contrato"></div>
<div id="dmDetalleEmpleado" title="Detalle Empleado"></div>
<div id="dmNuevaPropiedad" title="Nueva Propiedad"></div>
<div id="dmEditarPropiedad" title="Editar Propiedad"></div> -->
<div id="Grafica" title="Grafica"></div>

<div id="dmHorarioBusquedaListado" title="Reporte"></div>
<div id="GraficaHeat" title="GraficaHeat"></div>
<div id="dmMensajeHorario" title="Mensaje"></div>
<div style="padding: 30px 0px;"></div>
</div>