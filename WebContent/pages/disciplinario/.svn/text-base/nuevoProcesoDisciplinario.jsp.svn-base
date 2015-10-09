<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnCrearCancelarProceso]").button();	
	$("[name=btnCrearProceso]").button();
	$("[name=btnCrearTestigo]").button();
	
	//Validaciones
	$("#fCrearProcesoDisciplinario").validate({
		errorClass: "invalid",
		rules: {
			idTipoFaltaAsignada: {
				required: true,
				min:1
			},
			idFaltaAsignada: {
				required: true,
				min:1
			},
			observacionUno:{
				required: true,
				maxlength: 2000
			}
		},
		
		messages: {
			
			idTipoFaltaAsignada:{
				required: "Seleccione una opción para el tipo de falta.",	
			},
			idFaltaAsignada: {
				required: "Seleccione una opción para la falta."
			},
			observacionUno:{
				required: "Se requiere una observación al crear este proceso.",
				maxlength: "No puede ingresar mas de 2000 caráteres.",
			}
		},
		submitHandler: function(form) {
// 			idSancion
// 			var idSancion = $('#idSancion').val();
// 			if(idSancion=='' || isSancion==null){
// 				crearProcesoDisciplinario(form);
// 			}else{
// 				alert('1111111111111111111111');
// 				crearProcesoDisciplinario(form);	
// 			}
			crearProcesoDisciplinario(form);
		}
	}); 
	
});

/**
 * Para la carga de archivos al servidor.
 * @param form.
 */
function crearProcesoDisciplinario(form) {
	$("[name=btnCrearProceso]").attr('disabled',true);
	$("[name=btnCrearCancelarProceso]").attr('disabled',true);
	$("#dmMensajeProcesoDisciplinario").dialog("open");
	$("#dmMensajeProcesoDisciplinario").html(getHTMLLoaging16(' Creando'));
	
	
	var date = new Date();
	var mensaje = $("#dmMensajeProcesoDisciplinario"); 
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
				// alert('Entro a eventhandler'); 
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
			    $("#dmMensajeProcesoDisciplinario").dialog("close");
	            $("#dmNuevoProcesoDisciplinario").dialog("close");
	            
	            //actualizarDocumentoPersonal('${empleado.idempleado}');
				//${idcontrato}
				
				actualizarProcesosDisciplinarios('${idcontrato}');
	            
			    setTimeout('iframeId.parentNode.removeChild(iframeId)', 30);
		    };
		    
		    if (iframeId.addEventListener){
		    	iframeId.addEventListener("load", eventHandler, true);
		    }
		    if (iframeId.attachEvent){
		    	iframeId.attachEvent("onload", eventHandler);
		    }
		    
		 	form.setAttribute("target", iframe_nombre);

		    form.setAttribute("action","${ctx}/page/disciplinario?action=insertarProcesoDisciplinario");
		    form.setAttribute("method", "post");
		  	form.enctype = "multipart/form-data";
		  	
		    form.submit();
		    mensaje.html(getHTMLLoaging16("Cargando..."));
		   
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


/*
* Método para validar el tamaño y la extension del archivo.
* Tamaño máximo : 20MB (20971520 bytes)
* Extensión no permitida: .exe
*/
function validarArchivo(id) {
// 	alert("ID = "+id);
	var nombreArchivo = $('#'+id+'').val();
// 	alert("NombreArchivo = "+nombreArchivo);
	var extension = nombreArchivo.substring(nombreArchivo.lastIndexOf('.'));
// 	alert("extension = "+extension );
	var input = document.getElementById(id);
	var file = input.files[0];
	var tamanio = file.size;
	
	
	if(tamanio>20971520){
		alert('El tamaño del archivo no debe superar los 20MB.');
		$('#'+id).val('');
	}else if(extension=='.exe' || extension=='exe' || extension=='.EXE' || extension=='EXE'){
		alert('Archivo no válido.');
		$('#'+id).val('');
	}else if(nombreArchivo!=''){
		if(id=='archivoUno'){
// 			alert('Entro al tipo uno');
			idtipoarchivoUno.required=true;
		}
		if(id=='archivoDos'){
			idtipoarchivoDos.required=true;
		}
		if(id=='archivoTres'){
			idtipoarchivoTres.required=true;
		}
		if(id=='archivoCuatro'){
			idtipoarchivoCuatro.required=true;
		}
		if(id=='archivoCinco'){
			idtipoarchivoCinco.required=true;
		}
		if(id=='archivoSeis'){
			idtipoarchivoSeis.required=true;
		}
	}else{
		if(id=='archivoUno'){
			idtipoarchivoUno.required=false;
		}
		if(id=='archivoDos'){
			idtipoarchivoDos.required=false;
		}
		if(id=='archivoTres'){
			idtipoarchivoTres.required=false;
		}
		if(id=='archivoCuatro'){
			idtipoarchivoCuatro.required=false;
		}
		if(id=='archivoCinco'){
			idtipoarchivoCinco.required=false;
		}
		if(id=='archivoSeis'){
			idtipoarchivoSeis.required=false;
		}
	}
	
};

