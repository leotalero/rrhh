<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		$("[name=btnCrearPropiedadCorrespondencia]").button();	
		$("[name=btnCrearCancelarPropiedadCorrespondencia]").button();

		$("#fEmpleadoPropiedadCorrespondencia").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idtipopropiedadCorrespondencia: {
					required: true,
					digits: true,
					min:1
				},
				datoCorrespondencia:{
					required: true,
					
				},
				
				idprioridadCorrespondencia:{
					required: true,
					min:1
				},
			
				
				
				
				
			},
			messages: {
				
				idtipopropiedadCorrespondencia: {
					required: "Seleccione una opción para tipo de propiedad",
		
				},
				datoCorrespondencia: {
					required: "Este valor es requerido.",
					
				},
				idprioridadCorrespondencia: {
					required: "Este valor es requeridor."
				}
				
			},
			submitHandler: function(form) {				
// 				crearPropiedad(form);
				guardarCambios(form);
			}
		});


	});
		
	/**
	 * Edita y guarda los cambios de los datos de correspondencia.
	 */
	function guardarCambios(form){
		$("[name=btnCrearPropiedadCorrespondencia]").attr('disabled',true);
		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',true);
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
            	$("[name=btnCrearPropiedadCorrespondencia]").attr('disabled',false);
        		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmDesvinculacionEditarPropiedad").dialog("close");
                	$("#dmDesvinculacion").dialog("close");
                	verDesvinculacion(data);
                } else {
                	$("[name=btnCrearPropiedadCorrespondencia]").attr('disabled',false);
            		$("[name=btnCrearCancelarPropiedadCorrespondencia]").attr('disabled',false);
                    $("#dmMensajeEmpleado").html('Error desconocido');					
                }            		 
            }
        });
		
	}
	
	function actualizarPropiedades(idempleado){
		$("#dmPropiedades").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/empleado?action=empleado_propiedades&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmPropiedades").html(data);   
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
	
	
	
</script>

<div align="left">

<div>
</div>

<form name="fEmpleadoPropiedadCorrespondencia" id="fEmpleadoPropiedadCorrespondencia" action="${ctx}/page/desvinculacion" method="post">

<input type="hidden" name="action" value="empleado_editarpropiedadCorrespondencia"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idempleadopropiedad" value="${empleadopropiedad.idempleadopropiedad}"/>
<input type="hidden" name="idContrato" value="${idContrato}"/>

<div>
	<button type="button" id="btnCrearCancelarPropiedadCorrespondencia" name="btnCrearCancelarPropiedadCorrespondencia" onclick="$('#dmDesvinculacionEditarPropiedad').dialog('close');">Cancelar
	</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia">Grabar</button></div>
<br/>
<fieldset>
<legend class="e6">Correspondencia</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>
<th nowrap="nowrap" style="text-align: right;">Tipo. Correspondencia:</th>
<td>
		<select name="idtipopropiedadCorrespondencia">
		<option value=""></option>
		<c:forEach items="${propiedades}" var="propiedad" varStatus="loop">
		<option value="${propiedad.idpropiedad}"><c:out value="${propiedad.nombrepropiedad}"/></option>
		</c:forEach>
		</select>
		
		<script type="text/javascript">$("#fEmpleadoPropiedadCorrespondencia [name=idtipopropiedadCorrespondencia]").val("${empleadopropiedad.idpropiedad}");</script>
	</td>
</tr>
<tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Dato:</th>
<td><input type="text" name="datoCorrespondencia" value="${empleadopropiedad.dato}" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Observación:</th>
<td><input type="text" name="observacionCorrespondencia" value="${empleadopropiedad.observacion}" style="width: 50%;"/></td>
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
		<script type="text/javascript">$("#fEmpleadoPropiedadCorrespondencia [name=idprioridadCorrespondencia]").val("${empleadopropiedad.idprioridad}");</script>
		
	</td>
</tr>



</table>
</fieldset>
<br/>


<div>
     <button type="button" id="btnCrearCancelarPropiedadCorrespondencia" name="btnCrearCancelarPropiedadCorrespondencia" onclick="$('#dmDesvinculacionEditarPropiedad').dialog('close');">Cancelar
     </button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedadCorrespondencia" name="btnCrearPropiedadCorrespondencia">Grabar</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>