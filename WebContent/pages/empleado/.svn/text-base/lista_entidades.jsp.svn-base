<%@ include file="/taglibs.jsp"%>

<script type="text/javascript">
</script>
<div align="left" >
	<select name="identidadasignada"  style="width: 200px">
		<option value=""></option>
		<c:forEach items="${entidades}" var="entidad">
			<option  value="${entidad.idafiliacionentidad}">
				<c:out value="${entidad.nombreentidad}"/>
			</option>
		</c:forEach>
	</select>
	<script type="text/javascript">
 		$("[name=identidadasignada]").val("${empleadoafiliacion.idafiliacionentidad}");
 	</script>
</div>
