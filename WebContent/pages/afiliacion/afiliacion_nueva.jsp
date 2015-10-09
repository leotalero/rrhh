<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnCrearCancelarAfiliacion]").button();	
	$("[name=btnCrearAfiliacion]").button();
	
	//Validaciones
	$("#fCrearAfiliacion").validate({
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
			fechaInicioAfiliacion:{
				required:true//,
				//date: true
			},
			fechaFinAfiliacion:{
				required:false//,
				//date: true
// 				greaterThan: "#fechaInicioAfiliacion"
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
			fechaInicio:{
				required:"Seleccione una fecha",
				//date: "No es una fecha valida"
			},
			observacion:{
				maxlength: "No puede ingresar mas de 2000 carácteres."
			}
		},
		submitHandler: function(form) {				
// 			if($("#fechaFinAfiliacion").val()!=""){
// 				if($("#fechaInicioAfiliacion").val() > $("#fechaFinAfiliacion").val()){
// 					alert('La fecha fin debe ser posterior a la fecha de inicio.');
// 				}else{
					//crearAfiliacion(form);
// 					alert('Se va crear afiliacion.');
// 				}
// 			}else{
				crearAfiliacion(form);
// 			}
		}
	}); 
	
	var dates = $("#fechaInicioAfiliacion").datepicker({
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
					var option = this.id == "fechaInicioAfiliacion" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	}).val('');	


	var dates = $("#fechaFinAfiliacion").datepicker({
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
					var option = this.id == "fechaFinAfiliacion" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	}).val('');
	
	
});


//Crear Afiliación
function crearAfiliacion(form) {
		
		$("[name=btnCrearAfiliacion]").attr('disabled',true);
		$("[name=btnCrearCancelarAfiliacion]").attr('disabled',true);
		
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
            	$("[name=btnCrearAfiliacion]").attr('disabled',false);
        		$("[name=btnCrearCancelarAfiliacion]").attr('disabled',false);
                $("#dmMensajeAfiliacion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeAfiliacion").dialog("close");
                	$("#dmNuevaAfiliacion").dialog("close");
                	actualizarAfiliacion(data);
                } else {
                	$("[name=btnCrearAfiliacion]").attr('disabled',false);
            		$("[name=btnCrearCancelarAfiliacion]").attr('disabled',false);
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

</script>


<div align="left">

<div>
</div>

<form name="fCrearAfiliacion" id="fCrearAfiliacion" action="${ctx}/page/afiliacion" method="post">

<input type="hidden" name="action" value="afiliacion_insertar"/>
<input type="hidden" name="idempleado" value="${idempleado}"/>
<input type="hidden" name="tiposAfiliacion" value="${tiposAfiliacion}"/>
<input type="hidden" name="entidades" value="${entidades}"/>

<div>
	<button type="button" id="btnCrearCancelarAfiliacion" name="btnCrearCancelarAfiliacion" onclick="$('#dmNuevaAfiliacion').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnCrearAfiliacion" name="btnCrearAfiliacion">Crear</button>
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
		<select name="idtipoasignado" onchange="entidad(this.value)">
			<option value=""></option>
			<c:forEach items="${tiposAfiliacion}" var="tipo" varStatus="loop">
				<option  value="${tipo.idafiliaciontipo}">
					<c:out value="${tipo.tipoafiliacion}"/>
				</option>
			</c:forEach>
		</select>
	</td>
</tr>

<!-- Listado de entidades de afiliación -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Entidad:</th>
	<td>
		<div id="divEntidad">
			<select name="identidadasignada">
				<option value=""></option>
				
			</select>
		</div>
	</td>
</tr>


<!-- Fecha inicio  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Fecha inicio:</th>
	<td>
		<input type="text" name="fechaInicioAfiliacion" id="fechaInicioAfiliacion" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;" readonly="readonly"/>
	</td>
</tr>


<!-- Fecha fin  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Fecha fin:</th>
	<td>
		<input type="text" name="fechaFinAfiliacion" id="fechaFinAfiliacion" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/>
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
<button type="button" id="btnCrearCancelarAfiliacion" name="btnCrearCancelarAfiliacion" onclick="$('#dmNuevaAfiliacion').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearAfiliacion" name="btnCrearAfiliacion">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>