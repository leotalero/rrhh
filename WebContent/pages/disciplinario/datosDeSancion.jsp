<%@ include file="/taglibs.jsp"%>
<script type="text/javascript">
</script>
<div align="left" >
	<!-- Recurrencia  -->
	<tr>
		<td>
		    <!-- Si el tama�o de sanci�n es mayor a cero lo muestra normal. -->
			<c:if test="${fn:length(sancion.nombresancion) >0}"	>
				<c:out value="${sancion.nombresancion}"/>
 				<input type="hidden" id="idSancion" name="idSancion" value="${sancion.idsancion}"/>
			</c:if>
			<!-- Si el tama�o de sanci�n es igual a cero muestra la frase en rojo. -->
<%--  			<c:if test="${fn:length(sancion.nombresancion) ==0}"> --%>
<!--  				<p style="color:red"> -->
<%--  					<c:out value="No existe Sanci�n para el tipo y falta seleccionada. El proceso NO ser� registrado."/> --%>
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