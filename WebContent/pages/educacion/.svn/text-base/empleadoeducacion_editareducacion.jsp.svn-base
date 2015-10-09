<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnEditarCancelarEducacion]").button();	
	$("[name=btnEditarEducacion]").button();
	
	
	//Validaciones
	$("#fEditarEducacion").validate({
		errorClass: "invalid",
		rules: {
			idnivelasignado: {
				required: true,
				min:1
			},
			institucion:{
				required: true,
				maxlength: 60
			},
			carrera:{
				required: true,
				maxlength: 60
			},
			titulo:{
				required: true,
				maxlength: 60
			},

			fechaInicioEducacion_editar:{
				required:true
			},
			fechaFinEducacion_editar:{
				required:false
			},
			idestadosignado:{
				required:true,
				min:1
			},
			observacion:{
				required:false,
				maxlength: 2000
			}
			
		},
		
		messages: {
			
			idnivelasignado:{
				required: "Seleccione una opción.",	
			},
			institucion: {
				required: "Campo requerido.",
				maxlength: "El nombre de la institución es muy largo."
			},
			carrera:{
				required: "Campo requerido.",
				maxlength: "El nombre de la carrera el muy largo."
			},
			titulo:{
				required: "Campo requerido.",
				maxlength: "El título es demasiado largo."
			},
			fechaInicioEducacion_editar:{
				required:"Seleccione una fecha"
			},
			idestadosignado:{
				required: "Seleccione una opción"
			},
			observacion:{
				maxlength:"No puede ingresar mas de 2000 carácteres."
			}
		},
		submitHandler: function(form) {	
 			editarEducacion(form);
		}
	}); 
	
	
	var dates = $("#fechaInicioEducacion_editar").datepicker({
		dateFormat : "dd/mm/yy",
// 		maxDate : '0',
		numberOfMonths: 2,
		changeMonth: true,
		changeYear: true,
		dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi',
				'Ju', 'Vi', 'Sa' ],
		monthNames : [ 'Enero', 'Febrero', 'Marzo',
				'Abril', 'Mayo', 'Junio', 'Julio',
				'Agosto', 'Septiembre', 'Octubre',
				'Noviembre', 'Diciembre' ],
		monthNamesShort : [ 'Ene', 'Feb', 'Mar',
				'Abr', 'May', 'Jun', 'Jul', 'Ago',
				'Sep', 'Oct', 'Nov', 'Dic' ],
		onSelect: function( selectedDate ) {
					var option = this.id == "fechaInicioEducacion_editar" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	});
	
	var dates = $("#fechaFinEducacion_editar").datepicker({
		dateFormat : "dd/mm/yy",
		maxDate : '0',
		numberOfMonths: 2,
		changeMonth: true,
		changeYear: true,
		dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi',
				'Ju', 'Vi', 'Sa' ],
		monthNames : [ 'Enero', 'Febrero', 'Marzo',
				'Abril', 'Mayo', 'Junio', 'Julio',
				'Agosto', 'Septiembre', 'Octubre',
				'Noviembre', 'Diciembre' ],
		monthNamesShort : [ 'Ene', 'Feb', 'Mar',
				'Abr', 'May', 'Jun', 'Jul', 'Ago',
				'Sep', 'Oct', 'Nov', 'Dic' ],
		onSelect: function( selectedDate ) {
					var option = this.id == "fechaFinEducacion_editar" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	});
	
	
// 	var dates = $("#fechaInicioEducacion_editar, #fechaFinEducacion_editar").datepicker({
// 		dateFormat : "dd/mm/yy",
// 		maxDate : '0',
// 		numberOfMonths: 1,
// 		dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi',
// 				'Ju', 'Vi', 'Sa' ],
// 		monthNames : [ 'Enero', 'Febrero', 'Marzo',
// 				'Abril', 'Mayo', 'Junio', 'Julio',
// 				'Agosto', 'Septiembre', 'Octubre',
// 				'Noviembre', 'Diciembre' ],
// 		monthNamesShort : [ 'Ene', 'Feb', 'Mar',
// 				'Abr', 'May', 'Jun', 'Jul', 'Ago',
// 				'Sep', 'Oct', 'Nov', 'Dic' ],
// 		onSelect: function( selectedDate ) {
// 					var option = this.id == "fechaInicioEducacion_editar" ? "minDate" : "maxDate",
// 						instance = $( this ).data( "datepicker" ),
// 						date = $.datepicker.parseDate(
// 							instance.settings.dateFormat ||
// 							$.datepicker._defaults.dateFormat,
// 							selectedDate, instance.settings );
// 					dates.not( this ).datepicker( "option", option, date );
// 		}
// 	});
	
	
	//Para fecha Inicio
