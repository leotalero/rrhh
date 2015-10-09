<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnCrearCancelarFamilia]").button();	
	$("[name=btnCrearFamilia]").button();
	
	//Validaciones
	$("#fCrearFamilia").validate({
		errorClass: "invalid",
		rules: {
			idparentescoasignado: {
				required: true,
				min:1
			},
			idgeneroasignado:{
				required: true,
				min:1
			},
			idtipodocumentoasignado:{
				required: true,
				min:1
			},
			numerodocumento:{
				required: true,
				digits:true,
				maxlength:12
			},
			nombre:{
				required:true,
				maxlength: 60
			},
			apellido:{
				required:true,
				maxlength: 60
			},
			fechaNacimiento:{
				required: true
			},
			observacion:{
				required: false,
				maxlength:2000
			}
			
		},
		
		messages: {
			
			idparentescoasignado:{
				required: "Seleccione una opción.",	
			},
			idgeneroasignado:{
				required: "Seleccione una opción."
			},
			idtipodocumentoasignado:{
				required: "Seleccione una opción."
			},
			numerodocumento:{
				required: "Campo requerido.",
				  digits: "Ingrese solo números.",
				  maxlength: "No puede ingresar mas de 12 caráteres."
			},
			nombre:{
				required: "Ingrese un nombre.",
				maxlength: "El nombre es demasiado largo."
			},
			apellido:{
				required: "Ingrese un apellido.",
				maxlength: "El apellido es demasiado largo."
			},
			fechaNacimiento:{
				required: "Seleccione una fecha."
			},
			observacion:{
				maxlength: "No puede ingresar mas de 2000 caráteres."
			}
		},
		submitHandler: function(form) {				
			crearFamiliar(form);
		}
	}); 
	
	
	var dates = $("#fechaNacimiento").datepicker({
		dateFormat : "dd/mm/yy",
// 		maxDate : '0',
// 		minDate : new Date(1900, 1 - 1, 1),
		yearRange: '1900:2015',
		numberOfMonths: 1,
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
					var option = this.id == "fechaNacimiento" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
							instance.settings.dateFormat ||
							$.datepicker._defaults.dateFormat,
							selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
		}
	}).val('');	
	
	//Para fecha Inicio
// 	var dates = $("#fechaNacimiento").datepicker(
// 	{
// 		dateFormat : "dd/mm/yy",
//  		maxDate : '0',
// // 		minDate : '-0D',
// //		minyear:'-80Y',
// 		yearRange: '1900:2015',
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
// 			var option = this.id == "fechaNacimiento" ? "minDate": "maxDate", instance = $(this)
// 				.data("datepicker"), date = $.datepicker
// 				.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
// 			dates.not(this).datepicker("option", option, date);
// 		}
// 	}).val('');
	
	
	
});


//Crear Familiar.
function crearFamiliar(form) {
		$("[name=btnCrearFamilia]").attr('disabled',true);
		$("[name=btnCrearCancelarFamilia]").attr('disabled',true);
		
		$("#dmMensajeFamilia").dialog("open");
		$("#dmMensajeFamilia").html(getHTMLLoaging16('Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearFamilia]").attr('disabled',false);
        		$("[name=btnCrearCancelarFamilia]").attr('disabled',false);
                $("#dmMensajeFamilia").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeFamilia").dialog("close");
                	$("#dmNuevoFamiliar").dialog("close");
                	actualizarFamilia(data);
                } else {
                	$("[name=btnCrearFamilia]").attr('disabled',false);
            		$("[name=btnCrearCancelarFamilia]").attr('disabled',false);
                    $("#dmMensajeFamilia").html('Error desconocido');					
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

<form name="fCrearFamilia" id="fCrearFamilia" action="${ctx}/page/familia" method="post">

<input type="hidden" name="action" value="familia_insertar"/>
<input type="hidden" name="idempleado" value="${idempleado}"/>
<input type="hidden" name="parentescos" value="${parentescos}"/>
<input type="hidden" name="generos" value="${generos}"/>
<input type="hidden" name="tiposIdentificacion" value="${tiposIdentificacion}"/>

<div>
	<button type="button" id="btnCrearCancelarFamilia" name="btnCrearCancelarFamilia" onclick="$('#dmNuevoFamiliar').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnCrearFamilia" name="btnCrearFamilia">Crear</button>
</div>
<br/>

<fieldset><legend class="e6">Familiar</legend>
	<table border="0" width="100%" class="caja">
	<col style="width: 15%"/>
	<col/>
	<tr>
	
	<!-- Listado de parentescos. -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Parentesco:</th>
		<td>
			<select name="idparentescoasignado">
				<option value=""></option>
				<c:forEach items="${parentescos}" var="parentesco" varStatus="loop">
					<option  value="${parentesco.idparentesco}">
						<c:out value="${parentesco.nombreparentesco}"/>
					</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	
	<!-- Listado de generos. -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Género:</th>
		<td>
			<select name="idgeneroasignado">
				<option value=""></option>
				<c:forEach items="${generos}" var="genero" varStatus="loop">
					<option  value="${genero.idgenero}">
						<c:out value="${genero.nombregenero}"/>
					</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	
	<!-- Listado de tipos de identificación. -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Tipo Documento:</th>
		<td>
			<select name="idtipodocumentoasignado">
				<option value=""></option>
				<c:forEach items="${tiposIdentificacion}" var="tipoIdentificacion" varStatus="loop">
					<option  value="${tipoIdentificacion.ididentificaciontipo}">
						<c:out value="${tipoIdentificacion.tipo}"/>
					</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	
	<!-- Número Identificación  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Número documento:</th>
		<td>
			<input type="text" name="numerodocumento" value=""  style="width: 50%;"/>
		</td>
	</tr>
	
	<!-- Nombre -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Nombre:</th>
		<td>
			<input type="text" name="nombre" value=""  style="width: 50%;"/>
		</td>
	</tr>
	
	
	<!-- Apellido -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Apellido:</th>
		<td>
			<input type="text" name="apellido" value=""  style="width: 50%;"/>
		</td>
	</tr>
	
	
	<!-- Fecha de Nacimiento  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Fecha Nacimiento:</th>
		<td>
			<input type="text" name="fechaNacimiento" id="fechaNacimiento" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;" readonly="readonly"/>
		</td>
	</tr>
	
	<!-- Observación  -->
	<tr>
		<th nowrap="nowrap" style="text-align: right;">Observación:</th>
		<td>
			<textarea id="observacion" name="observacion" rows="3" cols="48"></textarea>
		</td>
	</tr>
	
	</table>
</fieldset>
<br/>


<div>
<button type="button" id="btnCrearCancelarFamilia" name="btnCrearCancelarFamilia" onclick="$('#dmNuevoFamiliar').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearFamilia" name="btnCrearFamilia">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>