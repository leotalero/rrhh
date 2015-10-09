<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
</script>
<input type="hidden" name="idContrato" value="${idContrato}"/>
<div align="left" >
	<select name="idFaltaAsignada"  style="width: 99%" onchange="cargarDatosDeSancion(this.value,${idContrato})">
		<option value=""></option>
		<c:forEach items="${faltas}" var="falta">
			<option  value="${falta.idfalta}">
				<c:out value="${falta.faltanombre}"/>
			</option>
		</c:forEach>
	</select>
</div>
