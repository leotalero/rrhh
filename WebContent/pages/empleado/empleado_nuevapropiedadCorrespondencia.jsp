<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		$("[name=btnCrearPropiedadCorrespondencia]").button();	
		$("[name=btnCrearCancelarPropiedadCorrespondencia]").button();

		$("#fEmpleadoPropiedadCorrespondencia").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idtipopropiedadcorrespondencia: {
					required: true,
					digits: true,
					min:1
				},
				datocorrespondencia:{
					required: true,
					
				},
				
				idprioridadcorrespondencia:{
					required: true,
					min:1
				},
			},
			messages: {
				
				idtipopropiedadcorrespondencia: {
					required: "Seleccione una opción para tipo de propiedad",
		
				},
				datocorrespondencia: {
					required: "Este valor es requerido.",
					
				},
				idprioridadcorrespondencia: {
					required: "Este valor es requerido."
				}
				
			},
			submitHandler: function(form) {
 				crearPropiedadCorrespondencia(form);
			}
		});

			
		$("#dmMensajeEmpleadoCorrespondencia").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		

	});
	
	
	
	/*
	 * Envia petición al server para crear una propiedad de correspondencia.
	 */
	function crearPropiedadCorrespondencia(form) {
		$("[name=btnCrearPropiedadbtnCrearPropiedadCorrespondencia]").attr('disabled',true);
		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',true);
		$("#dmMensajeEmpleadoCorrespondencia").dialog("open");
		$("#dmMensajeEmpleadoCorrespondencia").html(getHTMLLoaging16(' Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearPropiedadbtnCrearPropiedadCorrespondencia]").attr('disabled',false);
        		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',false);
                $("#dmMensajeEmpleadoCorrespondencia").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleadoCorrespondencia").dialog("close");
                	$("#dmNuevaPropiedadCorrespondencia").dialog("close");
                	$("#dmDesvinculacion").dialog("close");
					reAbrirVentanaDesvinculacion(data);
                } else {
                	$("[name=btnCrearPropiedadbtnCrearPropiedadCorrespondencia]").attr('disabled',false);
            		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',false);
                    $("#dmMensajeEmpleadoCorrespondencia").html('Error desconocido');					
                }            		 
            }
        });
	}

	

	/*
	 * Envia petición al server para crear una propiedad de correspondencia Al editar el proceso de desvinculación.
	 */
	function crearPropiedadCorrespondenciaAlEditar(form) {
		$("[name=btnCrearPropiedadbtnCrearPropiedadCorrespondencia]").attr('disabled',true);
		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',true);
		$("#dmMensajeEmpleadoCorrespondencia").dialog("open");
		$("#dmMensajeEmpleadoCorrespondencia").html(getHTMLLoaging16(' Creando'));
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearPropiedadbtnCrearPropiedadCorrespondencia]").attr('disabled',false);
        		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',false);
                $("#dmMensajeEmpleadoCorrespondencia").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleadoCorrespondencia").dialog("close");
                	$("#dmNuevaPropiedadCorrespondencia").dialog("close");
                	$("#dmDesvinculacionEditar").dialog("close");
					reAbrirVentanaDesvinculacionAlEditar(data);
                } else {
                	$("[name=btnCrearPropiedadbtnCrearPropiedadCorrespondencia]").attr('disabled',false);
            		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',false);
                    $("#dmMensajeEmpleadoCorrespondencia").html('Error desconocido');					
                }            		 
            }
        });
	}
	
	
	function validarEntero(valor){ 
    	valor = parseInt(valor);
     	if (isNaN(valor)) {  
           	 return false;
     	}else{
           	 return true;
     	} 
	}
	
	
	/**
	 * Recarga el formulario de desvinculación con la nueva propiedad creada.
	 */
	function reAbrirVentanaDesvinculacion(idContrato){
// 		alert('Se va a reabrir la ventana de desvinculación. idcontrato = '+idContrato);
		$("#dmNuevaPropiedadCorrespondencia").dialog("close");
		$("#dmDesvinculacion").dialog("close");
		$("#dmDesvinculacion").dialog("open");
		$("#dmDesvinculacion").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/desvinculacion?action=ver_desvinculacion&idcontrato="+idContrato,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {	                    	                    	
	           	$("#dmDesvinculacion").html(data);     
	        }
	    });
	}
	
	/**
	 * Recarga el formulario de desvinculación al editar con la nueva propiedad creada.
	 */
	function reAbrirVentanaDesvinculacionAlEditar(idContrato){
// 		alert('Se va a reabrir la ventana de desvinculación. idcontrato = '+idContrato);
		$("#dmNuevaPropiedadCorrespondencia").dialog("close");
		$("#dmGuardarDesvinculacion").dialog("close");
		$("#dmDesvinculacion").dialog("close");
		$("#dmDesvinculacion").dialog("open");
		$("#dmDesvinculacion").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/desvinculacion?action=ver_desvinculacion&idcontrato="+idContrato,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {	                    	                    	
	           	$("#dmDesvinculacion").html(data);     
	        }
	    });
	}
	
	
</script>
<div align="left">
<div>
</div>

<form name="fEmpleadoPropiedadCorrespondencia" id="fEmpleadoPropiedadCorrespondencia" action="${ctx}/page/empleado${accion}" method="post">

<!-- <input type="hidden" name="action" value="empleadoCrearPropiedadCorrespondencia"/> -->
<input type="hidden" id="accionRealizar" name="accionRealizar" value="${accionRealizar}"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<%-- <input type="hidden" name="idContrato" value="${idContrato}"/> --%>
<div><button type="button" id="btnCrearCancelarPropiedadCorrespondencia" name="btnCrearCancelarPropiedadCorrespondencia" onclick="$('#dmNuevaPropiedadCorrespondencia').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia">Crear</button></div>
<br/>
<fieldset><legend class="e6">Correspondencia</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>
<th nowrap="nowrap" style="text-align: right;">Tipo. Correspondencia:</th>
<td>
		<select name="idtipopropiedadCorrespondencia">
			<option value=""></option>
			<c:forEach items="${propiedades}" var="propiedad" varStatus="loop">
				<option value="${propiedad.idpropiedad}">
					<c:out value="${propiedad.nombrepropiedad}"/>
				</option>
			</c:forEach>
		</select>
		
<!-- 	<script type="text/javascript">$("#fEmpleadoPropiedad [name=idtipopropiedad]").val("${propiedad.idpropiedad}");</script> -->
	</td>
</tr>
<tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Dato:</th>
<td><input type="text" name="datoCorrespondencia" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Observación:</th>
<td><input type="text" name="observacionCorrespondencia" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Prioridad:</th>
	<td>
		<select name="idprioridadCorrespondencia">
			<option value=""></option>
			<c:forEach items="${prioridades}" var="prioridad" varStatus="loop">
				<option value="${prioridad.idprioridad}"><c:out value="${prioridad.nombreprioridad}"/></option>
			</c:forEach>
		</select>
	</td>
</tr>



</table>
</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarPropiedadCorrespondencia" name="btnCrearCancelarPropiedadCorrespondencia" onclick="$('#dmNuevaPropiedadCorrespondencia').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>