<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
</script>
<div align="left" >
	<!-- Recurrencia  -->
	<tr>
		<td>
		    <!-- Si el tamaño de sanción es mayor a cero lo muestra normal. -->
			<c:if test="${fn:length(sancion.nombresancion) >0}"	>
				<c:out value="${sancion.nombresancion}"/>
 				<input type="hidden" id="idSancion" name="idSancion" value="${sancion.idsancion}"/>
			</c:if>
			<!-- Si el tamaño de sanción es igual a cero muestra la frase en rojo. -->
<%--  			<c:if test="${fn:length(sancion.nombresancion) ==0}"> --%>
<!--  				<p style="color:red"> -->
<%--  					<c:out value="No existe Sanción para el tipo y falta seleccionada. El proceso NO será registrado."/> --%>
<!--  				</p> -->
<%--  			</c:if> --%>
 			
 			<c:if test="${fn:length(sancion.nombresancion) ==0}">
 				<p style="color:red">
 					<c:out value="No tiene permiso para registrar esta falta. Debe escalar el caso."/>
 					<input type="hidden" id="idSancion" name="idSancion" value=""/>
 				</p>
 			</c:if>
		</td>
	</tr>
</div>