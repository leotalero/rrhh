<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$("[name=btnEditarProceso]").button();
	$("[name=btnCambiarEstado]").button();
	$("[name=btnAgregarTestigo]").button();
	
	//Validaciones
	$("#fCambioEstadoProceso").validate({
		errorClass: "invalid",
		rules: {
			idEstadoSeleccionado: {
				required: true,
				min:1
			},
			comentarioRevision: {
				required: true,
				maxlength: 2000
			},
		},
		
		messages: {
			
			idEstadoSeleccionado:{
				required: "Seleccione una opción para el nuevo estado",	
			},
			comentarioRevision: {
				required: "Ingrese un comentario.",
				maxlength: "No se permite mas de 2000 caráteres."
			}
		},
		submitHandler: function(form) {
			crearDisciplinaHistorial(form);
		}
	});
	
});

/**
 * Para la carga de archivos al servidor. Y envio del formulario.
 * @param form.
 */
function crearDisciplinaHistorial(form) {
// 	$("[name=btnCrearProceso]").attr('disabled',true);
// 	$("[name=btnCrearCancelarProceso]").attr('disabled',true);;
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
			    $("#dmMensajeProcesoDisciplinario").dialog("close");
	            $("#dmDetalleProcesoDisciplinario").dialog("close");
	            
	            //actualizarDocumentoPersonal('${empleado.idempleado}');
				//${idcontrato}
// 				alert('Aqui va actualizar... con idContrato : ${detalleDisciplina.idcontrato}');
// 				alert("Antes de actualizar.");
				actualizarHistoricoDisciplinario(${listaIdAreas});
	            
			    setTimeout('iframeId.parentNode.removeChild(iframeId)', 30);
		    };
		    
		    if (iframeId.addEventListener){
		    	iframeId.addEventListener("load", eventHandler, true);
		    }
		    if (iframeId.attachEvent){
		    	iframeId.attachEvent("onload", eventHandler);
		    }
		    
		 	form.setAttribute("target", iframe_nombre);

		    form.setAttribute("action","${ctx}/page/disciplinario?action=insertarDisciplinaHistorial");
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
function validarArchivoDetalle(id) {
	var nombreArchivo = $('#'+id+'').val();
	var extension = nombreArchivo.substring(nombreArchivo.lastIndexOf('.'));
// 	alert('Nombre archivo : '+nombreArchivo+'Extension: '+extension);
	var input = document.getElementById(id);
	var file = input.files[0];
	var tamanio = file.size;
	
	if(tamanio>20971520){
		alert('El tamaño del archivo no debe superar los 20MB.');
		$('#'+id+'').val('');
	}else if(extension=='.exe' || extension=='exe' || extension=='.EXE' || extension=='EXE'){
		alert('Archivo no valido.');
		$('#'+id+'').val('');
	}else if(nombreArchivo!=''){
// 		alert('Nombre != vacio');
		if(id=='archivoUnoDetalle'){
			idtipoarchivoUno.required=true;
		}
		if(id=='archivoDosDetalle'){
			idtipoarchivoDos.required=true;
		}
		if(id=='archivoTresDetalle'){
			idtipoarchivoTres.required=true;
		}
		if(id=='archivoCuatroDetalle'){
			idtipoarchivoCuatro.required=true;
		}
		if(id=='archivoCincoDetalle'){
			idtipoarchivoCinco.required=true;
		}
		if(id=='archivoSeisDetalle'){
			idtipoarchivoSeis.required=true;
		}
	}else{
// 		alert('Nombre vacio');
		if(id=='archivoUnoDetalle'){
			idtipoarchivoUno.required=false;
		}
		if(id=='archivoDosDetalle'){
			idtipoarchivoDos.required=false;
		}
		if(id=='archivoTresDetalle'){
			idtipoarchivoTres.required=false;
		}
		if(id=='archivoCuatroDetalle'){
			idtipoarchivoCuatro.required=false;
		}
		if(id=='archivoCincoDetalle'){
			idtipoarchivoCinco.required=false;
		}
		if(id=='archivoSeisDetalle'){
			idtipoarchivoSeis.required=false;
		}
	}
	
};


function agregarComoTestigo(idempleado,idDisciplina,idSancion,idContrato,idFalta){
	insertarTestigo(idempleado, idDisciplina,idSancion,idContrato,idFalta);
}

