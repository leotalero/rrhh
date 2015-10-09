<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	
	$(document).ready(function() {
		$("[name=btnEnviarCorreoElectronico]").button();	
		$("[name=btnCrearCancelarCorreo]").button();

		$("#fEnviarCorreo").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				
				para:{
					required: true,
					
				}
			
				
				
				
				
			},
			messages: {
				
				
				para: {
					required: "Este valor es requerido.",
					
				}
				
			},
			submitHandler: function(form) {				
				EnviarCorreoform(form);
			}
		});


	});
		
	
	
	
	function EnviarCorreoform(form) {
		$("[name=btnEnviarCorreoElectronico]").attr('disabled',true);;
		$("[name=btnCrearCancelarCorreo]").attr('disabled',true);;
		$("#dmMensajeEmpleado").dialog("open");
		$("#dmMensajeEmpleado").html(getHTMLLoaging16('Creando'));
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
            type: $(form).attr('method'),            
            url: $(form).attr('action'),
            data: $(form).serialize(),
            dataType: "text",
            error: function(jqXHR, textStatus, errorThrown) {
            	$("[name=btnEnviarCorreoElectronico]").attr('disabled',false);
        		$("[name=btnCrearCancelarCorreo]").attr('disabled',false);
                $("#dmMensajeEmpleado").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeEmpleado").dialog("close");
                	$("#dmAbreEditarEnviarCorreo").dialog("close");
                	//actualizarPropiedades(data);
                } else {
                	$("[name=btnEnviarCorreoElectronico]").attr('disabled',false);
            		$("[name=btnCrearCancelarCorreo]").attr('disabled',false);
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
<div align="left">

<div>
</div>

<form name="fEnviarCorreo" id="fEnviarCorreo" action="${ctx}/page/desvinculacion" method="post">

<input type="hidden" name="action" value="enviar_correo"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<div><button type="button" id="btnCrearCancelarCorreo" name="btnCrearCancelarCorreo" onclick="$('#dmAbreEditarEnviarCorreo').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnEnviarCorreoElectronico" name="btnEnviarCorreoElectronico">Enviar</button></div>
<br/>
<fieldset><legend class="e6">Para:</legend>
<table border="0" width="100%" class="caja">
<col style="width: 15%"/>
<col/>


<tr>
<th nowrap="nowrap" style="text-align: right;">Para:
<div class="texto1">multiples correos separados <br/>
por punto y coma(;)</div> </th>
<td><textarea   name="para" cols=60 rows=4 maxlength="3950" spellcheck="true" ></textarea></td>

							
</tr>

</table>
</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarCorreo" name="btnCrearCancelarCorreo" onclick="$('#dmAbreEditarEnviarCorreo').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnEnviarCorreoElectronico" name="btnEnviarCorreoElectronico">Enviar</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>