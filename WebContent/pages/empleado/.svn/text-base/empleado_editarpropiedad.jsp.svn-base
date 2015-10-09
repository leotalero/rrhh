<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		$("[name=btnCrearPropiedad]").button();	
		$("[name=btnCrearCancelarPropiedad]").button();

		$("#fEmpleadoPropiedad").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idtipopropiedad: {
					required: true,
					digits: true,
					min:1
				},
				dato:{
					required: true,
					
				},
				
				idprioridad:{
					required: true,
					min:1
				},
			
				
				
				
				
			},
			messages: {
				
				idtipopropiedad: {
					required: "Seleccione una opción para tipo de propiedad",
		
				},
				dato: {
					required: "Este valor es requerido.",
					
				},
				idprioridad: {
					required: "Este valor es requeridor."
				}
				
			},
			submitHandler: function(form) {				
				crearPropiedad(form);
			}
		});


	});
		
	
	
	
	function crearPropiedad(form) {
		$("[name=btnCrearPropiedad]").attr('disabled',true);;
		$("[name=btnCrearCancelarPropiedad]").attr('disabled',true);;
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
            	$("[name=btnCrearPropiedad]").attr('disabled',false);
        		$("[name=btnCrearCancelarPropiedad]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmEditarPropiedad").dialog("close");
                	actualizarPropiedades(data);
                } else {
                	$("[name=btnCrearPropiedad]").attr('disabled',false);
            		$("[name=btnCrearCancelarPropiedad]").attr('disabled',false);
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

<div align="left">

<div>
</div>

<form name="fEmpleadoPropiedad" id="fEmpleadoPropiedad" action="${ctx}/page/empleado" method="post">

<input type="hidden" name="action" value="empleado_editarpropiedad"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idempleadopropiedad" value="${empleadopropiedad.idempleadopropiedad}"/>

<div><button type="button" id="btnCrearCancelarPropiedad" name="btnCrearCancelarPropiedad" onclick="$('#dmEditarPropiedad').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedad" name="btnCrearPropiedad">Grabar</button></div>
<br/>
<fieldset><legend class="e6">Usuario</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>
<tr>
<th nowrap="nowrap" style="text-align: right;">Tipo. propiedad:</th>
<td>
		<select name="idtipopropiedad">
		<option value=""></option>
		<c:forEach items="${propiedades}" var="propiedad" varStatus="loop">
		<option value="${propiedad.idpropiedad}"><c:out value="${propiedad.nombrepropiedad}"/></option>
		</c:forEach>
		</select>
		
		<script type="text/javascript">$("#fEmpleadoPropiedad [name=idtipopropiedad]").val("${empleadopropiedad.idpropiedad}");</script>
	</td>
</tr>
<tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Dato:</th>
<td><input type="text" name="dato" value="${empleadopropiedad.dato}" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Observacion:</th>
<td><input type="text" name="observacion" value="${empleadopropiedad.observacion}" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Prioridad:</th>
	<td>
		<select name="idprioridad">
		<option value=""></option>
		<c:forEach items="${prioridades}" var="prioridad" varStatus="loop">
		<option value="${prioridad.idprioridad}"><c:out value="${prioridad.nombreprioridad}"/></option>
		</c:forEach>
		</select>
		<script type="text/javascript">$("#fEmpleadoPropiedad [name=idprioridad]").val("${empleadopropiedad.idprioridad}");</script>
		
	</td>
</tr>



</table>
</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarPropiedad" name="btnCrearCancelarPropiedad" onclick="$('#dmEditarPropiedad').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedad" name="btnCrearPropiedad">Grabar</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>