function insertarTestigo(idempleado,idDisciplina,idSancion,idContrato,idFalta){

	if(idempleado=='' || idDisciplina==''){
		
	}else{
		if(confirm('¿Esta seguro de agregar al empleado con id ['+idempleado+'] como testigo del proceso?')){
			$.ajax({
				cache: false,
				contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	            type: 'post',            
	            url: '${ctx}/page/disciplinario?action=insertarUnTestigo&idEmpleado='+idempleado+'&idDisciplina='+idDisciplina,
	            data: '',
	            dataType: "text",
	            error: function(jqXHR, textStatus, errorThrown) {        		
	                $("#dmMensajeDisciplinario").html(jqXHR.statusText);
		        },
	            success: function(data) {
	            	if(validarEntero(data)){
// 	                	actualizarBanco(data);
// 	            		$("#dmMensajeDisciplinario").html('El testigo se registró correctamente.');	
						alert('El testigo se registró correctamente.');
						actualizarDetalle(idDisciplina,idSancion,idContrato,idFalta);
	                } else {
	                    $("#dmMensajeDisciplinario").html('Error desconocido');					
	                }
	            }
	        });	 
		}
	}
}

/*
	 * Actualizar datos de la tabla bancos.
	 */
	function actualizarDetalle(idDisciplina,idSancion,idContrato,idFalta){
		$("#dmDetalleProcesoDisciplinario").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/disciplinario?action=detalleProcesoDisciplinario&idDisciplina="+idDisciplina+"&idSancion="+idSancion+"&idContrato="+idContrato+"&idFalta="+idFalta,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmDetalleProcesoDisciplinario").html(data);
	        }
	    });
	}




//Ver Buscar testigo
function verBuscarTestigo(idDisciplina,idSancion,idContrato,idFalta) {		
	if(idDisciplina==''){
	}else{
		visualizarBusquedaTestigo(idDisciplina,idSancion,idContrato,idFalta); //Este método está en empleado_busqueda.jsp
	}
}


</Script>

<input type="hidden" name="estadoProceso" id="estadoProceso"
	value="${estado}" style="width: 95%;" />
