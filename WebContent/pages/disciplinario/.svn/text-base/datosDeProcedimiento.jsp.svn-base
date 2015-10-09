<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
</script>
<div align="left" >

		<!-- Procedimiento  -->
		<tr>
			<td>
			    <!-- Si el tamaño del procedimiento es mayor a cero lo muestra normal. -->
				<c:if test="${fn:length(sancion.procedimiento) >0}"	>
					<c:out value="${sancion.procedimiento}"/>
				</c:if>
				<!-- Si el tamaño del procedimiento es igual a cero muestra la frase en rojo. -->
<%-- 	 			<c:if test="${fn:length(sancion.procedimiento) ==0}"> --%>
<!-- 	 				<p style="color:red"> -->
<%-- 	 					<c:out value="No existe un Procedimiento para el tipo y falta seleccionada. El proceso NO será registrado."/> --%>
<!-- 	 				</p> -->
<%-- 	 			</c:if> --%>
				
				<c:if test="${fn:length(sancion.procedimiento) ==0}">
	 				<p style="color:red">
	 					<c:out value="No tiene permiso para registrar esta falta. Debe escalar el caso."/>
	 				</p>
	 			</c:if>
				
				
			</td>
		</tr>
		
</div>