</script>


<div align="left">

<div>
</div>

<form name="fCrearProcesoDisciplinario" id="fCrearProcesoDisciplinario" enctype="multipart/form-data" action="${ctx}/page/disciplinario" method="post">

<input type="hidden" name="action" value="insertarProcesoDisciplinario"/>
<input type="hidden" name="datoDePrueba" value="Dato de prueba en JSP"/>
<input type="hidden" name="idcontrato" value="${idcontrato}"/>
<input type="hidden" name="tiposFalta" value="${listaTiposFalta}"/>
<input type="hidden" name="faltas" value="${listaFaltas}"/>
<input type="hidden" name="recurrenciaNumero" value="${recurrenciaNumero}"/>
<input type="hidden" name="creador" value="${sessionScope[consHermes.USUARIO_SESSION].nombre} (${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.grupo.nombre})"/>

<div>
	<button type="button" id="btnCrearCancelarProceso" name="btnCrearCancelarProceso" onclick="$('#dmNuevoProcesoDisciplinario').dialog('close');">Cancelar</button>
	&nbsp;&nbsp;&nbsp;
	<button type="submit" id="btnCrearProceso" name="btnCrearProceso">Registrar Proceso</button>
</div>
<br/>
<!-- Para datos del proceso -->
<fieldset>
	<legend class="e6">Nuevo Proceso Disciplinario</legend>
	
	<!-- Tabla del formulario -->
	<table border="0" width="100%" class="caja">
	<col style="width: 15%"/>
	<col/>
		<tr>
		
		<!-- Listado de Tipos de Faltas. -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Tipo de Falta:</th>
			<td>
<!-- 			Pendiente desarrollar el onchange -->
				<select name="idTipoFaltaAsignada" onchange="falta(this.value,${idcontrato})" style="width: 99%;">
					<option value=""></option>
					<c:forEach items="${listaTiposFalta}" var="tipoFalta" varStatus="loop">
						<option  value="${tipoFalta.idfaltatipo}">
							<c:out value="${tipoFalta.nombrefaltatipo}"/>
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<!--Listado de faltas. -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Falta :</th>
			<td>
				<div id="divFalta">
					<select name="idFaltaAsignada">
						<option value=""></option>
					</select>
				</div>
			</td>
		</tr>

		<!-- Recurrencia  -->
		<tr>
		<th nowrap="nowrap" style="text-align: right;">Recurrencia:</th>
			<td>
				<div id="divDatosDeRecurrencia">
				</div>
			</td>
		</tr>
		
		<!-- Sanción  -->
		<tr>
		<th nowrap="nowrap" style="text-align: right;">Sanción:</th>
			<td>
				<div id="divDatosDeSancion">
				</div>
			</td>
		</tr>
		
		<!-- Procedimiento  -->
		<tr>
		<th nowrap="nowrap" style="text-align: right;">Procedimiento:</th>
			<td>
				<div id="divDatosDeProcedimiento">
				</div>
			</td>
		</tr>
		
		<!-- Responsable  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Responsable:</th>
			<td>
				<b>
					<c:out value="${sessionScope[consHermes.USUARIO_SESSION].nombre}"/>
				</b>
				<b>
					(<c:out value="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.grupo.nombre}"/>)
				</b>
			</td>
		</tr>
		
		<!-- Observación  -->
		<tr>
			<th nowrap="nowrap" style="text-align: right;">Observación:</th>
			<td>
				<textarea id="observacionUno" name="observacionUno" rows="5" cols="98%"></textarea>
			</td>
		</tr>
		
	</table>
</fieldset>

<br/>

<br/>

<!-- Formatos de la falta -->
<fieldset>
	<legend class="e6">Formatos</legend>
	<div id="divFormatosDeFalta">
		<h5>Seleccione una falta para cargar los formatos.</h5>
	</div>		
</fieldset>

<br/>

