<%@ include file="/taglibs.jsp"%>
<div align="left" >

<c:choose>
		<c:when test="${fn:length(sanciones) eq 0}">
			<div class="msgInfo1" align="left">No se encontraron coincidencias.</div>
		</c:when>		
		<c:otherwise>
			<div>
			<div id="usuario_acciones" style="padding: 5px 0px 0px 0px;">			
<%--			<b>Ventas selecionadas:</b>&nbsp;&nbsp;&nbsp;<span class="enlace" id="enviar_correo_usuario">enviar por correo</span>--%>
				<div style="float: right;"><span class="texto1">Ordenar múltiples columnas: (Shift+[clic columna])</span></div>
			</div>
			<div style="clear: both;"></div>
			<div id="divempleados" >
			<table style="width:100%" border="0" id="cargoareaasignada" class="tExcel tRowSelect">
				  <thead>
				  <tr class="td3">
					    <th>#</th>		
					    
					    <th><span title="Identificador sanción">Id. sanción</span></th>	
					    <th><span title="Tipo de Falta">Tipo de Falta</span></th> 
					    <th><span title="Nombre Falta">Nombre Falta</span></th> 
					    <th><span title="Recurrencia">Recurrencia</span></th>    
					    <th><span title="Sanción"></span>Sanción</th>   
						<th><span title="Procedimiento">Procedimiento</span></th>
						<th><span title="Responsable">Responsable</span></th>
					  	
					  	<th>Fechacrea</th>
					  	<th>Usuario crea.</th>
					   	<th>Fechamod</th>	
					  	<th>Usuario mod.</th>	
					    <th>Estado</th>
					  	<th>Acciones</th>
				  </tr>
				  </thead>
				  <tbody>
					  <c:forEach items="${sanciones}" var="sancion" varStatus="loop">
						  <tr style="color: ${sancion.estado==2?'':'red'};">
							  	<td><c:out value="${loop.index+1}"/></td>	
							  	
							  	<td><c:out value="${sancion.idsancion}"/></td>	
							  	<td><c:out value="${sancion.faltaTipo.nombrefaltatipo}"/></td>
							  	<td><c:out value="${sancion.falta.faltanombre}"/></td>	
							  	<td><c:out value="${sancion.recurrencia}"/></td>
							  	<td><c:out value="${sancion.nombresancion}"/></td>
							  	<td><c:out value="${sancion.procedimiento}"/></td>
							  	<td><c:out value="${sancion.responsable}"/> </td>
							    
							  	<td><fmt:formatDate value="${sancion.fechacrea}" pattern="dd/MM/yyyy H:mm"/></td>
							  	<td><c:out value="${sancion.idusuariocrea} "/></td>
							 	<td><fmt:formatDate value="${sancion.fechamod}" pattern="dd/MM/yyyy H:mm"/></td>	
							  	<td><c:out value="${sancion.idusuariomod} "/></td>		  		  	
							  	
							  	<c:if test="${sancion.estado==2}">
							  		<td><c:out value="Activo"/></td>
							  	</c:if>
							  	<c:if test="${sancion.estado==3}">
							  		<td><c:out value="Deshabilitado"/></td>
							  	</c:if>
							  	<c:if test="${sancion.estado==1}">
							  		<td><c:out value="Eliminado"/></td>
							  	</c:if>
							  	
							  	<td valign="middle" align="center">	
								  	<c:if test="${sancion.estado==2}">
										<span class="enlace" onclick="deshabilitarFalta(${sancion.idsancion},${sancion.idfalta});" title="Deshabilitar"><img alt="Deshabilitar" src="${ctx}/imagen/control_deshabilitar.gif"></span>
 										
									</c:if> 
									<c:if test="${sancion.estado==3}">
										<span class="enlace" onclick="habilitarFalta(${sancion.idsancion},${sancion.idfalta});" title="Activar"><img alt="Activar" src="${ctx}/imagen/control_habilitar.gif"></span>
									</c:if>
								</td>	
						  </tr>		
					  	 
					  </c:forEach>			  
				  </tbody>
			</table>
			</div>
			</div>
	</c:otherwise>
</c:choose> 
</div>