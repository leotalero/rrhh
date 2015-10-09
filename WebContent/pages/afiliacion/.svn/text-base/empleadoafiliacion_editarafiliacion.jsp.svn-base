<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnEditarCancelarAfiliacion]").button();	
	$("[name=btnEditarAfiliacion]").button();
	
	//Validaciones
	$("#fEditarAfiliacion").validate({
		errorClass: "invalid",
		rules: {
			idempleado: {
				required: true,
				min:1
			},
			idtipoasignado:{
				required: true,
				min:1
			},
			identidadasignada:{
				required: true,
				min:1
			},
			fechaInicioAfiliacion_editar:{
				required:true
// 				date: true
			},
			fechaFinAfiliacion_editar:{
				required:false
// 				date: true
			},
			observacion:{
				maxlength: 2000
			}
		},
		
		messages: {
			
			idtipoasignado:{
				required: "Seleccione una opción.",	
			},
			identidadasignada: {
				required: "Campo requerido."
			},
			identidadasignada:{
				required: "Campo requerido.",
			},
			fechaInicioAfiliacion_editar:{
				required:"Seleccione una fecha",
// 				date: "No es una fecha valida"
			},
			observacion:{
				maxlength: "No puede ingresar mas de 2000 carácteres."
			}
		},
		submitHandler: function(form) {				
			editarAfiliacion(form);	
		}
	}); 
	
	
	var dates = $("#fechaInicioAfiliacion_editar").datepicker({
		dateFormat : "dd/mm/yy",
// 		maxDate : '0',
// 		minDate : new Date(1900, 1 - 1, 1),
		yearRange: '1900:2015',
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
					var option = this.id == "fechaInicioAfiliacion_editar" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	});	


	var dates = $("#fechaFinAfiliacion_editar").datepicker({
		dateFormat : "dd/mm/yy",
// 		maxDate : '0',
		minDate : new Date(1900, 1 - 1, 1),
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
					var option = this.id == "fechaFinAfiliacion_editar" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	}).val('');
	
	
	
// 	var dates = $("#fechaInicioAfiliacion_editar, #fechaFinAfiliacion_editar").datepicker({
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
// 					var option = this.id == "fechaInicioAfiliacion_editar" ? "minDate" : "maxDate",
// 						instance = $( this ).data( "datepicker" ),
// 						date = $.datepicker.parseDate(
// 							instance.settings.dateFormat ||
// 							$.datepicker._defaults.dateFormat,
// 							selectedDate, instance.settings );
// 					dates.not( this ).datepicker( "option", option, date );
// 		}
// 	});	
	
	
	//Para fecha Inicio
// 	var dates = $("#fechaInicioAfiliacion_editar").datepicker(
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
// 	var dates2 = $("#fechaFinAfiliacion_editar").datepicker(
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