<!-- Archivos Asociados -->
<fieldset>
	<legend class="e6">Archivos</legend>
	<table border="0" width="100%" class="caja">
			<col style="width: 15%"/>
			<col/>
			<!-- Archivo(s) a subir -->
			<tr>
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Archivo(s) :
				<div class="texto1">Todo tipo de archivos tam max:20MB</div> 
				</th>
				<td>
				<!-- Archivo Uno -->
					<input type="file" name="archivoUno" id="archivoUno" style="max-width: 100%" onchange="validarArchivo(this.id);"/>
					<select id="idtipoarchivoUno" name="idtipoarchivoUno">
						<option value=""></option>
						<c:forEach items="${listaTiposArchivos}" var="tipoArchivoUno" varStatus="loop">
							<option value="${tipoArchivoUno.iddisciplinaarchivotipo}">
								<c:out value="${tipoArchivoUno.nombretipoarchivo}"/>
							</option>
						</c:forEach>
					</select>
					
					<!-- Archivo Dos -->
					<input type="file" name="archivoDos" id="archivoDos" style="max-width: 100%" onchange="validarArchivo(this.id);"/>
					<select id="idtipoarchivoDos" name="idtipoarchivoDos">
						<option value=""></option>
						<c:forEach items="${listaTiposArchivos}" var="tipoArchivoDos" varStatus="loop">
							<option value="${tipoArchivoDos.iddisciplinaarchivotipo}">
								<c:out value="${tipoArchivoDos.nombretipoarchivo}"/>
							</option>
						</c:forEach>
					</select>
					
					<!-- Archivo Tres -->
					<input type="file" name="archivoTres" id="archivoTres" style="max-width: 100%" onchange="validarArchivo(this.id);"/>
					<select id="idtipoarchivoTres" name="idtipoarchivoTres">
						<option value=""></option>
						<c:forEach items="${listaTiposArchivos}" var="tipoArchivoTres" varStatus="loop">
							<option value="${tipoArchivoTres.iddisciplinaarchivotipo}">
								<c:out value="${tipoArchivoTres.nombretipoarchivo}"/>
							</option>
						</c:forEach>
					</select>
					
					<!-- Archivo Cuatro -->
					<input type="file" name="archivoCuatro" id="archivoCuatro" style="max-width: 100%" onchange="validarArchivo(this.id);"/>
					<select id="idtipoarchivoCuatro" name="idtipoarchivoCuatro">
						<option value=""></option>
						<c:forEach items="${listaTiposArchivos}" var="tipoArchivoCuatro" varStatus="loop">
							<option value="${tipoArchivoCuatro.iddisciplinaarchivotipo}">
								<c:out value="${tipoArchivoCuatro.nombretipoarchivo}"/>
							</option>
						</c:forEach>
					</select>
					
					<!-- Archivo Cinco -->
					<input type="file" name="archivoCinco" id="archivoCinco" style="max-width: 100%" onchange="validarArchivo(this.id);"/>
					<select id="idtipoarchivoCinco" name="idtipoarchivoCinco">
						<option value=""></option>
						<c:forEach items="${listaTiposArchivos}" var="tipoArchivoCinco" varStatus="loop">
							<option value="${tipoArchivoCinco.iddisciplinaarchivotipo}">
								<c:out value="${tipoArchivoCinco.nombretipoarchivo}"/>
							</option>
						</c:forEach>
					</select>
				    
					<!-- Archivo Seis -->
					<input type="file" name="archivoSeis" id="archivoSeis" style="max-width: 100%" onchange="validarArchivo(this.id);"/>
					<select id="idtipoarchivoSeis" name="idtipoarchivoSeis">
						<option value=""></option>
						<c:forEach items="${listaTiposArchivos}" var="tipoArchivoSeis" varStatus="loop">
							<option value="${tipoArchivoSeis.iddisciplinaarchivotipo}">
								<c:out value="${tipoArchivoSeis.nombretipoarchivo}"/>
							</option>
						</c:forEach>
					</select>
					
				</td>
			</tr>
			<!-- Observación -->
<!-- 			<tr> -->
<!-- 				<th nowrap="nowrap" style="text-align: right;">Observación:</th> -->
<!-- 				<td> -->
<!-- 					<textarea id="observacionDos" name="observacionDos" cols=50 rows=3 maxlength="2000" spellcheck="true" ></textarea> -->
<!-- 				</td> -->
<!-- 			</tr> -->

		</table>
</fieldset>

<br/>


<div>
<button type="button" id="btnCrearCancelarProceso" name="btnCrearCancelarProceso" onclick="$('#dmNuevoProcesoDisciplinario').dialog('close');">Cancelar</button>
&nbsp;&nbsp;&nbsp;
<button type="submit" id="btnCrearProceso" name="btnCrearProceso">Registrar Proceso</button></div>
</form>

</div>
<div style="padding: 30px 0px;"></div>