<div align="left">

	<%-- 	<button type="submit" id="btnEditarProceso" name="btnEditarProceso" onclick="VerEditarDisciplina(${idDisciplina});">Editar Proceso</button> --%>

	<br/>
	<fieldset>
		<legend class="e6">Estado del proceso</legend>
		<div
			style="background-color: #cccccc; clear: both; margin: 0px 0px 10px 0px; padding: 5px;">
			Estado actual del proceso : <b>${estado}</b>
		</div>
	</fieldset>
	<br />
	<!-- DATOS BÁSICOS DE LA FALTA -->
	<fieldset>
		<legend class="e6">Detalle Disciplinario</legend>
		<table border="0" width="100%" class="caja">
			<col style="width: 30%" />
			<col style="width: 70%" />
			<tr class="td3">
				<th nowrap="nowrap" style="text-align: center;">Información:</th>
				<th nowrap="nowrap" style="text-align: center;">Detalle:</th>
			</tr>
			<!-- Tipo de falta -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Tipo de Falta:</th>
				<td><c:out
						value="${detalleDisciplina.faltaTipo.nombrefaltatipo}" /></td>
			</tr>
			<!-- Falta -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Falta:</th>
				<td><c:out value="${detalleDisciplina.falta.faltanombre}" /></td>
			</tr>
			<!-- Sanción -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Sanción:</th>
				<td><c:out value="${detalleDisciplina.sancion.nombresancion}" /></td>
			</tr>
			<!-- Procedimiento -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Procedimiento:</th>
				<td><c:out value="${detalleDisciplina.sancion.procedimiento}" /></td>
			</tr>
			<!-- Responsable -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Responsable:</th>
				<td><c:out value="${detalleDisciplina.sancion.responsable}" /></td>
			</tr>
			<!-- Recurrencia -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Recurrencia:</th>
				<td><b> <c:out value="${recurrencia}" />
				</b></td>
			</tr>
			<!-- Observación -->
			<!-- 			<tr> -->
			<!-- 				<th nowrap="nowrap" style="text-align: right;">Observación:</th> -->
			<%-- 				<td><c:out --%>
			<%-- 						value="${detalleDisciplina.disciplinaHistorial.observacion}" /></td> --%>
			<!-- 			</tr> -->
			<!-- Creador -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Creó:</th>
				<td><c:out
						value="${detalleDisciplina.disciplinaHistorial.creadorProceso}" /></td>
			</tr>
			<!-- Fecha de registro -->
			<tr>
				<th nowrap="nowrap" style="text-align: right;">Fecha Registro:</th>
				<td><c:out value="${detalleDisciplina.fechacrea}" /></td>
			</tr>
		</table>
	</fieldset>

	<br />

	<!-- FORMATOS -->
	<fieldset style="width: auto">
		<legend class="e6">Formatos</legend>
		<c:choose>
			<c:when test="${empty listaFormatos}">
				<div class="msgInfo1" align="left">No hay formatos para
					mostrar.</div>
			</c:when>
			<c:otherwise>

				<table style="" border="0" width="100%" class="tExcel tRowSelect">
					<tr>
						<th>Nombre Formato</th>
						<th>User crea</th>
						<th>Fecha crea</th>
						<th>User mod</th>
						<th>Fecha mod</th>
						<th>Estado</th>
						<th>Acción</th>
					</tr>
					<tbody>

						<c:forEach items="${listaFormatos}" var="formato" varStatus="loop">

							<tr style="color: ${formato.estado==2?'':'red'};">
								<td class="e6"><c:out value="${formato.nombreformato}" /></td>
								<td><c:out value="${formato.idusuariocrea}" /></td>
								<td><fmt:formatDate value="${formato.fechacrea}"
										pattern="dd/MM/yyyy" /></td>
								<td><c:out value="${formato.idusuariomod}" /></td>
								<td><fmt:formatDate value="${formato.fechamod}"
										pattern="dd/MM/yyyy" /></td>
								<td><c:if test="${formato.estado==2}">
										<c:out value="Activo" />
									</c:if> <c:if test="${formato.estado==3}">
										<c:out value="Desactivado" />
									</c:if></td>
								<td><a
									href="${ctx}/page/disciplinario?action=descargarFormato&idFormato=${formato.idformato}"
									target="_blank"> <img alt=""
										src="${ctx}/imagen/download.png">
								</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</fieldset>
	
	<br/>

	<!-- DATOS DE LOS TESTIGOS -->
	<fieldset style="width: auto">
		<legend class="e6">Testigos</legend>
		<c:choose>
			<c:when test="${empty listaTestigos}">
				<div class="msgInfo1" align="left">Este proceso no tiene testigos.</div><br/>
				<button type="button" id="btnAgregarTestigo" name="btnAgregarTestigo" onclick="verBuscarTestigo(${detalleDisciplina.iddisciplina},${detalleDisciplina.idcontrato},${detalleDisciplina.sancion.idsancion},${detalleDisciplina.falta.idfalta});">Agregar testigo</button>&nbsp;&nbsp;&nbsp;			
			</c:when>
			<c:otherwise>
			<button type="button" id="btnAgregarTestigo" name="btnAgregarTestigo" onclick="verBuscarTestigo(${detalleDisciplina.iddisciplina},${detalleDisciplina.idcontrato},${detalleDisciplina.sancion.idsancion},${detalleDisciplina.falta.idfalta});">Agregar testigo</button>&nbsp;&nbsp;&nbsp;
				<table style="" border="0" width="100%" class="tExcel tRowSelect">
					<tr>
						<th>Tipo Documento</th>
						<th>Identificación</th>
						<th>Nombre(s)</th>
						<th>Apellidos</th>
						<th>Fecha nacimiento</th>
						<th>Género</th>
						<th>User crea</th>
						<th>Fecha crea</th>
						<th>User mod</th>
						<th>Fecha mod</th>
						<th>Estado</th>
					</tr>
					<tbody>
						<c:forEach items="${listaTestigos}" var="testigo" varStatus="loop">
							<tr style="color: ${testigo.estado==2?'':'red'};">
								<td><c:out value="${testigo.empleado.identificaciontipo.tipo}" />
								</td>
								<td><c:out
										value="${testigo.empleado.empleadoidentificacion.numeroidentificacion}" /> 
								</td>
								<td><c:out value="${testigo.empleado.nombres}" /></td>
								<td><c:out value="${testigo.empleado.apellidos}" /></td>
								<td><fmt:formatDate
			 							value="${testigo.empleado.fechanacimiento}" pattern="dd/MM/yyyy" /></td> 
			 					<td><c:out value="${testigo.empleado.genero.nombregenero}" /></td> 
			 					<td><c:out value="${testigo.empleado.idusuariocrea}" /></td> 
			 					<td><fmt:formatDate value="${testigo.empleado.fechacrea}" 
			 							pattern="dd/MM/yyyy" /></td> 
			 					<td><c:out value="${testigo.empleado.idusuariomod}" /></td> 
			 					<td><fmt:formatDate value="${testigo.empleado.fechamod}" 
			 							pattern="dd/MM/yyyy" /></td> 
								<td><c:if test="${testigo.empleado.estado==2}"> 
			 							<c:out value="Activo" /> 
									</c:if> <c:if test="${testigo.empleado.estado==3}"> 
			 							<c:out value="Desactivado" />
			 						</c:if></td>
			 				</tr>
						</c:forEach> 
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</fieldset>
	<br />
	
