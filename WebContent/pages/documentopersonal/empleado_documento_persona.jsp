<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$("[name=btnNuevoDocumentoPersonal]").button();
		
		
		$("[name=btnEdicionEmpleado]").button();
		$("[name=btnDeshabilitarEmpleado]").button();
		$("[name=btnActivarEmpleado]").button();	
		$("[name=btnEdicionEmpleadoContrasena]").button();
		$("[name=btnEdicionContrato]").button();
		$("[name=btnDeshabilitarContrato]").button();
		$("[name=btnActivarContrato]").button();
		
		
		$("[name=lnkUpdateDocumento]").click(function() {
			actualizarDocumentoPersonal('${empleado.idempleado}');
		});
		
		$("#dmMensajeDocumentoPersonal").dialog({   				
			width: 400,
			height: 200,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		$("#dmNuevoDocumentoPersonal").dialog({   				
			width: 700,
			height: 320,   				
			modal: true,
			autoOpen: false,
			resizable: true
		});
		
		
	});
	
	/*
	 * Actualizar datos de la tabla documentos personales.
	 * @param: idempleado.
	 */
	function actualizarDocumentoPersonal(idempleado){
		$("#dmEmpleadoDocumentos").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/documento?action=documento_propiedades&idempleado="+idempleado,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmEmpleadoDocumentos").html(data);
	        }
	    });
	}
	
	/**
	 * Deshabilitar un empleado documento.
	 * @param: idempleado.
	 */
	function deshabilitarEmpleadoDocumento(idempleadodocumento,idempleado) {		
		 if(idempleadodocumento==''){
		}else{
			if(confirm('¿Esta seguro de deshabilitar este documento del empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/documento?action=documento_personal_deshabilitar&idempleadodocumento='+idempleadodocumento+'&idempleado='+idempleado,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeDocumentoPersonal").html(jqXHR.statusText);
			        },
			        
		            success: function(data) {
		            	if(validarEntero(data)){
		            		actualizarDocumentoPersonal(data);
		                } else {
		                    $("#dmMensajeDocumentoPersonal").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
	
/**
* Activar un empleado documento.
*/
function habilitarEmpleadoDocumento(idempleadodocumento,idempleado) {		
		if(idempleadodocumento==''){
				
		}else{
			if(confirm('¿Esta seguro de habilitar este documento al empleado [${empleado.codempleado}] ${empleado.nombres} ${empleado.apellidos}?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
			        type: 'post',            
			        url: '${ctx}/page/documento?action=empleado_documento_habilitar&idempleadodocumento='+idempleadodocumento+'&idempleado='+idempleado,
			        data: '',
			        dataType: "text",
			        error: function(jqXHR, textStatus, errorThrown) {
			            $("#dmMensajeDocumentoPersonal").html(jqXHR.statusText);
				    },
			        success: function(data) {
			            	if(validarEntero(data)){
			            		actualizarDocumentoPersonal(data);
			                } else {
			                    $("#dmMensajeDocumentoPersonal").html('Error desconocido');					
			                }
			         }
			    });	 
			}
		}
}


/**
 * Para subir un documento.
 */
function verCrearDocumentoPersonal(idempleado){
	
	$("#dmNuevoDocumentoPersonal").dialog("open");
	$("#dmNuevoDocumentoPersonal").html(getHTMLLoaging30());
	$.ajax({
		cache: false,
		contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
        type: 'POST',
        url: "${ctx}/page/documento?action=crear_nuevo_documento&idempleado="+idempleado,
        dataType: "text",
        error: function(jqXHR, textStatus, errorThrown) {
            alert(jqXHR.statusText);
        },
        success: function(data) {		                    	                    	
           	$("#dmNuevoDocumentoPersonal").html(data);     
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


<div align="left" id="dmEmpleadoDocumentos">
<c:choose>
		<c:when test="${empty empleadodocumentopersonal}">
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 }">
				<c:if test="${empleado.estado==2}">
					<button type="button" id="btnNuevoDocumentoPersonal" name="btnNuevoDocumentoPersonal" onclick="verCrearDocumentoPersonal(${empleado.idempleado});">Cargar Documento</button>&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:if>
			<div class="msgInfo1" align="left">El empleado no tiene documentos cargados.</div>
		</c:when>
		<c:otherwise>

		<br/>
		
		<br/>
			<div id="idTabsEmpleadoDocumento">
				<c:choose>
				<c:when test="${empty empleadodocumentopersonal}">
				<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 }">
					<c:if test="${empleado.estado==2}">
						<button type="button" id="btnNuevoDocumentoPersonal" name="btnNuevoDocumentoPersonal" onclick="verCrearDocumentoPersonal(${empleado.idempleado});">Cargar Documento</button>&nbsp;&nbsp;&nbsp;
					</c:if>
				</c:if>
					<div class="msgInfo1" align="left">El empleado no tiene documentos cargados.</div>
				</c:when>
				<c:otherwise>
					<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 }">
						<c:if test="${empleado.estado==2}">
							<button type="button" id="btnNuevoDocumentoPersonal" name="btnNuevoDocumentoPersonal" onclick="verCrearDocumentoPersonal(${empleado.idempleado});">Cargar Documento</button>&nbsp;&nbsp;&nbsp;
						</c:if>
					</c:if>
				<fieldset style="width: auto"><legend class="e6"  >Documentos Personales</legend>	
				
						<!-- Tabla documentos -->
						<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
							<tr>
								<th>Tipo Documento</th>
								<th>Nombre Documento</th>
								<th>Observación</th>
								<th>User crea</th>
								<th>Fecha crea</th>
								<th>User mod</th>
								<th>Fecha mod</th>	
								<th>Estado</th>	
								<th>Acción</th>	
							</tr>
						<tbody>
								
								
								 <c:forEach items="${empleadodocumentopersonal}" var="empleadoDocumento" varStatus="loop">
									
										<tr style="color: ${empleadoDocumento.estado==2?'':'red'};">
										<td class="e6" >
											<c:out value="${empleadoDocumento.tipodocumento.nombretipodocumento}"/>
										</td>
										<td>
											<c:out value="${empleadoDocumento.nombredocumento}"/>
										</td>
										<td>
											<c:out value="${empleadoDocumento.observaciondocumento}"/>
										</td>									
										<td>
											<c:out value="${empleadoDocumento.idusuariocrea}"/>
										</td>
										<td>
											<fmt:formatDate value="${empleadoDocumento.fechacrea}" pattern="dd/MM/yyyy H:mm"/>
										</td>
										<td>
											<c:out value="${empleadoDocumento.idusuariomod}"/>
										</td>
										<td>
											<fmt:formatDate value="${empleadoDocumento.fechamod}" pattern="dd/MM/yyyy H:mm"/>
										</td>
										<td>
											<c:if test="${empleadoDocumento.estado==2}">
												<c:out value="Activo"/>
											</c:if>
											<c:if test="${empleadoDocumento.estado==3}">
												<c:out value="Desactivado"/>
											</c:if>
										</td>
										
										<td>
									<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
										<c:if test="${empleado.estado==2}">
											<c:if test="${empleadoDocumento.estado==2}">
												<span class="enlace" onclick="deshabilitarEmpleadoDocumento(${empleadoDocumento.idempleadodocumento},${empleado.idempleado});" title="Deshabilitar">
													<img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif">
												</span>
												<a href="${ctx}/page/documento?action=verDocumento&idempleadodocumentopersonal=${empleadoDocumento.idempleadodocumento}" target="_blank"><img alt="" src="${ctx}/imagen/download.png"></a>
												&nbsp;
											</c:if> 
											<c:if test="${empleadoDocumento.estado==3}">
												<span class="enlace" onclick="habilitarEmpleadoDocumento(${empleadoDocumento.idempleadodocumento},${empleado.idempleado});" title="Activar">
													<img alt="Activar" src="${ctx}/imagen/control_habilitar.gif">
												</span>
											</c:if>
										</c:if>
									</c:if>	
											
										</tr>
									
								</c:forEach>	
										
										
								</tbody>
								</table>
						
					</fieldset>
				</c:otherwise>
				</c:choose>		
			</div>
		
		<br/>
		
		
		<div>
		
		<span class="enlace" id='lnkUpdateDocumento' name='lnkUpdateDocumento'>&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
		</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>
<div id="dmMensajeDocumentoPersonal" title="Mensaje"></div>
<div id="dmNuevoDocumentoPersonal" title="Nuevo Documento"></div>