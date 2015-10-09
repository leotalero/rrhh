<%@ include file="/taglibs.jsp"%>
<script type="text/javascript"></script>
<div align="left" >

<select name="idsucursal"  style="width: 200px">
	<option value=""></option>
	<c:forEach items="${sucursales}" var="sucursal">
		<option value="${sucursal.idsucursal}"><c:out value="${sucursal.idsucursal}" /> - <c:out value="${sucursal.nombresucursal}" /></option>
	</c:forEach>
</select>

<script type="text/javascript">
	$("[name=idsucursal]").val("${contrato.idsucursal}");
</script>

</div>