<!-- 	HISTORIAL DE REVISIONES -->

	<fieldset>
		<legend class="e6">Historial de revisión</legend>
		
		<c:forEach items="${disciplinaHistorial}" var="historial"
			varStatus="loop">
			<div
				style="background-color: #cccccc; clear: both; margin: 0px 0px 10px 0px; padding: 5px;">
				<b> <c:out 
				value="${historial.creadorProceso}   [${historial.disciplinaEstado.estadodisciplina}]" />
				</b>
				<div align="right" style="float: right;">
					<fmt:formatDate value="${historial.fechacrea}"
						pattern="dd/MM/yyyy H:mm" />
				</div>
				<div style='padding-bottom: 10px;'>
			    	<c:out value="${historial.observacion}" />
			    </div>			
				<div>
					<c:if test="${ not empty historial.listaArchivos}">
						<b><c:out value="Archivos asociados:" /></b>
						<br /><br />
						<c:forEach items="${historial.listaArchivos}" var="archivo"
							varStatus="loop">
							
							<c:out value="${archivo.disciplinaArchivoTipo.nombretipoarchivo} : "/>
							<a href="${ctx}/page/disciplinario?action=descargarArchivo&idDisciplinaArchivo=${archivo.iddisciplinaarchivo}" target="_blank">
								<c:out value="${archivo.nombrearchivo}" />
							</a><br/>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</c:forEach>

	</fieldset>
	
