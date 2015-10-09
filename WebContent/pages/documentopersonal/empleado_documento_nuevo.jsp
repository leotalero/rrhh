<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		$("[name=btnCrearDocumentoPersonal]").button();	
		$("[name=btnCrearCancelarDocumentoPersonal]").button();

		$("#fdocumentoPersonal").validate({
			errorClass: "invalid",
			rules: {
				idtipodocumento: {
					required: true,
					digits: true,
					min:1
				},
				observacion:{
					maxlength: 2000
				},
				archivo: {
					required:true,
					maxlength: 150,
				}
			},
			messages: {
				idtipodocumento: {
					required: "Seleccione una opción para tipo de documento."
				},
				archivo: {
					required: "Se requiere un archivo.",
					maxlength: "El archivo debe tener un nombre menor a 150 carácteres.",
					maxSize:"Maximo tamaño 2m"
				},
				observacion: {
					maxlength: "Ingresar menos de 2000 carácteres."
				}
			},
			submitHandler: function(form) {				
				crearDocumentoPersonal(form);
			}
		});
	});
		

/**
 * Para la carga de archivos al servidor.
 * @param form.
 */
function crearDocumentoPersonal(form) {
	$("[name=btnCrearDocumentoPersonal]").attr('disabled',true);;
	$("[name=btnCrearCancelarDocumentoPersonal]").attr('disabled',true);;
	$("#dmMensajeDocumentoPersonal").dialog("open");
	$("#dmMensajeDocumentoPersonal").html(getHTMLLoaging16(' Creando'));
		
	var date = new Date();
	var mensaje = $("#dmMensajeDocumentoPersonal"); 
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
			    $("#dmMensajeDocumentoPersonal").dialog("close");
	            $("#dmNuevoDocumentoPersonal").dialog("close");
	            
	            actualizarDocumentoPersonal('${empleado.idempleado}');
			    setTimeout('iframeId.parentNode.removeChild(iframeId)', 30);
		    };
		    
		    if (iframeId.addEventListener){
		    	iframeId.addEventListener("load", eventHandler, true);
		    }
		    if (iframeId.attachEvent){
		    	iframeId.attachEvent("onload", eventHandler);
		    }
		    
		 	form.setAttribute("target", iframe_nombre);

		    form.setAttribute("action","${ctx}/page/documento?action=guardar_documento_personal");
		    form.setAttribute("method", "post");
		  	form.enctype = "multipart/form-data";
		  	
		    form.submit();
		    mensaje.html(getHTMLLoaging16("Cargando ... "));
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
		}
		else{
			alert("Solo documentos en pdf");
			document.getElementById(idelement).value="";
			return false;
		}
	}

	/*
	* Método para validar el tamaño y la extension del archivo.
	* Tamaño máximo : 20MB (20971520 bytes)
	* Extensión no permitida: .exe
	*/
	$('#archivo').bind('change', function() {
		var nombreArchivo = $('#archivo').val();
		var extension = nombreArchivo.substring(nombreArchivo.lastIndexOf('.'));
		
		if(this.files[0].size>20971520){
			alert('El tamaño del archivo no debe superar los 20MB.');
			$("#archivo").val('');
		}
		if(extension=='.exe' || extension=='exe' || extension=='.EXE' || extension=='EXE'){
			alert('Archivo no valido.');
			$("#archivo").val('');
		}
	});
	
</script>
<div align="left">

<div>
</div>

<form name="fdocumentoPersonal" id="fdocumentoPersonal" enctype="multipart/form-data" action="${ctx}/page/documento" method="post">
	
	<input type="hidden" name="action" value="guardar_documento_personal"/>
	<input type="hidden" name="idempleado" value="${empleado.idempleado}"/>
	
	<div>
		<button type="button" id="btnCrearCancelarDocumentoPersonal" name="btnCrearCancelarDocumentoPersonal" onclick="$('#dmNuevoDocumentoPersonal').dialog('close');">Cancelar</button>
		&nbsp;&nbsp;&nbsp;
		<button type="submit" id="btnCrearDocumentoPersonal" name="btnCrearDocumentoPersonal">Crear</button>
	</div>
	<br/>
	
	<fieldset>
		<legend class="e6">Documentos De Empleado</legend>
		<table border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Tipo Documento:</th>
				<td>
					<select name="idtipodocumento">
						<option value=""></option>
						<c:forEach items="${tiposdocumento}" var="tipo" varStatus="loop">
							<option value="${tipo.idempleadodocumentotipo}">
								<c:out value="${tipo.nombretipodocumento}"/>
							</option>
						</c:forEach>
					</select>
<!-- 				<script type="text/javascript">
						$("#fArchivoPropiedad [name=idprocesopropiedad]").val("${procesopropiedad.idprocesopropiedad}");
					</script> 
				-->
				</td>
			</tr>
			<tr>
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Documento :
				<div class="texto1">Todo tipo de archivos tam max:20MB</div> 
				</th>
				<td>
					<input type="file" name="archivo" id="archivo" style="max-width: 100%" onchange="javascript:Checkfiles(this.id)">
				</td>
			</tr>
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Observación:</th>
				<td>
					<textarea  name="observacion" cols=70 rows=5 maxlength="2000" spellcheck="true" ></textarea>
				</td>
			</tr>
		
		</table>
	</fieldset>
	<br/>
	
	
	<div>
		<button type="button" id="btnCrearCancelarDocumentoPersonal" name="btnCrearCancelarDocumentoPersonal" onclick="$('#dmNuevoDocumentoPersonal').dialog('close');">Cancelar</button>
		&nbsp;&nbsp;&nbsp;
		<button type="submit" id="btnCrearDocumentoPersonal" name="btnCrearDocumentoPersonal">Crear</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>