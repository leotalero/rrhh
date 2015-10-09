<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	jQuery.validator.addMethod("loginregex", function(value, element) {
	    return this.optional(element) || /^[a-zA-Z0-9\_]+$/.test(value);
	});
	
	$(document).ready(function() {
		$('#numidentificacionrepetido').bind("cut copy paste",function(e) {
	          e.preventDefault();
	      });

	    $('body').restive({
	    breakpoints: ['240', '320', '480', '640-p', '640-l', '960'],
	    classes: ['css-240', 'css-320', 'css-480', 'css-640-p', 'css-640-l', 'css-960']
	    });

		    
		$("[name=btnCrearEmpleado]").button();	
		$("[name=btnCrearCancelarEmpleado]").button();

		$("#fCrearUsuario").validate({
			
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				ididentificaciontipo: {
					required: true,
					digits: true,
					min:1
				},
				numidentificacion:{
					required: true,
					digits: true
				},
				numidentificacionrepetido: {
					required: true,
					 equalTo: "#numidentificacion"
					 },
					 
				ciudadexpedicion:{
					required: true
					
				},
				idgenero:{
					required: true
					
				},
				fechanacimiento:{
					required: true
					
				},
				nombres:{
					required: true
				},
				apellidos:{
					required: true
				},
				
				idempresa:{
					required: true,
					min:1
				},
				idsucursal:{
					required: true,
					min:1
				}
				
				
				
				
			},
			messages: {
				
				ididentificaciontipo: {
					required: "Seleccione una opción para tipo de identificación",
					
					digits: "Seleccione una opción para tipo de identificación",
					
				},
				numidentificacion: {
					required: "Ingrese un valor.",
					digits: "Ingrese solo dígitos"
				},
				numidentificacionrepetido: {
					required: "Ingrese un valor igual al número de identificación.",
					equalTo: "Ingrese un valor igual al número de identificación.",
					digits: "Ingrese solo dígitos"
				},
				nombre: {
					required: "Ingrese un valor."
				},
				usuario: {
					required: "Ingrese un valor.",
					loginregex: "Caracteres inválidos, ingrese solo alfanummerico y/o _"
				},
				clave: {
					required: "Ingrese un valor."
				},
				claver: {
					required: "Ingrese un valor."
				},
				claver: {
					required: "Ingrese un valor."
				},
				idsucursal: {
					required: "Seleccione una sucursal."
				},
				iddirectivacontrasena: {
					required: "Seleccione una directiva de contrseña."
				},
				clavecambio: {
					required: "Seleccione una opción para Usuario debe cambiar clave."
				},
				usuarioaltitude: {
					digits: "Ingrese solo dígitos"
				},				
				extensionaltitude: {
					digits: "Ingrese solo dígitos"
				},				
				extensionxlite: {
					digits: "Ingrese solo dígitos"
				}
			},
			submitHandler: function(form) {				
				crearEmpleado(form);
			}
		});

		$("#tipobusquedausuario").change( function() {
			var data =  $(this).val();
			$(".classtipobusquedausuario").hide();
			if(data==1){
				$("#tipobusquedausuario_creacion").show();
			}else if(data==2){
				$("#tipobusquedausuario_nombre").show();
			}else if(data==3){
				$("#tipobusquedausuario_numidentificacion").show();
			}else if(data==4){
				$("#tipobusquedausuario_usuario").show();
			}else if(data==5){
				$("#tipobusquedausuario_codusuario").show();
			}else if(data==6){
				$("#tipobusquedausuario_idaplicacion").show();
			}else if(data==7){
				$("#tipobusquedausuario_idgrupo").show();
			}
			 
		});

		
		var dates = $("#fechanacimiento, #txtTo")
		.datepicker(
		{
			dateFormat : "dd/mm/yy",
			maxDate : '+0D',
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
				var option = this.id == "fechanacimiento" ? "minDate"
						: "maxDate", instance = $(this)
						.data("datepicker"), date = $.datepicker
						.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings); 
				dates.not(this).datepicker("option", option, date);
			}
		});
		
	});

	
	
	
	function crearEmpleado(form) {
		$("[name=btnCrearEmpleado]").attr('disabled',true);
		$("[name=btnCrearCancelarEmpleado]").attr('disabled',true);;
		$("#dmMensajeEmpleado").dialog("open");
		$("#dmMensajeEmpleado").html(getHTMLLoaging16(' Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearEmpleado]").attr('disabled',false);
        		$("[name=btnCrearCancelarEmpleado]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmNuevoEmpleado").dialog("close");
            		visualizarDetalleEmpleado(data);
                } else {
                	$("[name=btnCrearEmpleado]").attr('disabled',false);
            		$("[name=btnCrearCancelarEmpleado]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
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
	
	
	
</script>

<body>
<div  align="left">

<div>
</div>

<form name="fCrearUsuario" id="fCrearUsuario" action="${ctx}/page/empleado" method="post">

<input type="hidden" name="action" value="empleado_insertar"/>
	<div>
		<button type="button" id="btnCrearCancelarEmpleado" name="btnCrearCancelarEmpleado" onclick="$('#dmNuevoEmpleado').dialog('close');">Cancelar
		</button
		>&nbsp;&nbsp;&nbsp;
		<button type="submit" id="btnCrearEmpleado" name="btnCrearEmpleado">Crear
		</button>
	</div>
<br/>
<fieldset><legend class="e6">Usuario</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>
<th nowrap="nowrap" style="text-align: right;">Tipo de identificación:</th>
	<td>
		<select name="ididentificaciontipo">
		<option value=""></option>
		<c:forEach items="${tiposidentifiaccion}" var="identificaciontipo" varStatus="loop">
		<option value="${identificaciontipo.ididentificaciontipo}"><c:out value="${identificaciontipo.abreviatura}"/> - <c:out value="${identificaciontipo.tipo}"/></option>
		</c:forEach>
		</select>
	</td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Num. Identificación:</th>
<td><input type="text" name="numidentificacion"  id="numidentificacion" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Repetir Num. Identificación:</th>
<td><input type="text" name="numidentificacionrepetido" id="numidentificacionrepetido" value="" style="width: 50%;"/></td>
</tr>
<tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Ciudad de expedición:</th>
<td><input type="text" name="ciudadexpedicion" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Genero:</th>
	<td>
		<select name="idgenero">
		<option value=""></option>
		<c:forEach items="${generos}" var="genero" varStatus="loop">
		<option value="${genero.idgenero}"><c:out value="${genero.nombregenero}"/></option>
		</c:forEach>
		</select>
	</td>
</tr>


<tr>
<th nowrap="nowrap" style="text-align: right;">Fecha de nacimiento:</th>
<td><input type="text" name="fechanacimiento" id="fechanacimiento" value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />" style="width: 50%;"/></td>
</tr>

<tr>
<th nowrap="nowrap" style="text-align: right;">Nombres:</th>
<td><input type="text" name="nombres" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Apellidos:</th>
<td><input type="text" name="apellidos" value="" style="width: 50%;"/></td>
</tr>
<tr>


</table>
</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarEmpleado" name="btnCrearCancelarEmpleado" onclick="$('#dmNuevoEmpleado').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearEmpleado" name="btnCrearEmpleado">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>
</body>