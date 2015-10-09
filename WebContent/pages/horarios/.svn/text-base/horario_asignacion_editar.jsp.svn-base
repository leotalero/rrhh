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
		
		$("[name=btnEditarHorarioAsignado]").button();	
		$("[name=btnCrearCancelarEditar]").button();

		$("#fEditarHorario").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idhorario: {
					required: true,
					min:1
				},
				validezinicioeditar:{
					required: true,
					
				},
				
				
				
				
			},
			messages: {
				
				idhorario: {
					required: "Seleccione una opción para Horario",
					
					
				},
				validezinicioeditar: {
					required: "Seleccione una fecha de inicio",
					
				}
				
				
			},
			submitHandler: function(form) {	
			
					EditarHorarioAsignado(form);
			
				
			}
		});

	
		
		
		var dates = $("#validezinicioeditar, #validezfineditar")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			//maxDate : '+0D',
			minDate : '-0D',
			//minyear:'-80Y',
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
				var option = this.id == "validezinicioeditar" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates.not(this).datepicker("option", option, date);
			}
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
                	visualizarEditarHorario(data);
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
	
	

</script>
<div align="left">

<div>
</div>

<form name="fEditarHorario" id="fEditarHorario" action="${ctx}/page/horarios" method="post">

<input type="hidden" name="action" value="editar_horario_asignado"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="idhorarioasignado" value="${horarioasignado.idhorarioasignado}"/>

<div><button type="button" id="btnCrearCancelarEditar" name="btnCrearCancelarEditar" onclick="$('#dmEditarHorarioAsignado').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnEditarHorarioAsignado" name="btnEditarHorarioAsignado">Guardar</button>

</div>
<br/>
<fieldset><legend class="e6">Editar Horario</legend>
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
	<script type="text/javascript">$("#fEditarHorario [name=idhorario]").val("${horarioasignado.horario.idhorario}");</script>

</td>
<td>
<input type="text" name="validezinicioeditar" id="validezinicioeditar" value="<fmt:formatDate value="${horarioasignado.validezinicio}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>
<td>
<input type="text" name="validezfineditar" id="validezfineditar" value="<fmt:formatDate value="${horarioasignado.validezfin}" pattern="dd/MM/yyyy" />" style="width: 95%;"/>
</td>
<td><input type="text" name="observaciones" value="${horarioasignado.causahorario}" style="width:95%;"/></td>

</tr>

</tbody>




</table>



</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarEditar" name="btnCrearCancelarEditar" onclick="$('#dmEditarHorarioAsignado').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnEditarHorarioAsignado" name="btnEditarHorarioAsignado">Guardar</button>

</div>
</form>

</div>
<div id="dmHorarioenCalendario" title="Horario"></div>
<div id="dmMensajeHorario" title="Mensaje"></div>
<div style="padding: 30px 0px;"></div>