<br/>
<br/>
	
	<!-- Revisión del proceso -->
	<form name="fCambioEstadoProceso" id="fCambioEstadoProceso"
		enctype="multipart/form-data" action="${ctx}/page/disciplinario"
		method="post">
		<input type="hidden" name="action" value="cambiarEstadoProceso" /> <input
			type="hidden" name="idDisciplina" value="${idDisciplina}" /> <input
			type="hidden" name="idContrato"
			value="${detalleDisciplina.idcontrato}" /> <input type="hidden"
			name="usuarioCreador"
			value="${sessionScope[consHermes.USUARIO_SESSION].nombre} (${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.grupo.nombre})" />

		<fieldset>
			<legend class="e6">Revisión</legend>
			<table border="0" width="100%" class="caja">
				<col style="width: 30%" />
				<col style="width: 70%" />

				<!-- Estado Actual-->
				<tr>
					<th nowrap="nowrap" style="text-align: right;">Estado Actual :</th>
					<td><b><c:out value="${estado}" /></b></td>
				</tr>

				<!-- Cambiar estado a -->
				<tr>
					<th nowrap="nowrap" style="text-align: right;">Cambiar estado
						a :</th>
					<td><select id="idEstadoSeleccionado"
						name="idEstadoSeleccionado">
							<option value=""></option>
							<c:forEach items="${listaEstados}" var="estado" varStatus="loop">
								<option value="${estado.iddisciplinaestado}">
									<c:out value="${estado.estadodisciplina}" />
								</option>
							</c:forEach>
					</select></td>
				</tr>

				<!-- Comentario -->
				<tr>
					<th nowrap="nowrap" style="text-align: right;">Comentario :</th>
					<td><textarea id="comentarioRevision"
							name="comentarioRevision" rows="4" cols="98%"></textarea></td>
				</tr>

				<!-- Archivos -->
				<tr>
					<th nowrap="nowrap" style="text-align: right;">Archivo(s) :
						<div class="texto1">Todo tipo de archivos tam max:20MB</div>
					</th>
					<td>
						<!-- Archivo Uno --> <input type="file" name="archivoUnoDetalle"
						id="archivoUnoDetalle" style="max-width: 100%"
						onchange="validarArchivoDetalle(this.id);" /> <select
						id="idtipoarchivoUno" name="idtipoarchivoUno">
							<option value=""></option>
							<c:forEach items="${listaTiposArchivos}" var="tipoArchivoUno"
								varStatus="loop">
								<option value="${tipoArchivoUno.iddisciplinaarchivotipo}">
									<c:out value="${tipoArchivoUno.nombretipoarchivo}" />
								</option>
							</c:forEach>
					</select> <!-- Archivo Dos --> <input type="file" name="archivoDosDetalle"
						id="archivoDosDetalle" style="max-width: 100%"
						onchange="validarArchivoDetalle(this.id);" /> <select
						id="idtipoarchivoDos" name="idtipoarchivoDos">
							<option value=""></option>
							<c:forEach items="${listaTiposArchivos}" var="tipoArchivoDos"
								varStatus="loop">
								<option value="${tipoArchivoDos.iddisciplinaarchivotipo}">
									<c:out value="${tipoArchivoDos.nombretipoarchivo}" />
								</option>
							</c:forEach>
					</select> <!-- Archivo Tres --> <input type="file" name="archivoTresDetalle"
						id="archivoTresDetalle" style="max-width: 100%"
						onchange="validarArchivoDetalle(this.id);" /> <select
						id="idtipoarchivoTres" name="idtipoarchivoTres">
							<option value=""></option>
							<c:forEach items="${listaTiposArchivos}" var="tipoArchivoTres"
								varStatus="loop">
								<option value="${tipoArchivoTres.iddisciplinaarchivotipo}">
									<c:out value="${tipoArchivoTres.nombretipoarchivo}" />
								</option>
							</c:forEach>
					</select> <!-- Archivo Cuatro --> <input type="file"
						name="archivoCuatroDetalle" id="archivoCuatroDetalle"
						style="max-width: 100%" onchange="validarArchivoDetalle(this.id);" />
						<select id="idtipoarchivoCuatro" name="idtipoarchivoCuatro">
							<option value=""></option>
							<c:forEach items="${listaTiposArchivos}" var="tipoArchivoCuatro"
								varStatus="loop">
								<option value="${tipoArchivoCuatro.iddisciplinaarchivotipo}">
									<c:out value="${tipoArchivoCuatro.nombretipoarchivo}" />
								</option>
							</c:forEach>
					</select> <!-- Archivo Cinco --> <input type="file"
						name="archivoCincoDetalle" id="archivoCincoDetalle"
						style="max-width: 100%" onchange="validarArchivoDetalle(this.id);" />
						<select id="idtipoarchivoCinco" name="idtipoarchivoCinco">
							<option value=""></option>
							<c:forEach items="${listaTiposArchivos}" var="tipoArchivoCinco"
								varStatus="loop">
								<option value="${tipoArchivoCinco.iddisciplinaarchivotipo}">
									<c:out value="${tipoArchivoCinco.nombretipoarchivo}" />
								</option>
							</c:forEach>
					</select> <!-- Archivo Seis --> <input type="file" name="archivoSeisDetalle"
						id="archivoSeisDetalle" style="max-width: 100%"
						onchange="validarArchivoDetalle(this.id);" /> <select
						id="idtipoarchivoSeis" name="idtipoarchivoSeis">
							<option value=""></option>
							<c:forEach items="${listaTiposArchivos}" var="tipoArchivoSeis"
								varStatus="loop">
								<option value="${tipoArchivoSeis.iddisciplinaarchivotipo}">
									<c:out value="${tipoArchivoSeis.nombretipoarchivo}" />
								</option>
							</c:forEach>
					</select>

					</td>
				</tr>

			</table>
			<button type="submit" id="btnCambiarEstado" name="btnCambiarEstado">Grabar</button>
		</fieldset>
	</form>
	<br />


</div>
<div style="padding: 30px 0px;"></div>









