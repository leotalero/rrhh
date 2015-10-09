<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	
	$(document).ready(function() {
		$("[name=btnCrearPropiedad]").button();	
		$("[name=btnCrearCancelarPropiedad]").button();

		$("#fActivoPropiedad").validate({
			//errorLabelContainer: "#msnBuscarCargue",
			errorClass: "invalid",
			rules: {
				idprocesopropiedad: {
					required: true,
					digits: true,
					min:1
				},
				dato:{
					required: true,
					maxlength: 150
				},
				
				observacion:{
					
					maxlength: 2500
				}
				
				
				
				
				
			},
			messages: {
				
				idprocesopropiedad: {
					required: "Seleccione una opción para tipo de propiedad",
		
				},
				dato: {
					required: "Este valor es requerido.",
					maxlength: "Ingresar menos de 150 caracteres"
				},
				observacion: {
					
					maxlength: "Ingresar menos de 2500 caracteres"
				},
				
			},
			submitHandler: function(form) {				
				crearPropiedad(form);
			}
		});


	});
		
	
	
	
	function crearPropiedad(form) {
		//alert("va");
		$("[name=btnCrearPropiedad]").attr('disabled',true);;
		$("[name=btnCrearCancelarPropiedad]").attr('disabled',true);;
		$("#dmMensajeDesvinculacion").dialog("open");
		$("#dmMensajeDesvinculacion").html(getHTMLLoaging16(' Creando'));
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
                $("#dmMensajeDesvinculacion").html(jqXHR.statusText);
	        },
            success: function(data) {    
            	if(validarEntero(data)){
            		$("#dmMensajeDesvinculacion").dialog("close");
                	$("#dmNuevaPropiedad").dialog("close");
                	actualizarPropiedadesProcesos('${contratoproceso.proceso.nombreproceso}',data,'${contratoproceso.proceso.idproceso}');
                } else {
                	$("[name=btnCrearPropiedad]").attr('disabled',false);
            		$("[name=btnCrearCancelarPropiedad]").attr('disabled',false);
                    $("#dmMensajeDesvinculacion").html('Error desconocido');					
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

<form name="fActivoPropiedad" id="fActivoPropiedad" action="${ctx}/page/desvinculacion" method="post">

<input type="hidden" name="action" value="activos_guardar_propiedad"/>
<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
<input type="hidden" name="idcontrato" value="${contrato.idcontrato}"/>
<input type="hidden" name="nombreproceso" value="${contratoproceso.proceso.nombreproceso}"/>
<input type="hidden" name="idproceso" value="${contratoproceso.proceso.idproceso}"/>
<div><button type="button" id="btnCrearCancelarPropiedad" name="btnCrearCancelarPropiedad" onclick="$('#dmNuevaPropiedad').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedad" name="btnCrearPropiedad">Crear</button></div>
<br/>

<fieldset><legend class="e6">${contratoproceso.proceso.nombreproceso}</legend>


<table border="0" width="100%" class="caja">

<col style="width: 15%"/>
<col/>
<tr>
<th nowrap="nowrap" style="text-align: right;">${contratoproceso.proceso.nombreproceso}:</th>
<td>
		<select name="idprocesopropiedad">
		<option value=""></option>
		<c:forEach items="${procesopropiedades}" var="propiedad" varStatus="loop">
		<option value="${propiedad.idprocesopropiedad}"><c:out value="${propiedad.nombrepropiedad}"/></option>
		</c:forEach>
		</select>
		
		<script type="text/javascript">$("#fActivoPropiedad [name=idprocesopropiedad]").val("${procesopropiedad.idprocesopropiedad}");</script>
	</td>
</tr>
<tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Detalle</th>
<td><input type="text" name="dato" value="" style="width: 50%;"/></td>
</tr>
<tr>
<th nowrap="nowrap" style="text-align: right;">Observacion:</th>

<td><textarea  name="observacion" cols=70 rows=5 maxlength="3950" spellcheck="true" ></textarea></td>
</tr>





</table>
</fieldset>
<br/>


<div><button type="button" id="btnCrearCancelarPropiedad" name="btnCrearCancelarPropiedad" onclick="$('#dmNuevaPropiedad').dialog('close');">Cancelar</button>&nbsp;&nbsp;&nbsp;<button type="submit" id="btnCrearPropiedad" name="btnCrearPropiedad">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>