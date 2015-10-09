<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
</script>
<div align="left" >

		<!-- Recurrencia  -->
		<tr>
<!-- 			<th nowrap="nowrap" style="text-align: right;">Recurrencia:</th> -->
			<td>
<%-- 			<c:out value="${contrato.empresa.nombreempresa}"/>--%>
				<c:out value="${recurrencia}"/>
				<input type="hidden" name="recurrenciaEnNumero" value="${recurrenciaEnNumero}"/>
			</td>
		</tr>
		
</div>