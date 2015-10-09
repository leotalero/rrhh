<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnCrearCancelarEducacion]").button();	
	$("[name=btnCrearEducacion]").button();
	
	//Validaciones
	$("#fCrearEducacion").validate({
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

			fechaInicioEducacion:{
				required:true
			},
			fechaFin:{
				required:false
			},
			idestadosignado:{
				required:true,
				min:1
			},
			observacion:{
				required:false,
				maxlength:2000
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
			fechaInicioEducacion:{
				required:"Seleccione una fecha"
			},
			idestadosignado:{
				required: "Seleccione una opción"
			},
			observacion:{
				maxlength: "No puede ingresar mas de 2000 carácteres."
			}
		},
		submitHandler: function(form) {
// 			if($("#fechaFinEducacion").val()!=""){
// 				if($("#fechaInicioEducacion").val() > $("#fechaFinEducacion").val()){
// 					alert('La fecha fin debe ser posterior a la fecha de inicio.');
// 				}else{
					crearEducacion(form);
// 				}
// 			}else{
// 				crearEducacion(form);
// 			}
		}
	}); 
	
	
	var dates = $("#fechaInicioEducacion").datepicker({
		dateFormat : "dd/mm/yy",
// 		maxDate : '0',
		numberOfMonths: 2,
		changeMonth: true,
		changeYear: true,
		yearRange: '1900:2015',
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
					var option = this.id == "fechaInicioEducacion" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	}).val('');
	
	var dates = $("#fechaFinEducacion").datepicker({
		dateFormat : "dd/mm/yy",
		maxDate : '0',
		numberOfMonths: 2,
		changeMonth: true,
		changeYear: true,
		yearRange: '1900:2015',
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
					var option = this.id == "fechaFinEducacion" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	}).val('');
	
});


//Crear Educación.
function crearEducacion(form) {
		$("[name=btnCrearEducacion]").attr('disabled',true);
		$("[name=btnCrearCancelarEducacion]").attr('disabled',true);
		
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
            	$("[name=btnCrearEducacion]").attr('disabled',false);
        		$("[name=btnCrearCancelarEducacion]").attr('disabled',false);
                $("#dmMensajeEducacion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEducacion").dialog("close");
                	$("#dmNuevaEducacion").dialog("close");
                	actualizarEducacion(data);
                } else {
                	$("[name=btnCrearEducacion]").attr('disabled',false);
            		$("[name=btnCrearCancelarEducacion]").attr('disabled',false);
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

//Des/Habilita el campo de fecha fin segun el campo (Incompleto/Culminado)
function habilitar(idEstadoEducacion){
	if(idEstadoEducacion==1){//Culminado.
		fechaFinEducacion.required=true;
		fechaFinEducacion.disabled = false;
	}else{//Incompleto.
 		$("#fechaFinEducacion").val('');
		fechaFinEducacion.disabled = true;
		fechaFinEducacion.required=false;
	}
}



</script>


<div align="left">

<div>
</div>

<form name="fCrearEducacion" id="fCrearEducacion" action="${ctx}/page/educacion" method="post">

<input type="hidden" name="action" value="educacion_insertar"/>
<input type="hidden" name="idempleado" value="${idempleado}"/>
<input type="hidden" name="niveles" value="${niveles}"/>
<input type="hidden" name="estados" value="${estados}"/>

<div>
	<button type="button" id="btnCrearCancelarEducacion" name="btnCrearCancelarEducacion" onclick="$('#dmNuevaEducacion').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnCrearEducacion" name="btnCrearEducacion">Crear</button>
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
		</td>
	</tr>
	
	
	<!-- Institución  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Institución:</th>
		<td>
			<input type="text" name="institucion" value=""  style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Carrera -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Carrera:</th>
		<td>
			<input type="text" name="carrera" value=""  style="width: 50%;"/>
		</td>
	</tr>
	
	
	<!-- Título -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Título:</th>
		<td>
			<input type="text" name="titulo" value=""  style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Listado de estados de educación -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Estado:</th>
		<td>
			<select name="idestadosignado" onchange="habilitar(this.value);">
				<option value=""></option>
				<c:forEach items="${estados}" var="estado" varStatus="loop">
					<option  value="${estado.idEducacionEstado}">
						<c:out value="${estado.nombreEducacionEstado}"/>
					</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	
	
	<!-- Fecha inicio  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Fecha inicio:</th>
		<td>
			<input type="text" name="fechaInicioEducacion" id="fechaInicioEducacion" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;" readonly="readonly"/>
		</td>
	</tr>
	
	
	<!-- Fecha fin  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Fecha fin:</th>
		<td>
			<input type="text" name="fechaFinEducacion" id="fechaFinEducacion" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Observación  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Observación:</th>
		<td>
			<textarea id="observacion" name="observacion" rows="3" cols="50"></textarea>
		</td>
	</tr>
	
	</table>
</fieldset>
<br/>


<div>
<button type="button" id="btnCrearCancelarEducacion" name="btnCrearCancelarEducacion" onclick="$('#dmNuevaEducacion').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearEducacion" name="btnCrearEducacion">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>