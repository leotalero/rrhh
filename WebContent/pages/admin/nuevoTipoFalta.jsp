<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnCrearCancelarTipoFalta]").button();	
	$("[name=btnCrearTipoFaltaNuevo]").button();
	
	//Validaciones
	$("#fCrearTipoFalta").validate({
		errorClass: "invalid",
		rules: {
			nuevoTipoDeFalta: {
				required: true,
				maxlength:2000,
			},
		},
		
		messages: {
			
			nuevoTipoDeFalta: {
				required: "Ingrese el tipo de falta.",
				maxlength:"No puede ingresar mas de 2000 carácteres.",
			},
			
		},
		submitHandler: function(form) {				
			crearTipoDeFalta(form);
		}
	}); 
	
	
	
	
});



//crear un Tipo De Falta nuevo.
function crearTipoDeFalta(form) {
		$("#dmNuevoTipoFalta").dialog("close");
		$("#dmNuevoTipoFalta").dialog("open");
		$("#dmMensajeFalta").dialog("close");
		
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnCrearTipoFaltaNuevo]").attr('disabled',false);
        		$("[name=btnCrearCancelarTipoFalta]").attr('disabled',false);
                $("#dmMensajeFalta").html(jqXHR.statusText);
	        },
            success: function(data) {
            	if(validarEntero(data)){
            		alert('Se ha creado un nuevo tipo de falta.');
                	$("#dmMensajeFalta").dialog("close");
                	$("#dmNuevoTipoFalta").dialog("close");
                	$("[name=btnCrearTipoFaltaNuevo]").attr('disabled',false);
                	reAbrirVentanaNuevaFalta();	
            	}
            }
        });
	}

/**
 * Recarga el formulario con el nuevo tipo de falta.
 */
function reAbrirVentanaNuevaFalta(){
	$("#dmNuevaFalta").dialog("close");
	$("#dmNuevaFalta").dialog("open");
	$("#dmNuevaFalta").html(getHTMLLoaging30());
	$.ajax({
		cache: false,
		contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
        type: 'POST',	            
        url: "${ctx}/page/administracion?action=nuevaFalta",
        dataType: "text",
        error: function(jqXHR, textStatus, errorThrown) {
            alert(jqXHR.statusText);
        },
        success: function(data) {		                    	                    	
           	$("#dmNuevaFalta").html(data);     
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

<form name="fCrearTipoFalta" id="fCrearTipoFalta" action="${ctx}/page/administracion" method="post">

<input type="hidden" name="action" value="insertarTipoDeFalta"/>

<!-- <div> -->
<!-- 	<button type="button" id="btnCrearCancelarTipoFalta" name="btnCrearCancelarTipoFalta" onclick="$('#dmNuevoTipoFalta').dialog('close');">Cancelar</button> -->
<!-- 	&nbsp;&nbsp;&nbsp; -->
<!-- 	<button type="submit" id="btnCrearTipoFalta" name="btnCrearTipoFalta">Crear</button> -->
<!-- </div> -->
<br/>

<fieldset>
	<legend class="e6">Tipo de Falta</legend>
		<table border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			<tr>
			
			<!-- Campo para nuevo tipo de falta -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Nuevo Tipo de Falta:</th>
				<td>
					<input type="text" id="nuevoTipoDeFalta" name="nuevoTipoDeFalta" value=""  style="width: 99%;"/>
				</td>
			</tr>
		
		</table>
</fieldset>
<br/>


<div>
<!-- <button type="button" id="btnCrearCancelarTipoFalta" name="btnCrearCancelarTipoFalta" onclick="$('#dmNuevoTipoFalta').dialog('close');">Cancelar</button> -->
<!-- &nbsp;&nbsp;&nbsp; -->
<button type="submit" id="btnCrearTipoFaltaNuevo" name="btnCrearTipoFaltaNuevo">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>