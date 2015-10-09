<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	
</script>
<br/>
<br/>
<div align="left">
	
	<!-- Formatos -->
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
					<td>
						
						<c:if test="${formato.estado==2}">
							<span class="enlace" onclick="deshabilitarFormato(${formato.idformato});" title="Deshabilitar">
								<img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif">
							</span>
							<a href="${ctx}/page/disciplinario?action=descargarFormato&idFormato=${formato.idformato}"
								target="_blank"> <img alt="" src="${ctx}/imagen/download.png">
							</a>
						</c:if>
									
						<c:if test="${formato.estado==3}">
							<span class="enlace" onclick="habilitarFormato(${formato.idformato});" title="Activar">
								<img alt="Activar" src="${ctx}/imagen/control_habilitar.gif">
							</span>
						</c:if>
						
					</td>
				</tr>

			</c:forEach>
		</tbody>
	</table>

</div>