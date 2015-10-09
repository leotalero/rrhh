<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
	
</script>
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

			<c:forEach items="${listaFormatos}" var="sancionFormato" varStatus="loop">

				<tr style="color: ${sancionFormato.estado==2?'':'red'};">
					<td class="e6"><c:out value="${sancionFormato.formato.nombreformato}" /></td>
					<td><c:out value="${sancionFormato.idusuariocrea}" /></td>
					<td><fmt:formatDate value="${sancionFormato.fechacrea}"
							pattern="dd/MM/yyyy" /></td>
					<td><c:out value="${sancionFormato.idusuariomod}" /></td>
					<td><fmt:formatDate value="${sancionFormato.fechamod}"
							pattern="dd/MM/yyyy" /></td>
					<td><c:if test="${sancionFormato.estado==2}">
							<c:out value="Activo" />
						</c:if> <c:if test="${sancionFormato.estado==3}">
							<c:out value="Desactivado" />
						</c:if></td>
					<td>
						<a href="${ctx}/page/disciplinario?action=descargarFormato&idFormato=${sancionFormato.formato.idformato}"
							target="_blank"> <img alt="" src="${ctx}/imagen/download.png">
						</a>
					</td>
				</tr>

			</c:forEach>
		</tbody>
	</table>

</div>