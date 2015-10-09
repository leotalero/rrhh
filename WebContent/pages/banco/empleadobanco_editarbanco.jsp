<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnEditarCancelarBanco]").button();	
	$("[name=btnEditarBanco]").button();
	
	//Validaciones
	$("#fEditarBanco").validate({
		errorClass: "invalid",
		rules: {
			idempleado: {
				required: true,
				min:1
			},
			idbancoasignado:{
				required: true,
				min:1
			},
			numerocuenta:{
				required: true,
				digits: true,
				maxlength: 25
			},
			fechaVigencia:{
				required: true
			}
		},
		
		messages: {
			
			idempresa: {
				required: "Seleccione una opción para Banco.",
		
			},
			numerocuenta: {
				required: "Campo requerido.",
				digits:"Ingrese solo números",
				maxlength: "El número de cuenta no debe sobrepasar los 25 caráteres."
			},
			fechaVigencia:{
				required: "Campo requerido.",
			},
		},
		submitHandler: function(form) {				
			crearBanco(form);
		}
	}); 
	
	
	//Para fecha
	var dates = $("#fechaVigencia")
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
			var option = this.id == "fechaVigencia" ? "minDate": "maxDate", instance = $(this)
				.data("datepicker"), date = $.datepicker
				.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
			dates.not(this).datepicker("option", option, date);
		}
	});
	
});


//Crear Banco
function crearBanco(form) {
		$("[name=btnEditarBanco]").attr('disabled',true);;
		$("[name=btnEditarCancelarBanco]").attr('disabled',true);;
		
		$("#dmMensajeBanco").dialog("open");
		$("#dmMensajeBanco").html(getHTMLLoaging16('Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEditarBanco]").attr('disabled',false);
        		$("[name=btnEditararCancelarBanco]").attr('disabled',false);
                $("#dmMensajeBanco").html(jqXHR.statusText);
	        },
            success: function(data) {
            	if(validarEntero(data)){
            		$("#dmMensajeBanco").dialog("close");
                	$("#dmEditarBanco").dialog("close");
                	actualizarBanco(data);
                } else {
                	$("[name=btnEditarBanco]").attr('disabled',false);
            		$("[name=btnEditarCancelarBanco]").attr('disabled',false);
                    $("#dmMensajeBanco").html('Error desconocido');					
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

<form name="fEditarBanco" id="fEditarBanco" action="${ctx}/page/banco" method="post">

<input type="hidden" name="action" value="empleadobanco_editar"/>
<input type="hidden" name="idempleado" value="${empleadobanco.idempleado}"/>
<input type="hidden" name="idempleadobanco" value="${empleadobanco.idempleadobanco}"/>
<input type="hidden" name="bancos" value="${bancos}"/>

<div>
	<button type="button" id="btnEditarCancelarBanco" name="btnEditarCancelarBanco" onclick="$('#dmEditarBanco').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnEditarBanco" name="btnEditarBanco">Grabar</button>
</div>
<br/>

<fieldset><legend class="e6">Editar Banco</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>

<!-- Listado de bancos. -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Banco:</th>
	<td>
		<select name="idbancoasignado">
			<option value=""></option>
			<c:forEach items="${bancos}" var="banco" varStatus="loop">
				<option  value="${banco.idbanco}">
					<c:out value="${banco.nombrebanco}"/>
				</option>
			</c:forEach>
		</select>
		<!-- Poner el seleccionado. -->
		<script type="text/javascript">
			$("#fEditarBanco [name=idbancoasignado]").val("${empleadobanco.idbanco}");
		</script>
	</td>
</tr>

<!-- Campo Número de cuenta bancaria.  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Número de cuenta:</th>
	<td>
		<input type="text" name="numerocuenta" value="${empleadobanco.numerocuenta}"  style="width: 50%;"/>
	</td>
</tr>

<!-- Campo vigencia del número de cuenta.  -->
<tr>
	<th nowrap="nowrap" style="text-align: right;">Vigente desde:</th>
	<td>
		<input type="text" name="fechaVigencia" id="fechaVigencia" value="<fmt:formatDate value="${empleadobanco.vigentedesde}" pattern="dd/MM/yyyy" />" style="width: 50%;" readonly="readonly"/>
	</td>
</tr>

</table>
</fieldset>
<br/>


<div>
<button type="button" id="btnEditarCancelarBanco" name="btnEditarCancelarBanco" onclick="$('#dmEditarBanco').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnEditarBanco" name="btnEditarBanco">Grabar</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>