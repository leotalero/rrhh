<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		$("[name=btnCrearFormatoFalta]").button();	
		$("[name=btnCrearCancelarFormatoFalta]").button();

		$("#fFormatoFalta").validate({
			errorClass: "invalid",
			rules: {
				nombreFormato:{
					required:true,
					maxlength: 2000
				},
				formato: {
					required:true,
					maxlength: 150,
				}
			},
			messages: {
				nombreFormato:{
					required:"Se requiere un nombre para el formato.",
					maxlength: "El nombre del formato no debe superar los 2000 caráteres."
				},
				formato: {
					required:"Se requiere un archivo como formato.",
				}
			},
			submitHandler: function(form) {				
				crearFormatoFalta(form);
			}
		});
	});
		

/**
 * Para la carga de archivos al servidor.
 * @param form.
 */
function crearFormatoFalta(form) {
	$("[name=btnCrearFormatoFalta]").attr('disabled',true);
	$("[name=btnCrearCancelarDocumentoPersonal]").attr('disabled',true);
// 	$("#dmMensajeFormatoFalta").dialog("open");
// 	$("#dmMensajeFormatoFalta").html(getHTMLLoaging16(' Creando'));
		
	var date = new Date();
// 	var mensaje = $("#dmMensajeFormatoFalta"); 
	var iframe_nombre = "upload_iframe_"+date.getTime();
	var iframe_id = iframe_nombre;

	var iframe = document.createElement("iframe");
	iframe.setAttribute("id", iframe_nombre);
	iframe.setAttribute("name", iframe_nombre);
	iframe.setAttribute("width", "0");
	iframe.setAttribute("height", "0");
	iframe.setAttribute("border", "0");
	iframe.setAttribute("style", "width: 0; height: 0; border: none;");
		   
	// Add to document...
	form.parentNode.appendChild(iframe);
	window.frames[iframe_nombre].name = iframe_nombre;
	iframeId = document.getElementById(iframe_id);

	// Add event...
	var eventHandler = null;
	eventHandler = function () {
// 		alert('Entro a eventhandler');
 			    if (iframeId.detachEvent){ 
					iframeId.detachEvent("onload", eventHandler);
				}else {
					iframeId.removeEventListener("load", eventHandler, false);		            	
			    }
			    // Message from server...
			    if (iframeId.contentDocument) {
			    	content = iframeId.contentDocument.body.innerHTML;
			    } else if (iframeId.contentWindow) {
			        content = iframeId.contentWindow.document.body.innerHTML;
			    } else if (iframeId.document) {
			        content = iframeId.document.body.innerHTML;
			    }
			    // Del the iframe...
			    //refresca todo el div de cargues por base
	            $("#dmNuevoFormatoFalta").dialog("close");
 				actualizarVentanaAdministracion();
			    setTimeout('iframeId.parentNode.removeChild(iframeId)', 30);
		    };
		    
		    if (iframeId.addEventListener){
		    	iframeId.addEventListener("load", eventHandler, true);
		    }
		    if (iframeId.attachEvent){
		    	iframeId.attachEvent("onload", eventHandler);
		    }
		    
		 	form.setAttribute("target", iframe_nombre);

		    form.setAttribute("action","${ctx}/page/administracion?action=registrarNuevoFormato");
		    form.setAttribute("method", "post");
		  	form.enctype = "multipart/form-data";
		    form.submit();
		   
}

	
/**
 * Validar si un dato es de tipo entero.
 */
function validarEntero(valor){ 
    valor = parseInt(valor);
    if (isNaN(valor)) {
       return false;
    }else{
       return true;
    } 
}
	

	
	function Checkfiles(idelement){
	  
	    var fileName = document.getElementById(idelement).value;
	    var ext = fileName.substring(fileName.lastIndexOf('.') + 1);
	
		if(ext !="exe" || ext!="EXE"){
			return true;
		}else{
			alert("Archivo no válido.");
			document.getElementById(idelement).value="";
			return false;
		}
	}

	/*
	* Método para validar el tamaño y la extension del archivo.
	* Tamaño máximo : 20MB (20971520 bytes)
	* Extensión no permitida: .exe
	*/
	$('#formato').bind('change', function() {
		var nombreArchivo = $('#formato').val();
		var extension = nombreArchivo.substring(nombreArchivo.lastIndexOf('.'));
		
		if(this.files[0].size>20971520){
			alert('El tamaño del formato no debe superar los 20MB.');
			$("#formato").val('');
		}
		if(extension=='.exe' || extension=='exe' || extension=='.EXE' || extension=='EXE'){
			alert('Archivo no válido.');
			$("#formato").val('');
		}
	});
	
</script>
<div align="left">

<div>
</div>

<form name="fFormatoFalta" id="fFormatoFalta" enctype="multipart/form-data" action="${ctx}/page/documento" method="post">
	
	<input type="hidden" name="action" value="guardarNuevoFormato"/>
	
	<div>
		<button type="button" id="btnCrearCancelarFormatoFalta" name="btnCrearCancelarFormatoFalta" onclick="$('#dmNuevoFormatoFalta').dialog('close');">Cancelar</button>
		&nbsp;&nbsp;&nbsp;
		<button type="submit" id="btnCrearFormatoFalta" name="btnCrearFormatoFalta">Crear</button>
	</div>
	<br/>
	
	<fieldset>
		<legend class="e6">Nuevo Formato</legend>
		<table border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			<tr>
			<!-- Nombre del formato -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Nombre de Formato:</th>
				<td>
					<input type="text"  id="nombreFormato" name="nombreFormato" maxlength="2000" spellcheck="true"  size="50"/>
				</td>
			</tr>
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Archivo :
					<div class="texto1">Todo tipo de archivos tam max:20MB</div> 
				</th>
				<td>
					<input type="file" name="formato" id="formato" style="max-width: 100%" onchange="javascript:Checkfiles(this.id)" size="50">
				</td>
			</tr>
			
		
		</table>
	</fieldset>
	<br/>
	
	
	<div>
		<button type="button" id="btnCrearCancelarFormatoFalta" name="btnCrearCancelarFormatoFalta" onclick="$('#dmNuevoFormatoFalta').dialog('close');">Cancelar</button>
		&nbsp;&nbsp;&nbsp;
		<button type="submit" id="btnCrearFormatoFalta" name="btnCrearFormatoFalta">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>