// 	var dates = $("#fechaInicioEducacion_editar").datepicker(
// 	{
// 		dateFormat : "dd/mm/yy",
// // 		maxDate : '+0D',
// // 		minDate : '-0D',
// 		minyear:'-80Y',
// 		numberOfMonths : 1,
// 		 changeMonth: true,
// 		 changeYear: true,
// 		//showAnim: 'fold',
// 		dayNamesMin : [ 'Do', 'Lu', 'Ma',
// 				'Mi', 'Ju', 'Vi', 'Sa' ],
// 		monthNames : [ 'Enero', 'Febrero',
// 				'Marzo', 'Abril', 'Mayo',
// 				'Junio', 'Julio', 'Agosto',
// 				'Septiembre', 'Octubre',
// 				'Noviembre', 'Diciembre' ],
// 		monthNamesShort : [ 'Ene', 'Feb',
// 				'Mar', 'Abr', 'May', 'Jun',
// 				'Jul', 'Ago', 'Sep', 'Oct',
// 				'Nov', 'Dic' ],
// 		onSelect : function(selectedDate) {
// 			var option = this.id == "fechaInicio" ? "minDate": "maxDate", instance = $(this)
// 				.data("datepicker"), date = $.datepicker
// 				.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
// 			dates.not(this).datepicker("option", option, date);
// 		}
// 	});
	
	//Para fecha Fin
// 	var dates2 = $("#fechaFinEducacion_editar").datepicker(
// 	{
// 		dateFormat : "dd/mm/yy",
// 		//maxDate : '+0D',
// 		//minDate : '-0D',
// 		minyear:'-80Y',
// 		numberOfMonths : 1,
// 		 changeMonth: true,
// 		 changeYear: true,
// 		//showAnim: 'fold',
// 		dayNamesMin : [ 'Do', 'Lu', 'Ma',
// 				'Mi', 'Ju', 'Vi', 'Sa' ],
// 		monthNames : [ 'Enero', 'Febrero',
// 				'Marzo', 'Abril', 'Mayo',
// 				'Junio', 'Julio', 'Agosto',
// 				'Septiembre', 'Octubre',
// 				'Noviembre', 'Diciembre' ],
// 		monthNamesShort : [ 'Ene', 'Feb',
// 				'Mar', 'Abr', 'May', 'Jun',
// 				'Jul', 'Ago', 'Sep', 'Oct',
// 				'Nov', 'Dic' ],
// 		onSelect : function(selectedDate) {
// 			var option = this.id == "fechaFin" ? "minDate": "maxDate", instance = $(this)
// 				.data("datepicker"), date = $.datepicker
// 				.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
// 			dates2.not(this).datepicker("option", option, date);
// 		}
// 	});
	
});


//Crear Educación.
function editarEducacion(form) {
	    
		$("[name=btnEditarEducacion]").attr('disabled',true);
		$("[name=btnEditarCancelarEducacion]").attr('disabled',true);
		
		$("#dmMensajeEducacion").dialog("open");
		$("#dmMensajeEducacion").html(getHTMLLoaging16('Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarEducacion]").attr('disabled',false);
        		$("[name=btnEditarCancelarEducacion]").attr('disabled',false);
                $("#dmMensajeEducacion").html(jqXHR.statusText);
	        },
            success: function(data) {
            	if(validarEntero(data)){
            		$("#dmMensajeEducacion").dialog("close");
                	$("#dmEditarEducacion").dialog("close");
                	actualizarEducacion(data);
                } else {
                	$("[name=btnEditarEducacion]").attr('disabled',false);
            		$("[name=btnEditarCancelarEducacion]").attr('disabled',false);
                    $("#dmMensajeEducacion").html('Error desconocido');					
                }            		 
            }
        });
	}

//Validar número entero.
function validarEntero(valor){ 
    	valor = parseInt(valor);
     	if (isNaN(valor)) { 
           	 return false;
     	}else{ 
           	 return true;
     	} 
}

