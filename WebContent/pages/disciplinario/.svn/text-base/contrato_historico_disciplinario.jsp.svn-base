<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("[name=btnNuevoProceso]").button();
		
		
		$("[name=lnkUpdateProceso]").click(function() {
			actualizarProcesosDisciplinarios('${contrato.idcontrato}');
		});
		
	});
	
	/*
	 * Actualizar datos de la tabla de procesos disciplinarios.
	 */
	function actualizarProcesosDisciplinarios(idcontrato){
//  		alert('Va actualizar: '+idcontrato);
		$("#dmProcesos").html(getHTMLLoaging30());
		$.ajax({
			cache: false,
			contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
	        type: 'POST',
	        url: "${ctx}/page/disciplinario?action=verProcesoDisciplinario&idcontrato="+idcontrato,
	        dataType: "text",
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.statusText);
	        },
	        success: function(data) {
	        	$("#dmProcesos").html(data);
	        }
	    });
	}
	
	/**
	 * Deshabilitar la relacion disciplina.
	 * Cambiar el estado a 1 (Inactivo)
	 */
	function eliminarProcesoDisciplinario(idDisciplina,idContrato) {		
		
		if(idDisciplina=='' || idContrato==''){
			
		}else{
			if(confirm('¿Está seguro de ELIMINAR el proceso disciplinario?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/disciplinario?action=eliminarDisciplina&idDisciplina='+idDisciplina+'&idContrato='+idContrato,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeProcesoDisciplinario").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		            		actualizarProcesosDisciplinarios(data);
		                } else {
		                    $("#dmMensajeProcesoDisciplinario").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
	/**
	 * Habilitar la relación disciplina.
	 * Cambiar el estado a 2 (activo)
	 */
	function activarProcesoDisciplinario(idDisciplina,idContrato) {		
		
		if(idDisciplina=='' || idContrato==''){
			
		}else{
			if(confirm('¿Está seguro de ACTIVAR el proceso disciplinario?')){
				$.ajax({
					cache: false,
					contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1;', 
		            type: 'post',            
		            url: '${ctx}/page/disciplinario?action=activarDisciplina&idDisciplina='+idDisciplina+'&idContrato='+idContrato,
		            data: '',
		            dataType: "text",
		            error: function(jqXHR, textStatus, errorThrown) {        		
		                $("#dmMensajeProcesoDisciplinario").html(jqXHR.statusText);
			        },
		            success: function(data) {
		            	if(validarEntero(data)){
		            		actualizarProcesosDisciplinarios(data);
		                } else {
		                    $("#dmMensajeProcesoDisciplinario").html('Error desconocido');					
		                }
		            }
		        });	 
			}
		}
	}
	
</script>

<!--------------------------------------------------------------------
	Listado de procesos disciplinarios para el contrato seleccionado.
 --------------------------------------------------------------------->
<div align="left" id="dmProcesos">
<c:choose>
		<c:when test="${empty listaDisciplina}">
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
				<button type="button" id="btnNuevoProceso" name="btnNuevoProceso" onclick="CrearProcesoDisciplinario(${contrato.idcontrato});">Nuevo Proceso</button>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;
			</c:if>
			<div class="msgInfo1" align="left">El contrato no tiene Procesos Disciplinarios.</div>
		</c:when>
		<c:otherwise>
<br/>

<br/>

	<div id="idTabsContratoProcesosDisciplinarios">
		<c:choose>
		<c:when test="${empty listaDisciplina}">
			<div class="msgInfo1" align="left">El contrato no tiene procesos disciplinarios.</div>
		</c:when>
		<c:otherwise>
			<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 ||sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 215 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 216}">
				<button type="button" id="btnNuevoProceso" name="btnNuevoProceso" onclick="CrearProcesoDisciplinario(${contrato.idcontrato});">Nuevo Proceso</button>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;
			</c:if>
			&nbsp;&nbsp;&nbsp;
		<br/>
		<fieldset style="width: auto">
		<legend class="e6"  >Histórico Disciplinario</legend>	
		
				<!-- TABLA HISTÓRICO DISCIPLINARIO -->
				<table style="font " border="0" width="100%" class="tExcel tRowSelect" >
						<tr>
							<th>Tipo de falta</th>
							<th>Falta</th>
<!-- 							<th>Observación</th> -->
							<th>Sanción</th>
							<th>Responsable</th>
							<th>Procedimiento</th>
<!-- 							<th>User crea</th> -->
							<th>Fecha creación</th>
<!-- 							<th>User mod</th> -->
<!-- 							<th>Fecha mod</th>	 -->
							<th>Estado registro</th>
<!-- 							recurrenciaPorFalta -->
							<th>Recurrencia</th>
							<th>Estado Proceso</th>	
							<th>Acción</th>	
						</tr>
				<tbody>
						
						 <c:forEach items="${listaDisciplina}" var="disciplina" varStatus="loop">
							
								<tr style="color: ${disciplina.estado==2?'':'red'};">
									<td class="e6" >
										<c:out value="${disciplina.faltaTipo.nombrefaltatipo}"/>
									</td>
									<td class="e6" >
										<c:out value="${disciplina.falta.faltanombre}"/>
									</td>
<!-- 									<td> -->
<%-- 										<c:out value="${disciplina.disciplinaHistorial.observacion}"/> --%>
<!-- 									</td> -->
									<td>
										<c:out value="${disciplina.sancion.nombresancion}"/>
									</td>
									<td>
										<c:out value="${disciplina.sancion.responsable}"/>
<%-- 									<c:out value="${disciplina.disciplinaHistorial.creadorProceso}"/> --%>
									</td>
									<td>
										<c:out value="${disciplina.sancion.procedimiento}"/>
									</td>
<!-- 									<td> -->
<%-- 										<c:out value="${disciplina.idusuariocrea}"/> --%>
<!-- 									</td> -->
									<td>
										<fmt:formatDate value="${disciplina.fechacrea}" pattern="dd/MM/yyyy"/>
									</td>
<!-- 									<td> -->
<%-- 										<c:out value="${disciplina.idusuariomod}"/> --%>
<!-- 									</td> -->
<!-- 									<td> -->
<%-- 										<fmt:formatDate value="${disciplina.fechamod}" pattern="dd/MM/yyyy"/> --%>
<!-- 									</td> -->
									<td>
										<c:if test="${disciplina.estado==1}">
											<c:out value="Eliminado"/>
										</c:if>
										<c:if test="${disciplina.estado==2}">
											<c:out value="Activo"/>
										</c:if>
										<c:if test="${disciplina.estado==3}">
											<c:out value="Desactivado"/>
										</c:if>
									</td>
									<td>
										<b><c:out value="${disciplina.recurrenciaPorFalta}"/></b>
									</td>
									<td>
										<b><c:out value="${disciplina.ultimoDisciplinaEstado.estadodisciplina}"/></b>
									</td>
									<td valign="middle" align="center">
										<c:if test="${disciplina.estado==2}">
<!-- 										ESTO SE DESHABILITA POR CONFIGURACIÓN DE PERMISOS. -->
<%-- 											<c:if test="${sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 1 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 212 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 213 || sessionScope[consHermes.USUARIO_SESSION].usuarioaplicacion.idgrupo == 214}"> --%>
<%-- 												<span class="enlace" onclick="eliminarProcesoDisciplinario(${disciplina.iddisciplina},${disciplina.idcontrato});" title="Eliminar"> --%>
<%-- 													<img alt="Eliminar" src="${ctx}/imagen/control_deshabilitar.gif"> --%>
<!-- 												</span> -->
<%-- 											</c:if> --%>
											<span class="enlace" onclick="visualizarDetalleProcesoDisciplinario(${disciplina.iddisciplina},${disciplina.idsancion},${disciplina.idcontrato},${disciplina.falta.idfalta});" title="Detalle">
												<img alt="Detalle" src="${ctx}/imagen/ico-editar.gif">
											</span>
										</c:if>
<%-- 										<c:if test="${disciplina.estado==1}"> --%>
<%-- 											<span class="enlace" onclick="activarProcesoDisciplinario(${disciplina.iddisciplina},${disciplina.idcontrato});" title="Activar"> --%>
<%-- 												<img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"> --%>
<!-- 											</span> -->
<%-- 										</c:if> --%>
									</td>
								</tr>
							
								</c:forEach>	
						</tbody>
						</table>
			</fieldset>
		</c:otherwise>
		</c:choose>		
	</div>

<br/>


<!-- Enlace Actualizar -->
<div>
	<span class="enlace" id='lnkUpdateProceso' name='lnkUpdateProceso'>&nbsp;Actualizar<span>&nbsp;</span></a></span>&nbsp;&nbsp;&nbsp;
</div>

</c:otherwise>
</c:choose>
</div>




<div style="padding: 30px 0px;"></div>