//Editar Afiliación
function editarAfiliacion(form) {
		$("[name=btnEditarAfiliacion]").attr('disabled',true);
		$("[name=btnEditarCancelarAfiliacion]").attr('disabled',true);
		
		$("#dmMensajeAfiliacion").dialog("open");
		$("#dmMensajeAfiliacion").html(getHTMLLoaging16('Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarAfiliacion]").attr('disabled',false);
        		$("[name=btnEditarCancelarAfiliacion]").attr('disabled',false);
                $("#dmMensajeAfiliacion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		//alert('Success');
            		$("#dmMensajeAfiliacion").dialog("close");
                	$("#dmEditarAfiliacion").dialog("close");
                	actualizarAfiliacion(data);
                } else {
                	$("[name=btnEditarAfiliacion]").attr('disabled',false);
            		$("[name=btnEditarCancelarAfiliacion]").attr('disabled',false);
                    $("#dmMensajeAfiliacion").html('Error desconocido');					
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


function entidadeditar(idafiliaciontipo){
			if(idafiliaciontipo!=""){
				$("#divEntidadEditar").html(getHTMLLoaging30());
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'POST',
		            dataType : 'text',
		            url: "${ctx}/page/afiliacion?action=cargar_entidades&idafiliaciontipo="+idafiliaciontipo,
		            error: function(jqXHR, textStatus, errorThrown) {
		                alert(jqXHR.statusText);
			        },
		            success: function(data) {
		            	alert('Success');
		            	alert(data);
		               	$("#divEntidadEditar").html(data);     
		            }
		        });
			}else{
				alert("seleccione un tipo de afiliación.");
			}
}



</script>


<div align="left">

<div>
</div>

<form name="fEditarAfiliacion" id="fEditarAfiliacion" action="${ctx}/page/afiliacion" method="post">

<input type="hidden" name="action" value="empleadoafiliacion_editar"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idempleadoafiliacion" value="${empleadoafiliacion.idempleadoafiliacion}"/>
<input type="hidden" name="tiposAfiliacion" value="${tipos}"/>
<input type="hidden" name="entidades" value="${entidades}"/>

<div>
	<button type="button" id="btnEditarCancelarAfiliacion" name="btnEditarCancelarAfiliacion" onclick="$('#dmEditarAfiliacion').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnEditarAfiliacion" name="btnEditarAfiliacion">Grabar</button>
</div>
<br/>

<fieldset><legend class="e6">Afiliaciones</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>

<!-- Listado de Tipos de afiliación. -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Afiliar a:</th>
	<td>
		<select name="idtipoasignado" onchange="entidadeditar(this.value)">
			<option value=""></option>
			<c:forEach items="${tipos}" var="tipo" varStatus="loop">
				<option  value="${tipo.idafiliaciontipo}">
					<c:out value="${tipo.tipoafiliacion}"/>
				</option>
			</c:forEach>
		</select>
		<!-- Poner el seleccionado. -->
		<script type="text/javascript">
			$("#fEditarAfiliacion [name=idtipoasignado]").val("${empleadoafiliacion.idafiliaciontipo}");
		</script>
	</td>
</tr>

<!-- Listado de entidades de afiliación -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Entidad:</th>
	<td>
		<div id="divEntidadEditar">
			<select name="identidadasignada">
				<option value=""></option>
				<c:forEach items="${entidades}" var="entidad" varStatus="loop">
					<option  value="${entidad.idafiliacionentidad}">
						<c:out value="${entidad.nombreentidad}"/>
					</option>
				</c:forEach>
			</select>
			<!-- Poner el seleccionado. --> 
 			<script type="text/javascript"> 
 				$("#fEditarAfiliacion [name=identidadasignada]").val("${empleadoafiliacion.idafiliacionentidad}");
			</script>
		</div>
	</td>
</tr>


<!-- Fecha inicio  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Fecha inicio:</th>
	<td>
		<input type="text" name="fechaInicioAfiliacion_editar" id="fechaInicioAfiliacion_editar" value="<fmt:formatDate value="${empleadoafiliacion.fechainicio}" pattern="dd/MM/yyyy" />" style="width: 50%;" readonly="readonly"/>
	</td>
</tr>


<!-- Fecha fin  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Fecha fin:</th>
	<td>
		<input type="text" name="fechaFinAfiliacion_editar" id="fechaFinAfiliacion_editar" value="<fmt:formatDate value="${empleadoafiliacion.fechafin}" pattern="dd/MM/yyyy" />" style="width: 50%;"/>
	</td>
</tr>

<!-- Observación  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Observación:</th>
	<td>
		<textarea id="observacion" name="observacion" rows="3" cols="50">${empleadoafiliacion.observacion}</textarea>
	</td>
</tr>

</table>
</fieldset>
<br/>


<div>
<button type="button" id="btnEditarCancelarAfiliacion" name="btnEditarCancelarAfiliacion" onclick="$('#dmEditarAfiliacion').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarAfiliacion" name="btnEditarAfiliacion">Grabar</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>