//Habilita el campo de fecha fin
function habilitar(idEstadoEducacion){
	if(idEstadoEducacion==1){
		fechaFinEducacion_editar.required=true;
		fechaFinEducacion_editar.disabled = false;
	}else{
 		$("#fechaFinEducacion_editar").val('');
 		fechaFinEducacion_editar.disabled = true;
 		fechaFinEducacion_editar.required=false;
	}
}

</script>


<div align="left">

<div>
</div>

<form name="fEditarEducacion" id="fEditarEducacion" action="${ctx}/page/educacion" method="post">

<input type="hidden" name="action" value="educacion_editar"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="empleadoeducacion" value="${empleadoeducacion}"/>
<input type="hidden" name="idempleadoeducacion" value="${empleadoeducacion.idEmpleadoEducacion}"/>
<input type="hidden" name="niveles" value="${niveles}"/>
<input type="hidden" name="estados" value="${estados}"/>

<div>
	<button type="button" id="btnEditarCancelarEducacion" name="btnEditarCancelarEducacion" onclick="$('#dmEditarEducacion').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnEditarEducacion" name="btnEditarEducacion">Grabar</button>
</div>
<br/>

<fieldset><legend class="e6">Educación</legend>
	<table border="0" width="100%" class="caja">
	<col style="width: 15%"/>
	<col/>
	<tr>
	
	<!-- Listado de niveles de educación. -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Nivel:</th>
		<td>
			<select name="idnivelasignado">
				<option value=""></option>
				<c:forEach items="${niveles}" var="nivel" varStatus="loop">
					<option  value="${nivel.idEducacionNivel}">
						<c:out value="${nivel.nombreEducacionNivel}"/>
					</option>
				</c:forEach>
			</select>
			<!-- Poner el seleccionado. -->
			<script type="text/javascript">
				$("#fEditarEducacion [name=idnivelasignado]").val("${empleadoeducacion.idEducacionNivel}");
			</script>
		</td>
	</tr>
	
	
	<!-- Institución  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Institución:</th>
		<td>
			<input type="text" name="institucion" value="${empleadoeducacion.institucion}"  style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Carrera -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Carrera:</th>
		<td>
			<input type="text" name="carrera" value="${empleadoeducacion.carrera}"  style="width: 50%;"/>
		</td>
	</tr>
	
	
	<!-- Título -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Título:</th>
		<td>
			<input type="text" name="titulo" value="${empleadoeducacion.titulo}"  style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Listado de estados de educación -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Estado:</th>
		<td>
			<select name="idestadosignado" onchange="habilitar(this.value)">
				<option value=""></option>
				<c:forEach items="${estados}" var="estado" varStatus="loop">
					<option  value="${estado.idEducacionEstado}">
						<c:out value="${estado.nombreEducacionEstado}"/>
					</option>
				</c:forEach>
			</select>
			<!-- Poner el seleccionado. -->
			<script type="text/javascript">
				$("#fEditarEducacion [name=idestadosignado]").val("${empleadoeducacion.idEducacionEstado}");
			</script>
		</td>
	</tr>
	
	
	<!-- Fecha inicio  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Fecha inicio:</th>
		<td>
			<input type="text" name="fechaInicioEducacion_editar" id="fechaInicioEducacion_editar" value="<fmt:formatDate value="${empleadoeducacion.fechaInicio}" pattern="dd/MM/yyyy" />" style="width: 50%;" readonly="readonly"/>
		</td>
	</tr>
	
	
	<!-- Fecha fin  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Fecha fin:</th>
		
		<td>
			<input type="text" name="fechaFinEducacion_editar" id="fechaFinEducacion_editar" value="<fmt:formatDate value="${empleadoeducacion.fechafin}" pattern="dd/MM/yyyy" />" style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Observación  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Observación:</th>
		<td>
			<textarea id="observacion" name="observacion" rows="3" cols="50">${empleadoeducacion.observacion}</textarea>
		</td>
	</tr>
	
	</table>
</fieldset>
<br/>


<div>
<button type="button" id="btnEditarCancelarEducacion" name="btnEditarCancelarEducacion" onclick="$('#dmEditarEducacion').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarEducacion" name="btnEditarEducacion">Grabar</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>