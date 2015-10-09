<%@ include file="/taglibs.jsp"%>


<script type="text/javascript">

function recargarTabOpcion(index){
	$("#tabsHorariosAsignacion").tabs("load", index );
}


	$(document).ready(function() {

		$("#tabsHorariosAsignacion").tabs({
			cache: true,
			spinner: ' '+getHTMLLoaging14(''),			
			ajaxOptions: {
				cache: false,
				error: function( xhr, status, index, anchor ) {
					$( anchor.hash ).html(
						"No se pudo cargar esta pestaña. Informe a su área de tecnología." );
				}
			}
		});
		
		
		$("#dmHorarioenCalendario").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmMensajeHorario").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("[name=btnAsignarHorario]").button();	
		$("[name=btnDeshabilitarHorario]").button();	

		$("#fAsignarHorario").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idhorario: {
					required: true,
					min:1
				},
				validezinicioAsignacion:{
					required: true
					
				},
				cedulas:{
					required: true,
					
				}
				
				
				
				
			},
			messages: {
				
				idhorario: {
					required: "Seleccione una opción para Horario",
					
					
				},
				validezinicioAsignacion: {
					required: "Seleccione una fecha de inicio",
					
				},
				cedulas:{
					required: "Este campo es requerído",
				}
				
				
			},
			submitHandler: function(form) {	
				
					//alert("asignar:!!");
					AsignarHorarios(form);
				
				
			}
		});


		
		
		var dates = $("#validezinicioAsignacion, #validezfinAsignacion")
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
				var option = this.id == "validezinicioAsignacion" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates.not(this).datepicker("option", option, date);
			}
		});
		
	
		
	});


	
	
	function AsignarHorarios(form) {
		$("[name=btnAsociarHorarioNuevo]").attr('disabled',true);;
		$("[name=btnCrearCancelarContrato]").attr('disabled',true);;
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
            	$("[name=btnAsociarHorarioNuevo]").attr('disabled',false);
        		//$("[name=btnCrearCancelarContrato]").attr('disabled',false);
                $("#dmMensajeHorario").html(jqXHR.statusText);
	        },
            success: function(data) { 
            	
               	$("#dmMensajeHorario").html(data);
               	//<a href="${ctx}/page/horarios?action=asignacion_horario">&nbsp;Horario<span>&nbsp;</span></a>   		 
            	reloadpagina();
            }
        });
	}

	function reloadpagina(){
		//$("#divfechas").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=asignacion_horario",
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {		                    	                    	
               	//$("#divfechas").html(data);     
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
	

	function tipofechas(idtipofecha){
		$("#divfechas").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=tipofecha&idtipofecha="+idtipofecha,
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.statusText);
	        },
            success: function(data) {		                    	                    	
               	$("#divfechas").html(data);     
            }
        });
	}
	
	
	
	
	function deshabilitarhorariosactuales(){
		$("[name=btnAsociarHorarioNuevo]").attr('disabled',true);;
		$("[name=btnCrearCancelarContrato]").attr('disabled',true);;
		$("#dmMensajeHorario").dialog("open");
		$("#dmMensajeHorario").html(getHTMLLoaging16('Creando'));
		var ced=$("#cedulas").val();
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: 'POST',
            url: "${ctx}/page/horarios?action=deshabilitarhorariosactuales&cedulas="+ced,
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnAsociarHorarioNuevo]").attr('disabled',false);
        		//$("[name=btnCrearCancelarContrato]").attr('disabled',false);
                $("#dmMensajeHorario").html(jqXHR.statusText);
	        },
            success: function(data) { 
            	
               	$("#dmMensajeHorario").html(data);
               	//<a href="${ctx}/page/horarios?action=asignacion_horario">&nbsp;Horario<span>&nbsp;</span></a>   		 
            	//reloadpagina();
            }
        });
	}
</script>



<div align="left">

<div id="tabsHorariosAsignacion">
	<ul>		
		<li><a href="#idTabsAsignarHorario">&nbsp;Asignacion<span>&nbsp;</span></a></li>
		<li><a href="${ctx}/page/horarios?action=ver_reportes">&nbsp;Reportes<span>&nbsp;</span></a></li>
		
	</ul>
	<div id="idTabsAsignarHorario">

			<form name="fAsignarHorario" id="fAsignarHorario" action="${ctx}/page/horarios" method="post">
			
			<input type="hidden" name="action" value="asignar_horarios_masivo"/>
			<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
			<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
			<input type="hidden" name="idhorarioasignado" value="${horarioasignado.idhorarioasignado}"/>
			
			<div>
			<button type="submit" id="btnAsignarHorario" name="btnAsignarHorario">Asignar</button>
			<button type="button" onclick="deshabilitarhorariosactuales();" id="btnDeshabilitarHorario" name="btnDeshabilitarHorario">Deshabilitar Actuales</button>
			</div>
			<br/>
			<fieldset><legend class="e6">Asignar Horario</legend>
			<table border="0" width="100%" class="caja">
			<col style="width:30%"/>
			<col/>
			
			
			
			<tr>
			<th>Horario asigando </th>
			<th>Fecha validez inicio</th>
			<th>Fecha validez final</th>
			<th>Observaciones</th>
			
			<th></th>
			</tr>
			<tbody>
			<tr>
			<td valign="middle">
			<select name="idhorario">
				<option value=""></option>
				<c:forEach items="${horarios}" var="horario" varStatus="loop">
				<option value="${horario.idhorario}"><c:out value="${horario.nombrehorario} "/> [ <c:out value="${horario.horaentrada} "/> - <c:out value="${horario.horasalida} "/>] - [frecuencia:<c:out value="${horario.frecuenciaasignacion.nombrefrecuencia} "/>]</option>
				</c:forEach>
				</select>
				<script type="text/javascript">$("#fAsignarHorario [name=idhorario]").val("${horarioasignado.horario.idhorario}");</script>
			
			</td>
			<td>
			<input type="text" name="validezinicioAsignacion" id="validezinicioAsignacion" value="<fmt:formatDate value="${horarioasignado.validezinicio}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
			</td>
			<td>
			<input type="text" name="validezfinAsignacion" id="validezfinAsignacion" value="<fmt:formatDate value="${horarioasignado.validezfin}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
			</td>
			<td><input type="text" name="observaciones" value="${horarioasignado.causahorario}" style="width:95%;"/></td>
			
			</tr>
			<tr>
			<th>Cedulas</th>
			<td colspan="3">
			<input type="text" name="cedulas" id="cedulas" value="" style="width: 95%;"/>
			</td>
			</tr>
			</tbody>
			
			
			
			
			</table>
			
			
			
			</fieldset>
			<br/>
			
			
			<div>
			<button type="submit" id="btnAsignarHorario" name="btnAsignarHorario">Asignar</button>
			<button type="button" onclick="deshabilitarhorariosactuales();" id="btnDeshabilitarHorario" name="btnDeshabilitarHorario">Deshabilitar Actuales</button>
			
			</div>
			</form>

</div>

</div>
<div id="dmHorarioenCalendario" title="Horario"></div>
<div id="dmMensajeHorario" title="Mensaje"></div>
<div style="padding: 30px 0px;"></div>
</div>