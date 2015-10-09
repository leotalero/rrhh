<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
</script>
<div align="left" >
	
	<select name="idFaltaAsignadaEnSancion"  style="width: 99%" onchange="cargarRecurrenciaDeSancion(this.value)">
		<option value=""></option>
			<c:forEach items="${faltasParaSancion}" var="falta">
				<option  value="${falta.idfalta}">
					<c:out value="${falta.faltanombre}"/>
				</option>
			</c:forEach>
	</select>
</div>
